//
//  ConfirmationPaymentDetailCell.m
//  YOUXINBAO
//
//  Created by zjp on 15/6/2.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "ConfirmationPaymentDetailCell.h"

@implementation ConfirmationPaymentDetailCell{
//    UIImageView         *_orderImg;
//    UILabel             *_orderTitle;
//    UILabel             *_orderTitleTwo;
//    UILabel             *_stagesMoney;//每月还款金额
//    UILabel             *_stagesNum;//分多少期
    UILabel             *_firstMoney;//
    UILabel             *_freight;//
    UILabel             *_coupon;//优惠
    UILabel             *_orderID;//分多少期
    
     NSMutableAttributedString *strLabel;
     NSMutableAttributedString *strLabel1;
    NSMutableAttributedString *strLabel2;
    NSMutableAttributedString *strLabel3;
    NSMutableAttributedString *strLabel4;
}

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        _orderImg = [[UIImageView alloc ]initWithFrame:CGRectMake(10, 10, kDeviceWidth/64*10, kDeviceWidth/64*10)];
//        [self.contentView addSubview:_orderImg];
//        
//        _orderTitle = [[UILabel alloc] initWithFrame:CGRectMake(_orderImg.right+5,_orderImg.top, kDeviceWidth-_orderImg.right-10, _orderImg.height/10*4)];
//        _orderTitle.textAlignment = NSTextAlignmentLeft;
//        _orderTitle.font = [UIFont systemFontOfSize:16];
//        _orderTitle.textColor = [UIColor blackColor];
//        [self.contentView addSubview:_orderTitle];
//        [_orderTitle setAdjustsFontSizeToFitWidth:YES];
//        
//        _orderTitleTwo = [[UILabel alloc] initWithFrame:CGRectMake(_orderImg.right+5,_orderTitle.bottom, kDeviceWidth-_orderTitle.width, _orderImg.height/10*4)];
//        _orderTitleTwo.textAlignment = NSTextAlignmentLeft;
//        _orderTitleTwo.font = [UIFont systemFontOfSize:16];
//        _orderTitleTwo.textColor = [UIColor blackColor];
//        [self.contentView addSubview:_orderTitleTwo];
//        [_orderTitleTwo setAdjustsFontSizeToFitWidth:YES];
//        
//        _stagesMoney = [[UILabel alloc] initWithFrame:CGRectMake(_orderImg.right+5,_orderTitleTwo.bottom, _orderTitle.width, _orderImg.height/10*2)];
//        _stagesMoney.textAlignment = NSTextAlignmentLeft;
//        _stagesMoney.font = [UIFont systemFontOfSize:16];
//        _stagesMoney.textColor = [UIColor blackColor];
//        [self.contentView addSubview:_stagesMoney];
//        [_stagesMoney setAdjustsFontSizeToFitWidth:YES];
//        
//        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, _orderImg.bottom+10, kDeviceWidth-10, 0.5f)];
//        lineView.backgroundColor = [UIColor lightGrayColor];
//        [self.contentView addSubview:lineView];
        
        
        _firstMoney = [[UILabel alloc] initWithFrame:CGRectMake(10,10, kDeviceWidth-20, 30)];
        _firstMoney.textAlignment = NSTextAlignmentLeft;
        _firstMoney.font = [UIFont systemFontOfSize:15];
        _firstMoney.textColor = [YXBTool colorWithHexString:@"#303030"];
        [self.contentView addSubview:_firstMoney];
        [_firstMoney setAdjustsFontSizeToFitWidth:YES];
        
        _freight = [[UILabel alloc] initWithFrame:CGRectMake(10,_firstMoney.bottom, kDeviceWidth-20, 30)];
        _freight.textAlignment = NSTextAlignmentLeft;
        _freight.font = [UIFont systemFontOfSize:15];
        _freight.textColor = [YXBTool colorWithHexString:@"#303030"];
        [self.contentView addSubview:_freight];
        [_freight setAdjustsFontSizeToFitWidth:YES];
        
        _coupon = [[UILabel alloc] initWithFrame:CGRectMake(10,_freight.bottom, kDeviceWidth-20, 30)];
        _coupon.textAlignment = NSTextAlignmentLeft;
        _coupon.font = [UIFont systemFontOfSize:15];
        _coupon.textColor = [YXBTool colorWithHexString:@"#303030"];
        [self.contentView addSubview:_coupon];
        [_coupon setAdjustsFontSizeToFitWidth:YES];
        
        _orderID = [[UILabel alloc] initWithFrame:CGRectMake(10,_coupon.bottom, kDeviceWidth-20, 30)];
        _orderID.textAlignment = NSTextAlignmentLeft;
        _orderID.font = [UIFont systemFontOfSize:15];
        _orderID.textColor = [YXBTool colorWithHexString:@"#303030"];
        [self.contentView addSubview:_orderID];
        [_orderID setAdjustsFontSizeToFitWidth:YES];
        
    }
    return self;
}

- (void)createData {
//    [_orderImg setImageWithURL:[NSURL URLWithString:self.model.imageUrl] placeholderImage:nil];
//    
//    _orderTitle.text = self.model.descripe;
//    
//    _orderTitleTwo.text = self.model.subDescripe;
//    
//    NSString *str = [NSString stringWithFormat:@"%@ x %ld",self.model.stagesMoney,(long)self.model.stagesNum];
//    strLabel = [[NSMutableAttributedString alloc] initWithString:str];
//    [strLabel addAttribute:NSForegroundColorAttributeName value:[UIColor redColor]
//                     range:[str rangeOfString:self.model.stagesMoney]];
//    [strLabel addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18]
//                     range:[str rangeOfString:self.model.stagesMoney]];
//    [strLabel addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor]
//                     range:[str rangeOfString:[NSString stringWithFormat:@"x %ld",(long)self.model.stagesNum]]];
//    [strLabel addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15]
//                     range:[str rangeOfString:[NSString stringWithFormat:@"x %ld",(long)self.model.stagesNum]]];
//    _stagesMoney.attributedText = strLabel;
    
    
    NSString *str1 = [NSString stringWithFormat:@"首       付: ￥%@",self.model.downPaymentMoney];
    strLabel1 = [[NSMutableAttributedString alloc] initWithString:str1];
    [strLabel1 addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#303030"] range:NSMakeRange(0,strLabel1.length)];
    [strLabel1 addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#d91e3d"]
                     range:[str1 rangeOfString:[NSString stringWithFormat:@"￥%@",self.model.downPaymentMoney]]];
    _firstMoney.attributedText = strLabel1;

    
    
    NSString *str2 = [NSString stringWithFormat:@"运       费: ￥%@",self.model.freight];
    strLabel2 = [[NSMutableAttributedString alloc] initWithString:str2];
    [strLabel2 addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#303030"] range:NSMakeRange(0,strLabel2.length)];
    [strLabel2 addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#9d9d9d"]
                     range:[str2 rangeOfString:[NSString stringWithFormat:@"￥%@",self.model.freight]]];
    _freight.attributedText = strLabel2;
    
    

    NSString *str3 = [NSString stringWithFormat:@"优       惠: %@",self.model.coupon];
    strLabel3 = [[NSMutableAttributedString alloc] initWithString:str3];
    [strLabel3 addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#303030"] range:NSMakeRange(0,strLabel3.length)];
    [strLabel3 addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#9d9d9d"]
                      range:[str3 rangeOfString:self.model.coupon]];
    _coupon.attributedText = strLabel3;

    NSString *str4 = [NSString stringWithFormat:@"订单编号: %ld",(long)self.model.orderID];
    strLabel4 = [[NSMutableAttributedString alloc] initWithString:str4];
    [strLabel4 addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#303030"] range:NSMakeRange(0,strLabel4.length)];
    [strLabel4 addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#9d9d9d"]
                      range:[str4 rangeOfString:[NSString stringWithFormat:@"%ld",(long)self.model.orderID]]];
    _orderID.attributedText = strLabel4;

}

- (void)setModel:(OrderDownPayment *)model {
    if (_model != model) {
        _model = model;
        [self createData];
    }
}
@end
