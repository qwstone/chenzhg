//
//  FriendSelecteViewController.h
//  YOUXINBAO
//
//  Created by CH10 on 15/11/10.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "HttpOperator.h"
#import "LoanCenterConfig.h"
#import "AmorConfig.h"
#import "QCFriendsViewController.h"
#import "YXBLoan.h"

#define kSectionHeight 20
#define CellLabelFont 16
#define CellHeaderColor [YXBTool colorWithHexString:@"#F2F1F6"]
#define kCellHeaderTextColor [YXBTool colorWithHexString:@"#7F7E7E"]

@interface FriendSelecteViewController : QCBaseViewController
@property (retain, nonatomic) HttpOperator* iHttpOperator;
@property(nonatomic,weak)UITableView *myTableView;
@property (nonatomic,assign)BOOL  session0Hidden;//新朋友和扫一扫隐藏
@property(nonatomic,assign)LoanNewFriendType friendType;//好友来源类型
@property(nonatomic,assign)NSInteger maxNames;//多选人数限制
@property (nonatomic,retain) YXBLoan * loanModel;
@property (nonatomic,retain) YXBLoan *yxbLoanModel;
@property (nonatomic,assign) AmorOrderPayType payType;//订单详情，选好友来源类型
@property (nonatomic,assign)id<QCFriendsViewControllerBackDelegate>delegate;
@property (nonatomic,weak)UIView *noRecordView;//没有好友时的界面


@end
