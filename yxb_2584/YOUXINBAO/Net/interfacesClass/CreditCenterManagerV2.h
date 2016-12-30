//
//  CreditCenterManagerV2.h
//  YOUXINBAO
//
//  Created by pro on 16/9/26.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSSkyArray.h"
#import "TResultSet.h"
@interface CreditCenterManagerV2 : NSObject

/**
 * 获取失信大厅数据
 *
 * @param pageNum
 * @return NSSkyArray
 *
 * @author SKY
 * @date 2016年10月17日
 */
-(NSSkyArray *)getDishonestCenterDate:(NSInteger)pageNum;



/**
 * 根据条件获取失信大厅数据
 *
 * @param usertoken
 * @param pageNo
 * @param type  类型(type 1 我附近的 2 我的好友)
 * @return NSSkyArray
 *
 * @author SKY
 * @date 2016年10月17日
 */
-(NSSkyArray *)getDishonestCenterDateByUserInfo:(NSString *)usertoken pageNum:(NSInteger)pageNo andType:(NSInteger)type;



/**
 * 查询用户是否在失信列表中
 *
 * @param pageNum
 * @param mobile
 * @return NSSkyArray
 *
 * @author SKY
 * @date 2016年10月17日
 */
-(NSSkyArray *)getDishonestCenterDateByCondition:(NSString *)mobile pageNo:(NSInteger)pageNo;


@end
