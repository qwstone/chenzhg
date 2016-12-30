//
//  payScrollView.m
//  YOUXINBAO
//
//  Created by Feili on 15/9/15.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "PayScrollView.h"

#define DetailItemsWidth 70
#define PaydetailViewTagStart 2000

@interface PayScrollView ()
{
    UILabel *startYearLabel;
}
@property (nonatomic,strong)UIScrollView *scrollView;
@end

@implementation PayScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame array:(NSMutableArray *)modelArray
{
    self = [super initWithFrame:frame];
    if (self) {
        _modelArray = modelArray;
        [self initViews];
    }
    
    return self;
}

- (void)setModelArray:(NSArray *)modelArray {
    _modelArray = modelArray;
    if (self.subviews != nil) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    [self initViews];
}

-(void)setStartYear:(NSString *)startYear
{
//    if (![_startYear isEqualToString:startYear]) {
        _startYear = startYear;
        startYearLabel.text = _startYear;
//    }
}

-(void)initViews
{
    NSInteger numberOfItems = [_modelArray count];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, self.height)];
    [self addSubview:_scrollView];
    
    _scrollView.contentSize = CGSizeMake(numberOfItems * 70 + (numberOfItems + 1) * 34, self.height);
    _scrollView.bounces = NO;
    CGFloat x = 0, y = 43, w = _scrollView.contentSize.width,h = 1;
    
    //添加水平直线
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    line.backgroundColor = rgb(160, 160, 160, 1.0);
    [_scrollView addSubview:line];

    
    if (startYearLabel != nil && startYearLabel.superview != nil) {
        [startYearLabel removeFromSuperview];
    }

    //添加起始年份
    x = 0,y = 28,w = 50,h = 16;
    startYearLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    startYearLabel.text = @"--";
    startYearLabel.textColor = [UIColor lightGrayColor];
    startYearLabel.font = [UIFont systemFontOfSize:14.0];
    startYearLabel.textAlignment = NSTextAlignmentCenter;
    startYearLabel.backgroundColor = [UIColor clearColor];
    [_scrollView addSubview:startYearLabel];

    
    x = 0, y = 0, w = 70,h = _scrollView.height;
    NSInteger space = 34;
    

    
    for (int i = 0; i < numberOfItems; i ++) {
        x = (i + 1) * space + i *w;
        PaydetailView *detailView = [[PaydetailView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [detailView addTarget:self action:@selector(detailViewAction:) forControlEvents:UIControlEventTouchUpInside];
        detailView.tag = PaydetailViewTagStart + i;
        [_scrollView addSubview:detailView];
    }
    
    [self refreshData];
}

-(void)refreshData
{
    for (int i = 0; i < [_modelArray count]; i ++) {
        PaydetailView *detailView = (PaydetailView *)[_scrollView viewWithTag:PaydetailViewTagStart + i];
        detailView.model = _modelArray[i];
        detailView.index = i + 1;
        
    }
    
}

-(void)detailViewAction:(PaydetailView *)detailView;
{
    NSInteger index = detailView.tag - PaydetailViewTagStart;
    GuaranteeStages *model = _modelArray[index];
    
    if (_delegate && [_delegate respondsToSelector:@selector(payScrollViewDidSelectIndex:model:)]) {
        [ProgressHUD showSuccessWithStatus:@"还款点击事件"];
        [_delegate payScrollViewDidSelectIndex:index model:model];
    }
}

@end
