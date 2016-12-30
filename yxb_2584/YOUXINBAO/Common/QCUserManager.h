//
//  QCUserManager.h
//  YOUXINBAO
//
//  Created by 张淼 on 14-5-29.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QCUserModel.h"

@interface QCUserManager : NSObject
{
    QCUserModel * _currUser;

}

           

+ (id)sharedInstance;
- (void)setLoginUser:(QCUserModel *)m;
- (QCUserModel *)getLoginUser;



@end
