//
//  QCDeviceModel.m
//  YOUXINBAO
//
//  Created by zjp on 15/7/3.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//
#import <AdSupport/ASIdentifierManager.h>
#import "QCDeviceModel.h"

@implementation QCDeviceModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *adId =[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        self.idfa = adId;
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder {

    [aCoder encodeObject:self.device.phoneModelNumber forKey:@"phoneModelNumber"];
    [aCoder encodeObject:self.device.phoneSerialNumber forKey:@"phoneSerialNumber"];
    [aCoder encodeObject:self.device.phoneMEID forKey:@"phoneMEID"];
    [aCoder encodeObject:self.device.phoneICCID forKey:@"phoneICCID"];
    [aCoder encodeObject:self.device.phoneCallNumber forKey:@"phoneCallNumber"];
    
    [aCoder encodeObject:self.guideChart forKey:@"guideChart"];
    [aCoder encodeObject:self.deviceToken forKey:@"deviceToken"];
    [aCoder encodeObject:self.idfa forKey:@"idfa"];

}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {

        self.device.phoneModelNumber = [aDecoder decodeObjectForKey:@"phoneModelNumber"];
        self.device.phoneSerialNumber = [aDecoder decodeObjectForKey:@"phoneSerialNumber"];
        self.device.phoneMEID = [aDecoder decodeObjectForKey:@"phoneMEID"];
        self.device.phoneICCID = [aDecoder decodeObjectForKey:@"phoneICCID"];
        self.device.phoneCallNumber = [aDecoder decodeObjectForKey:@"phoneCallNumber"];
        
        self.guideChart = [aDecoder decodeObjectForKey:@"guideChart"];
        
        self.deviceToken = [aDecoder decodeObjectForKey:@"deviceToken"];
        
        self.idfa = [aDecoder decodeObjectForKey:@"idfa"];
        

        
    }
    return self;
}


@end
