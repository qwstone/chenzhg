//
//  QCFriendsViewController.h
//  YOUXINBAO
//
//  Created by ZHANGMIAO on 14-3-4.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCBaseViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "QCSearchBar.h"
#import "HttpOperator.h"
//#import "TActivity.h"
#import "AAActivity.h"
#import "Loan.h"
#import "AmorConfig.h"

#define kSectionHeight 20
#define CellLabelFont 16
#define CellHeaderColor [YXBTool colorWithHexString:@"#F2F1F6"]
#define kCellHeaderTextColor [YXBTool colorWithHexString:@"#7F7E7E"]

@protocol QCFriendsViewControllerBackDelegate <NSObject>

@optional
- (void)QCFriendsViewControllerBackAction:(NSInteger)recordId;

-(void)createLoanDetailWithLoan:(Loan *)loan;

-(void)callWeChatWithLoanId:(NSInteger)loanId;

-(void)amorOrderDetailCallBackWithType:(AmorOrderPayType)payType gid:(NSString *)gid;

- (void)createAACollectMoneyRequestWithNames:(NSString *)names;

@end
@interface QCFriendsViewController : QCBaseViewController<UITableViewDataSource,UITableViewDelegate,QCSearchBarDelegate,UIAlertViewDelegate>
{
    UISearchBar * _searchBar;
    UIControl *_cover;
    
}
@property (nonatomic,assign)id<QCFriendsViewControllerBackDelegate>delegate;
@property (nonatomic,retain) UITableView *linkManListView;
@property (nonatomic,strong) UIView *bottomView;    //确定按钮父视图
@property (nonatomic,retain) UIView *noRecordView; //无记录
//@property (nonatomic,retain)NSMutableArray *friendArr;  //好友列表数据

@property (nonatomic,assign) BOOL isFromBorrow;

@property (nonatomic,assign)BOOL isFromLender;

@property (nonatomic,assign) BOOL isFromInvite;     //是否从聚会邀请push过来

@property (nonatomic,assign) BOOL isAAshoukuan;     //是否从AA收款邀请push过来
@property (nonatomic,assign) NSInteger isAAshoukuanNumeber;     //是否从AA收款邀请push过来

@property (nonatomic,assign) BOOL isSelectPeople;//是否从订单详情->选择担保人跳转而来

@property (nonatomic,assign) AmorOrderPayType payType;//订单详情，选好友来源类型
@property (nonatomic,retain) NSMutableDictionary *contactDic;   //搜索时使用的用户字典
@property (nonatomic,retain) NSMutableArray *searchByName;  //搜索数组

@property (retain, nonatomic) HttpOperator* iHttpOperator;

@property (retain,nonatomic) AAActivity * activity;
@property (nonatomic,retain) Loan * loanModel;
//@property (nonatomic,retain) QCBorrowModel * loanborrowModel;

@property(nonatomic,strong)NSString *subject;
@property(nonatomic,strong)NSString *allNum;
@property(nonatomic,strong)NSString *allMoney;
@property(nonatomic,strong)NSString *desc;
@property(nonatomic,retain)NSArray *filteData;

@property(nonatomic,assign)NSInteger recordId;

@property (nonatomic,strong) NSMutableDictionary *dataDictionary;//用于数据展示的字典，替换以前的二维数组
@property (nonatomic,strong) NSMutableArray *sortedkeysArray;//字典key的排序

@property (nonatomic,strong) NSMutableDictionary *addressDataDictionary;//用于数据展示的字典，替换以前的二维数组
@property (nonatomic,strong) NSMutableArray *addressSortedkeysArray;//字典key的排序

@property (nonatomic,strong) NSString *AddressSearchText;


@property (nonatomic,assign) BOOL isLoanRepay;

@property (nonatomic,strong) NSMutableArray *fullModelArray;//用于搜索过滤


- (void)loadData;
-(void)processDataToDicWithArray:(NSArray *)result isSaved:(BOOL)isSaved;
-(void)updateUIWithArray:(NSArray *)dataArray isSaved:(BOOL)isSaved;

- (void)setSelectedCell;

//读取本地数据，构造网络请求返回的数据结构
-(void)loadSavedData;


@end
