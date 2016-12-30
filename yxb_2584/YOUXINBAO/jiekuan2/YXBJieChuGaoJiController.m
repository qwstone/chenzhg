//
//  YXBJieChuGaoJiController.m
//  YOUXINBAO
//
//  Created by Feili on 16/2/16.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "YXBJieChuGaoJiController.h"
#import "YXBJieKuanBaseCell.h"
#import "JieKuanJinECell.h"
#import "HuanKuanShiJianCell.h"
#import "HuanKuanFangShiCell.h"
#import "LIXiCell.h"
#import "YXBTool.h"
#define kOFFSET_FOR_KEYBOARD (80.0 + 100)

@interface YXBJieChuGaoJiController ()<UITableViewDelegate,UITableViewDataSource,JieKuanCellDelegate>
{
    UILabel *tintLabel;//下部提示文字

}
//@property (nonatomic,strong)UITableView *tableView;
@end

@implementation YXBJieChuGaoJiController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)setViewFrame:(CGRect)viewFrame
{
    [super setViewFrame:viewFrame];
    //设置 footerView
    
    NSInteger labelHeight = 50;

    UIView *footerView = [[UIView alloc] initWithFrame:ccr(0, 0, kDeviceWidth, labelHeight + 20)];
    footerView.backgroundColor = [UIColor clearColor];
    
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:ccr(0, 0, kDeviceWidth-30, labelHeight)];
    UIImage *img1 = [UIImage imageNamed:@"JieKuanbgcon.png"];
//    img1 = [img1 stretchableImageWithLeftCapWidth:img1.size.width/2 topCapHeight:img1.size.height/2];
    bgImage.image = img1;
    [footerView addSubview:bgImage];
    
    tintLabel = [[UILabel alloc] initWithFrame:ccr(0, 5, bgImage.width, labelHeight)];
    tintLabel.text = @"信用来之不易,借款量力而行";
    tintLabel.textColor = kRGB(225, 39, 39);
    tintLabel.font = [UIFont systemFontOfSize:14.0];
    tintLabel.textAlignment = NSTextAlignmentCenter;
    [bgImage addSubview:tintLabel];
    
    UIImageView *footerImage = [[UIImageView alloc] initWithFrame:ccr(0, bgImage.bottom, kDeviceWidth - 30, 20)];
    UIImage *img = [UIImage imageNamed:@"jiekuanbgfoot.png"];
//    img = [img stretchableImageWithLeftCapWidth:img.size.width/2 topCapHeight:img.size.height/2];
    
    footerImage.image = img;
    [footerView addSubview:footerImage];
    
    self.tableView.tableFooterView = footerView;
    [self refreshBottom];
    
    
}



#pragma -mark UITableView Datasource & delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [self getCellHeight:indexPath.row];

    YXBJieKuanBaseCell *cell = nil;
    //借款金额
    if (indexPath.row == 0) {
        NSString *cellIdentifier = @"jine";//金额
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            //            cell = [[JieKuanJinECell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell = [[JieKuanJinECell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier width:self.tableView.width height:44];
            
            
        }
        
    }
    else if (indexPath.row == 1)
    {
        //还款时间
        NSString *cellIdentifier = @"time";//金额
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            //            cell = [[HuanKuanShiJianCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            CGFloat height = 44 + 100;
            
            cell = [[HuanKuanShiJianCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier width:self.tableView.width height:height];
            
            
        }
        
    }
    else if (indexPath.row == 2)
    {
        //还款方式
        static NSString * cellID  =@"HuanKuanFangShiCell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[HuanKuanFangShiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID width:self.tableView.width height:height];
            
        }
        
    }
    else if (indexPath.row == 3)
    {
        static NSString * cellID  =@"LIXiCell";
        cell = [self.tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            
            cell = [[LIXiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID width:self.tableView.width height:height];
            
        }

    }
    
    YXBLoan *loan = [JieKuanInstance shareInstance].yxbLoan;
    if (loan != nil) {
        cell.loan = loan;
    }
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    CGFloat height = 44;
//    if (indexPath.row == 1) {
//        height = 44 + 100;
//    }
    return [self getCellHeight:indexPath.row];
}

//获取cell的高度
-(CGFloat)getCellHeight:(NSInteger)row
{
    YXBLoan *loan = [JieKuanInstance shareInstance].yxbLoan;
    CGFloat height = 44;
    if (row == 1) {
        NSInteger durationHeight = 0;
        if ([loan.duration integerValue] > 0) {
            durationHeight = 10;
        }

        height = 34 + [YXBTool getSquareHeight] + durationHeight;
    }
    else if (row == 2) {
        //        if (loan.repayType == YXBRepayTypeFenQi) {
        height = 44 + 20;
        //        }
    }
    else if (row == 3) {
        
        //有息的高度
        if (loan.interestType == YXBInterestTypeYES) {
            height = 44+74;
        }
    }
    
    return height;
}

#pragma -mark Jiekuancelldelegate

-(void)updateJieKuanJinEWithMoney:(NSString *)money
{
    JieKuanInstance *loanInstance = [JieKuanInstance shareInstance];
    
    loanInstance.yxbLoan.money = money;
    [self refreshData];
}

-(void)updateHuanKuanShiJian:(NSString *)time
{
    JieKuanInstance *loanInstance = [JieKuanInstance shareInstance];
    
    loanInstance.yxbLoan.backTime = time;
    
    NSInteger fenqishu = [YXBTool getAmortizationNumWithEndDate:loanInstance.yxbLoan.backTime];
    if (fenqishu > 1 && loanInstance.yxbLoan.repayType == YXBRepayTypeFenQi)
    {
        
    }
    else
    {
        loanInstance.yxbLoan.repayType = YXBRepayTypeQuanE;

    }

    NSInteger day = [YXBTool daysBetweenTwoDaysWithEndDayStr:time];
    loanInstance.yxbLoan.duration = [NSString stringWithFormat:@"%ld",(long)day];
    [self refreshData];

    
}

-(void)updateHuanKuanFangShi:(YXBRepayType)repayType
{
    JieKuanInstance *loanInstance = [JieKuanInstance shareInstance];
    
    loanInstance.yxbLoan.repayType = repayType;
    [self refreshData];
    
}

-(void)updateHuanKuanInterestType:(YXBInterestType)interestType userBankRate:(YXBUseBankRate)userBankRate interest:(NSString *)interest rate:(NSString *)rate
{
    JieKuanInstance *loanInstance = [JieKuanInstance shareInstance];
    
    loanInstance.yxbLoan.interestType = interestType;
    loanInstance.yxbLoan.useBankRate  = userBankRate;
    loanInstance.yxbLoan.interest = interest;
    //    loanInstance.yxbLoan.interestRate = rate;
    self.loanRate = rate;
    NSLog(@"yxbloan--\n%@",loanInstance.yxbLoan);
    
    [self refreshData];
}

-(void)refreshData
{
    [self.tableView reloadData];
    [self refreshBottom];
    
}

-(void)refreshBottom
{
    JieKuanInstance *loanInstance = [JieKuanInstance shareInstance];
    
    //更新底部文字提示信息
    if (loanInstance.yxbLoan.interestType == YXBInterestTypeNO) {
        tintLabel.text = @"默认无息,可自定义借款利息";
    }else if(loanInstance.yxbLoan.interestType == YXBInterestTypeYES)
    {
        tintLabel.text = @"利息取整,只进不舍. 例:应付1.01,实付2元";
        
    }

}


//键盘弹出  控制textfield
-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

//-(void)textFieldDidBeginEditing:(UITextField *)sender
-(void)jiekuanBeginEditIsMoveKeyBoard:(BOOL)isMove
{
    //move the main view, so that the keyboard does not hide it.
    if (isMove) {
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }

    }
}

-(void)jiekuanEndEdit
{
    if (self.view.frame.origin.y < 0) {
        [self setViewMovedUp:NO];

    }
}

-(void)updateHuanKuanRate:(NSString *)rate
{
    self.loanRate = rate;
}


//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [self.view endEditing:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    [self.view endEditing:YES];

}

-(BOOL)isMoneyCellEdit
{
    JieKuanJinECell *cell0 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    BOOL cell0IsEdit = [cell0.textField isFirstResponder];
    LIXiCell *cell1 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    BOOL cell1IsEdit = [cell1 isTextFieldEdit];

    return (cell0IsEdit || cell1IsEdit);
}




@end
