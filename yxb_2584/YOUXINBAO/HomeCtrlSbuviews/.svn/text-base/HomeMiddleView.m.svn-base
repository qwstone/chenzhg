//
//  HomeMiddleView.m
//  YOUXINBAO
//
//  Created by zjp on 15/5/20.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "HomeMiddleView.h"



#define addHight        2
@implementation HomeMiddleView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView {
    NSArray *imgarr = @[@"indexnav1-6",@"indexnav2-6",@"indexnav3-6"];
    if (kDeviceHeight == 667){
        imgarr = @[@"indexnav1-6",@"indexnav2-6",@"indexnav3-6"];
    }else if (kDeviceWidth > 375){
        imgarr = @[@"indexnav1-6plus",@"indexnav2-6plus",@"indexnav3-6plus"];
    }
    for (int i = 0; i < imgarr.count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(25+117*i, 25, 90, 90.0f/158*197)];
        button.tag = i+1000;
        if (kDeviceHeight == 480) {
            button.frame = CGRectMake(20+i*100, 12.5f-addHight, 80, 101.5f);
        }else if (kDeviceHeight == 568){
            button.frame = CGRectMake(20+i*100, 12.5f-addHight, 80, 101.5f);
        }else if (kDeviceHeight == 667){
            button.frame = CGRectMake(20+i*119.5f, 27.5-addHight, 96, 122);
        }else if (kDeviceWidth > 375){
            button.frame = CGRectMake(20+i*134, 30-addHight, 106, 137);
        }
        
        if (i == 0) {
            NSString  *imgName = @"indexnav1on";
            if (kDeviceHeight == 667){
                imgName = @"indexnav1-6on";
            }else if (kDeviceWidth > 375){
                imgName = @"indexnav1-6pluson";
            }
            self.hasNewfbut = [[UIButton alloc] initWithFrame:button.bounds];
            self.hasNewfbut.userInteractionEnabled = NO;
            [self.hasNewfbut setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
            [button addSubview:self.hasNewfbut];
        }
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:[UIImage imageNamed:imgarr[i]] forState:UIControlStateNormal];
        [self addSubview:button];

    }
}

- (void)buttonAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(HomeMiddleViewAction:)]) {
        [self.delegate HomeMiddleViewAction:sender.tag];
    }
    
}

@end
