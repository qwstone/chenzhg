//
//  MoneyButton.h
//  LotteryApp
//  此类用于显示我的界面里（钱数+总额）button
//  Created by 程立彬 on 14-4-30.
//  Copyright (c) 2014年 windo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyInfoConfig.h"

@interface MoneyButton : UIButton
{
    UILabel *_moneyLabel;
    UILabel *_nameLabel;
    UIButton *_nextButton;
}
//@property(nonatomic, retain)UILabel *moneyLabel;
//@property(nonatomic, retain)UILabel *nameLabel;
@property(nonatomic,assign) NSString *money; //钱数 ￥2000 以￥开头
@property(nonatomic,copy)   NSString *name;  //名称 三种 总额、现金、红包
@property (nonatomic,assign) enum MoneyButtonType type;//按钮类型

-(void)setMoneyButtonWithMoney:(NSString *)money name:(NSString *)name;
-(void)setMoneyButtonColorWithMoneyColor:(UIColor*)moneyColor nameColor:(UIColor*)nameColor;
@end
