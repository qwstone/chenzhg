//
//  DetailsFooterView.h
//  YOUXINBAO
//
//  Created by 张淼 on 15/3/20.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AAActivitiesListViewController.h"

typedef enum {
    F_TAOLUN = 10000,//讨论
    F_BAOMING,//报名
    F_QUXIAOHUODONG,//取消活动
    F_YAOQINGHAOYOU,//邀请好友
    F_JIESHUHUODONG,//结束活动
    //发起新活动
    //编辑活动
    
}footerBtnStyle;

@protocol DetailsFooterViewDelegate <NSObject>

- (void)footerViewbuttonActionWithSender:(UIButton *)sender;

@end

@interface DetailsFooterView : UIView

@property (nonatomic,assign) ListStyle footerStyle;
@property (nonatomic,assign) id<DetailsFooterViewDelegate>delegate;

- (id)initWithNameArr:(NSArray *)nameArr;

@end
