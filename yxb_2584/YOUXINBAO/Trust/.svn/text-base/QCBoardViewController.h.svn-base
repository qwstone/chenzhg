//
//  QCBoardViewController.h
//  YOUXINBAO
//
//  Created by CH10 on 15/4/10.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "HttpOperator.h"
#import "CreditConfig.h"


////typedef enum {
////    QCBoardTypeHuoYue = 4,
////    QCBoardTypeRenYuan = 1,
////    QCBoardTypeShiXin = 5,
////    QCBoardTypeHaoZhaoLi = 2,
////    QCBoardTypeYiQi = 3,
////    QCBoardTypeTuHao = 0
////}QCBoardType;
//
//typedef NS_ENUM(NSInteger, QCBoardType)
//{
//    QCBoardTypeHuoYue = 4,
//    QCBoardTypeRenYuan = 1,
//    QCBoardTypeShiXin = 5,
//    QCBoardTypeHaoZhaoLi = 2,
//    QCBoardTypeYiQi = 3,
//    QCBoardTypeTuHao = 0
//}
//;

@interface QCBoardViewController : QCBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet QCBaseTableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *alphaView;

@property (retain, nonatomic) HttpOperator* iHttpOperator;

@property (nonatomic,assign) QCBoardType type;

@end
