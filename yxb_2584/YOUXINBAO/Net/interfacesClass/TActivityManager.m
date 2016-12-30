//
//  TActivityManager.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/3/9.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "TActivityManager.h"

@implementation TActivityManager

//
//- (TActivity *)getTActivityList:(NSInteger)index page:(NSInteger)page
//{
//    return [[TActivity alloc]init];
//}
//
//- (TActivity *)getTActivityListNearBy:(double)localLongitude localLatitude:(double)localLatitude page:(NSInteger)page
//{
//    return [[TActivity alloc]init];
//}

- (TActivity *)getTActivityById:(NSInteger)userId activityId:(NSInteger)activityId tagType:(NSInteger)tagType {
    return [[TActivity alloc]init];
}

- (TResultSet *)finishTActivity:(NSInteger)userId activityId:(NSInteger)activityId
{
    return [[TResultSet alloc]init];
}

- (TResultSet *)cancelTActivity:(NSInteger)userId activityId:(NSInteger)activityId
{
    return [[TResultSet alloc]init];
}

- (TResultSet *)createTActivity:(NSInteger)userId category:(NSInteger)category activityDate:(NSString *)activityDate topic:(NSString *)topic destName:(NSString *)destName destLongitude:(NSString *)destLongitude destLatitude:(NSString *)destLatitude capacity:(NSInteger)capacity showType:(NSInteger)showType payType:(NSInteger)payType femaleFee:(NSInteger)femaleFee avgCost:(NSString *)avgCost detail:(NSString *)detail picCount:(NSInteger)picCount {
    return [[TResultSet alloc] init];
}
- (TResultSet *)createTActivityNew:(NSString *)str arrr:(NSArray *)array
{
    return [[TResultSet alloc]init];
}

@end
