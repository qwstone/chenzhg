//
//  QCHomeDataManager.m
//  YOUXINBAO
//
//  Created by zjp on 15/7/1.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCHomeDataManager.h"
#import "QCUserManager.h"
#import "QCUserModel.h"
@implementation QCHomeDataManager



+ (QCHomeDataManager *)sharedInstance
{
    static QCHomeDataManager * _s;
    @synchronized(self){        //死锁
        //给代码添加线程锁，防止多个线程处理同一个资源数据
        if (_s == nil) {
            _s = [[[self class] alloc]init];
            [_s initData];
        }
    }
    return _s;
}


- (void)initData {
    self.showThirdLogin = @"0";
    self.annualPercentageRate = @"5.00";
    self.zuorishouyi = [[QCUserManager sharedInstance]getLoginUser].user.yestodayMoney;
    self.ishasNewLoanMess = NO;
}
- (void)saveDataWithDic:(NSDictionary *)dic  {

    
    //获取到数据，给 showThirdLogin 、 annualPercentageRate 赋值
    [self decodeWithDic:dic];
}

-(void) decodeWithDic:(NSDictionary*) dic{
    if (dic != nil) {
        if (dic[@"showThirdLogin"] != nil) {
            self.showThirdLogin = dic[@"showThirdLogin"];
        }
        if (dic[@"annualPercentageRate"] != nil) {
            self.annualPercentageRate = dic[@"annualPercentageRate"];
        }
    }
}

//获取第三方登录
- (NSString *)getShowThirdLogin {
    if (self.showThirdLogin != nil) {
        return self.showThirdLogin;
    }
    return @"0";
}

//获取 年化利率
- (NSString *)getAnnualPercentageRate {
    if (self.annualPercentageRate != nil) {
        return self.annualPercentageRate;
    }
    return @"5.00";
}
@end
