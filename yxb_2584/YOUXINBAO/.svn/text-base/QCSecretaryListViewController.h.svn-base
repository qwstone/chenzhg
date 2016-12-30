//
//  QCSecretaryListViewController.h
//  YOUXINBAO
//
//  Created by Walice on 15/7/7.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "HttpOperator.h"

#define MessageCenterPageNOStart 1
typedef NS_ENUM(NSInteger, QCPickerViewStyle){
  
    QCFriend = 0,//朋友
    QCRelative=1,//亲戚
    QCClassmate =2,//同学
    QCColleague =3  //同事

};

@interface QCSecretaryListViewController : QCBaseViewController<UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>


@property(nonatomic,strong)QCBaseTableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (retain, nonatomic) HttpOperator* iHttpOperator;
@property(nonatomic,strong)UIButton *relationButton;
@property(nonatomic,strong)UILabel *relationLabel;
@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,strong)NSArray *array;
@property(nonatomic,strong)UIButton * sureButton;
@property(nonatomic,strong)UIView *sendBackImage;
@property (nonatomic,assign)QCPickerViewStyle style;
@end
