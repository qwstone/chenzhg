//
//  FriendDetailHeaderView.h
//  YOUXINBAO
//
//  Created by Feili on 15/5/13.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "QCBaseView.h"


@protocol FriendDetailHeaderViewDelegate <NSObject>

-(void)imageActionWithImageView:(UIImageView *)imageView;
@end

@interface FriendDetailHeaderView : QCBaseView

@property(nonatomic,strong)NSString *xinyongGrade;
@property(nonatomic,strong)NSString *realName;
@property(nonatomic,assign)BOOL isFriend;
@property(nonatomic,strong)User *user;

@property(nonatomic,assign)id<FriendDetailHeaderViewDelegate>delegate;

@end
