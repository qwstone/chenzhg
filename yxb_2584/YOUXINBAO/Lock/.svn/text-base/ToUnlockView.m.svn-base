//
//  ToUnlockView.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/4/22.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "ToUnlockView.h"
#import "YLSwipeLockView.h"
#import "QCLoginOneViewController.h"

#define kErrorAlertTag 30080

@interface ToUnlockView()<YLSwipeLockViewDelegate,UIAlertViewDelegate>

@property (nonatomic, weak) YLSwipeLockView *lockView;
@property (nonatomic, weak) UILabel *titleLabel;


@end

@implementation ToUnlockView
{
    NSString * cheshi;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        cheshi = @"036";
        self.backgroundColor = [UIColor colorWithRed:35/255.0 green:39/255.0 blue:54/255.0 alpha:1];
        //    self.view.backgroundColor = [UIColor grayColor];
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"绘制手势来解锁";
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.frame = CGRectMake(10, 60, self.bounds.size.width - 20, 20);
        titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *counterLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, self.bounds.size.width - 20, 20)];
        counterLabel.textColor = [UIColor redColor];
        counterLabel.textAlignment = NSTextAlignmentCenter;
        counterLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:counterLabel];
        self.counterLabel = counterLabel;
        self.counterLabel.hidden = YES;
        
        
        CGFloat viewWidth = self.bounds.size.width - 40;
        CGFloat viewHeight = viewWidth;
        
        YLSwipeLockView *lockView = [[YLSwipeLockView alloc] initWithFrame:CGRectMake(20, self.bounds.size.height - viewHeight - 40 - 100, viewWidth, viewHeight)];
        [self addSubview:lockView];
        
        self.lockView = lockView;
        self.lockView.delegate = self;
        
        self.unmatchCounter = 5;

    }
    
    return self;
}

-(YLSwipeLockViewState)swipeView:(YLSwipeLockView *)swipeView didEndSwipeWithPassword:(NSString *)password
{
    NSString *savedPassword = [[NSUserDefaults standardUserDefaults] objectForKey:@"gesturePassword"];
//    
//    if ([password isEqualToString:cheshi]) {
//        [self dismiss];
//    }
    if ([savedPassword isEqualToString:password]) {
        [self dismiss];
        return YLSwipeLockViewStateNormal;
    }else{
        self.unmatchCounter--;
        if (self.unmatchCounter == 0) {
            self.counterLabel.text = @"密码错误";
            self.counterLabel.hidden = NO;
            
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"您的密码已失效,请重新登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alter.tag = kErrorAlertTag;
            [alter show];
            
        }else {
            self.counterLabel.text = [NSString stringWithFormat:@"密码错误, 还有%lu 次机会", (unsigned long)self.unmatchCounter];
            self.counterLabel.hidden = NO;
        }
        
        
        return YLSwipeLockViewStateWarning;
    }
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == kErrorAlertTag && buttonIndex == 0) {
        [self loginout];
        
        [self dismiss];
        
        [self toLogin];
        
        
        
    }
}

- (void)loginout {
    QCUserModel *userModel = [[QCUserManager sharedInstance]getLoginUser];
    QCUserManager * um = [QCUserManager sharedInstance];
    userModel.isLogin = NO;
    userModel.gestureOpen = NO;
//    [YXBTool setGesturePassWord:nil];

    [um setLoginUser:userModel];
    
    //关闭上一个人手势密码的判断
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"gesturePassword"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //断开融云连接   不接受推送消息
    //        [[RCIM sharedRCIM] disconnect:NO];
    //            [self toLogin];
    
}

- (void)toLogin {
    QCLoginOneViewController * loginView = [[QCLoginOneViewController alloc]init];
    UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginView];
    [self.nav presentViewController:loginNav animated:YES completion:nil ];
}


-(void)dismiss{
    
    self.counterLabel.text = @"";
    [self removeFromSuperview];
}

- (void)show
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}




@end
