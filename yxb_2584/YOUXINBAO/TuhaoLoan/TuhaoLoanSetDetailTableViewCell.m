//
//  TuhaoLoanSetDetailTableViewCell.m
//  YOUXINBAO
//
//  Created by zjp on 15/5/5.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "TuhaoLoanSetDetailTableViewCell.h"
#import "YXBTool.h"
@implementation TuhaoLoanSetDetailTableViewCell{
    UILabel *jine;
    UILabel *yearMoney;
    UILabel *lixi;
    UILabel *loanTime;
    UILabel *loanWay;
    UILabel *number;
    UILabel *loaned;
}


- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        jine = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kDeviceWidth, kDeviceWidth/320*125/10*3)];
        jine.textAlignment = NSTextAlignmentLeft;
        jine.font = [UIFont systemFontOfSize:19];
        jine.textColor = [UIColor blackColor];
        jine.text = @"金   额：";
        [self addSubview:jine];
        [jine setAdjustsFontSizeToFitWidth:YES];
        
        yearMoney = [[UILabel alloc] initWithFrame:CGRectMake(20, kDeviceWidth/320*125/10*7, kDeviceWidth/3, kDeviceWidth/320*125/10*2)];
        yearMoney.textAlignment = NSTextAlignmentLeft;
        yearMoney.font = [UIFont systemFontOfSize:14];
        yearMoney.textColor = [UIColor blackColor];
        yearMoney.text = @"年利率：";
        [self addSubview:yearMoney];
        [yearMoney setAdjustsFontSizeToFitWidth:YES];
        
        lixi = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2+10, yearMoney.top, kDeviceWidth/3, kDeviceWidth/320*125/10*2)];
        lixi.textAlignment = NSTextAlignmentLeft;
        lixi.font = [UIFont systemFontOfSize:14];
        lixi.textColor = [UIColor blackColor];
        lixi.text = @"利息：";
        [self addSubview:lixi];
        [lixi setAdjustsFontSizeToFitWidth:YES];

        loanWay = [[UILabel alloc] initWithFrame:CGRectMake(20,kDeviceWidth/320*125/10*5, kDeviceWidth/2, kDeviceWidth/320*125/10*2)];
        loanWay.textAlignment = NSTextAlignmentLeft;
        loanWay.font = [UIFont systemFontOfSize:14];
        loanWay.textColor = [UIColor lightGrayColor];
        loanWay.text = @"还款方式：";
        [self addSubview:loanWay];
        [loanWay setAdjustsFontSizeToFitWidth:YES];
        
        loanTime = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2+10, loanWay.top, kDeviceWidth/2, kDeviceWidth/320*125/10*2)];
        loanTime.textAlignment = NSTextAlignmentLeft;
        loanTime.font = [UIFont systemFontOfSize:14];
        loanTime.textColor = [UIColor blackColor];
        loanTime.text = @"借款时长：";
        [self addSubview:loanTime];
        [loanTime setAdjustsFontSizeToFitWidth:YES];
        
        number = [[UILabel alloc] initWithFrame:CGRectMake(20, kDeviceWidth/320*125/10*3, kDeviceWidth/2, kDeviceWidth/320*125/10*2)];
        number.textAlignment = NSTextAlignmentLeft;
        number.font = [UIFont systemFontOfSize:14];
        number.textColor = [UIColor lightGrayColor];
        number.text = @"可借数量：";
        [self addSubview:number];
        [number setAdjustsFontSizeToFitWidth:YES];
        
        loaned = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2+10,number.top, kDeviceWidth/2, kDeviceWidth/320*125/10*2)];
        loaned.textAlignment = NSTextAlignmentLeft;
        loaned.font = [UIFont systemFontOfSize:14];
        loaned.textColor = [UIColor lightGrayColor];
        loaned.text = @"已借出白条：";
        [self addSubview:loaned];
        [loaned setAdjustsFontSizeToFitWidth:YES];
    }
    
    return self;
}


- (void)setModel:(BlankNoteData *)model {
    if (_model != model) {
        _model = model;
        [self createData];
    }
}


- (void)createData {



    if (self.model.repaymentType == 0) {
        loanWay.text = @"还款方式：全额";
    }else if (self.model.repaymentType == 1){
        loanWay.text = @"还款方式：分期";
    }
    NSMutableAttributedString *strLabel = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"白条总数：%ld",(long)self.model.borrowNumber]];
    [strLabel addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5,strLabel.length-5)];
    number.attributedText = strLabel;
    
    NSMutableAttributedString *strLabel1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"已借数量：%ld",(long)self.model.loanNumber]];
    [strLabel1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5,strLabel1.length-5)];
    loaned.attributedText = strLabel1;

    NSString *money = [NSString stringWithFormat:@"金    额：%@",self.model.money];
    NSMutableAttributedString *strLabel2 = [[NSMutableAttributedString alloc] initWithString:money];
    [strLabel2 addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:[money rangeOfString:@"金    额："]];
    [strLabel2 addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:[money rangeOfString:@"元"]];
    jine.attributedText = strLabel2;
    
    NSString *yearMoneystr = [NSString stringWithFormat:@"年  利  率：%@",self.model.yearRate];
    NSMutableAttributedString *strLabel3 = [[NSMutableAttributedString alloc] initWithString:yearMoneystr];
    [strLabel3 addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:[yearMoneystr rangeOfString:@"年"]];
    [strLabel3 addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:[yearMoneystr rangeOfString:@"利"]];
    [strLabel3 addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:[yearMoneystr rangeOfString:@"率："]];
    yearMoney.attributedText = strLabel3;
    
    NSString *lixistr = [NSString stringWithFormat:@"利      息：%@元",[YXBTool setMoney:self.model.money yearRate:self.model.yearRate repaymentMonth:self.model.repaymentMonth]];
    NSMutableAttributedString *strLabel4 = [[NSMutableAttributedString alloc] initWithString:lixistr];
    [strLabel4 addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:[lixistr rangeOfString:@"利"]];
    [strLabel4 addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:[lixistr rangeOfString:@"息："]];
    [strLabel4 addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:[lixistr rangeOfString:@"元"]];
    lixi.attributedText = strLabel4;
    
    NSString *timestr = [NSString stringWithFormat:@"周      期：%ld个月",(long)self.model.repaymentMonth];
    NSMutableAttributedString *strLabel5 = [[NSMutableAttributedString alloc] initWithString:timestr];
    [strLabel5 addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:[timestr rangeOfString:@"周"]];
    [strLabel5 addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:[timestr rangeOfString:@"期："]];
    [strLabel5 addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:[timestr rangeOfString:@"个月"]];
    loanTime.attributedText = strLabel5;
    
}
@end
