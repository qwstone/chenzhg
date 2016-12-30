//
//  DashLine.h
//  DashLine
//
//  Created by Juwencheng on 15/5/17.
//  Copyright (c) 2015年 jackdono. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface DashLine : UIView


@property (nonatomic, assign) CGFloat dashInset;

@property (nonatomic, strong) IBInspectable UIColor *dashColor;

@end
