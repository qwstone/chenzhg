//
//  YXBJieHuanKuanSheZhiBaseController.h
//  YOUXINBAO
//
//  Created by Feili on 16/1/28.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "YXBLoan.h"
#import "JieKuanInstance.h"

@interface YXBJieHuanKuanSheZhiBaseController : QCBaseViewController
@property (nonatomic,assign)CGRect viewFrame;
@property (nonatomic,strong)UITableView *tableView;
//@property (nonatomic,strong)YXBLoan *yxbLoan;

-(void)scrollViewDidScroll:(UIScrollView *)scrollView;

@end
