//
//  PostponeView.h
//  YOUXINBAO
//
//  Created by 张淼 on 15/5/13.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PostponeView;
@protocol PostponeViewDelegate <NSObject>

- (void)postponetView:(PostponeView *)postponeView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface PostponeView : UIView

@property (nonatomic,retain)    UITextField * textField;


@property (nonatomic,assign)id<PostponeViewDelegate>delegate;
- (id)initWithbtnTitleArray:(NSArray *)array;

- (void)show;
- (void)remove;

@end
