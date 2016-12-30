//
//  MyLoanListTableViewFiveCellTableViewCell.h
//  YOUXINBAO
//
//  Created by 密码是111 on 2016/12/20.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXBLoanDialogue.h"
@interface MyLoanListTableViewFiveCell : UITableViewCell
@property (nonatomic,strong) YXBLoanDialogue *model;
+(instancetype)MyLoanListTableViewFiveCellWithTableView:(UITableView *)tableView;
@end
