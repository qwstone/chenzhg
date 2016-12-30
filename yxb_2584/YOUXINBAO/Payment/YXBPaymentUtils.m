//
//  YXBPaymentUtils.m
//  YOUXINBAO
//
//  Created by sky on 15/7/4.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "YXBPaymentUtils.h"
#import "BaseData.h"
#import "YXBTool.h"
#import "CgLoan.h"
#import "YXBLoan.h"
#import "LoanConfig.h"

@implementation YXBPaymentUtils

//得到完整url地址
+(NSString*) getFullWebUrl:(BaseData *)pay {

    
    NSString* className = NSStringFromClass([pay class]);
    
    NSArray* arr = [className componentsSeparatedByString:@"_"];
    NSString* jspName = @"unkown";
    jspName = [self getJspNameFromClass:pay];
    if (jspName == nil) {
        if ([arr count] >= 2) {
            jspName = arr[1];
        }

    }
    NSLog(@"jspName = %@", jspName);
    
    NSString *fullUrl = [NSString stringWithFormat:@"%@webView/user/%@.jsp?data=%@",YXB_IP_ADRESS,jspName,[self getWebUrlOfPayment:pay]];
    NSLog(@"【%@】 payUrl:---%@",[pay class],fullUrl);
    return fullUrl;
}

+(NSString*) getWebUrlOfPayment:(BaseData*) pay {
    
    /*
    * 参数data={"cookie": ,"token": ,"v": ,"pt": ,"tmp": ,"encToken": ,"other": {}}
    */
    
    NSMutableDictionary* json = [[NSMutableDictionary alloc] init];
    
    [json setObject:[pay getYxbDic] forKey:@"other"];
    
    NSString *cookie = [YXBTool getYxbCookie];
    [json setObject:cookie forKey:@"cookie"];
    
    NSString *token = [YXBTool getUserToken];
    if (token == nil) {
        token = @"";
    }
    [json setObject:token forKey:@"token"];

    [json setObject:YXB_VERSION_CODE forKey:@"v"];
    [json setObject:@"ios" forKey:@"pt"];
    [json setObject:[YXBTool getStamp] forKey:@"tmp"];
    NSString *encToken= [YXBTool getMD5StringWithStamp:[YXBTool getStamp] token:[NSMutableString stringWithString:token]];
    if (encToken == nil) {
        encToken = @"";
    }
    [json setObject:encToken forKey:@"encToken"];
    NSError *error;
    NSData* jsonDate = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString* paramsString = [[NSString alloc] initWithData:jsonDate encoding:NSUTF8StringEncoding];
    
//    return [paramsString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    return paramsString;
}

+(NSString *)getJspNameFromClass:(BaseData *)baseData
{
    NSString *jspName = nil;
    if([baseData isKindOfClass:[Loan class]])
    {
        jspName = @"loanPayTLoan";
    }else if([baseData isKindOfClass:[YXBLoan class]])
    {
        jspName = @"loanPayYXBLoan";
    }else if ([baseData isKindOfClass:[CgLoan class]])
    {
        jspName = @"loanPayCgLoanV3";
    }
    return jspName;
}

@end
