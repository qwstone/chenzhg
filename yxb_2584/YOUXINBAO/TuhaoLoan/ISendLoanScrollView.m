//
//  ISendLoanScrollView.m
//  YOUXINBAO
//
//  Created by zjp on 15/4/28.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "ISendLoanScrollView.h"
#import "TuhaoAreltContentView.h"


#define zeroX       0
#define beginColorBG       [UIColor clearColor];
@implementation ISendLoanScrollView



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
        self.remainMoney = [userModel.user.remainMoney floatValue];
//        self.remainMoney = 0;//假数据
        [self createData];
        [self createUI];
    }
    return self;
}

-(NSString *)countNumAndChangeformat:(NSString *)num{

    NSRange range = [num rangeOfString:@"."];
    NSString *str1 = [num substringFromIndex:range.location];
    NSString *str = [num substringToIndex:range.location];
    NSMutableString *string = [NSMutableString stringWithString:str];
    NSMutableString *newstring = [NSMutableString stringWithString:str];
    int x = ([newstring length] % 3);
    int j = 0;
    for(int i =0; i < [newstring length]; i++)
    {
        if (i != 0) {
            
            if ((x == 0) & (i % 3 == 0)) {
                [string insertString:@"," atIndex:j];
                j++;
            }
            if ((x == 1) & (i % 3 == 1)) {
                [string insertString:@"," atIndex:j];
                j++;
            }
            if ((x == 2) & (i % 3 == 2)) {
                [string insertString:@"," atIndex:j];
                j++;
            }
        }
        j++;
    }
    return [NSString stringWithFormat:@"￥ %@%@元",string,str1];
//    return string;
}
- (void)createUI {
    
    ISendViewBg *bgView = [[ISendViewBg alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 667)];
    bgView.backgroundColor = [UIColor clearColor];
    [self addSubview:bgView];
//-----------------------我的资金
    UILabel *MyallZiJin = [[UILabel alloc] initWithFrame:CGRectMake(zeroX+5, 30, (kDeviceWidth/10)*3, 20)];
    MyallZiJin.backgroundColor = beginColorBG
    MyallZiJin.textAlignment = NSTextAlignmentRight;
    MyallZiJin.textColor = [UIColor lightGrayColor];
    MyallZiJin.font = [UIFont systemFontOfSize:13];
    MyallZiJin.text = @"我的资金：";
    [self addSubview:MyallZiJin];
    

    _MyallZiJinText = [[UILabel alloc] initWithFrame:CGRectMake(MyallZiJin.right, MyallZiJin.top, (kDeviceWidth/10)*7, 20)];
    _MyallZiJinText.backgroundColor = beginColorBG
    _MyallZiJinText.textAlignment = NSTextAlignmentLeft;
    _MyallZiJinText.textColor = [UIColor lightGrayColor];
    _MyallZiJinText.font = [UIFont systemFontOfSize:13];
//    _MyallZiJinText.text = [NSString stringWithFormat:@"￥ %.2f元",self.remainMoney];
    _MyallZiJinText.text = [self countNumAndChangeformat:[NSString stringWithFormat:@"%.2f",self.remainMoney]];
//     _MyallZiJinText.text = [NSString stringWithFormat:@"%ld",(long)self.remainMoney];
    [self addSubview:_MyallZiJinText];

//-----------------------选择白条金额
    UILabel *loanMoney = [[UILabel alloc] initWithFrame:CGRectMake(zeroX, 100, (kDeviceWidth/10)*3, 20)];
    loanMoney.backgroundColor = beginColorBG
    loanMoney.textAlignment = NSTextAlignmentRight;
    loanMoney.textColor = [UIColor lightGrayColor];
    loanMoney.font = [UIFont systemFontOfSize:13];
    loanMoney.text = @"选择白条金额：";
    [self addSubview:loanMoney];
    
    self.loanMoneypicklabel = [[UILabel alloc] initWithFrame:CGRectMake(loanMoney.right, loanMoney.top, 100, 20)];
    self.loanMoneypicklabel.backgroundColor = beginColorBG
    self.loanMoneypicklabel.textAlignment = NSTextAlignmentCenter;
    self.loanMoneypicklabel.textColor = [UIColor lightGrayColor];
    self.loanMoneypicklabel.font = [UIFont systemFontOfSize:13];
    self.loanMoneypicklabel.text = @"2000";
    [self addSubview:self.loanMoneypicklabel];
    
   UIButton *loanMoneyBut= [[UIButton alloc] initWithFrame:CGRectMake(loanMoney.right, loanMoney.top, 100, 20)];
    loanMoneyBut.tag = 8001;
    [loanMoneyBut addTarget:self action:@selector(loanMoneyButAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:loanMoneyBut];
    
//-----------------------设置白条数量
    UILabel *loanNumber = [[UILabel alloc] initWithFrame:CGRectMake(zeroX, 150, (kDeviceWidth/10)*3, 20)];
    loanNumber.backgroundColor = beginColorBG
    loanNumber.textAlignment = NSTextAlignmentRight;
    loanNumber.textColor = [UIColor lightGrayColor];
    loanNumber.font = [UIFont systemFontOfSize:13];
    loanNumber.text = @"设置白条数量：";
    [self addSubview:loanNumber];
    
    UIButton *releaseBut= [[UIButton alloc] initWithFrame:CGRectMake(loanNumber.right, loanNumber.top, kDeviceWidth/10, 20)];
    releaseBut.tag = 8002;
    releaseBut.backgroundColor = [UIColor brownColor];
    [releaseBut setTitle:@"—" forState:UIControlStateNormal];
//    [releaseBut setImage:[UIImage imageNamed:@"navigation_add_"] forState:UIControlStateNormal];
    [releaseBut addTarget:self action:@selector(loanMoneyButAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:releaseBut];
    
    self.loanField = [[UITextField alloc] initWithFrame:CGRectMake(releaseBut.right, releaseBut.top, kDeviceWidth/10*2, 20)];
    self.loanField.backgroundColor = beginColorBG
    self.loanField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.loanField.layer.borderWidth = 1;
    self.loanField.font = [UIFont systemFontOfSize:13];
    self.loanField.text = @"1";
    self.loanField.delegate = self;
    self.loanField.keyboardType = UIKeyboardTypeNumberPad;
    self.loanField.textAlignment = NSTextAlignmentCenter;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(butuserInteractionEnabled:) name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(butuserInteractionEnabled:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [self addSubview:self.loanField];
    
    UIButton *addBut= [[UIButton alloc] initWithFrame:CGRectMake(self.loanField.right, self.loanField.top, kDeviceWidth/10, 20)];
    addBut.tag = 8003;
    addBut.backgroundColor = [UIColor brownColor];
    [addBut setImage:[UIImage imageNamed:@"navigation_add_"] forState:UIControlStateNormal];
    [addBut addTarget:self action:@selector(loanMoneyButAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addBut];
    
    self.loanPlan = [[UILabel alloc] initWithFrame:CGRectMake(addBut.right, addBut.top, (kDeviceWidth/10)*3, 20)];
    self.loanPlan.backgroundColor = beginColorBG
    self.loanPlan.textAlignment = NSTextAlignmentCenter;
    self.loanPlan.font = [UIFont systemFontOfSize:13];
    self.loanPlan.textColor = [UIColor lightGrayColor];
    [self addSubview:self.loanPlan];
    
//-----------------------设置还款方式
    UILabel *Repayment = [[UILabel alloc] initWithFrame:CGRectMake(zeroX, 200, (kDeviceWidth/10)*3, 20)];
    Repayment.backgroundColor = beginColorBG
    Repayment.textAlignment = NSTextAlignmentRight;
    Repayment.font = [UIFont systemFontOfSize:13];
    Repayment.textColor = [UIColor lightGrayColor];
    Repayment.text = @"设置还款方式：";
    [self addSubview:Repayment];
    
    UIButton *RepaymentFenqi= [[UIButton alloc] initWithFrame:CGRectMake(Repayment.right, Repayment.top, 100, 20)];
    RepaymentFenqi.tag = 8004;
    [RepaymentFenqi setTitle:@"分期" forState:UIControlStateNormal];
    [RepaymentFenqi setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [RepaymentFenqi addTarget:self action:@selector(loanMoneyButAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:RepaymentFenqi];
    
    UIButton *RepaymentDingqi= [[UIButton alloc] initWithFrame:CGRectMake(RepaymentFenqi.right, RepaymentFenqi.top, 100, 20)];
    RepaymentDingqi.tag = 8005;
    [RepaymentDingqi setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [RepaymentDingqi setTitle:@"全额" forState:UIControlStateNormal];
    [RepaymentDingqi addTarget:self action:@selector(loanMoneyButAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:RepaymentDingqi];
    
    self.selectBut= [[UIButton alloc] initWithFrame:CGRectMake(Repayment.right, Repayment.top, 100, 20)];
    self.selectBut.layer.borderWidth = 1;
    self.selectBut.center = RepaymentDingqi.center;
    self.selectBut.layer.borderColor = [UIColor redColor].CGColor;
    [self addSubview:self.selectBut];
    
//-----------------------还款周期
    UILabel *loanTime = [[UILabel alloc] initWithFrame:CGRectMake(zeroX, 250, 100, 20)];
    loanTime.backgroundColor = beginColorBG
    loanTime.textAlignment = NSTextAlignmentRight;
    loanTime.font = [UIFont systemFontOfSize:13];
    loanTime.textColor = [UIColor lightGrayColor];
    loanTime.text = @"还款周期：";
    [self addSubview:loanTime];
    
    self.loanTimePickLabel = [[UILabel alloc] initWithFrame:CGRectMake(loanTime.right, loanTime.top, 100, 20)];
    self.loanTimePickLabel.backgroundColor = beginColorBG
    self.loanTimePickLabel.textAlignment = NSTextAlignmentCenter;
    self.loanTimePickLabel.textColor = [UIColor lightGrayColor];
    self.loanTimePickLabel.font = [UIFont systemFontOfSize:13];
    self.loanTimePickLabel.text = @"3个月";
    [self addSubview:self.loanTimePickLabel];
    
    UIButton *loanTimeBut= [[UIButton alloc] initWithFrame:CGRectMake(loanTime.right, loanTime.top, 100, 20)];
    loanTimeBut.tag = 8006;
    [loanTimeBut addTarget:self action:@selector(loanMoneyButAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:loanTimeBut];
    
//-----------------------设置借款年利率
    UILabel *rateLoan = [[UILabel alloc] initWithFrame:CGRectMake(zeroX, 300, 100, 20)];
    rateLoan.backgroundColor = beginColorBG
    rateLoan.textAlignment = NSTextAlignmentRight;
    rateLoan.font = [UIFont systemFontOfSize:12];
    rateLoan.textColor = [UIColor lightGrayColor];
    rateLoan.text = @"设置借款年利率：";
    [self addSubview:rateLoan];
    
    self.loanRatePickLabel = [[UILabel alloc] initWithFrame:CGRectMake(rateLoan.right, rateLoan.top, 100, 20)];
    self.loanRatePickLabel.backgroundColor = beginColorBG
    self.loanRatePickLabel.textAlignment = NSTextAlignmentCenter;
    self.loanRatePickLabel.textColor = [UIColor lightGrayColor];
    self.loanRatePickLabel.font = [UIFont systemFontOfSize:13];
    self.loanRatePickLabel.text = @"10%";
    [self addSubview:self.loanRatePickLabel];
    
    UIButton *loanRateBut= [[UIButton alloc] initWithFrame:CGRectMake(rateLoan.right, rateLoan.top, 100, 20)];
    loanRateBut.backgroundColor = [UIColor clearColor];
    loanRateBut.tag = 8007;
    [loanRateBut addTarget:self action:@selector(loanMoneyButAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:loanRateBut];
    
//-----------------------每月收款金额
    self.MonthMoney = [[UILabel alloc] initWithFrame:CGRectMake(zeroX+5,350, kDeviceWidth-10, 50)];
    self.MonthMoney.textAlignment = NSTextAlignmentCenter;
    self.MonthMoney.backgroundColor = beginColorBG
    self.MonthMoney.textColor = [UIColor redColor];
    self.MonthMoney.numberOfLines = 0;
//    self.MonthMoney.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.MonthMoney];
    
//-----------------------提示
    self.Prompt = [[UILabel alloc] initWithFrame:CGRectMake(zeroX+5, 400, kDeviceWidth-10, 50)];
    self.Prompt.backgroundColor = beginColorBG
    self.Prompt.lineBreakMode = NSLineBreakByWordWrapping;
    self.Prompt.numberOfLines = 0;
    self.Prompt.textColor = [UIColor lightGrayColor];
    self.Prompt.font = [UIFont systemFontOfSize:13];
    self.Prompt.text = @"您随时可以取消尚未借出的白条，白条借出并到期后，本息将直接返回到无忧借条账户中，可随时提款";
    [self addSubview:self.Prompt];
    
//-----------------------条款
    UIButton *tongyi = [[UIButton alloc] initWithFrame:CGRectMake(50, 480, 20, 20)];
    tongyi.frame = CGRectMake(50, 480, 30, 30);
    [tongyi setImage:[UIImage imageNamed:@"chat_right_bg"] forState:UIControlStateNormal];
    [tongyi setImage:[UIImage imageNamed:@"chat_left_bg"] forState:UIControlStateSelected];
    tongyi.tag = 8008;
    [tongyi addTarget:self action:@selector(loanMoneyButAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:tongyi];
    tongyi.selected = YES;
    [self selectButtonTuhao:tongyi];
    
    UIButton *tongyitiaokuan = [[UIButton alloc] initWithFrame:CGRectMake(80, 480, kDeviceWidth-90-40, 30)];
    tongyitiaokuan.titleLabel.font = [UIFont systemFontOfSize:14];
    [tongyitiaokuan setTitle:@"我同意无忧借条土豪条款" forState:UIControlStateNormal];
    [tongyitiaokuan setTitleColor:rgb(25, 110, 150, 1) forState:UIControlStateNormal];
    [tongyitiaokuan setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
    tongyitiaokuan.tag = 8009;
    [tongyitiaokuan addTarget:self action:@selector(loanMoneyButAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:tongyitiaokuan];

//-----------------------发白条
    _zuotuhao = [[UIButton alloc] initWithFrame:CGRectMake(50, 520, (kDeviceWidth-100), 50)];
    _zuotuhao.backgroundColor = [UIColor orangeColor];
    [_zuotuhao setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [_zuotuhao setTitle:@"做土豪" forState:UIControlStateNormal];
    _zuotuhao.tag = 8010;
    [_zuotuhao addTarget:self action:@selector(loanMoneyButAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_zuotuhao];
    
    self.dingOrFen = @"全额";
    self.repaymentType = 0;
    [self upDate];
}


- (void)createData {

    arr1 = [NSArray arrayWithObjects:@[@"1500",@"2000",@"2500",@"3000",@"3500",@"4000",@"4500",@"5000"], nil];
    arr2 = [NSArray arrayWithObjects:@[@"3个月",@"6个月",@"9个月",@"12个月",@"24个月"], nil];
    arr3 = [NSArray arrayWithObjects:@[@"1%",@"2%",@"3%",@"4%",@"5%",@"6%",@"7%",@"8%",@"9%",@"10%",@"11%",@"12%",@"13%",@"14%",@"15%"], nil];
    
    arr2to = [NSArray arrayWithObjects:@[@"3",@"6",@"9",@"12",@"24"], nil];
    arr3to = [NSArray arrayWithObjects:@[@"0.01",@"0.02",@"0.03",@"0.04",@"0.05",@"0.06",@"0.07",@"0.08",@"0.09",@"0.10",@"0.11",@"0.12",@"0.13",@"0.14",@"0.15"], nil];
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
        }
    }else if (sender.tag == 8003){
        NSLog(@"++++++++");
        if ([self.loanField.text integerValue] < _numbers) {
            self.loanField.text = [NSString stringWithFormat:@"%ld",(long)[self.loanField.text integerValue]+1];
        }
    }else if (sender.tag == 8004){
        self.selectBut.center = sender.center;
        self.dingOrFen = @"分期";
        self.repaymentType = 1;
    }else if (sender.tag == 8005){
        self.selectBut.center = sender.center;
        self.dingOrFen = @"全额";
        self.repaymentType = 0;
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
    }else if (sender.tag == 8010){
        NSLog(@"做土豪");
        [self findToLoan1];
    }

    [self upDate];
    [self endEditing:YES];
}


- (void)addPickerView:(NSArray *)pickArray label:(UILabel *)label{
    if ( _visiblePicker != nil) {
        [_visiblePicker removeFromSuperview];
    }
    _visiblePicker = [[ISendPickerView alloc] initWithFrame:CGRectMake(0, self.height, self.width, kCreatePickerCustomHeight) Component:1 listArr:pickArray];
    _visiblePicker.delegate = self;
    __weak ISendLoanScrollView *this = self;
    _visiblePicker.selectedBlock = ^ (NSString *text, AACreatePickerView *createPickerView) {
        label.text = text;
        [this upDate];
    };
    _pivkerWindow = [[UIView alloc] initWithFrame:self.window.bounds];
    _pivkerWindow.alpha = 0.1;
    _pivkerWindow.backgroundColor = [UIColor blackColor];
    [self.window addSubview:_pivkerWindow];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapWindowAction)];
    [_pivkerWindow addGestureRecognizer:tap];
    [self.window addSubview:_visiblePicker];
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
    [self endEditing:YES];
}

//动态更新数据
- (void)upDate {
    _numbers = ((self.remainMoney)/([self.loanMoneypicklabel.text integerValue]));
    if (_numbers > 100) {
        _numbers = 100;
    }
    self.loanPlan.text = [NSString stringWithFormat:@"(最多%ld个)",(long)_numbers];
    if ([self.loanField.text integerValue] < 1) {
        self.loanField.text = [NSString stringWithFormat:@"1"];
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
        string = [NSString stringWithFormat:@"白条借出后的%@，每一个白条每月收款%.2f元",self.loanTimePickLabel.text,moneys];
    }else if ([self.dingOrFen isEqualToString:@"全额"]){
        string = [NSString stringWithFormat:@"白条借出%@后，每一个白条一次性收款%.2f元",self.loanTimePickLabel.text,moneys1];
    }
    strLabel = [[NSMutableAttributedString alloc] initWithString:string];
    [strLabel addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"DBLCDTempBlack" size:17.0] range:NSMakeRange(0,strLabel.length)];
    if ([self.dingOrFen isEqualToString:@"分期"]) {
        [strLabel addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13]
                         range:[string rangeOfString:@"白条借出后的"]];
        [strLabel addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13]
                         range:[string rangeOfString:@"个月，每一个白条每月收款"]];
    }else if ([self.dingOrFen isEqualToString:@"全额"]){
        [strLabel addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13]
                         range:[string rangeOfString:@"白条借出"]];
        [strLabel addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13]
                         range:[string rangeOfString:@"个月后，每一个白条一次性收款"]];
    }
    [strLabel addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13]
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
    if ([userModel.user.remainMoney floatValue] < ([self.loanMoneypicklabel.text integerValue] * [self.loanField.text integerValue])) {
        UIAlertView *arview = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您的余额不足" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去充值", nil];
        arview.tag = 10010;
        [arview show];
        return;
    }
    CreateBlankNote *model = [[CreateBlankNote alloc] init];
    model.token = userModel.user.yxbToken;
    model.money = [NSString stringWithFormat:@"%ld",(long)[self.loanMoneypicklabel.text integerValue] * [self.loanField.text integerValue]];//白条金额
    model.borrowNumber = [self.loanField.text integerValue];//白条数量
    model.repaymentType = self.repaymentType;//1分期 0全额
    model.repaymentMonth = [self.timeToLoan integerValue];//还款周期
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

            if ([self.tuhaoDelegate respondsToSelector:@selector(ISendScrollViewzuotuhao:)]) {
                [self.tuhaoDelegate ISendScrollViewzuotuhao:model];
            }
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
        self.zuotuhao.backgroundColor = [UIColor orangeColor];
    }else{
        self.zuotuhao.userInteractionEnabled = NO;
        self.zuotuhao.backgroundColor = [UIColor lightGrayColor];
    }

}

#pragma mark -- 绘图
- (void)drawRect:(CGRect)rect {


}


@end
