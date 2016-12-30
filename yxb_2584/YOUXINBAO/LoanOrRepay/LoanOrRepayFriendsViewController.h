//
//  LoanOrRepayFriendsViewController.h
//  YOUXINBAO
//
//  Created by CH10 on 15/7/21.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCFriendsViewController.h"

typedef enum{
    LoanOrRepayFriendsStyleYXB, //友信宝好友
    LoanOrRepayFriendsStyleAddress,  //通讯录好友
}LoanOrRepayFriendsStyle;

@protocol LoanOrRepayFriendsViewControllerDelegate <NSObject>

-(void)createLoanDetailWithLoan:(Loan *)loan;

@end



@interface LoanOrRepayFriendsViewController : QCFriendsViewController

@property (nonatomic,assign)LoanOrRepayFriendsStyle friendStyle;

@property(nonatomic,strong)NSMutableArray *addressBookTemp; //手机通讯录数组
@property(nonatomic,strong)NSMutableArray *addTypeBook; //添加状态的好友

@property(nonatomic,strong)NSMutableArray *listContent; //案首字母排序后的通讯录数组

@property(nonatomic,assign)BOOL             isFromSend;//判断是否是继续发送

@end
