//
//  FriendDetailViewController.h
//  YOUXINBAO
//
//  Created by Feili on 15/5/12.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "User.h"

@interface FriendDetailViewController : QCBaseViewController

@property(nonatomic,strong)User *user;
//@property(nonatomic,assign)BOOL isCheckFriend;//是否是验证好友的界面
//@property(nonatomic,assign)BOOL isFriend;//0——》不是好友默认  1——》已是好友

@end
