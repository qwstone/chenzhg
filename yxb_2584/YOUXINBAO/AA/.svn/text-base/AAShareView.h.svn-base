//
//  AAShareView.h
//  YOUXINBAO
//
//  Created by CH10 on 15/6/22.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AAShareView;

typedef enum{
    AAShareViewTypeAA,  //aa活动分享
    AAShareViewTypeFriend   //好友分享
}AAShareViewType;

@protocol AAShareViewDelegate <NSObject>
@optional
//微信好友
- (void)AAShareViewWeixinSessionButtonDidClicked:(AAShareView *)view;
//微信朋友圈
- (void)AAShareViewWeixinTimelineContentButtonDidClicked:(AAShareView *)view;
//投诉
- (void)AAShareViewLodgeButtonDidClicked:(AAShareView *)view;
//收款
- (void)AAShareViewGatheringButtonDidClicked:(AAShareView *)view;
//退款
- (void)AAShareViewRefundingButtonDidClicked:(AAShareView *)view;
@end

@interface AAShareView : UIView

@property (nonatomic,assign) id<AAShareViewDelegate> delegate;

@property (nonatomic,assign) AAShareViewType type;

- (id)initWithType:(AAShareViewType)type;

- (void)setLodgeButtonHidden:(BOOL)yesOrNo;

- (void)show;
- (void)hide;

@end
