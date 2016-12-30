//
//  QCHomeDataManager.h
//  YOUXINBAO
//
//  Created by zjp on 15/7/1.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseData.h"
@interface QCHomeDataManager : BaseData



+ (QCHomeDataManager *)sharedInstance;
- (void)saveDataWithDic:(NSDictionary *)dic;

@property(nonatomic,strong)NSMutableDictionary     *dic;

/*
 *第三方登录 判断字段 默认为“0”
 */
@property(nonatomic,strong)NSString                 *showThirdLogin;

/*
 *年化利率 默认为“0.00”
 */
@property(nonatomic,strong)NSString                 *annualPercentageRate;

/*
 *昨日收益（宝红利）
 */
@property(nonatomic,strong)NSString                 *zuorishouyi;

@property (nonatomic,assign) BOOL   ishasNewLoanMess;//是否有新的借款消息
//获取第三方登录
- (NSString *)getShowThirdLogin;

//获取 年化利率
- (NSString *)getAnnualPercentageRate;
@end
