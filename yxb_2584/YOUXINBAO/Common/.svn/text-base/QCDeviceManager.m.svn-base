//
//  QCDeviceManager.m
//  YOUXINBAO
//
//  Created by zjp on 15/7/3.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCDeviceManager.h"

@implementation QCDeviceManager

+ (QCDeviceManager *)sharedInstance
{
    static QCDeviceManager * _s;
    
    if (_s == nil) {
        _s = [[[self class] alloc]init];
    }
    return _s;
}


- (NSString *)getCurrUserFiler
{
    return [NSString stringWithFormat:@"%@/%@", NSHomeDirectory(),
            @"Library/Caches/DeviceModel"];
}

- (void)setPhoneDeviceModel:(QCDeviceModel *)m
{
    _deviceModel = m;
    NSString * filer = [self getCurrUserFiler];
    [NSKeyedArchiver archiveRootObject:m toFile:filer];
}

- (QCDeviceModel *)getDevieModel
{
    NSString * filer = [self getCurrUserFiler];
    _deviceModel = [NSKeyedUnarchiver unarchiveObjectWithFile:filer];
    
    if (_deviceModel != Nil) {
        
    }else{
        
        //model初始化
        _deviceModel = [[QCDeviceModel alloc]init];
        [self setPhoneDeviceModel:_deviceModel];
        
    }
    //获取本地数据
    _deviceModel = [NSKeyedUnarchiver unarchiveObjectWithFile:filer];
    return _deviceModel;
    
}


@end
