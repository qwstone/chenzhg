////  PayEaseComPayment.h//  ComPayment////  Created by 陈 斐 on 14-2-24.//  Copyright (c) 2014年 陈 斐. All rights reserved.//#import <UIKit/UIKit.h>#import "PayEaseComPayConfig.h"@protocol PayEaseComPaymentDelegate; @interface PayEaseComPayment : UIViewController@property (nonatomic, assign) id<PayEaseComPaymentDelegate> delegate;- (void) sendDataWithParentController:(UIViewController *)parentViewController orderID:(NSString *)oid merchantID:(NSString *)mid orderMd5Info:(NSString *)orderMd5Info otherInfo:(NSDictionary *)otherInfoDic;@end@protocol PayEaseComPaymentDelegate <NSObject>- (void) PayEaseComResultStatus:(PayEaseComPayStatus)payStatus statusDescription:(NSString *)statusDesc;@end