//
//  LoanDetailLiXiCell.m
//  YOUXINBAO
//
//  Created by Feili on 15/8/3.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanDetailLiXiCell.h"
#import "loan.h"

@interface LoanDetailLiXiCell ()<HeaderViewDelegate>

@property(nonatomic,strong)UILabel  *titleLabel;//标题
@property(nonatomic,strong)LoanDetailInterestView *interestView;//利息选择

@end

@implementation LoanDetailLiXiCell


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
    x = 20 , w = 80, h = 50;
    self.titleLabel = [self labelWithFrame:CGRectMake(x, y, w, h) fontSize:14 minimumScaleFactor:16 adjustsFontSizeToFitWidth:NO textColor:[UIColor blackColor] backgroundColor:[UIColor clearColor]];
    _titleLabel.text = @"利息";
    [bgView addSubview:_titleLabel];
    
    
    //利息选择
    //添加三种扣息方式 自定义利息、银行利息、无息
    x = 100, y = 10, w = kDeviceWidth - 20 - x, h = 30;
    self.interestView = [[LoanDetailInterestView alloc] initWithFrame:CGRectMake(x, y, w, h) WithArray:[NSArray arrayWithObjects:@"自定义息",@"银行息",@"无息", nil]];
    _interestView.delegate = self;
    [bgView addSubview:_interestView];
    
}

-(void)setLoan:(Loan *)loan
{
    _loan = loan;
//    _interestView.selectedIndex = _loan.loanInterestCalculateType;
}

-(void)headerViewSelectedIndex:(NSInteger)index
{
    if (index == 1) {
        self.loan.useBankRate = 1;
        self.loan.interestType = LoanInterestTypePost;
    }
    else
    {
        self.loan.useBankRate = 0;
        if (index == 2) {
            self.loan.interestType = LoanInterestTypeNone;
        }
        else if (index == 0)
        {
            self.loan.interestType = LoanInterestTypePre;

        }
    }
    
    if (_updateDelegate && [_updateDelegate respondsToSelector:@selector(updateLoanDetailWithLoan:)]) {
        [_updateDelegate updateLoanDetailWithLoan:self.loan];
    }
}

@end
