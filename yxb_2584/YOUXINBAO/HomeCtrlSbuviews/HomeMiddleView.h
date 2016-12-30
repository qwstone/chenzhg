//
//  HomeMiddleView.h
//  YOUXINBAO
//
//  Created by zjp on 15/5/20.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HomeMiddleViewDelegate <NSObject>

@optional
- (void)HomeMiddleViewAction:(NSInteger)senderTag;

@end
@interface HomeMiddleView : UIView



@property (nonatomic, assign) id<HomeMiddleViewDelegate> delegate;
@property(nonatomic,strong)UIButton         *hasNewfbut;
@end
