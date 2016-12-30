//
//  UILabel+YXYNumberAnimationLabel.m
//  YXYNumberAnimationLabelDemo
//
//  Created by 杨萧玉 on 14-5-25.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//
//#define AnimationSpeed 100
#import "UILabel+YXYNumberAnimationLabel.h"
#import <objc/runtime.h>

@implementation UILabel (YXYNumberAnimationLabel) 

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
-(void)changeFromNumber:(double) originalnumber toNumber:(double) newnumber withAnimationTime:(NSTimeInterval)timeSpan fitFontSize:(BOOL)yesOrNo{
    
    [UIView animateWithDuration:timeSpan delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        NSString *currencyStr = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithDouble: originalnumber]  numberStyle:NSNumberFormatterCurrencyStyle];
        currencyStr = [currencyStr substringWithRange:NSMakeRange(1, currencyStr.length-1)];
        if ([[currencyStr substringFromIndex:currencyStr.length-1] isEqualToString:@"0"]) {
            currencyStr =[currencyStr substringToIndex:currencyStr.length];
        }
        [self autochangeFontsize:originalnumber];
        NSString *str = [NSString stringWithFormat:@"%@元",currencyStr];
        NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc] initWithString:str];
        if (yesOrNo) {
            [aStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0] range:NSMakeRange([str length] - 1, 1)];
            [aStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange([str length] - 1, 1)];
            
        }else {
            [aStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0] range:NSMakeRange([str length] - 1, 1)];
            [aStr addAttribute:NSForegroundColorAttributeName value:rgb(163, 163, 173, 1) range:NSMakeRange([str length] - 1, 1)];
        }
        
        self.attributedText = aStr;
        
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeSpan * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if ((originalnumber==newnumber)) {
                
            }
            else if ((newnumber-originalnumber)/self.animationSpeed<0.0011) {
                [self changeFromNumber:newnumber toNumber:newnumber withAnimationTime:timeSpan fitFontSize:yesOrNo];
            }
            else if(((newnumber-originalnumber)/self.animationSpeed)<(newnumber-originalnumber)){
                [self changeFromNumber:originalnumber+(newnumber-originalnumber)/self.animationSpeed toNumber:newnumber withAnimationTime:timeSpan fitFontSize:yesOrNo];
                
            }
//            else if(originalnumber==newnumber){
//                //            [self changeFromNumber:newnumber toNumber:newnumber withAnimationTime:timeSpan];
//                return ;
//                
//            }
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

-(void)numberFrom:(CGFloat)fromNumber to:(CGFloat)toNumber fitFontSize:(BOOL)yesOrNo
{
#define AnimationTimeBaseSeconds 0.001
    CGFloat animationTime = AnimationTimeBaseSeconds;

    self.adjustsFontSizeToFitWidth = YES;
    NSInteger speed = fabs(toNumber - fromNumber) ;

    speed = toNumber - fromNumber;
    if (speed <= 10) {
        speed = 10;
        animationTime = AnimationTimeBaseSeconds * 100;
    }
    else if(speed <= 200)
    {
        speed = 100;
        animationTime = AnimationTimeBaseSeconds * 10;

    }else {
        speed = 200;
        animationTime = AnimationTimeBaseSeconds;

    }
//    speed = 500;
//    if (speed < 100) {
//
//       animationTime = AnimationTimeBaseSeconds * 10;
//    }
//    else
//    {
//        animationTime = AnimationTimeBaseSeconds;
//    }
//    
    [self setAnimationSpeed:speed];
    if (yesOrNo) {
        
    }else {
//        __block UILabel *bSelf = self;
        [self setNumberSizeBlock:^(double number) {
            //        bSelf.font = [UIFont systemFontOfSize:60.0];
        }];
        
    }
    [self changeFromNumber:fromNumber toNumber:toNumber withAnimationTime:animationTime fitFontSize:yesOrNo];

}

@end
