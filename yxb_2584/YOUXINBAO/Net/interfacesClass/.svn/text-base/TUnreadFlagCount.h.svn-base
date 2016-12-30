//
//  TUnreadFlagCount.h
//  YOUXINBAO
//
//  Created by 张淼 on 14-7-11.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "BaseData.h"

@interface TUnreadFlagCount : BaseData


/** identifier field */

@property (nonatomic, assign) NSInteger t_id;


/**  field  auto_increment */

/**  field  错误编号 */

//@property (nonatomic, assign) NSInteger  errCode;

/**  field  错误提示 */

@property (nonatomic,retain) NSString * errString;

/**  field  申请中 flag 计数 */

@property (nonatomic, assign) NSInteger  applyingFlagCount;

/**  field  待付款 flag 计数 */

@property (nonatomic,assign) NSInteger  needRepayFlagCount;

/**  field  被申请 flag 计数 */

@property (nonatomic,assign) NSInteger  beAppliedFlagCount;

/**  field  待收款 flag 计数 */

@property (nonatomic,assign) NSInteger  needRequestFlagCount;

@property (nonatomic,assign) NSInteger lenderHistoryFlagCount;

@property (nonatomic,assign) NSInteger borrowerHistoryFlagCount;

@property (nonatomic,assign) NSInteger  credit; /** 信誉星 初始值为5 4->诚信达人 | 3->信誉良好 | 2->信誉一般 | 1->信誉新人 | 0->重新出发 | 小于0->已失信 */

@property (nonatomic,assign) NSInteger generosity;
/**  field  上次查询日期
 * 如果为空,默认获取前一周的申请*/

//	private String  lastQueryDate;

/**  field  清除历史记录 flag
 * NOW() - lastQueryDate > 365*10大于10年设置为1,其他为0,
 * 0->不清除; 1->清除 */

@property (nonatomic,assign) NSInteger  needClearHistoryFlag;

@property (nonatomic,retain) NSString * lastQueryDate;


@property (nonatomic,assign) NSInteger  newFriendRelationFlagCount;


@end
