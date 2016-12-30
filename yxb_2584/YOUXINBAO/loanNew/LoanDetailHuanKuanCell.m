//
//  LoanDetailHuanKuanCell.m
//  YOUXINBAO
//
//  Created by Feili on 15/8/3.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanDetailHuanKuanCell.h"


@interface LoanDetailHuanKuanCell ()
@property (nonatomic,strong)UIButton    *huanKuanBtn;//先息、后息btn

@end
@implementation LoanDetailHuanKuanCell


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
    //添加还款方式
    //固定文字
    UILabel *huankuanlabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, 50)];
    huankuanlabel.textColor = rgb(74, 74, 74, 1);
    huankuanlabel.textAlignment = NSTextAlignmentLeft;
    huankuanlabel.font = [UIFont systemFontOfSize:14];
    huankuanlabel.text = @"还款方式";
    [self.contentView addSubview:huankuanlabel];

    //全额  分期选择
    UIImage * imageON1 = [UIImage imageNamed:@"fenqi.png"];
    UIImage * imageOff1 = [UIImage imageNamed:@"quane.png"];
    self.huanKuanBtn = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth - imageON1.size.width - 20, (50-imageON1.size.height)/2.0, imageON1.size.width, imageON1.size.height)];
    [_huanKuanBtn setImage:imageON1 forState:UIControlStateSelected];
    [_huanKuanBtn setImage:imageOff1 forState:UIControlStateNormal];
//    [_huanKuanBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_huanKuanBtn];

}

/*
-(void)buttonAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        self.loan.repayType = LoanRepayTypeMoneyStage;
    }
    else
    {
        self.loan.repayType = LoanRepayTypeMoneyFull;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(updateLoanDetailWithLoan:)]) {
        [_delegate updateLoanDetailWithLoan:self.loan];
    }
}

*/

@end
