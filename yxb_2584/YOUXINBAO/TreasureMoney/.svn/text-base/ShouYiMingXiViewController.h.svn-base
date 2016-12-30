//
//  ShouYiMingXiViewController.h
//  YOUXINBAO
//
//  Created by zjp on 15/9/23.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "MouthPickerView.h"

#define kTimeCustomHeight 216+30
@interface ShouYiMingXiViewController : QCBaseViewController<UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate> {
    NSInteger indexpage;
    UILabel     *_topLabel;
    UIImageView *_topImageView;
    UIImageView *_wushujiimg;
    UIButton *viewheader;
    
    UIImageView *_wushujiimglicai;

}
@property (nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)HttpOperator *iHttpOperator;

@property(nonatomic,assign)NSInteger page;
@property(nonatomic,copy)NSString *year;
@property(nonatomic,copy)NSString *mouth;
@property(nonatomic,assign)BOOL        isShow;
@property (nonatomic,strong)QCBaseTableView *tableView;
@property(nonatomic,strong)UISegmentedControl *segment;
@property(nonatomic,strong)MouthPickerView *timePicker;
@end
