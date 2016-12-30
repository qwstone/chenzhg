//
//  TMCustomAlertView.m
//  YOUXINBAO
//
//  Created by CH10 on 15/12/15.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "TMCustomAlertView.h"
#define AlertWidth 280
#define AlertHeight 160
@implementation TMCustomAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createAlertView];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createAlertView];
    }
    return self;
}
-(void)updateAlertWithTitle:(NSString *)title Message1:(NSString *)message1 Message2:(NSString *)message2 CancleBtnTitle:(NSString *)cancleBtnTitle SureBtnTitle:(NSString *)sureBtnTitle{
    self.titleLabel.text = title;
    self.messageLabel1.text = message1;
    self.messageLabel2.text = message2;
    [self.cancleBtn setTitle:cancleBtnTitle forState:UIControlStateNormal];
    [self.chongzhiBtn setTitle:sureBtnTitle forState:UIControlStateNormal];
}
-(void)createAlertView{
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = YES;
    UIView *tempAlertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AlertWidth, AlertHeight)];
    tempAlertView.backgroundColor = [UIColor whiteColor];
    tempAlertView.center = self.center;
    UILabel *tempTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, AlertWidth, 22)];
    tempTitleLabel.textAlignment = NSTextAlignmentCenter;
    tempTitleLabel.font = [UIFont systemFontOfSize:22];
    tempTitleLabel.textColor = rgb(51, 51, 51, 1);

    [tempAlertView addSubview:tempTitleLabel];
    
    UILabel *tempMessageLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, tempTitleLabel.bottom+10, AlertWidth, 20)];
    tempMessageLabel1.textColor = rgb(128, 128, 128, 1);
    tempMessageLabel1.font = [UIFont systemFontOfSize:18];
    tempMessageLabel1.textAlignment = NSTextAlignmentCenter;
    [tempAlertView addSubview:tempMessageLabel1];
    
    UILabel *tempMessageLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, tempMessageLabel1.bottom+5, AlertWidth, 20)];
    tempMessageLabel2.textColor = rgb(128, 128, 128, 1);
    tempMessageLabel2.font = [UIFont systemFontOfSize:18];
    tempMessageLabel2.textAlignment = NSTextAlignmentCenter;
    [tempAlertView addSubview:tempMessageLabel2];
    
    
    UIButton *tempCancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tempCancleBtn.frame = CGRectMake(0, AlertHeight-60, AlertWidth/2.0, 60);
    tempCancleBtn.backgroundColor = rgb(179, 179, 179, 1);
    tempCancleBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [tempCancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tempCancleBtn addTarget:self action:@selector(cancleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [tempAlertView addSubview:tempCancleBtn];
    
    UIButton *tempChongZhi = [UIButton buttonWithType:UIButtonTypeCustom];
    tempChongZhi.frame = CGRectMake(AlertWidth/2.0, AlertHeight-60, AlertWidth/2.0, 60);
    tempChongZhi.titleLabel.font = [UIFont systemFontOfSize:20];
    tempChongZhi.backgroundColor = rgb(237, 46, 36, 1);
    [tempChongZhi addTarget:self action:@selector(chongzhiBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [tempAlertView addSubview:tempChongZhi];
    self.titleLabel = tempTitleLabel;
    self.messageLabel1 = tempMessageLabel1;
    self.messageLabel2 = tempMessageLabel2;
    self.cancleBtn = tempCancleBtn;
    self.chongzhiBtn = tempChongZhi;
    self.alertView = tempAlertView;
    [self addSubview:tempAlertView];
}
-(void)cancleBtnClick:(UIButton *)btn{
    [self.delegate btnClickedAtIndex:0 Tag:self.tag];
    self.hidden = YES;
}
-(void)chongzhiBtnClick:(UIButton *)btn{
    [self.delegate btnClickedAtIndex:1 Tag:self.tag];
}
@end
