//
//  QCThreeController.h
//  YOUXINBAO
//
//  Created by zjp on 16/1/26.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "HttpOperator.h"
#import "YXBTool.h"
@class HeaderView;
typedef NS_ENUM(NSInteger, QCMessageListStyle){
    QCMessageOne = 0,    //系统通知
    QCMessageTwo = 1     //我的消息
};
@interface QCThreeController : QCBaseViewController<UITableViewDelegate,UITableViewDataSource,QCBaseTableViewDelegate>
{
    
    NSInteger page;
}

@property (retain, nonatomic) HttpOperator* iHttpOperator;
@property (nonatomic,assign)QCMessageListStyle style;
@property(nonatomic,strong)HeaderView *headerView;
//@property (nonatomic,assign)NSArray *dataArray;
@property(nonatomic,strong)UILabel *label;

@end
