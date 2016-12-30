//
//  MapPopView.m
//  YOUXINBAO
//
//  Created by zjp on 15/11/17.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "MapPopView.h"
#import "YXBTool.h"

@implementation MapPopView {
    UIView *view;
}

- (id)initWithFrame:(CreditProviceMapData *)data type:(NSInteger)type{
    UIWindow * window = [[UIApplication sharedApplication].delegate window] ;
    self = [super initWithFrame:window.bounds];
    if (self) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 200)];
        view.backgroundColor = [UIColor whiteColor];
        view.center = self.center;
        view.layer.cornerRadius = 10;
        view.layer.masksToBounds = YES;
//        if (KDeviceOSVersion >= 8.0) {
//            UIBlurEffect *blur1 = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//            self.effectview1 = [[UIVisualEffectView alloc] initWithEffect:blur1];
//            self.effectview1.frame = self.bounds;
//            self.effectview1.layer.cornerRadius = 5;
//            self.effectview1.alpha = 0.7;
//            self.effectview1.userInteractionEnabled = YES;
//            self.effectview1.layer.masksToBounds = YES;
//            [self addSubview:self.effectview1];
//            [self.effectview1 addSubview:view];
//        
//        }else {
//        }
        self.backgroundColor = rgb(0, 0, 0, 0.7);
        [self addSubview:view];
        
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(80, 150, 90, 40)];
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        button.backgroundColor = [UIColor orangeColor];
        [button setTitle:@"知道了" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(butAction) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(95, 10, 60, 60)];
        label1.text = data.proviceName;
        label1.textAlignment = NSTextAlignmentCenter;
        label1.textColor = [UIColor whiteColor];
        label1.font = [UIFont boldSystemFontOfSize:15];
        [label1 setAdjustsFontSizeToFitWidth:YES];
        label1.layer.cornerRadius = label1.width/2;
        label1.layer.masksToBounds = YES;
        [view addSubview:label1];
        
        
        NSString *interviewTime = @"";
        NSString *interviewTime1 = @"";
        if (type == 1) {
            if ([data.averageFlag isEqualToString:@"1"]) {
                label1.textColor = rgb(120, 120, 120, 1);
                label1.backgroundColor = [YXBTool colorWithHexString:@"#FCEEB4"];
            }
            if ([data.averageFlag isEqualToString:@"2"]) {
//                label1.textColor = [UIColor darkGrayColor];
                label1.backgroundColor = [YXBTool colorWithHexString:@"#80CCD5"];
            }
            if ([data.averageFlag isEqualToString:@"3"]) {
                label1.backgroundColor = [YXBTool colorWithHexString:@"#1D93BE"];
            }
            
            interviewTime = [NSString stringWithFormat:@"有效用户数:%@人",data.str1];
            interviewTime1 = [NSString stringWithFormat:@"平均信用积分:%@分",data.str2];
        }else if (type == 2){
            if ([data.averageFlag isEqualToString:@"1"]) {
                label1.backgroundColor = [YXBTool colorWithHexString:@"#BFC0C0"];
            }
            if ([data.averageFlag isEqualToString:@"2"]) {
                label1.backgroundColor = [YXBTool colorWithHexString:@"#9FA0A0"];
            }
            if ([data.averageFlag isEqualToString:@"3"]) {
                label1.backgroundColor = [YXBTool colorWithHexString:@"#595656"];
            }
            
            interviewTime = [NSString stringWithFormat:@"失信人数:%@人",data.str1];
            interviewTime1 = [NSString stringWithFormat:@"失信比例:%@%%",data.str2];
        }
        

        
       UILabel* label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, label1.bottom+20, view.width, 25)];
        label2.textColor = [UIColor darkGrayColor];
        label2.textAlignment = NSTextAlignmentCenter;
        label2.font = [UIFont systemFontOfSize:15];
        [label2 setAdjustsFontSizeToFitWidth:YES];
        [view addSubview:label2];
        NSMutableAttributedString *strLabel4 = [[NSMutableAttributedString alloc] initWithString:interviewTime];
        [strLabel4 addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#0078C8"] range:[interviewTime rangeOfString:data.str1]];
        label2.attributedText = strLabel4;
        
        UILabel* label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, label2.bottom, view.width, 25)];
        label3.textColor = [UIColor darkGrayColor];
        label3.textAlignment = NSTextAlignmentCenter;
        label3.font = [UIFont systemFontOfSize:15];
        [label3 setAdjustsFontSizeToFitWidth:YES];
        [view addSubview:label3];
        NSMutableAttributedString *strLabel5 = [[NSMutableAttributedString alloc] initWithString:interviewTime1];
        [strLabel5 addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#0078C8"] range:[interviewTime1 rangeOfString:data.str2]];
        label3.attributedText = strLabel5;
        
    }
    return self;
}

- (void)butAction {
    [self hidden];
}


- (void)show:(CGPoint )p {
    UIWindow * window = [[UIApplication sharedApplication].delegate window] ;
    view.center=CGPointMake(p.x, p.y+144);
    view.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.5 animations:^{
        view.center=self.center;
        view.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        
    }];
    [window addSubview:self];
}
- (void)show {
    UIWindow * window = [[UIApplication sharedApplication].delegate window] ;
    [window addSubview:self];
}
- (void)hidden {
    [self removeFromSuperview];
}


- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
@end
