//
//  TCreditCenterManager.h
//  YOUXINBAO
//
//  Created by CH10 on 15/4/11.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSSkyArray.h"

@interface TCreditCenterManager : NSObject

/**
 * 获取信用大厅排行榜(不包含 失信榜)
 *
 * @param userId 用户id
 * @param categoryIndex 分类id 0->土豪榜; 1->人缘榜; 2->号召力榜; 3->义气榜; 4->活跃度;
 * @return
 */
- (NSSkyArray *)getTCreditCenterRankListByCategory:(NSInteger)userId category:(NSInteger)categoryIndex;

//- (NSSkyArray *)getAllTDishonestBoardRecord:(NSInteger)page;

@end
