//
//  HomeNewBottomView.h
//  YOUXINBAO
//
//  Created by zjp on 15/8/7.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HomeNewBottomViewDelegate <NSObject>

@optional
- (void)HomeNewBottomViewAction:(NSInteger)senderTag;

@end
@interface HomeNewBottomView : UIView


@property (nonatomic, assign) id<HomeNewBottomViewDelegate> delegate;
@property(nonatomic,strong)NSMutableArray   *bottomViewMuArray;

@property(nonatomic,strong)UIButton         *hasNewfbut;
@end
