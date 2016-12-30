//
//  QCCountLabel.h
//  YOUXINBAO
//
//  Created by Feili on 15/6/2.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef void(^NumberSizeBlock)(double number);

typedef NS_ENUM(NSInteger, QCCountLabelStyle)
{
    QCCountLabelStyleRedbag = 1,//红包金额
    QCCountLabelStyleRemainMoney = 2,//账户余额
};

@interface QCCountLabel : UILabel


/**
 *  @author chenglibin
 *
 *  label过度动画
 *
 *  @param fromNumber 起始数字
 *  @param toNumber   结束数字
 *  @param yesOrNo    是否设置字体
 *  @param style      类型
 */
-(void)numberFrom:(double)fromNumber to:(double)toNumber fitFontSize:(BOOL)yesOrNo style:(QCCountLabelStyle)style;


@end
