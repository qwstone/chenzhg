//
//  LoanOrRepayAddressbookCell.h
//  YOUXINBAO
//
//  Created by CH10 on 15/7/21.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCAddressBook.h"

#define kAddressbookCellHeight 55

typedef enum{
    LoanOrRepayAddressbookCellStyleYXBFriend,
    LoanOrRepayAddressbookCellStyleAddressFriend,
    LoanOrRepayAddressbookCellStyleAddressNotFriend,
    LoanOrRepayAddressbookCellStyleAddressBlank,
}LoanOrRepayAddressbookCellStyle;

@interface LoanOrRepayAddressbookCell : UITableViewCell

@property (nonatomic,strong) QCAddressBook *addressBook;
@property (nonatomic,assign) LoanOrRepayAddressbookCellStyle friendStyle;
@property (nonatomic,strong) User *user;

@end
