//
//  QCAddressListNewController.h
//  YOUXINBAO
//
//  Created by Walice on 15/9/11.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "HttpOperator.h"
#import "AddressListCell.h"

@interface QCAddressListNewController : QCBaseViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate,QCAddressListDelegate,QCBaseTableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UISearchBar *topSearchBar;
@property(nonatomic,strong)UISearchDisplayController *mySearchDisplayController;
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,strong) NSMutableArray * dataArr;
@property (nonatomic, strong) NSArray *searchResults;
@property (nonatomic,retain) NSMutableDictionary *contactDic;
@property(nonatomic,strong)HttpOperator *iHttpOperator;

@property(nonatomic,strong)NSMutableArray *requestArray;
//将电话拼接成的字符串
@property(nonatomic,strong)NSMutableString *phoneNum;
//将电话存成数组
@property(nonatomic,strong)NSMutableArray *phonesArr;
@property(nonatomic,strong)NSMutableArray *result;

@property(nonatomic,assign)NSInteger page;

@end
