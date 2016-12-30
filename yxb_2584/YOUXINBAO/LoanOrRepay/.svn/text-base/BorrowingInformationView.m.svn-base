//
//  BorrowingInformationView.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/4/11.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "BorrowingInformationView.h"
#import "Loan.h"
#import "YXBTool.h"

#define kYSpacing 7.0

@implementation BorrowingInformationView
{
    NSArray * statusArray;
    UIView * lineView2;
    UIImageView *nextImage;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = rgb(246, 246, 246, 1);
        
        statusArray = @[@"待同意",@"待同意-待借款人确认",@"待打款",@"待打款-待借款人确认",@"待打款-待放款人确认",@"线下打款确认",@"待还款",@"待还款-超时",@"冻结",@"冻结-超时",@"申请修改-放款方确认",@"申请修改-借款方确认",@"线下还款确认",@"线下还款确认-还款超时",@"按时还款成功",@"超时还款成功",@"已取消",@"已拒绝",@"已关闭"];
        _systemLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, kDeviceWidth/2, 20)];
        _systemLabel.minimumScaleFactor = 8.0/_systemLabel.font.pointSize;
        _systemLabel.adjustsFontSizeToFitWidth = YES;
//        _stautsLabel.backgroundColor = [UIColor redColor];
        _systemLabel.textColor = rgb(48, 48, 48, 1);
        _systemLabel.font = [UIFont systemFontOfSize:15];
//        _systemLabel.text = @"系统:您发起了借款申请";
        [self addSubview:_systemLabel];
        
        _stautsLabel = [[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth-kDeviceWidth/2, 10, kDeviceWidth/2-20, 20)];
        _stautsLabel.textAlignment= NSTextAlignmentRight;
        _stautsLabel.font = [UIFont systemFontOfSize:15.5];
        _stautsLabel.textColor = rgb(62, 163, 255, 1);
//        _stautsLabel.text = @"=====";
        [self addSubview:_stautsLabel];
        
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, kDeviceWidth, 0.5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:lineView];
        
        CGFloat ySpace = kYSpacing;
        
//        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 50, 30, 20)];
//        
//        label1.text = @"借款:";
//        label1.font = [UIFont systemFontOfSize:13];
//        label1.textColor = rgb(132, 132, 132, 1);
//        [self addSubview:label1];
//        
//        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(15, 80, 30, 20)];
//        
//        label2.text = @"利息:";
//        label2.font = [UIFont systemFontOfSize:13];
//        label2.textColor =
//        [self addSubview:label2];
        UILabel *orderNum = [[UILabel alloc ]initWithFrame:CGRectMake(15, 50, kDeviceWidth-30, 30)];
        orderNum.font = [UIFont systemFontOfSize:14];
        orderNum.text = @"交易编号";
        [self addSubview:orderNum];
        
        self.orderNumberLabel = [[UILabel alloc ]initWithFrame:CGRectMake(15, 50, kDeviceWidth-30, 35)];
        self.orderNumberLabel.textAlignment = NSTextAlignmentRight;
        self.orderNumberLabel.font = [UIFont systemFontOfSize:13];
        self.orderNumberLabel.textColor = rgb(132, 132, 132, 1);
        [self addSubview:self.orderNumberLabel];

        UIImageView *moneyImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, _orderNumberLabel.bottom+2.5, 15, 15)];
        moneyImage.image = [UIImage imageNamed:@"money-icon"];
        [self addSubview:moneyImage];
        
        _moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(35, _orderNumberLabel.bottom, kDeviceWidth/2, 20)];
//        _moneyLabel.text =@"￥20000";
//        _moneyLabel.backgroundColor = [UIColor redColor];
        _moneyLabel.textColor = rgb(132, 132, 132, 1);
        _moneyLabel.font = [UIFont systemFontOfSize:12.5];
        [self addSubview:_moneyLabel];
        
        UIImageView *interestImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, _moneyLabel.bottom+2.5+ySpace, 15, 15)];
        interestImage.image = [UIImage imageNamed:@"inst-icon"];
        [self addSubview:interestImage];
        
        _interestLabel = [[UILabel alloc]initWithFrame:CGRectMake(35, _moneyLabel.bottom+ySpace, kDeviceWidth/2, 20)];
//        _interestLabel.backgroundColor = [UIColor redColor];
//        _interestLabel.text = @"￥20000";
        _interestLabel.textColor = rgb(132, 132, 132, 1);
        _interestLabel.font = [UIFont systemFontOfSize:12.5];
        [self addSubview:_interestLabel];
        
        UIImageView *usedtimeImage = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth-kDeviceWidth/2 - 20, _orderNumberLabel.bottom+2.5, 15, 15)];
        usedtimeImage.image = [UIImage imageNamed:@"data-icon"];
        [self addSubview:usedtimeImage];
        
        _usedtimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(usedtimeImage.right+5, _orderNumberLabel.bottom, kDeviceWidth/2, 20)];
//        _usedtimeLabel.backgroundColor = [UIColor redColor];
        _usedtimeLabel.font = [UIFont systemFontOfSize:12.5];
        _usedtimeLabel.textColor = rgb(132, 132, 132, 1);
        _usedtimeLabel.text = @"用款时间 :  2015-03-04";
        [self addSubview:_usedtimeLabel];
        
        UIImageView *timelongImage = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth-kDeviceWidth/2 - 20, _usedtimeLabel.bottom+ySpace+2.5, 15, 15)];
        timelongImage.image = [UIImage imageNamed:@"time-icon"];
        [self addSubview:timelongImage];
        
        _timelongLabel = [[UILabel alloc]initWithFrame:CGRectMake(timelongImage.right+5, _usedtimeLabel.bottom+ySpace, kDeviceWidth/2, 20)];
//        _timelongLabel.backgroundColor = [UIColor redColor];
        _timelongLabel.font = [UIFont systemFontOfSize:12.5];
        _timelongLabel.textColor = rgb(132, 132, 132, 1);
        [self addSubview:_timelongLabel];
        
        self.creator = [[UILabel alloc ]initWithFrame:CGRectMake(15, _timelongLabel.bottom+ySpace, kDeviceWidth-30, 20)];
        self.creator.font = [UIFont systemFontOfSize:13];
        self.creator.textColor = rgb(132, 132, 132, 1);
        [self addSubview:self.creator];
        
        self.identity = [[UILabel alloc ]initWithFrame:CGRectMake(15, _creator.bottom+ySpace, kDeviceWidth-30, 20)];
        self.identity.font = [UIFont systemFontOfSize:13];
        self.identity.textColor = rgb(132, 132, 132, 1);
        [self addSubview:self.identity];
        
        self.loanTip = [[UILabel alloc ]initWithFrame:CGRectMake(15, _identity.bottom+ySpace, kDeviceWidth-30, 20)];
        self.loanTip.font = [UIFont systemFontOfSize:11];
        self.loanTip.numberOfLines = 0;
        self.loanTip.textColor = rgb(132, 132, 132, 1);
        [self addSubview:self.loanTip];
        
        lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, self.height-0.5, kDeviceWidth, 0.5)];
        lineView2.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:lineView2];
        
        
        nextImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - 30, _timelongLabel.bottom - 30, 30, 30)];
        nextImage.contentMode = UIViewContentModeCenter;
        nextImage.image = [UIImage imageNamed:@"next.png"];
        [self addSubview:nextImage];
        
    }
    return self;
}

- (void)setHeight:(CGFloat)height {
    self.loanTip.height = height-(kCustomHeight+kYSpacing);
    lineView2.top = height-0.5;
}

- (void)setLoanWithLog:(TLoanWithLog *)loanWithLog
{
    _loanWithLog = loanWithLog;
    
    NSString *money = [NSString stringWithFormat:@"借款 :  %@元",loanWithLog.money];
    NSString *interest = [NSString stringWithFormat:@"利息 :  %@元",loanWithLog.interest];
    
    if (loanWithLog.money.length != 0 && loanWithLog.interest.length != 0) {
        if (KDeviceOSVersion>5.0) {
            NSMutableAttributedString *moneyAttributString = [[NSMutableAttributedString alloc] initWithString:money];
            //设置字符串的样式   NSFontAttributeName:样式名称
            NSRange moneyRange = [money rangeOfString:loanWithLog.money];
            [moneyAttributString addAttribute:NSFontAttributeName
                                        value:[UIFont systemFontOfSize:17]
                                        range:moneyRange];
            
            [moneyAttributString addAttribute:NSForegroundColorAttributeName
                                        value:rgb(217, 29, 61, 1)
                                        range:moneyRange];
            _moneyLabel.attributedText = moneyAttributString;
            
            NSMutableAttributedString *interestAttributString = [[NSMutableAttributedString alloc] initWithString:interest];
            //设置字符串的样式   NSFontAttributeName:样式名称
            NSRange interestRange = [interest rangeOfString:loanWithLog.interest];
            [interestAttributString addAttribute:NSFontAttributeName
                                           value:[UIFont systemFontOfSize:17]
                                           range:interestRange];
            
            [interestAttributString addAttribute:NSForegroundColorAttributeName
                                           value:rgb(217, 29, 61, 1)
                                           range:interestRange];
            _interestLabel.attributedText = interestAttributString;
            
        }else {
            _moneyLabel.text = money;
            _interestLabel.text = interest;
        }
        
    }
    if (loanWithLog.expectBorrowDate.length != 0) {
        _usedtimeLabel.text = [NSString stringWithFormat:@"用款时间 :  %@",loanWithLog.expectBorrowDate];
        
    }
    _timelongLabel.text = [NSString stringWithFormat:@"借款时长 :  %@",[Loan getLoanPeriodWith:(LoanPeriod)loanWithLog.loanPeriod]];
//    _stautsLabel.text = statusArray[loanWithLog.status];
    self.orderNumberLabel.text = loanWithLog.serialNo;
    
   
}

- (NSString *)getStatusWithBorrower:(BOOL)yesOrNo {
    NSString *status = nil;
    if (yesOrNo) {
        //借款人
        if (_loanWithLog.status == APPLYING_NEEDRECORD) {
            status = @"待录制视频";
        }else if (_loanWithLog.status == APPLYING_NEEDCONFIRMRECORD) {
            status = @"待对方确认视频";
        }else if (_loanWithLog.status == APPLYING_NEEDPAY) {
            status = @"待打款";
        }else if (_loanWithLog.status == APPLYING_NEEDCONFIRM) {
            status = @"待对方同意";
        }else if (_loanWithLog.status == APPLYING_NEEDCONFIRM_NEEDAGREE_BYBORROWER) {
            status = @"待同意";
        }else if (_loanWithLog.status == APPLYING_NEEDPAY) {
            status = @"待对方打款";
        }else if (_loanWithLog.status == OFFLINE_LENDMONEY_CONFIRM) {
            status = @"待确认";
        }else if (_loanWithLog.status == NEEDREPAY) {
            status = @"待还款";
        }else if (_loanWithLog.status == MODIFY_AFTERLEND_NEEDCONFIRM_BYLENDER) {
            status = @"待对方确认";
        }else if (_loanWithLog.status == NEEDRECEIVE) {
            status = @"待对方确认";
        }else if (_loanWithLog.status == REPAYED) {
            status = @"还款成功";
        }else if (_loanWithLog.status == BORROWERCANCELLED) {
            status = @"已取消";
        }else if (_loanWithLog.status == DECLINED) {
            status = @"被拒绝";
        }else if (_loanWithLog.status == CLOSED) {
            status = @"已关闭";
        }else if (_loanWithLog.status == QUICKLEND_NEEDCONFIRM) {
            status = @"快速放款待您确认";
        }
        else if (_loanWithLog.status == QUICKLEND_DECLINED) {
            status = @"快速放款您已拒绝";
        }
        else if (_loanWithLog.status == QUICKLEND_CLOSED) {
            status = @"快速放款已关闭";
        }
        
    }else {
        //放款人
        if (_loanWithLog.status == APPLYING_NEEDRECORD) {
            status = @"待对方录制视频";
        }else if (_loanWithLog.status == APPLYING_NEEDCONFIRMRECORD) {
            status = @"去审核";
        }else if (_loanWithLog.status == APPLYING_NEEDCONFIRM) {
            status = @"待同意";
        }else if (_loanWithLog.status == APPLYING_NEEDCONFIRM_NEEDAGREE_BYBORROWER) {
            status = @"待对方同意";
        }else if (_loanWithLog.status == APPLYING_NEEDPAY) {
            status = @"待打款";
        }else if (_loanWithLog.status == OFFLINE_LENDMONEY_CONFIRM) {
            status = @"待对方确认";
        }else if (_loanWithLog.status == NEEDREPAY) {
            status = @"待对方还款";
        }else if (_loanWithLog.status == MODIFY_AFTERLEND_NEEDCONFIRM_BYLENDER) {
            status = @"待确认";
        }else if (_loanWithLog.status == NEEDRECEIVE) {
            status = @"待确认";
        }else if (_loanWithLog.status == REPAYED) {
            status = @"还款成功";
        }else if (_loanWithLog.status == BORROWERCANCELLED) {
            status = @"已取消";
        }else if (_loanWithLog.status == DECLINED) {
            status = @"已拒绝";
        }else if (_loanWithLog.status == CLOSED) {
            status = @"已关闭";
        }else if (_loanWithLog.status == QUICKLEND_NEEDCONFIRM) {
            status = @"快速放款待对方确认";
        }
        else if (_loanWithLog.status == QUICKLEND_DECLINED) {
            status = @"快速放款已被对方拒绝";
        }
        else if (_loanWithLog.status == QUICKLEND_CLOSED) {
            status = @"快速放款已关闭";
        }

        
    }
    
    return status;
}

+ (CGFloat)getViewHeightWithLoanLog:(TLoanLog *)loanLog {
    if (loanLog.loanCenterValidNote && loanLog.loanCenterValidNote.length != 0) {
        return (kCustomHeight+kYSpacing+[YXBTool countLabelHeightWithText:loanLog.loanCenterValidNote font:[UIFont systemFontOfSize:11] labelWidth:kDeviceWidth-30]);
    }else {
        return kCustomHeight;
    }
    
}

@end
