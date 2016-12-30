//
//  FundDetail.h
//  YOUXINBAO
//
//  Created by Feili on 15/5/15.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FundDetail : BaseData
@property (nonatomic, assign) NSInteger id;
/**
 * field 错误编号
 */
@property (nonatomic, assign) NSInteger errCode;
/**
 * field 错误提示
 */
@property (nonatomic, strong) NSString* errString;
/** 用户id */
@property (nonatomic, assign) NSInteger userId;
/** 此次操作涉及的金额 */
@property (nonatomic, strong) NSString* money;
/** 操作后用户的账户余额 */
@property (nonatomic, strong) NSString* resultMoney;
/** 客户端标题 */
@property (nonatomic, strong) NSString* title;
/** 头像 */
@property (nonatomic, strong) NSString* imgUrl;
/** 表示资金是进帐还是出帐 0进账 1出账 */
@property (nonatomic, assign) NSInteger mode;
/** 资金类型 */
@property (nonatomic, assign) NSInteger type;
/** 创建时间 */
@property (nonatomic, strong) NSString* createTime;
/** 订单id（关联id） */
@property (nonatomic, assign) NSInteger t_id;
/** 备注 */
@property (nonatomic, strong) NSString* remark;


@end
