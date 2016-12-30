//
//  TreasureMoneyProductViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 15/12/14.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "TreasureMoneyProductViewController.h"
#import "QCBaseTableView.h"
#import "TreasureMoneyProductTableViewCell.h"
#import "TMCustomAlertView.h"
#import "ProfitRegularDetail.h"
#import "ProfitManagerV3.h"
#import "QCUserModel.h"
#import "UserManager.h"
#import "QCLoginOneViewController.h"
#import "YXBTool.h"
#import "QCPurchaseSuccessController.h"
#import "PayHomeViewController.h"
#import "FundDetailHomeViewController.h"
#import "MyzhangbenViewController.h"
typedef NS_ENUM(NSInteger,TCPAlertCategory){
    TCPAlertChongZhi = 500,//充值弹框
    TCPAlertBuy = 501,//购买弹框
    TCPAlertChongZhiSuccess = 502//充值成功弹框
};
@interface TreasureMoneyProductViewController ()<QCBaseTableViewDelegate,UITableViewDataSource,UITableViewDelegate,TreasureMoneyProductTableViewCellDelegate,TMCustomAlertViewDelegate,UITextFieldDelegate>

@property (nonatomic,weak) QCBaseTableView *myTableView;
@property (nonatomic,weak) UITextField *textField;
/**充值弹框*/
@property (nonatomic,weak) TMCustomAlertView *chongzhiAlertView;
/**立即购买弹框*/
@property (nonatomic,weak) TMCustomAlertView *buyAlertView;
/**充值成功弹框*/
@property (nonatomic,weak) TMCustomAlertView *chongzhiSuccessAlertView;
/**弹框背景*/
@property (nonatomic,weak) UIView *blackBgView;
/**宝赚钱产品详情模型*/
@property (nonatomic,strong) ProfitRegularDetail *model;
/**当前用户*/
@property (nonatomic,strong) User *currentUser;
/**购买金额*/
@property (nonatomic,assign) NSInteger buyMoney;
/**可用余额*/
@property (nonatomic,assign) float remainingMoney;
/**键盘高度*/
@property (nonatomic,assign) CGFloat keyBoardHeight;
@end

@implementation TreasureMoneyProductViewController

-(void)dealloc{
    NSLog(@"TreasureMoneyProductViewController is dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self httpRequest];
    self.chongzhiSuccess = NO;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self alertManagerAllHidden];
    [self getRemainingMoney];
    if (self.chongzhiSuccess) {
        [self alertManagerShow:TCPAlertChongZhiSuccess];
    }
    
}
#pragma mark ---------------------------------------------- UI
-(void)initUI{
    [self createNav];
    [self createTableView];
    [self createAlertView];
    
}
- (void)createNav {
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    [self setNavigationButtonItrmWithiamge:@"zb" withRightOrleft:@"right" withtargrt:self withAction:@selector(rightClicked)];
}
-(void)createTableView{
    QCBaseTableView *tableView = [[QCBaseTableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64) style:UITableViewStylePlain];
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.refreshDelegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [self createTableFooterView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [tableView addGestureRecognizer:tap];

    self.myTableView = tableView;
    [self.view addSubview:self.myTableView];
}
-(UIView *)createTableFooterView{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 115)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(10, 0, kDeviceWidth-20, 50);
    sureBtn.layer.cornerRadius = 3;
    sureBtn.layer.masksToBounds = YES;
    [sureBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    sureBtn.backgroundColor = rgb(237, 46, 36, 1);
    [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:sureBtn];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, sureBtn.bottom+10, 15, 15)];
    imageView.image = [UIImage imageNamed:@"warning_circle"];
    [footerView addSubview:imageView];
    
    NSString *str = @"      温馨提示：您当前购买的是定期理财产品，购买成功后不得中途赎回，请谨慎购买。";
    CGFloat h = [YXBTool countLabelHeightWithText:str font:[UIFont systemFontOfSize:15] labelWidth:kDeviceWidth-20];
    UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, sureBtn.bottom+10, kDeviceWidth-20, h)];
    alertLabel.text = str;
    alertLabel.font = [UIFont systemFontOfSize:15];
    alertLabel.numberOfLines = 0;
    alertLabel.textColor = rgb(237, 46, 36, 1);
    [footerView addSubview:alertLabel];
    footerView.frame = CGRectMake(0, 0, kDeviceWidth, 10+h+sureBtn.bottom+10);
    return footerView;
}
-(void)createAlertView{
    UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.6;
    self.blackBgView = view;
    self.blackBgView.hidden = YES;
    [self.view addSubview:view];
    NSArray *titleArr = @[@"余额不足",@"确认购买",@"充值提示"];
    NSArray *messageArr1 = @[@"您的账户余额不足",@"宝赚钱定期理财",@"充值成功"];
    NSArray *messageArr2 = @[@"请充值后再购买",@"暂不支持中途退回功能",@"是否继续购买"];
    NSArray *cancleBtnTitleArray = @[@"取消",@"容我想想",@"容我想想"];
    NSArray *sureBtnTitleArray = @[@"去充值",@"确认购买",@"确认购买"];
    for (int i = 0;  i < 3; i ++) {
        TMCustomAlertView *tempChongzhiAlertView = [[TMCustomAlertView alloc] initWithFrame:CGRectMake(0, 0, 280, 160)];
        [tempChongzhiAlertView updateAlertWithTitle:[titleArr objectAtIndex:i]
                                        Message1:[messageArr1 objectAtIndex:i]
                                        Message2:[messageArr2 objectAtIndex:i]
                          CancleBtnTitle:[cancleBtnTitleArray objectAtIndex:i]
                              SureBtnTitle:[sureBtnTitleArray objectAtIndex:i]];
        tempChongzhiAlertView.center = self.view.center;
        tempChongzhiAlertView.delegate = self;
        tempChongzhiAlertView.tag = 500+i;
        tempChongzhiAlertView.hidden = YES;
        if (i == 0) {
            self.chongzhiAlertView = tempChongzhiAlertView;
        }else if (i == 1){
            self.buyAlertView = tempChongzhiAlertView;
        }else if (i == 2){
            self.chongzhiSuccessAlertView = tempChongzhiAlertView;
        }
        [self.view addSubview:tempChongzhiAlertView];
    }
}
//显示某个弹框
-(void)alertManagerShow:(TCPAlertCategory)category{
    CustomIOSAlertView *view = [self.view viewWithTag:category];
    self.blackBgView.hidden=NO;
    for (int i = 0; i < 3; i++) {
        TMCustomAlertView *alertView = [self.view viewWithTag:500+i];
        alertView.hidden=YES;
    }
    view.alpha = 0;
    self.blackBgView.alpha = 0;
    view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, 280, 0);
    [UIView animateWithDuration:0.3 animations:^{
        view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, 280, 160);
        view.alpha = 1;
        self.blackBgView.alpha = 0.6;
    }];
    view.hidden=NO;
 
    
}
//隐藏所有弹框
-(void)alertManagerAllHidden{
    self.blackBgView.hidden = YES;
    self.chongzhiAlertView.hidden = YES;
    self.chongzhiSuccessAlertView.hidden = YES;
    self.buyAlertView.hidden = YES;
}
#pragma mark ---------------------------------------------- 数据请求
-(void)httpRequest{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc] init];
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak TreasureMoneyProductViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        [this httpLoadParams:assginHtttperator];
    } complete:^(ProfitRegularDetail* r, int taskid) {
        
        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
}
-(void)httpLoadParams:(HttpOperator *)httpOperator{
    ProfitManagerV3* manager = (ProfitManagerV3*)  [httpOperator getAopInstance:[ProfitManagerV3 class] returnValue:[ProfitRegularDetail class]];
    [manager getProfitRegularDetail:self.regularID];
}
-(void)httpLoadComplete:(ProfitRegularDetail*)r{
    if (r.errCode==0) {
        self.model = r;
        self.title = self.model.name;
    }else{
        
    }
    [self.myTableView reloadDeals];
    [self.myTableView reloadData];
}

#pragma mark - 获取可用余额
-(void)getRemainingMoney{
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    if (userModel.isLogin == YES) {
        [self loginHttpRequest];
    }else {
        [self toLogin];
    }
}
- (void)toLogin {
    QCLoginOneViewController * loginView = [[QCLoginOneViewController alloc]init];
    UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginView];
    loginView.modalPresentationStyle = UIModalPresentationPopover;
    [self.navigationController presentViewController:loginNav animated:YES completion:nil ];
}
- (void)loginHttpRequest{
    if (self.loginOperator == nil) {
        self.loginOperator = [[HttpOperator alloc]init];
        
    }
    [self.loginOperator cancel];
    __weak HttpOperator * assginHtttperator = _loginOperator;
    __weak TreasureMoneyProductViewController *this = self;
    [self.loginOperator connetStart:^(int d) {
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        UserManager* _currUser = (UserManager*)  [assginHtttperator getAopInstance:[UserManager class] returnValue:[User class]];
        QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
        
        NSString *blackBox = [YXBTool getFMString];
        [_currUser userLoginWithFraudmetrix:userModel.user.username pwd:userModel.user.pwd fraudmetrixToken:blackBox];
        
    } complete:^(User* r, int taskid) {
        if (r.errCode == 0) {
            this.currentUser = r;
            this.remainingMoney = [this.currentUser.totalMoney floatValue]-[this.currentUser.freezenMoney floatValue];
            
        }else{
            [this toLogin];
        }
        [this.myTableView reloadData];
    }];
    [self.loginOperator connect];
    
}

#pragma mark - 购买宝赚产品
-(void)buyProductHttpRequest{
    if (self.buyProductOperator == nil) {
        self.buyProductOperator = [[HttpOperator alloc]init];
        
    }
    [self.buyProductOperator cancel];
    __weak HttpOperator * assginHtttperator = _buyProductOperator;
    __weak TreasureMoneyProductViewController *this = self;
    [self.buyProductOperator connetStart:^(int d) {
        [this.buyProductOperator stopAnimation];
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        ProfitManagerV3* manager = (ProfitManagerV3*)  [assginHtttperator getAopInstance:[ProfitManagerV3 class] returnValue:[TResultSet class]];
        [manager buyProfit:[YXBTool getUserToken] regularID:this.regularID buyMoney:[NSString stringWithFormat:@"%ld",(long)this.buyMoney]];
        
        
    } complete:^(TResultSet* r, int taskid) {
        if (r.errCode == 0) {//购买成功
            QCPurchaseSuccessController *qcpsvc = [[QCPurchaseSuccessController alloc] init];
            qcpsvc.money=[NSString stringWithFormat:@"%ld",(long)this.buyMoney];
            qcpsvc.purseid = this.model.regularID;
            [this.navigationController pushViewController:qcpsvc animated:YES];
        }else{//购买失败
            [ProgressHUD showWithStatus:r.errString];
        }
    }];
    [self.buyProductOperator connect];
}
#pragma mark ---------------------------------------------- Action
-(void)rightClicked{
    MyzhangbenViewController *zhangben=[[MyzhangbenViewController alloc]init];
    [self.navigationController pushViewController:zhangben animated:YES];
}
//立即购买
-(void)sureBtnClick:(UIButton *)btn{
    [self.textField resignFirstResponder];
    if (self.buyMoney<100) {
        [ProgressHUD showWithStatus:@"请输入大于等于100的整数"];
        self.textField.text = nil;
        return;
    }
    if (self.remainingMoney<self.buyMoney) {//余额不足
        [self alertManagerShow:TCPAlertChongZhi];
    }else{
        [self alertManagerShow:TCPAlertBuy];
    }
    
}
//收起键盘
-(void)tapAction:(UITapGestureRecognizer *)tap{
    [self.textField resignFirstResponder];
}
#pragma mark - TMCustomChongZhiAlertViewDelegate 弹框
-(void)btnClickedAtIndex:(NSInteger)index Tag:(NSUInteger)tag{
    if (index == 0) {
        self.chongzhiAlertView.hidden = YES;
        self.chongzhiSuccessAlertView.hidden = YES;
        self.buyAlertView.hidden = YES;
        self.blackBgView.hidden = YES;
    }else{
        switch (tag) {
            case TCPAlertChongZhi:{//充值
             
                PayHomeViewController *payhome = [[PayHomeViewController alloc] init];
                [self.navigationController pushViewController:payhome animated:YES];
                
            }break;
            case TCPAlertBuy:{//购买
                
                [self buyProductHttpRequest];
                
            }break;
            case TCPAlertChongZhiSuccess:{//充值成功
                
                if(self.remainingMoney<self.buyMoney){
                    //余额仍然不足
                    [self alertManagerShow:TCPAlertChongZhi];
                }else{
                    [self buyProductHttpRequest];
                }
                
            }break;
            default:
             break;
        }
    }
}
#pragma mark - TreasureMoneyProductTableViewCellDelegate
//查看项目详情
-(void)detailBtnAction{
    
}
//快速充值
-(void)chongZhiAction{
    PayHomeViewController *payhome = [[PayHomeViewController alloc] init];
    [self.navigationController pushViewController:payhome animated:YES];
}

#pragma mark ----------------------------------------------  tableView
#pragma mark - QCBaseTableViewDelegate
-(void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView{
    self.textField.text = @"";
    self.buyMoney = 0;
    [self httpRequest];
    [self getRemainingMoney];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = [NSString stringWithFormat:@"cellID%ld",(long)indexPath.row];
    TreasureMoneyProductTableViewCell *cell = [self getCellWithIdentifir:cellID];
    cell.delegate = self;
    cell.model = self.model;
    if (indexPath.row == 3) {
        cell.remainingMoney = [NSString stringWithFormat:@"%.2f",self.remainingMoney];
    }
    if (indexPath.row==4) {
        cell.buyMoney = self.buyMoney;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 70.0;
    }else if (indexPath.row == 1) {
        return 130.0;
    }else if (indexPath.row == 2){
        return 110.0;
    }else if (indexPath.row == 3){
        return 100.0;
    }else if (indexPath.row == 4){
        return 70.0;
    }
    return 0.0000001;
}

-(TreasureMoneyProductTableViewCell *)getCellWithIdentifir:(NSString *)identifirStr{
    TreasureMoneyProductTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:identifirStr];
    if (cell == nil) {
        cell = [[TreasureMoneyProductTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifirStr];
        if ([identifirStr isEqualToString:@"cellID3"]) {
            UITextField *tempTextField = [[UITextField alloc] initWithFrame:CGRectMake(80, 30+10, kDeviceWidth-10-80, 50)];
            tempTextField.keyboardType = UIKeyboardTypeNumberPad;
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 50)];
            tempTextField.leftView = view;
            tempTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
            tempTextField.leftViewMode = UITextFieldViewModeAlways;
            tempTextField.placeholder = @"最少购买100元";
            tempTextField.layer.cornerRadius = 5.0;
            tempTextField.layer.masksToBounds = YES;
            tempTextField.layer.borderColor = [[UIColor redColor] CGColor];
            tempTextField.layer.borderWidth = 2.0;
            tempTextField.delegate = self;
            self.textField = tempTextField;
            [self.textField addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
//            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextFieldTextDidChangeNotification object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
            //增加监听，当键退出时收出消息
//            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
            [cell addSubview:tempTextField];
        }
        
    }
    return cell;
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //禁止用户输入字母
    NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    for (int i = 0; i < [string length]; i++) {
        unichar c = [string characterAtIndex:i];
        if (![myCharSet characterIsMember:c]) {
            return NO;
        }
    }
    
    //处理第一个数字为小数点或者0的情况
    NSString *text = theTextField.text;
    NSString *passcode = [text stringByReplacingCharactersInRange:range withString:string];
    if ([passcode hasPrefix:@"."])
    {
        return NO;
    }
    
    
    //处理小数点两位后的情况
    if (!([theTextField.text rangeOfString:@"."].location == NSNotFound)) {
        NSArray *comArray = nil;
        comArray = [passcode componentsSeparatedByString:@"."];
        if (([comArray count] > 1) && ([comArray[1] length] > 2))
        {
            return NO;
        }
        
    }
    
    //处理两个以上小数点的情况
    if ([string isEqualToString:@"."])
    {
        //        if ([text containsString:@"."])
        if(!([text rangeOfString:@"."].location == NSNotFound))
        {
            return NO;
        }
    }
    
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.27 animations:^{
        self.myTableView.center = CGPointMake(self.myTableView.center.x, self.myTableView.center.y+self.keyBoardHeight);
    }];
}
#pragma mark - NSNotificationAction
- (void)textChanged{
    self.buyMoney = [self.textField.text integerValue];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:4 inSection:0];
    
    [self.myTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)keyboardWillShow:(NSNotification *)aNotification{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    self.keyBoardHeight = keyboardRect.size.height;
    [UIView animateWithDuration:0.28 animations:^{
        self.myTableView.center = CGPointMake(self.myTableView.center.x, self.myTableView.center.y-self.keyBoardHeight);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
