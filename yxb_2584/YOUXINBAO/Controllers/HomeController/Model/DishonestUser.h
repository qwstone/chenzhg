//
//  DishonestUser.h
//  YOUXINBAO
//
//  Created by pro on 16/9/26.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "TResultSet.h"

@interface DishonestUser : TResultSet
/**
 *  姓名
 */

@property (nonatomic, strong) NSString* name;

/**
 *  手机号
 */

@property (nonatomic, strong) NSString* mobile;

/**
 *  身份证号
 */

@property (nonatomic, strong) NSString* idcard;

/**
 *  状态(已失信，追讨中)
 */

@property (nonatomic, strong) NSString* stateStr;

/**
 * 性别
 * "0"女 "1"男
 */
@property (nonatomic, strong) NSString* gender;


/**
 *  和数据无关   显示效果需要
 */
@property (nonatomic, assign) BOOL isShow;

@end
