//
//  SelectView.h
//  YOUXINBAO
//
//  Created by zjp on 15/9/22.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectViewDelegate <NSObject>
@optional
- (void)SelectViewBtnAction:(UIButton *)sender;
-(void)SelectViewSelectedIndex:(NSInteger)index;
@end
@interface SelectView : UIView

@property(nonatomic,assign)NSInteger selectIndex;
@property(nonatomic,strong)UIButton *button;
@property (nonatomic,assign)id<SelectViewDelegate>delegate;

- (id)initWithFrame:(CGRect)frame WithArray:(NSArray *)array imgArray:(NSArray *)imgArray imgArraylight:(NSArray *)imgArraylight;
@end
