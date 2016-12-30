//
//  HomePopView.h
//  YOUXINBAO
//
//  Created by zjp on 15/7/3.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol HomePopViewDelegate <NSObject>
@optional
- (void)ImmediatelyJoin;//立即加入

- (void)IWantANniversalRoll:(UINavigationController *)nav;//我要万能卷

- (void)LookNniversalRoll:(NSString *)urlStr;//查看万能卷
@end

@interface HomePopView : UIView



@property (weak, nonatomic)id<HomePopViewDelegate>delegte;

- (void)showMostHonest;//最讲诚信用户


- (void)showHonestUser:(NSString *)Ranking;//第1888位诚信用户

- (void)showCongratulations;//恭喜
@end
