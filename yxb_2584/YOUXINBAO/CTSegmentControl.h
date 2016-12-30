//
//  CTSegmentControl.h
//  CustomSegmentControl
//
//  Created by CH10 on 16/3/16.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CTSegmentControlDelegate <NSObject>

-(void)segmentControlDidSelectedIndex:(NSInteger)index;

@end

//typedef void(^myBlock)(NSInteger index);

@interface CTSegmentControl : UIView


@property (nonatomic,assign)id<CTSegmentControlDelegate>delegate;

//@property (nonatomic,strong) myBlock CurrentIndexblock;

//-(void)currentIndexIs:(myBlock)block;

/**
 *被选中的item 从0开始
 */
@property (nonatomic,assign)NSInteger selectedIndex;
/**
 *是否开启滑块的动画  默认开启
 */
@property (nonatomic,assign)BOOL startAnimation;
/**
 *标题的字体大小
 */
@property (nonatomic,strong)UIFont *itemFont;
/**
 *滑块
 */
@property (nonatomic,weak)UIView *sliderLine;
/**
 *设置标题的默认字体颜色（默认黑色）
 */
@property (nonatomic,weak)UIColor *segmentTintColor;
/**
 *被选中的item的字体和滑块的颜色（默认灰色）
 */
@property (nonatomic,weak)UIColor *selectedItemColor;
/**
 *是否显示边框
 */
@property (nonatomic,assign)BOOL displayRect;
/**
 *边框颜色（默认灰色）
 */
@property (nonatomic,weak)UIColor *rectColor;
/**
 *frame:
 *items:标题
 *itemFont:标题字体大小
 *return: CTSegmentControl
 */
- (instancetype)initWithFrame:(CGRect)frame andItems:(NSArray *)items andItemFont:(UIFont *)itemFont;
+ (instancetype)CTSegmentControlWithFrame:(CGRect)frame andItems:(NSArray *)items andItemFont:(UIFont *)itemFont;
@end
