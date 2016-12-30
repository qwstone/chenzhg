//
//  LicaiButton.h
//  YOUXINBAO
//
//  Created by Walice on 15/12/14.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LicaiButton : UIButton
{
    UILabel *_moneyLabel;
    UILabel *_nameLabel;
}

@property(nonatomic,assign) NSString *money; //钱数 ￥2000 以￥开头
@property(nonatomic,copy)   NSString *name;  //名称 三种 总额、现金、红包

-(void)setMoneyButtonWithMoney:(NSString *)money name:(NSString *)name;
@end