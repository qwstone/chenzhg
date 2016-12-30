//
//  QCMoneyListViewController.h
//  YOUXINBAO
//
//  Created by CH10 on 15/4/28.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "HttpOperator.h"

typedef NS_ENUM(NSInteger, QCMoneyListStyle){
    
    QCMoneyListStyleEarning= 0,     //收入
    QCMoneyListStyleExpend,         //支出
    QCMoneyListStyleAll             //全部
};

typedef enum {
    QCMoneyTypeMoneyList = 0,   //资金明细
    QCMoneyTypeLiCai,           //理财金额
    QCMoneyTypeSusong,          //法院诉讼
    QCMoneyTypeCuishou,         //催收资金
    QCMoneyTypeFreezenMoney     //冻结金额

}QCMoneyType;

@interface QCMoneyListViewController : QCBaseViewController

@property (nonatomic,assign)QCMoneyListStyle style;

@property (retain, nonatomic) HttpOperator* iHttpOperator;

@end
