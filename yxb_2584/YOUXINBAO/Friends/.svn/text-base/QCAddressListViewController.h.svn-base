//
//  QCAddressListViewController.h
//  YOUXINBAO
//
//  Created by ZHANGMIAO on 14-3-4.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "QCSearchBar.h"
#import "HttpOperator.h"

@protocol MySecretaryDelegate <NSObject>

- (void)MySecretaryPushAction:(NSString *)tel;

@end

@interface QCAddressListViewController : QCBaseViewController<UITableViewDataSource,UITableViewDelegate,QCSearchBarDelegate>
{
    QCSearchBar * _searchBar;
    UIControl *_cover;
    
@private
    NSMutableArray *_listContent;

}

@property (nonatomic,retain) UITableView *tableView;
@property (nonatomic,retain) NSMutableDictionary *contactDic;
@property (nonatomic,retain) NSMutableArray *searchByName;  //搜索数组
@property (nonatomic,retain) QCSearchBar * searchBar;
@property (retain, nonatomic) HttpOperator* iHttpOperator;
@property (assign, nonatomic) BOOL     isSousuo;
@property(nonatomic,assign)BOOL isSecretary;
@property(nonatomic,assign)id<MySecretaryDelegate>delegate;

@property(nonatomic,assign)BOOL isWeixiao;
@end
