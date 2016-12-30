//
//  AAFlowView.m
//  YOUXINBAO
//
//  Created by CH10 on 15/4/1.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AAFlowView.h"

#define TABLEVIEWTAG 1000
#define CELLSUBVIEWTAG 10000

@implementation AAFlowView {
    NSMutableArray *_tableviews;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentSize = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)+1);
    }
    return self;
}

-(void)layoutSubviews{
    
    [self relayoutDisplaySubviews];
    
    
    for (UITableView *tableview in _tableviews) {
        
        [tableview setFrame:CGRectMake(tableview.frame.origin.x, self.contentOffset.y, CGRectGetWidth(tableview.frame), CGRectGetHeight(tableview.frame))];
        [tableview setContentOffset:self.contentOffset animated:NO];
    }
    
    [super layoutSubviews];
}


-(void)relayoutDisplaySubviews{
    
    self.columnCount = [self.AAFlowViewDatasource numberOfColumsInAAFlowView:self];
    self.cellsTotal = [self.AAFlowViewDatasource numberOfAllAAFlowView:self];
    
    if (_cellsTotal == 0 || _columnCount == 0) {
        
        return;
    }
    
    self.cellWidth = CGRectGetWidth(self.frame)/_columnCount; //每列的宽度
    
    if (!_tableviews) {
        
        _tableviews = [[NSMutableArray alloc] initWithCapacity:_columnCount];
        for (int i = 0; i < _columnCount; i++) {
            
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(_cellWidth*i, 0, _cellWidth, CGRectGetHeight(self.frame)) style:UITableViewStylePlain];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.tag = i + TABLEVIEWTAG; //保存列号
            tableView.showsVerticalScrollIndicator = NO;
            tableView.scrollEnabled = NO;
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            tableView.backgroundColor = [UIColor clearColor];
            [self addSubview:tableView];
            
            [_tableviews addObject:tableView];
        }
    }
}

- (void)setAAFlowViewDatasource:(id<AAFlowViewDataSource>)AAFlowViewDatasource {
    _AAFlowViewDatasource = AAFlowViewDatasource;
}

- (void)setAAFlowViewDelegate:(id<AAFlowViewDelegate>)AAFlowViewDelegate {
    _AAFlowViewDelegate = AAFlowViewDelegate;
}

- (void)reloadData{
    
    [self relayoutDisplaySubviews];
    
    float contenSizeHeight = 0.0f;
    
    for (UITableView *tabelview in _tableviews) {
        
        [tabelview reloadData];
        if (contenSizeHeight < tabelview.contentSize.height) {
            
            contenSizeHeight = tabelview.contentSize.height;
        }
    }
    
    contenSizeHeight = contenSizeHeight < CGRectGetHeight(self.frame)?CGRectGetHeight(self.frame)+1:contenSizeHeight;
    self.contentSize = CGSizeMake(self.contentSize.width, contenSizeHeight);
}


- (NSInteger)AAFlowView:(AAFlowView *)flowView numberOfRowsInColumn:(NSInteger)colunm {
    
    if (flowView.cellsTotal -(colunm + 1) < 0) {
        
        return 0;
    }else{
        return (flowView.cellsTotal -(colunm + 1))/flowView.columnCount+1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self AAFlowView:self numberOfRowsInColumn:tableView.tag-TABLEVIEWTAG];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    IndexPath *_indextPath = [IndexPath initWithRow:indexPath.row  withColumn:(tableView.tag - TABLEVIEWTAG)];
    CGFloat cellHeight = [self.AAFlowViewDelegate AAFlowView:self heightForRowAtIndexPath:_indextPath];
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    NSString *cellIndetify = [NSString stringWithFormat:@"cell%ld",(long)(tableView.tag -TABLEVIEWTAG)];
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellIndetify];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetify];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        IndexPath *_indextPath = [IndexPath initWithRow:indexPath.row  withColumn:tableView.tag - TABLEVIEWTAG];
        UIView *cellSub =  [self.AAFlowViewDatasource AAFlowView:self cellForRowAtIndexPath:_indextPath];
        [cell.contentView addSubview:cellSub];
        cellSub.tag = CELLSUBVIEWTAG;
    }
    
    IndexPath *_indextPath = [IndexPath initWithRow:indexPath.row  withColumn:tableView.tag - TABLEVIEWTAG];
    
    CGFloat cellHeight = [self.AAFlowViewDelegate AAFlowView:self heightForRowAtIndexPath:_indextPath];
    CGRect cellRect = CGRectMake(0, 0, _cellWidth, cellHeight);
    [[cell viewWithTag:CELLSUBVIEWTAG] setFrame:cellRect];  //调整子视图frame
    
    [self.AAFlowViewDatasource AAFlowView:self relayoutCellSubview:[cell viewWithTag:CELLSUBVIEWTAG] withIndexPath:_indextPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    IndexPath *_indextPath = [IndexPath initWithRow:indexPath.row  withColumn:tableView.tag - TABLEVIEWTAG];
    [self.AAFlowViewDelegate AAFlowView:self didSelectRowAtIndexPath:_indextPath];
}

@end
