//
//  PayModeModel.h
//  LotteryApp
//
//  Created by 程立彬 on 14-4-9.
//  Copyright (c) 2014年 windo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PayHomeViewController.h"

@interface PayModeModel : NSObject
@property(nonatomic, copy) NSString*       logoImageName;//logo图片名称
@property(nonatomic, copy) NSString*       logoTitle;//logo标题
@property(nonatomic, copy) NSString*       logoDetail;//标题详情
@property(nonatomic, assign) Pay_Mode      payMode;

-(id)initWithImageName:(NSString *)imageName title:(NSString *)title detail:(NSString *)detail payMode:(Pay_Mode)payMode;

@end
