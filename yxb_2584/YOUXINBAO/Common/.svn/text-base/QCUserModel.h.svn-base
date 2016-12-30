//
//  QCUserModel.h
//  YOUXINBAO
//
//  Created by 张淼 on 14-5-28.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "TUnreadFlagCount.h"

@interface QCUserModel : NSObject<NSCoding>
{
//    User * currUser;
}

@property (nonatomic,retain) User * user;

@property (nonatomic,retain) TUnreadFlagCount * unreadCont;

@property (nonatomic,copy)NSString * firstMessageTime;

@property (nonatomic,copy)NSString * lastMessageTime;

//本地数据
@property (nonatomic,assign)BOOL isOpenPassword;
@property (nonatomic,assign)BOOL isLogin;

@property (nonatomic,assign)BOOL gestureOpen;
@end
