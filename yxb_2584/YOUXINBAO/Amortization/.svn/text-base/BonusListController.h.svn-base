//
//  BonusListController.h
//  YOUXINBAO
//
//  Created by Walice on 15/6/1.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

typedef NS_ENUM(NSInteger, BonusOrOtherListType){
    BonusListType=1,//宝赚钱
    OtherListType=0,  //其他收益
};
#import "QCBaseViewController.h"
#import "QCPopupView.h"
#import "HttpOperator.h"

@class CategoryTitleView;
@interface BonusListController : QCBaseViewController<UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate>{

      NSInteger page;
}
@property (nonatomic,strong)QCBaseTableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (retain, nonatomic) HttpOperator* iHttpOperator;
@property (nonatomic,strong)UISegmentedControl *segmentControl;
@property(nonatomic,assign)BonusOrOtherListType type;
@property(nonatomic,strong)UILabel *label;


@end
