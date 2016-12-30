//
//  FriendPopView.h
//  YOUXINBAO
//
//  Created by CH10 on 15/8/6.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FriendPopView;
@protocol FriendPopViewDelegate <NSObject>
@optional
- (void)FriendPopView:(FriendPopView *)popView clickedAtIndex:(NSInteger)index;

@end

@interface FriendPopView : UIView

@property (nonatomic,strong) NSArray *items;
@property (nonatomic,assign) id<FriendPopViewDelegate> delegate;

//FriendPopItem数组
- (id)initWithItems:(NSArray *)items;
- (void)showFromPoint:(CGPoint)point;
- (void)dismiss;

@end

@interface FriendPopItem : UIButton

@property (readwrite, nonatomic, strong) UIColor *titleColor;
@property (readwrite, nonatomic) NSTextAlignment alignment;

+ (instancetype) menuItem:(NSString *) title
                    image:(UIImage *) image;
- (void)setItemSize:(CGSize)size;

@end
