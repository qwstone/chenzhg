//
//  QCCountLabel.m
//  YOUXINBAO
//
//  Created by Feili on 15/6/2.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCCountLabel.h"
#import "YXBTool.h"

@interface QCCountLabel ()
@property(nonatomic,strong)UIColor *moneyColor;
@property(nonatomic,assign)NSInteger times;//次数
@end
@implementation QCCountLabel
/*
-(void)autochangeFontsize:(double) number{
    if (self.numberSizeBlock == NULL) {
        if (number<100000) {
            [self setFont:[UIFont fontWithName:self.font.fontName size:60.0]];
        }
        else if (number<1000000){
            [self setFont:[UIFont fontWithName:self.font.fontName size:50.0]];
        }
        else if (number<10000000){
            [self setFont:[UIFont fontWithName:self.font.fontName size:40.0]];
        }
        else if (number<100000000){
            [self setFont:[UIFont fontWithName:self.font.fontName size:30.0]];
        }
    }
    else {
        self.numberSizeBlock(number);
    }
}

*/
-(void)changeFromNumber:(double) originalnumber toNumber:(double) newnumber withAnimationTime:(NSTimeInterval)timeSpan fitFontSize:(BOOL)yesOrNo{
    
    [UIView animateWithDuration:timeSpan delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        /*
        NSString *currencyStr = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithDouble: originalnumber]  numberStyle:NSNumberFormatterCurrencyStyle];
        currencyStr = [currencyStr substringWithRange:NSMakeRange(1, currencyStr.length-1)];
        if ([[currencyStr substringFromIndex:currencyStr.length-1] isEqualToString:@"0"]) {
            currencyStr =[currencyStr substringToIndex:currencyStr.length];
        }
        
        */
        NSString * currencyStr = [YXBTool countNumAndChangeformat:[NSString stringWithFormat:@"%.2f",originalnumber]];
//        [self autochangeFontsize:originalnumber];
        NSString *str = [NSString stringWithFormat:@"%@元",currencyStr];
        NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc] initWithString:str];
        
        [aStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0] range:NSMakeRange([str length] - 1, 1)];
        [aStr addAttribute:NSForegroundColorAttributeName value:self.moneyColor range:NSMakeRange([str length] - 1, 1)];
        
        self.attributedText = aStr;
        
    } completion:^(BOOL finished) {
        _times ++;
        NSLog(@"_times---%ld=====speed==%f",(long)_times,self.animationSpeed);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeSpan * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (_times >= self.animationSpeed)
            {
                _times = 0;
                [self changeFromNumber:newnumber toNumber:newnumber withAnimationTime:timeSpan fitFontSize:yesOrNo];

            }
            else if ((originalnumber==newnumber))
            {
                
            }
            else if ((newnumber-originalnumber)/self.animationSpeed<0.0011) {
                [self changeFromNumber:newnumber toNumber:newnumber withAnimationTime:timeSpan fitFontSize:yesOrNo];
            }
            else if(((newnumber-originalnumber)/self.animationSpeed)<(newnumber-originalnumber)){
                [self changeFromNumber:originalnumber+(newnumber-originalnumber)/self.animationSpeed toNumber:newnumber withAnimationTime:timeSpan fitFontSize:yesOrNo];
                
            }
        });
        
    }];
    
}

-(double)animationSpeed{
    double speed = ((NSNumber *)objc_getAssociatedObject(self, @selector(animationSpeed))).doubleValue;
    if (!speed) {
        speed = 100;
    }
    return speed;
}

-(void)setAnimationSpeed:(double)speed{
    objc_setAssociatedObject(self, @selector(animationSpeed), [NSNumber numberWithDouble:speed], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NumberSizeBlock)numberSizeBlock{
    return objc_getAssociatedObject(self, @selector(numberSizeBlock));
}

-(void)setNumberSizeBlock:(NumberSizeBlock) numberSizeBlock{
    objc_setAssociatedObject(self, @selector(numberSizeBlock), numberSizeBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

-(void)numberFrom:(double)fromNumber to:(double)toNumber fitFontSize:(BOOL)yesOrNo
{
    /*
#define AnimationTimeBaseSeconds 3
    CGFloat animationTime = AnimationTimeBaseSeconds;
    NSInteger speed = fabs(toNumber - fromNumber) ;
    
    speed = toNumber - fromNumber;
    if (speed <= 500) {
        speed = 10;
//        animationTime = AnimationTimeBaseSeconds / (CGFloat)speed;
    }
    else if(speed <= 1000)
    {
        speed = speed / 100;
//        animationTime = AnimationTimeBaseSeconds * 10;
        
    }else {
        speed = 5;
//        animationTime = AnimationTimeBaseSeconds;
        
    }

    
    
    animationTime = AnimationTimeBaseSeconds / (CGFloat)speed;

    */
    NSInteger speed = 20;
    CGFloat animationTime = 0.01;
    
    [self setAnimationSpeed:speed];
    
    if (yesOrNo) {
        
    }else {
        [self setNumberSizeBlock:^(double number) {
            //        bSelf.font = [UIFont systemFontOfSize:60.0];
        }];
        
    }
    [self changeFromNumber:fromNumber toNumber:toNumber withAnimationTime:animationTime fitFontSize:yesOrNo];
    
}


-(void)numberFrom:(double)fromNumber to:(double)toNumber fitFontSize:(BOOL)yesOrNo style:(QCCountLabelStyle)style
{
    _times = 0;
    [self.layer removeAllAnimations];
    if (style == QCCountLabelStyleRedbag) {
        self.moneyColor = [UIColor whiteColor];
    }else if (style == QCCountLabelStyleRemainMoney)
    {
        self.moneyColor = [UIColor grayColor];
    }
    else
    {
        self.moneyColor = [UIColor blackColor];

    }
    
    self.font = [UIFont systemFontOfSize:self.frame.size.height];
    
    //计算逗号的数量
    NSInteger commaNumber = 1 + [[NSString stringWithFormat:@"%f",toNumber] length]/3;
    
    NSString *str = [NSString stringWithFormat:@"%f元",toNumber];
    
//将逗号的数量添加到计算size的字符串中
    NSMutableString *mStr = [[NSMutableString alloc] initWithString:str];

    for (int i = 0; i < commaNumber; i ++) {
        [mStr appendString:@"，"];
    }
    
    /*
    CGSize size = [YXBTool getFontSizeWithString:mStr font:self.font constrainSize:CGSizeMake(CGFLOAT_MAX, self.height)];

    while ((size.width > self.width)) {
        self.font = [UIFont systemFontOfSize:self.font.pointSize - 5];
        size = [YXBTool getFontSizeWithString:mStr font:self.font constrainSize:CGSizeMake(CGFLOAT_MAX, self.height)];

    }
    
    */
    
    //处理暂无红包
    NSString *nullText = @"暂无红包";
    if (style == QCCountLabelStyleRedbag && (NSInteger)toNumber == 0) {
    
        self.text = nullText;
        self.textColor = _moneyColor;
        return;
    }
    
    self.minimumScaleFactor = 10.0/self.font.pointSize;
    self.adjustsFontSizeToFitWidth = YES;
    [self numberFrom:fromNumber to:toNumber fitFontSize:yesOrNo];
    
}

@end
