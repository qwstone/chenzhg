//
//  ISendLoanViewController.m
//  YOUXINBAO
//
//  Created by zjp on 15/4/28.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "ISendLoanViewController.h"
#import "MyTuhaoLoanListViewController.h"
#import "LoandetailsTableViewCell.h"
#import "YXBTool.h"
#import "PayHomeViewController.h"
#import "Payment_blankNotePay.h"
#import "UserManager.h"
#import "YXBProtocolView.h"
#import "FMDeviceManager.h"

#define ISendLoanViewControllerTuhaoUrl @"webView/explain/zuotuhaoExplain.jsp?t=1"
#define zeroX       0
@interface ISendLoanViewController () <YXBProtocolViewtDelegate>{
       UITableView *_tableView;
    NSArray   * rowNameArray;
}



@end

@implementation ISendLoanViewController
-(void)dealloc{
    NSLog(@"ISendLoanViewController is dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createData];
    [self createNavBar];
    [self createBgScrollView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    if (!userModel.isLogin) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请登录账号使用发白条功能" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alter.tag = 2200;
        [alter show];
    }
    [self httpLogin];
//    self.remainMoney = [userModel.user.remainMoney doubleValue];
    
}


- (void)createNavBar {
    [self setTitle:@"我要发白条"];
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftAction)];
}
- (void)leftAction
{
    NSLog(@"%@",self.BgScrollView.dingOrFen);
    if ([self.loanMoneypicklabel.text isEqualToString:@"2000"] & ([self.loanField.text isEqualToString:@"1"]) & [self.dingOrFen isEqualToString:@"全额"] & [self.loanTimePickLabel.text isEqualToString:@"3个月"] & [self.loanRatePickLabel.text isEqualToString:@"10%"]) {
         [self.navigationController popViewControllerAnimated:YES];
    }else {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"是否确认放弃已编辑选项？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alter.tag = 1100;
        [alter show];
    }

}

#pragma mark - UIAlterView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1100) {
        
        if (buttonIndex == 0) {
            NSLog(@"取消");
        }else if (buttonIndex == 1){
            NSLog(@"确定");
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else if (alertView.tag == 2200){
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else if (alertView.tag == 10010){
        if (buttonIndex == 1) {
            PayHomeViewController *pay = [[PayHomeViewController alloc] init];
            [self.navigationController pushViewController:pay animated:YES];
        }
    }
}

- (void)createData {
    
    arr1 = [NSArray arrayWithObjects:@[@"1500",@"2000",@"2500",@"3000",@"3500",@"4000",@"4500",@"5000"], nil];
    arr2 = [NSArray arrayWithObjects:@[@"3个月",@"6个月",@"9个月",@"12个月",@"24个月"], nil];
    arr3 = [NSArray arrayWithObjects:@[@"1%",@"2%",@"3%",@"4%",@"5%",@"6%",@"7%",@"8%",@"9%",@"10%",@"11%",@"12%",@"13%",@"14%",@"15%",@"16%",@"17%",@"18%",@"19%",@"20%",@"21%",@"22%",@"23%",@"24%"], nil];
    
    arr2to = [NSArray arrayWithObjects:@[@"3",@"6",@"9",@"12",@"24"], nil];
    arr3to = [NSArray arrayWithObjects:@[@"0.01",@"0.02",@"0.03",@"0.04",@"0.05",@"0.06",@"0.07",@"0.08",@"0.09",@"0.10",@"0.11",@"0.12",@"0.13",@"0.14",@"0.15",@"0.16",@"0.17",@"0.18",@"0.19",@"0.20",@"0.21",@"0.22",@"0.23",@"0.24"], nil];
}

#pragma mark -- buttonAction
- (void)loanMoneyButAction:(UIButton *)sender {
    if (sender.tag == 8001) {
        NSLog(@"选择白条金额");
        [self addPickerView:arr1 label:self.loanMoneypicklabel];
    }else if (sender.tag == 8002){
        NSLog(@"————————");
        if ([self.loanField.text integerValue] > 1) {
            self.loanField.text = [NSString stringWithFormat:@"%ld",(long)[self.loanField.text integerValue]-1];
        }else {
            [YXBTool showAlertViewWithString:@"最少发一个白条"];
        }
    }else if (sender.tag == 8003){
        NSLog(@"++++++++");
        if ([self.loanField.text integerValue] < 100) {
            self.loanField.text = [NSString stringWithFormat:@"%ld",(long)[self.loanField.text integerValue]+1];
        }else{
            [YXBTool showAlertViewWithString:@"最多发100条白条"];
        }
    }else if (sender.tag == 8004){
        sender.selected = !sender.selected;
        if (sender.selected == NO) {
            self.dingOrFen = @"分期";
            self.repaymentType = 1;

        }else {
            self.dingOrFen = @"全额";
            self.repaymentType = 0;

        }
    }else if (sender.tag == 8006){
        NSLog(@"选择还款周期");
        [self addPickerView:arr2 label:self.loanTimePickLabel];
    }else if (sender.tag == 8007){
        NSLog(@"选择利率");
        [self addPickerView:arr3 label:self.loanRatePickLabel];
    }else if (sender.tag == 8008){
        NSLog(@"同意条款");
        sender.selected = !sender.selected;
        [self selectButtonTuhao:sender];
    }else if (sender.tag == 8009){
        NSLog(@"条款");
        NSString *url = [YXBTool getURL:ISendLoanViewControllerTuhaoUrl params:nil];
        [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"做土豪条款"];

        
    }else if (sender.tag == 8010){
        NSLog(@"做土豪");
        [self findToLoan1];
    }
    
    [self upDate];
    [self.view endEditing:YES];
}


- (void)addPickerView:(NSArray *)pickArray label:(UILabel *)label{
    if ( _visiblePicker != nil) {
        [_visiblePicker removeFromSuperview];
    }
    _visiblePicker = [[ISendPickerView alloc] initWithFrame:CGRectMake(0, self.view.bottom, self.view.width, kCreatePickerCustomHeight) Component:1 listArr:pickArray];
    _visiblePicker.delegate = self;
    __weak ISendLoanViewController *this = self;
    _visiblePicker.selectedBlock = ^ (NSString *text, AACreatePickerView *createPickerView) {
        label.text = text;
        [this upDate];
    };
    _pivkerWindow = [[UIView alloc] initWithFrame:self.view.window.bounds];
    _pivkerWindow.alpha = 0.1;
    _pivkerWindow.backgroundColor = [UIColor blackColor];
    [self.view.window addSubview:_pivkerWindow];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapWindowAction)];
    [_pivkerWindow addGestureRecognizer:tap];
    [self.view.window addSubview:_visiblePicker];
    [_visiblePicker showPickerView];
}

- (void)tapWindowAction {
    [UIView animateWithDuration:1.0f animations:^{
        [_visiblePicker showPickerView];
    } completion:^(BOOL finished) {
        [_pivkerWindow removeFromSuperview];
        [_visiblePicker removeFromSuperview];
    }];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

//动态更新数据
- (void)upDate {
    _numbers = ((self.remainMoney)/([self.loanMoneypicklabel.text integerValue]));
    if (_numbers > 100) {
        _numbers = 100;
    }
    
    NSArray *arra = arr2[0];
    NSArray *arra1 = arr2to[0];
    for (int i = 0; i < arra.count; i++) {
        if ([self.loanTimePickLabel.text isEqualToString:arra[i]]) {
            self.timeToLoan = arra1[i];
        }
    }
    NSArray *arraa = arr3[0];
    NSArray *arraa1 = arr3to[0];
    for (int i = 0; i < arraa.count; i++) {
        if ([self.loanRatePickLabel.text isEqualToString:arraa[i]]) {
            self.lilvToLoan = arraa1[i];
        }
    }
    //规则
    CGFloat moneys = ([self.loanMoneypicklabel.text floatValue]+[self.loanMoneypicklabel.text floatValue]*[self.timeToLoan floatValue]/12 *[self.lilvToLoan floatValue])/([self.timeToLoan floatValue]);
    CGFloat moneys1 = ([self.loanMoneypicklabel.text floatValue]+[self.loanMoneypicklabel.text floatValue]*[self.timeToLoan floatValue]/12 *[self.lilvToLoan floatValue]);
    NSString *string = nil;
    if ([self.dingOrFen isEqualToString:@"分期"]) {
        string = [NSString stringWithFormat:@"白条借出后的%@，每月收款%.2f元",self.loanTimePickLabel.text,moneys];
    }else if ([self.dingOrFen isEqualToString:@"全额"]){
        string = [NSString stringWithFormat:@"白条借出%@后，一次性收款%.2f元",self.loanTimePickLabel.text,moneys1];
    }
    strLabel = [[NSMutableAttributedString alloc] initWithString:string];
    [strLabel addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,strLabel.length)];
    if ([self.dingOrFen isEqualToString:@"分期"]) {
        [strLabel addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]
                         range:[string rangeOfString:@"白条借出后的"]];
        [strLabel addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]
                         range:[string rangeOfString:@"，每月收款"]];
    }else if ([self.dingOrFen isEqualToString:@"全额"]){
        [strLabel addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]
                         range:[string rangeOfString:@"白条借出"]];
        [strLabel addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]
                         range:[string rangeOfString:@"后，一次性收款"]];
    }
    [strLabel addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]
                     range:[string rangeOfString:@"元"]];
    self.MonthMoney.attributedText = strLabel;
}

- (void)butuserInteractionEnabled:(UITextField *)textFiled {
    if ([self.loanField.text integerValue] > 100) {
        self.loanField.text = [NSString stringWithFormat:@"100"];
    }
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.loanField.text integerValue] <= 0) {
        self.loanField.text = @"1";
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    UIImageView * sendBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(-1, 0, kDeviceWidth+2, 50)];
    sendBackImage.backgroundColor = [UIColor whiteColor];
    CALayer * lineup = [CALayer layer];
    lineup.backgroundColor = [rgb(255, 156, 146, 1) CGColor];
    lineup.frame = CGRectMake(0, 0, sendBackImage.width, 1);
    [sendBackImage.layer addSublayer:lineup];
    
    CALayer * linedown = [CALayer layer];
    linedown.backgroundColor = [rgb(255, 156, 146, 1) CGColor];
    linedown.frame = CGRectMake(0, sendBackImage.height-1, sendBackImage.width, 1);
    [sendBackImage.layer addSublayer:linedown];
    sendBackImage.userInteractionEnabled = YES;
    [self createButtonWithframe:CGRectMake(10, 5, kDeviceWidth-20, 40) withImage:@"register_sure.png" withView:sendBackImage withTarget:self withAcation:@selector(keyBtnAction) withTag:111];
    textField.inputAccessoryView = sendBackImage;
}

- (void)keyBtnAction{
    [self.loanField resignFirstResponder];
}

//创建UIButton
- (void)createButtonWithframe:(CGRect)btnframe withImage:(NSString *)image withView:(UIView *)cview withTarget:(id)t withAcation:(SEL)s withTag:(NSInteger)tag
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = btnframe;
    button.backgroundColor = [UIColor clearColor];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button addTarget:t action:s forControlEvents:UIControlEventTouchUpInside];
    button.tag = tag;
    //    [button setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    button.adjustsImageWhenHighlighted = NO;
    
    [cview addSubview:button];
}

//自定义arlctview
-(void)findToLoan1
{
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    if ([userModel.user.remainMoney doubleValue] < ([self.loanMoneypicklabel.text integerValue] * [self.loanField.text integerValue])) {
        UIAlertView *arview = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您的余额不足" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去充值", nil];
        arview.tag = 10010;
        [arview show];
        return;
    }
    if (([self.loanMoneypicklabel.text integerValue] * [self.loanField.text integerValue]) <= 0) {
        UIAlertView *arview = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"最少发一个白条" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        arview.tag = 10020;
        [arview show];
        return;
    }
    Payment_blankNotePay *model = [[Payment_blankNotePay alloc] init];
//    model.token = userModel.user.yxbToken;
    model.type = @"1";
    model.money = [NSString stringWithFormat:@"%ld",(long)[self.loanMoneypicklabel.text integerValue] * [self.loanField.text integerValue]];//白条金额
    model.borrowNumber = self.loanField.text;//白条数量
    model.repaymentType = [NSString stringWithFormat:@"%ld",(long)self.repaymentType];//1分期 0全额
    model.repaymentMonth = self.timeToLoan;//还款周期
    NSString *a = self.loanRatePickLabel.text;
    a = [a substringWithRange:NSMakeRange(0,a.length-1)];
    model.yearRate = a;//年利率
    CGFloat f = [self.loanField.text floatValue]*[self.loanMoneypicklabel.text floatValue];
    TuhaoAreltContentView *contentView = [self setAlertContentView];
    
    contentView.f = f;
    
    CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
    
    // Add some custom content to the alert view
    [alertView setContainerView:contentView];
    
    // Modify the parameters
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"取消", @"确认", nil]];
    [alertView setDelegate:self];
    
    // You may use a Block, rather than a delegate.
    [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
        if (buttonIndex == 1) {
            
            [self requestData:model];
        }
        [alertView close];
    }];
    
    [alertView setUseMotionEffects:true];
    [alertView show];
    
}

-(TuhaoAreltContentView *)setAlertContentView
{
    TuhaoAreltContentView *contentView = [[TuhaoAreltContentView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth-20, 200)];
    contentView.backgroundColor = [UIColor whiteColor];
    return contentView;
}

- (void)customIOS7dialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
    [alertView close];
}

#pragma mark -- ISendPickerViewDelegate
- (void)ISendPickerViewOK {
    [self tapWindowAction];
}


- (void)selectButtonTuhao:(UIButton *)button {
    if (button.selected == YES) {
        self.zuotuhao.userInteractionEnabled = YES;
        self.zuotuhao.alpha = 1;
    }else{
        self.zuotuhao.userInteractionEnabled = NO;
        self.zuotuhao.alpha = 0.3f;
    }
    
}


- (void)createBgScrollView {
//    self.BgScrollView = [[ISendLoanScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
//    self.BgScrollView.backgroundColor = [UIColor clearColor];
//    self.BgScrollView.contentSize = CGSizeMake(kDeviceWidth, 667);
//    self.BgScrollView.showsHorizontalScrollIndicator = NO;
//    self.BgScrollView.showsVerticalScrollIndicator = YES;
//    [self.BgScrollView setDelegate:self];
//    [self.BgScrollView setTuhaoDelegate:self];
//    [self.view addSubview:self.BgScrollView];
//    
     rowNameArray = @[@"账户资金",@"白条金额",@"白条数量",@"还款方式",@"还款周期",@"年  利  率"];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth,kDeviceHeight-64)];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    UIView *bgViewfoor = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 250)];
    bgViewfoor.backgroundColor = rgb(237, 237, 246, 1);
    //-----------------------每月收款金额
    self.MonthMoney = [[UILabel alloc] initWithFrame:CGRectMake(15,10, kDeviceWidth-10, 50)];
    self.MonthMoney.textAlignment = NSTextAlignmentLeft;
    self.MonthMoney.textColor = [UIColor redColor];
    self.MonthMoney.numberOfLines = 0;
    self.MonthMoney.font = [UIFont systemFontOfSize:13];
    [bgViewfoor addSubview:self.MonthMoney];
    
    //-----------------------提示
    self.Prompt = [[UILabel alloc] initWithFrame:CGRectMake(15, 60, kDeviceWidth-30,80)];
    self.Prompt.lineBreakMode = NSLineBreakByWordWrapping;
    self.Prompt.numberOfLines = 0;
    self.Prompt.textColor = [UIColor lightGrayColor];
    self.Prompt.font = [UIFont systemFontOfSize:14];
    NSString *stttr = @"您随时可以取消尚未借出的白条，白条借出并到期后，本息将直接返回到无忧借条账户中，可随时提款";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:stttr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [stttr length])];
    self.Prompt.attributedText = attributedString;
    [bgViewfoor addSubview:self.Prompt];
    
    //-----------------------条款
    YXBProtocolView *view=[[YXBProtocolView alloc]initWithType:TYPE_TO_TUHAO_CREATE Frame:CGRectMake(0, 150,kDeviceWidth, 20)location:VIEWAlignmentCenter];
    view.delegate=self;
    [bgViewfoor addSubview:view];
//    UIButton *tongyi = [[UIButton alloc] initWithFrame:CGRectMake((kDeviceWidth-17-5-150-80)/2, 150, 17, 17)];
//    [tongyi setBackgroundImage:[UIImage imageNamed:@"rightcheck-icon"] forState:UIControlStateNormal];
//    [tongyi setBackgroundImage:[UIImage imageNamed:@"right-icon"] forState:UIControlStateSelected];
//    tongyi.tag = 8008;
//    [tongyi addTarget:self action:@selector(loanMoneyButAction:) forControlEvents:UIControlEventTouchUpInside];
//    [bgViewfoor addSubview:tongyi];
//    tongyi.selected = YES;
//    [self selectButtonTuhao:tongyi];
//    
//    UILabel *tiaokuan = [[UILabel alloc] initWithFrame:CGRectMake(tongyi.right+5, tongyi.top, 150, 17)];
//    tiaokuan.text = @"我同意友信宝土豪条款";
//    tiaokuan.font = [UIFont systemFontOfSize:15];
////    tiaokuan.backgroundColor = [UIColor redColor];
//    [bgViewfoor addSubview:tiaokuan];
//    
//    UIButton *tongyitiaokuan = [[UIButton alloc] initWithFrame:CGRectMake(tiaokuan.right, tongyi.top, 80, 17)];
//    tongyitiaokuan.titleLabel.font = [UIFont systemFontOfSize:14];
//    [tongyitiaokuan setTitle:@"<查看详情>" forState:UIControlStateNormal];
//    [tongyitiaokuan setTitleColor:rgb(25, 110, 150, 1) forState:UIControlStateNormal];
//    [tongyitiaokuan setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
//    tongyitiaokuan.tag = 8009;
//    [tongyitiaokuan addTarget:self action:@selector(loanMoneyButAction:) forControlEvents:UIControlEventTouchUpInside];
//    [bgViewfoor addSubview:tongyitiaokuan];
//    
    //-----------------------发白条
    _zuotuhao = [[UIButton alloc] initWithFrame:CGRectMake(15, 180, (kDeviceWidth-30), 50)];
    [_zuotuhao setBackgroundImage:[UIImage imageNamed:@"ztuhao-but"] forState:UIControlStateNormal];
    _zuotuhao.tag = 8010;
    [_zuotuhao addTarget:self action:@selector(loanMoneyButAction:) forControlEvents:UIControlEventTouchUpInside];
    [bgViewfoor addSubview:_zuotuhao];
    
    self.dingOrFen = @"全额";
    self.repaymentType = 0;
    [self upDate];
    _tableView.tableFooterView = bgViewfoor;

}

- (void)checkButton:(UIButton *)sender {
    if (sender.selected == YES) {
        _zuotuhao.userInteractionEnabled = YES;
        _zuotuhao.alpha = 1;
    }else {
        _zuotuhao.userInteractionEnabled = NO;
        _zuotuhao.alpha = 0.3;
    }
}

#pragma mark ---- tableviewdelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellID = [NSString stringWithFormat:@"row%ld",(long)indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row == 0) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            _MyallZiJinText = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth-20, kDeviceWidth/32*5)];
            _MyallZiJinText.textAlignment = NSTextAlignmentRight;
            _MyallZiJinText.textColor = [UIColor darkGrayColor];
            _MyallZiJinText.font = [UIFont boldSystemFontOfSize:17];
            _MyallZiJinText.text = [NSString stringWithFormat:@"￥ %@元",[YXBTool countNumAndChangeformat:[NSString stringWithFormat:@"%.2f",self.remainMoney]]];
             NSLog(@"%@",_MyallZiJinText.text);
            [cell.contentView addSubview:_MyallZiJinText];
        }else if (indexPath.row == 1){
            self.loanMoneypicklabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth/640*500+15, kDeviceWidth/32*5)];
            self.loanMoneypicklabel.textAlignment = NSTextAlignmentRight;
            self.loanMoneypicklabel.textColor = [UIColor orangeColor];
            self.loanMoneypicklabel.font = [UIFont boldSystemFontOfSize:15];
            self.loanMoneypicklabel.text = @"2000";
            [cell.contentView addSubview:self.loanMoneypicklabel];
            
            UILabel *yuan = [[UILabel alloc] initWithFrame:CGRectMake(self.loanMoneypicklabel.right+5, self.loanMoneypicklabel.top, 20, kDeviceWidth/32*5)];
            yuan.text = @"元";
            yuan.font = [UIFont boldSystemFontOfSize:15];
            [cell.contentView addSubview:yuan];
        }else if (indexPath.row == 2){
            cell.accessoryType = UITableViewCellAccessoryNone;
            UIButton *releaseBut= [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth/640*240+40, 8, kDeviceWidth/32*5-16, kDeviceWidth/32*5-16)];
            releaseBut.tag = 8002;
            [releaseBut setBackgroundImage:[UIImage imageNamed:@"jian-icon"] forState:UIControlStateNormal];
            [releaseBut addTarget:self action:@selector(loanMoneyButAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:releaseBut];
            
            self.loanField = [[UITextField alloc] initWithFrame:CGRectMake(releaseBut.right+5, releaseBut.top, kDeviceWidth/640*400-((kDeviceWidth/32*5-6)*2)-40, kDeviceWidth/32*5-16)];
            self.loanField.layer.borderColor = [UIColor lightGrayColor].CGColor;
            self.loanField.layer.borderWidth = 1;
            self.loanField.layer.cornerRadius = 3;
            self.loanField.font = [UIFont systemFontOfSize:13];
            //        self.loanField.text = @"1";
            self.loanField.placeholder = @"最多100个";
            self.loanField.text = @"1";
            self.loanField.delegate = self;
            self.loanField.keyboardType = UIKeyboardTypeNumberPad;
            self.loanField.textAlignment = NSTextAlignmentCenter;
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(butuserInteractionEnabled:) name:UITextFieldTextDidChangeNotification object:nil];
            [cell.contentView addSubview:self.loanField];
            
            UIButton *addBut= [[UIButton alloc] initWithFrame:CGRectMake(self.loanField.right+5, releaseBut.top, kDeviceWidth/32*5-16, kDeviceWidth/32*5-16)];
            addBut.tag = 8003;
            [addBut setBackgroundImage:[UIImage imageNamed:@"jia-icon"] forState:UIControlStateNormal];
            [addBut addTarget:self action:@selector(loanMoneyButAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:addBut];
            
        }else if (indexPath.row == 3){
            cell.accessoryType = UITableViewCellAccessoryNone;
            UIImage * imageON = [UIImage imageNamed:@"fenqi.png"];
            UIImage * imageOff = [UIImage imageNamed:@"quane.png"];
            self.reimbursementSwitch = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth-100, 10, 80, kDeviceWidth/32*5-16)];
            self.reimbursementSwitch.selected = YES;
            self.dingOrFen = @"全额";
            self.repaymentType = 0;
            [self.reimbursementSwitch setImage:imageON forState:UIControlStateNormal];
            [self.reimbursementSwitch setImage:imageOff forState:UIControlStateSelected];
            [self.reimbursementSwitch addTarget:self action:@selector(loanMoneyButAction:) forControlEvents:UIControlEventTouchUpInside];
            self.reimbursementSwitch.tag = 8004;
            [cell.contentView addSubview:self.reimbursementSwitch];
        }else if (indexPath.row == 4){
            self.loanTimePickLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth-100, 0, 100, kDeviceWidth/32*5)];
            self.loanTimePickLabel.textAlignment = NSTextAlignmentCenter;
            self.loanTimePickLabel.textColor = [UIColor lightGrayColor];
            self.loanTimePickLabel.font = [UIFont systemFontOfSize:13];
            self.loanTimePickLabel.text = @"3个月";
            [cell.contentView addSubview:self.loanTimePickLabel];
            
        }else if (indexPath.row == 5){
            self.loanRatePickLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth-100, 0, 100, kDeviceWidth/32*5)];
            self.loanRatePickLabel.textAlignment = NSTextAlignmentCenter;
            self.loanRatePickLabel.textColor = [UIColor lightGrayColor];
            self.loanRatePickLabel.font = [UIFont systemFontOfSize:13];
            self.loanRatePickLabel.text = @"10%";
            [cell.contentView addSubview:self.loanRatePickLabel];
        }
    }

    cell.textLabel.text = rowNameArray[indexPath.row];
    [self upDate];
    return cell;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return rowNameArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kDeviceWidth/32*5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        [self addPickerView:arr1 label:self.loanMoneypicklabel];
    }else if (indexPath.row == 4){
        [self addPickerView:arr2 label:self.loanTimePickLabel];
    }else if (indexPath.row == 5){ 
        [self addPickerView:arr3 label:self.loanRatePickLabel];
    }
}

#pragma mark --- tuhaoDelegate
- (void)ISendScrollViewzuotuhao:(Payment_blankNotePay *)noteList {

    [self requestData:noteList];
}


#pragma mark --- 数据请求
-(void)requestData:(Payment_blankNotePay *)noteList
{
//    Payment_blankNotePay *payModel = [[Payment_blankNotePay alloc] init];
    NSString *url = [YXBPaymentUtils getFullWebUrl:noteList];
    [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"支付"];
    
//    if (self.iHttpOperator == nil) {
//        self.iHttpOperator = [[HttpOperator alloc]init];
//        
//    }
//    [self.iHttpOperator cancel];
//    __weak HttpOperator * assginHtttperator = _iHttpOperator;
////    __block ISendLoanViewController *this = self;
//    [self.iHttpOperator connetStart:^(int d) {
//        
//        
//    } cancel:^(int d) {
//        
//        
//    } error:^(int d, THttpOperatorErrorCode e) {
//        
//        
//    } param:^(NSString *s) {
//        AppBlankNoteManager* blankNote = (AppBlankNoteManager *)  [assginHtttperator getAopInstance:[AppBlankNoteManager class] returnValue:[TResultSet class]];
//        [blankNote __yxb__createBlankNote:noteList];
//    } complete:^(TResultSet *r, int taskid) {
//        if (r.errCode == 0) {
//            //扣钱
////            QCUserManager * userManager = [QCUserManager sharedInstance];
////            QCUserModel * userModel = [userManager getLoginUser];
////            userModel.user.remainMoney -= [noteList.money integerValue];
////            [userManager setLoginUser:userModel];
//            MyTuhaoLoanListViewController *mytuhao = [[MyTuhaoLoanListViewController alloc] init];
//            mytuhao.isMy = YES;
//            [self.navigationController pushViewController:mytuhao animated:YES];
//
//        }else {
//
//        }
//        
//        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"%@",r.errString] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alter show];
//    }];
//    
//    [self.iHttpOperator connect];
//    
}


#pragma mark -----------------------------------------------HttpDownLoad
- (void)httpLogin
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak ISendLoanViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        [this.iHttpOperator stopAnimation];
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_StatusCodeError) {
            //服务器挂了
        }
        
    } param:^(NSString *s) {
        
        [this httpLOadParams:s httpOperation:assginHtttperator];
    } complete:^(User* r, int taskid) {
        
        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
}

//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    UserManager* _currUser = (UserManager*)  [httpOperation getAopInstance:[UserManager class] returnValue:[User class]];
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    //                NSString * pwd = [MyMD5 md5:[NSString stringWithFormat:@"%@%@",Md5String,[MyMD5 md5:userModel.user.pwd]]];
//    [_currUser userLogin:userModel.user.username pass:userModel.user.pwd];
    NSString *blackBox = [YXBTool getFMString];
    [_currUser userLoginWithFraudmetrix:userModel.user.username pwd:userModel.user.pwd fraudmetrixToken:blackBox];
    
}
//请求完成
-(void)httpLoadComplete:(User *)r{
    if (r.errCode == 0) {
        QCUserModel * currUser = [[QCUserModel alloc]init];
        currUser.isLogin = YES;
        currUser.user = r;
        self.remainMoney = [currUser.user.totalMoney doubleValue];
        TUnreadFlagCount * unReaderCount = [[TUnreadFlagCount alloc]init];
        currUser.unreadCont = unReaderCount;
        currUser.unreadCont.lastQueryDate = @"";
        currUser.firstMessageTime = @"";
        currUser.lastMessageTime = @"";
        QCUserManager * um  = [QCUserManager sharedInstance];
        QCUserModel * oldUser = [um getLoginUser];
        if (![oldUser.user.username isEqualToString:r.username]) {
            currUser.gestureOpen = NO;
            [YXBTool setGesturePassWord:nil];
            
        }
        else
        {
            currUser.gestureOpen = oldUser.gestureOpen;
            
        }
        _MyallZiJinText.text = [NSString stringWithFormat:@"￥ %@元",[YXBTool countNumAndChangeformat:[NSString stringWithFormat:@"%.2f",self.remainMoney]]];
        //            NSLog(@"%@",_MyallZiJinText.text);
        [um setLoginUser:currUser];
    }else{
        NSString * string = r.errString;
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message: string delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }

}
//shang'chuan
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
