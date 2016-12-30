//
//  UILabel+CustomPackaging.h
//  LearningRoad
//
//  Created by CH10 on 16/3/24.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (CustomPackaging)
/**
 *行间距
 */
@property (nonatomic,assign)CGFloat textLineSpaceing;
/**
 *字符间距
 */
@property (nonatomic,assign)CGFloat textKern;


-(UILabel *)initWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont*)font textColor:(UIColor*)textColor;
+(UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont*)font textColor:(UIColor*)textColor;

/**-----------------------宽高是否自适应
 *cw:宽度是否自适应
 *ch:高度是否自适应
 *size:计算自适应宽高的标准
 */
-(void)customWidth:(BOOL)cw andHeight:(BOOL)ch withSize:(CGSize)size;

@end
