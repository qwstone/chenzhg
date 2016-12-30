//
//  HomeNewBottomView.m
//  YOUXINBAO
//
//  Created by zjp on 15/8/7.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "HomeNewBottomView.h"
#import "AAActivitiesListViewController.h"
#import "HomeBottomTablecell.h"
#import "MsgCenterMgr+Public.h"


#define lineWieth   kDeviceWidth/320*6
@implementation HomeNewBottomView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self createViewOld];
        [self createViewNew];
    }
    return self;
}

- (void)createViewNew {
    //沙龙峰会  发起活动  附近活动  三个按钮 底部的View
    UIView *Newview = [[UIView alloc]initWithFrame:CGRectMake(8, 7.5f, 248, 186)];
    if (kDeviceHeight == 480) {
        Newview.frame = CGRectMake(5, 5, 213, 150);
    }else if (kDeviceHeight == 568){
        Newview.frame = CGRectMake(5, 7.5f, 213, 152);
    }else if (kDeviceWidth > 375){
        Newview.frame = CGRectMake(8, 7.5f, 275, 197);
    }
    [self addSubview:Newview];
//    Newview.backgroundColor = [UIColor redColor];
    //土豪 跳到限时特惠 按钮
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Newview.width, (Newview.height/360*170-lineWieth))];
    button3.tag = 88888;
    [button3 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [button3 setBackgroundImage:[UIImage imageNamed:@"new-bt"] forState:UIControlStateNormal];
    [Newview addSubview:button3];
    
    //附近活动
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, button3.bottom+lineWieth, (Newview.width-lineWieth)/2, Newview.height/360*190)];
    button1.tag = 66666;
    [button1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setBackgroundImage:[UIImage imageNamed:@"new-act"] forState:UIControlStateNormal];
    [Newview addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(button1.right+lineWieth, button3.bottom+lineWieth, (Newview.width-lineWieth)/2, Newview.height/360*190)];
     button2.tag = 77777;
    [button2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [button2 setBackgroundImage:[UIImage imageNamed:@"yxbsy-act22"] forState:UIControlStateNormal];
    [Newview addSubview:button2];
    
    

//    NSLog(@"%.2f",button3.width);
//    NSLog(@"%.2f",button3.height);
    
    //信用大厅和下面那个按钮 底部的View
    UIView *Newrigthview= [[UIView alloc]initWithFrame:CGRectMake(Newview.right+7.5, 7.5f, kDeviceWidth- Newview.right-8-7.5, Newview.height)];
    if (kDeviceHeight == 480) {
        Newrigthview.frame = CGRectMake(Newview.right+7.5, 5,kDeviceWidth- Newview.right-5-7.5, Newview.height);
    }else if (kDeviceHeight == 568){
        Newrigthview.frame = CGRectMake(Newview.right+7.5, 7.5f, kDeviceWidth- Newview.right-5-7.5, Newview.height);
    }else if (kDeviceWidth > 375){
        Newrigthview.frame = CGRectMake(Newview.right+7.5, 7.5f, kDeviceWidth- Newview.right-8-7.5, Newview.height);
    }
    [self addSubview:Newrigthview];
//     Newrigthview.backgroundColor = [UIColor blueColor];
    
    NSArray *imgarr = @[@"index-nav44"];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,Newrigthview.width, Newrigthview.width/211*189)];
    button.tag = 1000;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:imgarr[0]] forState:UIControlStateNormal];
    [Newrigthview addSubview:button];
    

    //好友 按钮
    UIButton *buttonNew = [[UIButton alloc] initWithFrame:CGRectMake(0, button.bottom+lineWieth,Newrigthview.width, Newrigthview.height-button.height-lineWieth-1)];
    buttonNew.tag = 1002;
    [buttonNew addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttonNew setBackgroundImage:[UIImage imageNamed:@"new-hygl"] forState:UIControlStateNormal];
//    [buttonNew setBackgroundImage:[UIImage imageNamed:@"替换这里图片就可以了"] forState:UIControlStateNormal];
    [Newrigthview addSubview:buttonNew];
    
    //新好友 出现带点按钮
    self.hasNewfbut = [[UIButton alloc] initWithFrame:buttonNew.bounds];
    self.hasNewfbut.userInteractionEnabled = NO;
//    [self.hasNewfbut setBackgroundImage:[UIImage imageNamed:@"替换这里图片就可以了"] forState:UIControlStateNormal];
    [self.hasNewfbut setBackgroundImage:[UIImage imageNamed:@"new-hygl-on"] forState:UIControlStateNormal];
    [buttonNew addSubview:self.hasNewfbut];
    
}



- (void)createViewOld {
    //沙龙峰会  发起活动  附近活动  三个按钮 底部的View
    UIView *Newview = [[UIView alloc]initWithFrame:CGRectMake(8, 7.5f, 248, 186)];
    if (kDeviceHeight == 480) {
        Newview.frame = CGRectMake(5, 5, 213, 150);
    }else if (kDeviceHeight == 568){
        Newview.frame = CGRectMake(5, 7.5f, 213, 152);
    }else if (kDeviceWidth > 375){
        Newview.frame = CGRectMake(8, 7.5f, 275, 197);
    }
    [self addSubview:Newview];
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, (Newview.width-lineWieth)/2, Newview.height/360*190)];
    button1.tag = 66666;
    [button1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setBackgroundImage:[UIImage imageNamed:@"yxbsy-act11"] forState:UIControlStateNormal];
    [Newview addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(button1.right+lineWieth, 0, (Newview.width-lineWieth)/2, Newview.height/360*190)];
    button2.tag = 77777;
    [button2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [button2 setBackgroundImage:[UIImage imageNamed:@"yxbsy-act22"] forState:UIControlStateNormal];
    [Newview addSubview:button2];
    
    
    //附近活动 按钮
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(0, Newview.height/360*190+lineWieth, Newview.width, (Newview.height/360*170-lineWieth))];
    button3.tag = 88888;
    [button3 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [button3 setBackgroundImage:[UIImage imageNamed:@"yxbsy-act33"] forState:UIControlStateNormal];
    [Newview addSubview:button3];
    //    NSLog(@"%.2f",button3.width);
    //    NSLog(@"%.2f",button3.height);
    
    //信用大厅和下面那个按钮 底部的View
    UIView *Newrigthview= [[UIView alloc]initWithFrame:CGRectMake(Newview.right+7.5, 7.5f, kDeviceWidth- Newview.right-8-7.5, 186)];
    if (kDeviceHeight == 480) {
        Newrigthview.frame = CGRectMake(Newview.right+7.5, 5,kDeviceWidth- Newview.right-5-7.5, 150);
    }else if (kDeviceHeight == 568){
        Newrigthview.frame = CGRectMake(Newview.right+7.5, 7.5f, kDeviceWidth- Newview.right-5-7.5, 152);
    }else if (kDeviceWidth > 375){
        Newrigthview.frame = CGRectMake(Newview.right+7.5, 7.5f, kDeviceWidth- Newview.right-8-7.5, 197);
    }
    [self addSubview:Newrigthview];
    
    
    NSArray *imgarr = @[@"index-nav44"];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,Newrigthview.width, kDeviceWidth/320*73)];
    button.tag = 1000;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:imgarr[0]] forState:UIControlStateNormal];
    [Newrigthview addSubview:button];
    
    
    
    UIButton *buttonNew = [[UIButton alloc] initWithFrame:CGRectMake(0, button.bottom+lineWieth,Newrigthview.width, Newrigthview.height-button.height-lineWieth)];
    buttonNew.backgroundColor = [UIColor brownColor];
    buttonNew.layer.cornerRadius = 3;
    buttonNew.tag = 1001;
    [buttonNew addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttonNew setTitle:@"搜索换图" forState:UIControlStateNormal];
    //    [buttonNew setBackgroundImage:[UIImage imageNamed:imgarr[0]] forState:UIControlStateNormal];
    [Newrigthview addSubview:buttonNew];
    
    
        for (int i = 0; i < imgarr.count; i++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(Newview.right+7.5, 8+i*7.5+86, 105, 90)];
            button.tag = i+1000;
            if (i == 0) {
                if (kDeviceHeight == 480) {
                    button.frame = CGRectMake(Newview.right+7.5, i*78+5, 90, 73);
                }else if (kDeviceHeight == 568){
                    button.frame = CGRectMake(Newview.right+7.5, i*78+7.5f, 90, 73);
                }else if (kDeviceWidth > 375){
                    button.frame = CGRectMake(Newview.right+8, 7.5+i*7.5+i*94.5f, 115, 95);
                }else if (kDeviceWidth == 375){
                    button.frame = CGRectMake(Newview.right+7.5, 8+i*7.5, 105, 90);
                }
            }else{
                if (kDeviceHeight == 480) {
                    button.frame = CGRectMake(Newview.right+7.5, (i-1)*74/2+78+5, 90, 70/2);
                }else if (kDeviceHeight == 568){
                    button.frame = CGRectMake(Newview.right+7.5, (i-1)*78/2+78+7.5f, 90, 70/2);
                }else if (kDeviceWidth > 375){
                    button.frame = CGRectMake(Newview.right+8, 7.5+i*7.5+(i-1)*84/2+94.5f, 115, 90/2);
                }else if (kDeviceWidth == 375){
                    button.frame = CGRectMake(Newview.right+7.5, 8+i*7.5+(i-1)*78/2+88, 105, 84/2);
                }
    
            }
            if (i == 2) {
    
                self.hasNewfbut = [[UIButton alloc] initWithFrame:button.bounds];
                self.hasNewfbut.userInteractionEnabled = NO;
                [self.hasNewfbut setBackgroundImage:[UIImage imageNamed:@"index-hygn2ewsy"] forState:UIControlStateNormal];
                [button addSubview:self.hasNewfbut];
            }
            //        button.backgroundColor = [UIColor redColor];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [button setBackgroundImage:[UIImage imageNamed:imgarr[i]] forState:UIControlStateNormal];
            [self addSubview:button];
        }
    
}

- (void)buttonAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(HomeNewBottomViewAction:)]) {
        [self.delegate HomeNewBottomViewAction:sender.tag];
    }
    
    
}

@end
