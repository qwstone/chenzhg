//
//  BaoDynamicView.m
//  YOUXINBAO
//
//  Created by zjp on 15/6/30.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "BaoDynamicView.h"
#import "BaoDynamicCell.h"
#import "ProfitBannerData.h"
@implementation BaoDynamicView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
        
    }
    return self;
}

- (void)createView {
    UIImageView *imgview = [[UIImageView alloc ]initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height)];
    imgview.userInteractionEnabled = NO;
    UIImage *buttonImage = [UIImage imageNamed:@"bzq-txtbg"];
    buttonImage = [buttonImage stretchableImageWithLeftCapWidth:0 topCapHeight:floorf(buttonImage.size.height/2)];//设置拉伸点
    imgview.image = buttonImage;
    [self addSubview:imgview];
    
    //滑动列表
    _HomeLiseTableView = [[UITableView alloc] initWithFrame:CGRectMake(15, 15, imgview.frame.size.width-30, imgview.height-30) style:UITableViewStylePlain];
    _HomeLiseTableView.delegate = self;
    _HomeLiseTableView.dataSource = self;
//    _HomeLiseTableView.userInteractionEnabled = NO;
//    _HomeLiseTableView.transform = CGAffineTransformMakeRotation(M_PI);
    _HomeLiseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _HomeLiseTableView.backgroundColor = [UIColor clearColor];
    [imgview addSubview:_HomeLiseTableView];

}

- (void)setListData:(NSMutableArray *)listData {
    if (_listData != listData) {
        _listData = listData;
        [_HomeLiseTableView reloadData];
    }
}

#pragma mark --- tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 35;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString * cellID  =@"cellIDdd";
    BaoDynamicCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[BaoDynamicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    cell.model = self.listData[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//        cell.transform = CGAffineTransformMakeRotation(M_PI);
        [UIView animateWithDuration:0.3 animations:^{
//            cell.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    

}

@end
