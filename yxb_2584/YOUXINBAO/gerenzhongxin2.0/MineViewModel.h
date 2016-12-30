//
//  mineViewModel.h
//  LotteryApp
//
//  Created by Feili on 15/1/15.
//  Copyright (c) 2015年 windo. All rights reserved.
//

#import "MyInfoConfig.h"

@interface MineViewModel : NSObject

@property(nonatomic)MyInfoItemType itemType;//条目的类型
@property(nonatomic,copy)NSString *itemImageName;//条目图片名称
@property(nonatomic,copy)NSString *itemTitle;//条目标题
@property(nonatomic,copy)NSString *itemAddImageName;//用于提示的图片的名称
@property(nonatomic)NSInteger numberOfItemType;

-(id)initWithTitle:(NSString *)title imageName:(NSString *)imageName type:(MyInfoItemType)type;

@end
