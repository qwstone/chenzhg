//
//  UILabel+CustomPackaging.m
//  LearningRoad
//
//  Created by CH10 on 16/3/24.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "UILabel+CustomPackaging.h"

@implementation UILabel (CustomPackaging)
-(void)setTextKern:(CGFloat)textKern{
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange range = {0,attStr.length};
    NSNumber *kern = [NSNumber numberWithFloat:textKern];
    [attStr addAttribute:NSKernAttributeName value:kern range:range];
    self.attributedText = attStr;
}
-(CGFloat)textKern{
    return self.textKern;
}
-(void)setTextLineSpaceing:(CGFloat)textLineSpaceing{
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange range = {0,attStr.length};
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = textLineSpaceing;
    [attStr addAttribute:NSParagraphStyleAttributeName value:paragraph range:range];
    self.attributedText = attStr;
}
-(CGFloat)textLineSpaceing{
    return self.textLineSpaceing;
}
-(UILabel *)initWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont*)font textColor:(UIColor*)textColor{
    self = [[UILabel alloc] initWithFrame:frame];
    if (self) {
        
        self.text = text;
        self.font = font;
        self.textColor = textColor;
        
    }
    return self;
}
+(UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor{
    UILabel *label = [[UILabel alloc] initWithFrame:frame text:text font:font textColor:textColor];
    return label;
}
-(void)customWidth:(BOOL)cw andHeight:(BOOL)ch withSize:(CGSize)size{
    NSRange range = {0,self.text.length};
    NSDictionary *attDict = [self.attributedText attributesAtIndex:0 effectiveRange:&range];
    
    CGSize sizeResult = [self.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attDict context:nil].size;
    
    
    NSLog(@"%@",attDict);
    CGFloat width = cw ? sizeResult.width : self.frame.size.width;
    CGFloat height = ch ? sizeResult.height : self.frame.size.height;
    self.numberOfLines = 0;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, height);
}
@end
