//
//  FriendDetailFooterView.h
//  YOUXINBAO
//
//  Created by Feili on 15/5/13.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "QCLoginOneViewController.h"
typedef NS_ENUM(NSInteger, FootViewButtonType)
{
    FootViewButtonTypeBorrow,  //向他借款
    FootViewButtonTypeLend,     //快速放款
    FootViewButtonTypeConform,  //确认添加
    FootViewButtonTypeReport,   //加入黑名单
};



@protocol FriendDetailFooterViewDelegate <NSObject>

-(void)friendDetailFooterViewSelectItem:(FootViewButtonType)buttonType;

@end

@interface FriendDetailFooterView : UIView

-(instancetype)initWithFrame:(CGRect)frame titles:(NSMutableArray *)titles;

@property(nonatomic,assign)id<FriendDetailFooterViewDelegate>delegate;

@property(nonatomic,strong)NSMutableArray *titles;

@end
