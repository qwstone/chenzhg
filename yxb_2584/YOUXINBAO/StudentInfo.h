//
//  StudentInfo.h
//  YOUXINBAO
//
//  Created by Feili on 15/8/29.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StudentCerInfo.h"

@interface StudentInfo : NSObject
@property (nonatomic,copy) NSString *realName;//实名信息
@property (nonatomic,copy) NSString *idCardNO;//身份证号码
@property (nonatomic,strong) StudentCerInfo *studentInfo;
@end
