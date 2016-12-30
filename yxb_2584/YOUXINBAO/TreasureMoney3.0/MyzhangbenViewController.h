//
//  MyzhangbenViewController.h
//  YOUXINBAO
//
//  Created by Walice on 15/12/14.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

typedef NS_ENUM(NSInteger, selectType){
    LicaiType=0,//宝赚钱
    YueType=1,  //其他收益
};

#import "QCBaseViewController.h"
#import "LicaiButton.h"
#import "TreasureMoneyNewCell.h"
#import "MouthPickerView.h"
@class SelectView;
@interface MyzhangbenViewController:QCBaseViewController<UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate,SelectViewDelegate>{
    UIButton *viewheader;
    UILabel     *_topLabel;
    UIImageView *_topImageView;
    UIView *view2;
    UIView *view1;
    NSInteger page;
    UIView *middleView;
    UIView *thirdView;
    UILabel *noDataLabel;
  
}


@property(nonatomic,retain)QCBaseTableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,copy)NSString *year;
@property(nonatomic,copy)NSString *mouth;
@property(nonatomic,assign)selectType type;
@property (nonatomic,assign)id<TreasureMoneyNewCellDelegate>delegate;
@property (retain, nonatomic) HttpOperator* iHttpOperator;
@property(nonatomic,retain)HttpOperator *httpOperator;
@property(nonatomic,strong)MouthPickerView *timePicker;
@property(nonatomic,assign)BOOL        isShow;


@end
