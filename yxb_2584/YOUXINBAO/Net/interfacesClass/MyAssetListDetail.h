//
//  AssetListDetail.h
//  YOUXINBAO
//
//  Created by 密码是111 on 16/7/26.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TResultSet.h"

//投资历史记录
@interface MyAssetListDetail : TResultSet

/**
 * 购买标记录Id
 */

@property (nonatomic, strong) NSString* assetID;
/**
 * 标的标题
 */

@property (nonatomic, strong) NSString* assetTitle;

/**
 * 购买 购买时间(yyyy-MM-dd)
 */

@property (nonatomic, strong) NSString* buyDate;

/**
 * 进度百分比(0-100)
 */

@property (nonatomic, strong) NSString* percentage;

/**
 * 进度文字
 */

@property (nonatomic, strong) NSString* percentTxt;

/**
 * 投资金额(元)
 */

@property (nonatomic, strong) NSString* money;



/**
 * 到期预期收益
 */

@property (nonatomic, strong) NSString* exceptReturn;

/**
 * 年化收益 (10%)
 */

@property (nonatomic, strong) NSString* annualizedRate;

/**
 * 计息时间
 */

@property (nonatomic, strong) NSString* startTime;
/**
 * 结束时间
 */

@property (nonatomic, strong) NSString* endTime;

/**
 * 标的信息url
 */

@property (nonatomic, strong) NSString* url;

/**
 *项目周期文字
 * 2016.08.28~2016.08.31
 * 未开始:..~..
 */

@property (nonatomic, strong) NSString* limitStr;



@end
