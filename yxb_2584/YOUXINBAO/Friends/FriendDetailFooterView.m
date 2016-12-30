//
//  FriendDetailFooterView.m
//  YOUXINBAO
//
//  Created by Feili on 15/5/13.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "FriendDetailFooterView.h"
#import "YXBTool.h"
#import "UserState.h"

#define FriendDetailFooterViewTagStart 2000
#define FriendDetailFooterViewBtnBgColor (rgb(49, 136, 238, 1.0))

@interface FriendDetailFooterView ()

@end
@implementation FriendDetailFooterView

-(instancetype)initWithFrame:(CGRect)frame titles:(NSMutableArray *)titles
{
    self= [super initWithFrame:frame];
    if (self) {
        self.titles = titles;
        if (titles != nil) {
            [self initViews];

        }
        
    }
    return self;
}


-(void)initViews
{
    CGFloat fontSize = 18;
    //验证页面
    CGFloat leftAlign = 15;

    CGFloat x = leftAlign, y = leftAlign,w = self.width - 2 * x,h = 44;

    if ([_titles count] == 1) {
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.frame = CGRectMake(x, y, w, h);
        [addBtn setBackgroundImage:[YXBTool imageWithColor:FriendDetailFooterViewBtnBgColor] forState:UIControlStateHighlighted];
        [addBtn setBackgroundImage:[YXBTool imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        addBtn.layer.cornerRadius = 5.0;
        addBtn.clipsToBounds = YES;
        [addBtn setTitleColor:FriendDetailFooterViewBtnBgColor forState:UIControlStateNormal];
        [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];

        addBtn.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
        [addBtn setTitle:_titles[0] forState:UIControlStateNormal];
        addBtn.tag = FriendDetailFooterViewTagStart + 2;
        addBtn.backgroundColor = [UIColor blueColor];
        [addBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addBtn];
    }
    else
    {

        for (int i = 0; i < [_titles count]; i ++) {
            UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [tempBtn setTitle:_titles[i] forState:UIControlStateNormal];
            tempBtn.tag = FriendDetailFooterViewTagStart + i;
            tempBtn.backgroundColor = [UIColor blueColor];
            tempBtn.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];

            tempBtn.layer.cornerRadius = 5.0;
            tempBtn.clipsToBounds = YES;

            [tempBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

            if (i == [_titles count] - 1) {
                w =  120;
                h = h/2;
                x = self.width - w;
                fontSize = 15;
                [tempBtn setTitleColor:FriendDetailFooterViewBtnBgColor forState:UIControlStateNormal];
                tempBtn.backgroundColor = [UIColor clearColor];
                //隐藏加入黑名单按钮
                tempBtn.hidden = YES;
                
            }
            else
            {
                [tempBtn setBackgroundImage:[YXBTool imageWithColor:FriendDetailFooterViewBtnBgColor] forState:UIControlStateHighlighted];
                [tempBtn setBackgroundImage:[YXBTool imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];

                [tempBtn setTitleColor:FriendDetailFooterViewBtnBgColor forState:UIControlStateNormal];
                [tempBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];

            }
            
            tempBtn.frame = CGRectMake(x, y, w, h);
            tempBtn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
            [self addSubview:tempBtn];

            y = y + h + leftAlign;


        }
        
    }
}

-(void)buttonAction:(UIButton *)sender
{
    
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    if (!userModel.isLogin) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"您还没有登录，请登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alterView.tag = 10010;
        [alterView show];
        return;
    }
    if (sender.tag == 2000) {
        if ([UserState isLv1] == E_NO_OPERATE) {
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"为保障您的资金安全，借款前请先完善身份信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alterView.tag = 10086;
            [alterView show];
            return;
        }else if ([UserState isLv1] == E_IN_REVIEW) {
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"身份认证需要一段时间审核，您可以逛逛其他功能，认证通过后，我们会通知您" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alterView show];
            return;
        }else if ([UserState isLv1] == E_FAIL_UserStateRes) {
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"您的身份认证失败，请从新认证" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alterView show];
            return;
        }
    }else if (sender.tag == 2001) {
        
        if ([UserState isLv2] == E_NO_OPERATE) {
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"为保障您的资金安全，放款前请先完善身份信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alterView.tag = 10086;
            [alterView show];
            return;
        }else if ([UserState isLv2] == E_IN_REVIEW) {
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"身份认证需要一段时间审核，您可以逛逛其他功能，认证通过后，我们会通知您" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alterView show];
            return;
        }else if ([UserState isLv2] == E_FAIL_UserStateRes) {
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"您的身份认证失败，请从新认证" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alterView show];
            return;
        }
    }

    
    
    
//        if (userModel.user.accountStatus == 1) {
//            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"身份认证需要一段时间审核，您可以逛逛其他功能，认证通过后，我们会通知您" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//            //        alterView.tag = 10086;
//            [alterView show];
//            return;
//        }else if (userModel.user.accountStatus == 2) {
//            //通过
//        }else if (userModel.user.accountStatus == 4) {
////            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"身份认证需要一段时间审核，您可以逛逛其他功能，认证通过后，我们会通知您" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
////            [alterView show];
////            return;
//        }else if (userModel.user.accountStatus == 3) {
////            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"实名认证信息，审核失败，请重新进行实名认证" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
////            alterView.tag = 10086;
////            [alterView show];
////            return;
//        }else if (userModel.user.accountStatus == 0) {
//            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"为了更快的借入（借出）款项，请先完善身份信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            alterView.tag = 10086;
//            [alterView show];
//            return;
//        }
    NSString *title = sender.titleLabel.text;
    if (![title isEqualToString:@"已是好友"]) {
        if ((_delegate != nil)  && [_delegate respondsToSelector:@selector(friendDetailFooterViewSelectItem:)]) {
            [_delegate friendDetailFooterViewSelectItem:sender.tag-FriendDetailFooterViewTagStart];
        }
        else
        {
            NSLog(@"错误 %@",[self class]);
        }

    }
    else
    {
        
    }
}


- (void)toLogin {
     AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    QCLoginOneViewController * loginView = [[QCLoginOneViewController alloc]init];
    UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginView];
    [appDelegate.rootNav presentViewController:loginNav animated:YES completion:nil ];
}
- (UIViewController *)viewController {
    UIResponder *next = self.nextResponder;
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
    }while(next != nil);
    return nil;
}
- (void)toAuthentication {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    AuthenticationViewController *authentic = [[AuthenticationViewController alloc] init];
    [appDelegate.rootNav pushViewController:authentic animated:YES];
}

#pragma mark - UIAlterView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 10010) {
        if (buttonIndex == 1) {
            [self toLogin];
        }
    } else if (alertView.tag == 10086){
        if (buttonIndex == 1) {
            
            [self toAuthentication];
        }
    }
}

-(void)setTitles:(NSMutableArray *)titles
{
    //移除旧数据
    if (_titles == nil) {
        _titles = [NSMutableArray array];
    }
    else
    {
        [_titles removeAllObjects];
    }
    
    //设置新数据
    if (titles != nil) {
        
        _titles = titles;
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
        
        [self initViews];
    }
}

@end
