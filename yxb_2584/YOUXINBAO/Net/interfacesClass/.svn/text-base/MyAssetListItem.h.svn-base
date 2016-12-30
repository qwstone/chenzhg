//
//  AssetListItem.h
//  YOUXINBAO
//
//  Created by 密码是111 on 16/7/26.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TResultSet.h"

/**
 * 个人购买理财产品记录
 */
@interface MyAssetListItem : TResultSet

/**
 * 投标记录
 */

@property (nonatomic, strong) NSString* recordId;
/**
 * 标的标题
 */

@property (nonatomic, strong) NSString* assetTitle;
/**
 * 购买时间(yyyy-MM-dd)
 */

@property (nonatomic, strong) NSString* buyDate;
/**
 * 右上角标志
 * 1 进行中(可以购买的状态) 2 还款中(计息状态) 3 已完成(结束计息 投资期限结束)
 */

@property (nonatomic, strong) NSString* status;
/**
 * 到期预期收益(元)
 */

@property (nonatomic, strong) NSString* exceptReturn;
/**
 * 购买金额
 */

@property (nonatomic, strong) NSString* money;
/**
 * 起息时间(yyyy/MM/dd)
 * 状态为进行中的标的起息时间返回"无"(标满开始计息)
 */
@property (nonatomic, strong) NSString* startDate;
/**
 * 到期时间(yyyy/MM/dd)
 */
@property (nonatomic, strong) NSString* endDate;



@end
