//
//  AgentContract.m
//  DiTui
//
//  Created by zjp on 15/5/30.
//  Copyright (c) 2015年 YXBao. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "QCFriendModel.h"
typedef void (^onFriendRelationsDBCompleteBlock) (NSMutableArray *resultArray);

@interface DBManager : NSObject

@property(nonatomic,strong)NSManagedObjectContext *context;

@property(nonatomic,strong)NSMutableArray *dataArray;


@property(nonatomic,copy)onFriendRelationsDBCompleteBlock completeBlock;

+ (instancetype)shareInstance;

/**
 *  @author zhangjinpeng
 *
 *
 *  @param 
 *
 *  @return 创建mo对象
 */
- (NSManagedObject *)createMO:(NSString *)entityName;

/**
 *  @author zhangjinpeng
 *
 *
 *  @param  
 AgentContractNew *user = (User *)[dbManager createMO:@"AgentContractNew"];
 1.批量保存
     for (int i=0; i<20; i++) {
         AgentContractNew *user = (User *)[dbManager createMO:@"User"];
         user.name = [NSString stringWithFormat:@"zhang-%d",i];
        [user setValue:@8000 forKey:@"orderId"];
 
         [dbManager saveManagerObj:user];
     }
 
 
 2.保存user对象
        userMO 指向了一个user对象
     NSManagedObject *user = [dbManager createMO:@"AgentContractNew"];
     [user setValue:@"小明" forKey:@"name"];
     [user setValue:@8000 forKey:@"orderId"];
     [dbManager saveManagerObj:user];
 *
 *  @return 增加，保存数据
 */
- (void)saveManagerObj:(NSManagedObject *)mo;

/**
 *  @author zhangjinpeng
 *
 *
 *  @param 单线程异步查询    条件：列   NSPredicate *predicate = [NSPredicate predicateWithFormat:@"orderId = 8000"];
 *
 *  @return 数组（包含所有用户）
 */
- (NSArray *)query:(NSString *)entifyName
         predicate:(NSPredicate *)predicate;

/**
 *  @author zhangjinpeng
 *
 *
 *  @param NSArray *users = [dbManager query:@"AgentContractNew" predicate:predicate];
            NSManagedObject *user = users[0];
           [user setValue:@"小明" forKey:@"name"];
           [dbManager updateManagerObj:user];
 *
 *  @return 修改对象
 */
- (void)updateManagerObj:(NSManagedObject *)mo;

/**
 *  @author zhangjinpeng
 *
 *
 *  @param  NSArray *users = [dbManager query:@"AgentContractNew" predicate:predicate];
            NSManagedObject *user = users[0];
            [dbManager removeManagerObj:user];
 *
 *  @return 删除对象
 */
- (void)removeManagerObj:(NSManagedObject *)mo;

// 清空数据库
+(void)clearDataBaseWhenExit;


//保存数据到本地数据库
-(void)saveFriendRelationsToDB:(NSMutableDictionary *)dic;

//更新通信录
-(void)reloadFriendRelationsDB;

//读取本地数据
-(NSMutableArray *)loadSavedData;

//读取本地数据block回调
-(void)readLocalFriendRelationsDBWithCompleteBlock:(onFriendRelationsDBCompleteBlock)completeBlock;




-(void)cancel;

@end
