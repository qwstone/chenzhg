//
//  LoanDetailShiJianCell.m
//  YOUXINBAO
//
//  Created by Feili on 15/8/3.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanDetailShiJianCell.h"

@interface LoanDetailShiJianCell ()

@property(nonatomic,strong)UIButton *timeBtn;
@property(nonatomic,strong)UILabel  *titleLabel;//标题

@property (nonatomic, strong)AATimePickerView *timerPickerView;

@end
@implementation LoanDetailShiJianCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    
    return self;
}

-(void)initViews
{
    //添加背景
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    CGFloat x = 0,y = 0;
    CGFloat w = kDeviceWidth,h = 50;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    bgView.backgroundColor = rgb(255, 255, 255, 0.8);
    [self.contentView addSubview:bgView];
    
    //添加标题
    x = 20 , w = 80, h = bgView.height;
    self.titleLabel = [self labelWithFrame:CGRectMake(x, y, w, h) fontSize:14 minimumScaleFactor:16 adjustsFontSizeToFitWidth:NO textColor:[UIColor blackColor] backgroundColor:[UIColor clearColor]];
    [bgView addSubview:_titleLabel];
    
    //添加文本
#define LoginCellTextfieldleftAlign 20
    w = 100;
    x = kDeviceWidth - 20 - w;
    self.timeBtn = [[UIButton alloc] initWithFrame:CGRectMake(x, y, w, h)];
    [_timeBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_timeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    _timeBtn.contentHorizontalAlignment = UIControlContentHorizonAlignmentRight;
    _timeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _timeBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [bgView addSubview:_timeBtn];
    
    //添加时间选择view
    _timerPickerView = [[AATimePickerView alloc] initWithFrame:CGRectMake(0, kDeviceHeight, self.width, kTimeCustomHeight)withHour:NO];
    __weak typeof(self) this = self;
    _timerPickerView.selectedBlock= ^ (NSInteger year, NSInteger month, NSInteger day, NSInteger hour, NSInteger minIndex, AATimePickerView *timePickerView)
    {
//        NSString *date = [NSString stringWithFormat:@"%ld-%02ld-%02ld",(long)year,(long)month,(long)day];
        NSString *date = [NSString stringWithFormat:@"%ld-%02ld-%02ld",(long)year,(long)month,(long)day];
        [ProgressHUD showSuccessWithStatus:date];
        if (this.delegate && [_delegate respondsToSelector:@selector(updateLoanDetailWithLoan:)]) {
//            [this.delegate updateDetailLoanWithShiJian:date];
            [this.timeBtn setTitle:date forState:UIControlStateNormal];
            this.loan.expectBorrowDate = date;
            [this.delegate updateLoanDetailWithLoan:this.loan];
        }
    };
    
    UIWindow *mWindow = [[[UIApplication sharedApplication] delegate] window];
    if (!mWindow.isKeyWindow) {
        [mWindow makeKeyAndVisible];
        
    }
    [mWindow addSubview:_timerPickerView];
}

-(void)setModel:(LoginModel *)model
{
    if (_model != model) {
        _model = model;
        _titleLabel.text = model.titleName;
//        [_timeBtn setTitle:_model.text forState:UIControlStateNormal];
    }
}

-(void)setLoan:(Loan *)loan
{
    _loan = loan;
    [_timeBtn setTitle:_loan.expectBorrowDate forState:UIControlStateNormal];

}

-(void)buttonAction:(UIButton *)sender
{
    [_timerPickerView showPickerView];

}


@end
