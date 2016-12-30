//
//  CustomProgressView.h
//  YOUXINBAO
//
//  Created by CH10 on 15/11/12.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomProgressView : UIView
@property(nonatomic,assign)CGFloat progress;
@property(nonatomic,strong)UIColor *trackTintColor;
@property(nonatomic,strong)UIColor *progressTintColor;
- (instancetype)initWithFrame:(CGRect)frame progressTintColor:(UIColor *)progressTintColor trackTintColor:(UIColor *)trackTintColor;
@end
