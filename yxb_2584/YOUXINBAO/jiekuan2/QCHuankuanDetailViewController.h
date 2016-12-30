//
//  QCHuankuanDetailViewController.h
//  YOUXINBAO
//
//  Created by Walice on 16/2/18.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "HuankuanDetailCell.h"

@interface QCHuankuanDetailViewController : QCBaseViewController<UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate,HuankuanDetailDelegate>{
    NSInteger index;

}

@property(nonatomic,strong)QCBaseTableView *tableView;
/**
 判断多选还是单选 yes 多选 no单选
 */
@property (nonatomic,assign)BOOL isMultipleChoices;
@property (nonatomic,weak)UIView *bottomView;
@property(nonatomic,strong)UIButton *sureButton;
@property (nonatomic,strong)NSMutableArray *selectedUserArray;;

@end
