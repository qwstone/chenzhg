//
//  mineViewModel.m
//  LotteryApp
//
//  Created by Feili on 15/1/15.
//  Copyright (c) 2015年 windo. All rights reserved.
//

#import "MineViewModel.h"

@implementation MineViewModel

//-(void)dealloc
//{
//    self.itemImageName = nil;
//    self.itemAddImageName = nil;
//    self.itemTitle = nil;
//    [super dealloc];
//}

-(id)initWithTitle:(NSString *)title imageName:(NSString *)imageName type:(MyInfoItemType)type
{
    self = [super init];
    if (self) {
        _itemTitle = title;
        _itemImageName = imageName;
        _itemType = type;
    }
    return self;
}

@end
