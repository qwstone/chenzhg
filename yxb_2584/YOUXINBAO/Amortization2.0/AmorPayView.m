//
//  AmorPayView.m
//  YOUXINBAO
//
//  Created by Feili on 15/9/18.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AmorPayView.h"
#import "AmorPayButton.h"
#import "YXBTool.h"
#import "UIAlertView+Block.h"

@interface AmorPayView ()

@property(nonatomic,strong)NSMutableArray *payTypeArray;

@end

@implementation AmorPayView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initViews];
        self.clipsToBounds = YES;
    }
    
    return self;
}

-(void)initViews
{
    
}

-(void)setPayTypeArray:(NSMutableArray *)payTypeArray
{
    _payTypeArray = payTypeArray;
    
    if (self.subviews != nil) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    
    NSInteger count = [_payTypeArray count];
    CGFloat w = kDeviceWidth / count;
    CGFloat x = 0;
    for (int i = 0; i < count; i ++) {
        AmorPayButton *payBtn = [AmorPayButton buttonWithType:UIButtonTypeCustom];
        x = i * w;
        CGFloat y = 0, h = 50;
        payBtn.frame = CGRectMake(x, y, w, h);
        payBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        payBtn.layer.borderWidth = 1.0;
        payBtn.payType = [_payTypeArray[i] integerValue];
        [payBtn setTitleColor:[YXBTool colorWithHexString:@"#2C91EC"] forState:UIControlStateNormal];
        [payBtn setTitle:[self nameWithPayType:payBtn.payType] forState:UIControlStateNormal];
        [payBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:payBtn];
    }
    
    
}

-(NSString *)nameWithPayType:(AmorOrderPayType)payType
{
    //* 底部按钮显示控制 0【不显示按钮】， 1【付款】， 2【取消订单】， 3【确认收货】， 4【取消订单】 【付款】, 5【取消订单】【选择担保人】，
    //* 6【代付】【还款】

    NSString *title = @"";
    switch (payType) {
        case AmorOrderPayTypeFukuan:
        {
            title = @"付   款";
        }
            break;
        case AmorOrderPayTypeCancelOrder:
        {
            title = @"取消订单";
        }
            break;

        case AmorOrderPayTypeConfirmGoods:
        {
            title = @"确认收货";
        }
            break;
        case AmorOrderPayTypeSelectPeople:
        {
            title = @"选择担保人";
        }
            break;
        case AmorOrderPayTypeOtherPay:
        {
            title = @"代   付";
        }
            break;
            
        case AmorOrderPayTypeHuankuan:
        {
            title = @"还    款";
        }
            break;


            
        default:
            break;
    }
    
    return title;
}

-(void)buttonAction:(AmorPayButton *)button
{
    AmorOrderPayType payType = button.payType;
   // [ProgressHUD showSuccessWithStatus:[self nameWithPayType:payType]];

    
    if (_delegate && [_delegate respondsToSelector:@selector(amorPayViewPayButtonSelectedWithAmorType:)]) {
        if (payType==AmorOrderPayTypeOtherPay||payType==AmorOrderPayTypeOtherPayAll) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"代付当前期",@"代付全部", nil];
            [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
                
                if (buttonIndex == 1) {
                    
                    button.payType= AmorOrderPayTypeOtherPay;
                    AmorOrderPayType payType=button.payType;
                    [_delegate amorPayViewPayButtonSelectedWithAmorType:payType];
                }
                else if(buttonIndex==2){
                    
                    button.payType=AmorOrderPayTypeOtherPayAll;
                    AmorOrderPayType payType=button.payType;
                    [_delegate amorPayViewPayButtonSelectedWithAmorType:payType];
                }
            

            }];
  
            
        }
        else if (payType==AmorOrderPayTypeHuankuan||payType==AmorOrderPayTypeHuankuanFull){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:nil delegate:nil cancelButtonTitle: @"取消" otherButtonTitles:@"还款当前期",@"全额还款",nil];
            [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
                
                if (buttonIndex == 1) {
                    
                    button.payType= AmorOrderPayTypeHuankuan;
                    AmorOrderPayType payType=button.payType;
                    [_delegate amorPayViewPayButtonSelectedWithAmorType:payType];
                }
                else if(buttonIndex==2){
                    
                    button.payType=AmorOrderPayTypeHuankuanFull;
                    AmorOrderPayType payType=button.payType;
                    [_delegate amorPayViewPayButtonSelectedWithAmorType:payType];
                }

            }];
            
        }
        else if(payType==AmorOrderPayTypeCancelOrder){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"是否确认取消订单" message:nil delegate:nil cancelButtonTitle: @"取消" otherButtonTitles:@"确定",nil];
            [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
                
                if (buttonIndex == 1) {
                    
                    button.payType= AmorOrderPayTypeCancelOrder;
                    AmorOrderPayType payType=button.payType;
                    [_delegate amorPayViewPayButtonSelectedWithAmorType:payType];
                }
                
            }];
 
        
        }
        else if(payType==AmorOrderPayTypeConfirmGoods){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"是否确认收货" message:nil delegate:nil cancelButtonTitle: @"取消" otherButtonTitles:@"确定",nil];
            [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
                
                if (buttonIndex == 1) {
                    
                    button.payType= AmorOrderPayTypeConfirmGoods;
                    AmorOrderPayType payType=button.payType;
                    [_delegate amorPayViewPayButtonSelectedWithAmorType:payType];
                }
                
            }];
            
            
        }
        else{
             [_delegate amorPayViewPayButtonSelectedWithAmorType:payType];
        
        }

    }


}

-(void)setButtonType:(NSInteger)buttonType
{
    //* 底部按钮显示控制 0【不显示按钮】， 1【付款】， 2【取消订单】， 3【确认收货】， 4【取消订单】 【付款】, 5【取消订单】【选择担保人】，
    //* 6【代付】【还款】

    self.payTypeArray = [NSMutableArray array];

    
    if(buttonType == 0)
    {
        self.payTypeArray = [NSMutableArray array];
    }else if (buttonType == 1)
    {
//        1【付款】
        self.payTypeArray = [NSMutableArray arrayWithObjects:
                             [NSString stringWithFormat:@"%ld",(long)AmorOrderPayTypeFukuan],
                             nil];
    }else if (buttonType == 2)
    {
//         2【取消订单】
        self.payTypeArray = [NSMutableArray arrayWithObjects:
                             [NSString stringWithFormat:@"%ld",(long)AmorOrderPayTypeCancelOrder],
                             nil];
    }
    else if (buttonType == 3)
    {
//        3【确认收货】
        self.payTypeArray = [NSMutableArray arrayWithObjects:
                             [NSString stringWithFormat:@"%ld",(long)AmorOrderPayTypeConfirmGoods],
                             nil];
    }
    else if (buttonType == 4)
    {
//        4【取消订单】 【付款】
        self.payTypeArray = [NSMutableArray arrayWithObjects:
                             [NSString stringWithFormat:@"%ld",(long)AmorOrderPayTypeCancelOrder],
                             [NSString stringWithFormat:@"%ld",(long)AmorOrderPayTypeFukuan],
                             nil];
    }
    else if (buttonType == 5)
    {
        //        4【取消订单】 【选择担保人】
        self.payTypeArray = [NSMutableArray arrayWithObjects:
                             [NSString stringWithFormat:@"%ld",(long)AmorOrderPayTypeCancelOrder],
                             [NSString stringWithFormat:@"%ld",(long)AmorOrderPayTypeSelectPeople],
                             nil];
    }
    else if (buttonType == 6)
    {
        //* 6【代付】【还款】
        self.payTypeArray = [NSMutableArray arrayWithObjects:
                             [NSString stringWithFormat:@"%ld",(long)AmorOrderPayTypeOtherPay],
                             [NSString stringWithFormat:@"%ld",(long)AmorOrderPayTypeHuankuan],
                             nil];
    }





}

@end
