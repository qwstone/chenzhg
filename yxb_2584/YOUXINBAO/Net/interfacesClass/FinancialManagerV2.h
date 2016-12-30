//
//  FinancialManager2.h
//  YOUXINBAO
//
//  Created by pro on 16/10/12.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSSkyArray.h"
#import "AssetDetails.h"
#import "MyAssetListDetail.h"
#import "FinanceReturn.h"
#import "FinanceBuyData.h"
@interface FinancialManagerV2 : NSObject
/**
 * 获取全部产品
 *
 * @param userToken
 * @param pageNum
 * @return AssetListItem
 *
 * @author SKY
 * @date 2016年7月19日
 */
-(NSSkyArray *)getAllAssetList:(NSString *)userToken pageNum:(NSInteger)pageNum;

/**
 * 获取标的详情
 *
 * @param assetID   标的id
 * @param userToken
 * @param pageNum
 * @return
 *
 * @author SKY
 * @date 2016年7月20日
 */
-(AssetDetails *)getAssetDetails:(NSString *)assetID userToken:(NSString*)userToken pageNum:(NSInteger)pageNum;


/**
 * 获取投资记录
 *
 * @param userToken
 * @param pageNum
 * @return
 *
 */
-(NSSkyArray *)getMyAssetList:(NSString *)userToken pageNum:(NSInteger)pageNum;


/**
 * 获取个人购买标详情
 * @param userToken
 * @param recordId
 * @return
 */
-(MyAssetListDetail *) getMyAssetListDetail:(NSString *)userToken recordId:(NSInteger)recordId;

/**
 * 获取理财收益
 * @param usertoken
 * @return
 */
-(FinanceReturn *) getFinanceReturn:(NSString *)userToken ;
/**
 * 获取理财购买所需数据
 * 用户剩余金额
 * 服务协议地址
 * @param usertoken
 * @return
 */
-(FinanceBuyData*)getFinanceBuyData:(NSString*)usertoken assetID:(NSString*)assetID;
@end
