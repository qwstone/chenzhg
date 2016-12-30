//
//  MyLoanListViewController.h
//  YOUXINBAO
//
//  Created by CH10 on 16/2/16.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "HttpOperator.h"
#import "MyIOUHeaderView.h"
#import "QCBaseTableView.h"
#import "MyLoanListTableViewOneCell.h"
#import "MyLoanListTableViewTwoCell.h"
#import "MyLoanListTableViewThreeCell.h"
#import "MyLoanListTableViewFourCell.h"
#import "MyLoanListTableViewFiveCell.h"
#import "MyLoanListDialogBgView.h"
#import "MyLoanListBottomView.h"
#import "MyIOUHeaderView.h"
#import "MoreInformationViewController.h"
#import "QCLoginOneViewController.h"
#import "LoanManagerV10.h"
#import "YXBLoanDialogue.h"
#import "YXBLoanInfoDetails.h"
#import "YXBLoanChat.h"
#import "YXBTool.h"
#import "ImagePickerViewController.h"
#import "YXBJieKuanController.h"
#import "Payment_loanPayCgLoanV2.h"
#import "YanqiView.h"
#import "BuFenJieKuan.h"
#import "ZhifuViewController.h"
#import "UserManager.h"
#import "YXBLoanCenterViewController.h"
#import "MyLoanListRequireVideoAlert.h"
#import "MyLoanCuishouAlert.h"
#import "QCConsultLixiView.h"
#import "Payment_loanPayPartLoan.h"

@interface MyLoanViewController : QCBaseViewController<MyIOUHeaderViewDelegate,YanqiViewDelegate,BuFenJieKuanDelegate,ConsultLixiViewDelegate,UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate,MyLoanListDialogBgViewDelegate,MyLoanListBottomViewDelegate,UITextFieldDelegate,UIAlertViewDelegate,MyLoanListRequireVideoAlertDelegate,CTAlertViewDelegate,MyLoanCuishouAlertDelegate,UIActionSheetDelegate>
@property (assign, nonatomic) NSInteger loanID;
@property (nonatomic,copy)NSString *loanListItemDescript;
@property (retain, nonatomic) HttpOperator * iHttpOperator;
@property(nonatomic,assign)BOOL isFromVideo;
@property(nonatomic,assign)NSInteger type;

@end
