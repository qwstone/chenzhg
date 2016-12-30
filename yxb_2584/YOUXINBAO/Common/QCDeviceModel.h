//
//  QCDeviceModel.h
//  YOUXINBAO
//
//  Created by zjp on 15/7/3.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Device.h"

@interface QCDeviceModel : NSObject<NSCoding>



@property (nonatomic,strong) Device * device;//手机信息

/**
 * 是否显示过引导图
 */
@property (nonatomic, copy) NSString  * guideChart;//引导图


@property (nonatomic, copy) NSString  * deviceToken;//推送token

@property (nonatomic, copy) NSString  * idfa;//idfa

@end
