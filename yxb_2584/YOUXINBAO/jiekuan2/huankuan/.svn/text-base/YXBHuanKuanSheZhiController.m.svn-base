//
//  YXBHuanKuanSheZhiController.m
//  YOUXINBAO
//
//  Created by Feili on 16/1/28.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "YXBHuanKuanSheZhiController.h"
#import "YXBJieKuanBaseCell.h"
#import "HuanKuanFangShiCell.h"
#import "LIXiCell.h"
#import "JieKuanConfig.h"

#define kOFFSET_FOR_KEYBOARD (80.0)


@interface YXBHuanKuanSheZhiController ()<JieKuanCellDelegate>
{
    UILabel *tintLabel;//下部提示文字
}

@end

@implementation YXBHuanKuanSheZhiController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    tintLabel.text = @"默认无息,可自定义借款利息";
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
    
    
}


#pragma -mark UITableView Datasource & delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXBLoan *loan = [JieKuanInstance shareInstance].yxbLoan;
    CGFloat height = [self getCellHeight:indexPath.row];

    YXBJieKuanBaseCell *cell = nil;
    if (indexPath.row == 0) {
        static NSString * cellID  =@"HuanKuanFangShiCell";

        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[HuanKuanFangShiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID width:self.tableView.width height:height];
            
        }

    }
    else if (indexPath.row == 1){
        static NSString * cellID  =@"LIXiCell";
        cell = [self.tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
//            CGFloat height = 44;
//            if (loan.interestType == YXBInterestTypeYES) {
//                height = 44+74;
//            }
            
            cell = [[LIXiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID width:self.tableView.width height:height];

        }
        
        
    }


    if (loan != nil) {
        cell.loan = loan;
    }

    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [self getCellHeight:indexPath.row];
    return height;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    [super scrollViewDidScroll:scrollView];
    
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
//    if (interestType == YXBInterestTypeYES)
//    {
    loanInstance.yxbLoan.interestType = interestType;
        loanInstance.yxbLoan.useBankRate  = userBankRate;
        loanInstance.yxbLoan.interest = interest;
        //    loanInstance.yxbLoan.interestRate = rate;
        self.loanRate = rate;
        NSLog(@"yxbloan--\n%@",loanInstance.yxbLoan);

//    }
    
    [self refreshData];
}

-(void)refreshData
{
    [self.tableView reloadData];
    JieKuanInstance *loanInstance = [JieKuanInstance shareInstance];

    //更新底部文字提示信息
    if (loanInstance.yxbLoan.interestType == YXBInterestTypeNO) {
        tintLabel.text = @"默认无息,可自定义借款利息";
    }else if(loanInstance.yxbLoan.interestType == YXBInterestTypeYES)
    {
        tintLabel.text = @"利息取整,只进不舍. 例:应付1.01,实付2元";

    }
    

}

//获取cell的高度
-(CGFloat)getCellHeight:(NSInteger)row
{
    YXBLoan *loan = [JieKuanInstance shareInstance].yxbLoan;
    CGFloat height = 44;
    
    if (row == 0) {
        //还款方式
//        if (loan.repayType == YXBRepayTypeFenQi) {
            height = 44 + 20;
//        }
    }
    else if (row == 1) {
        
        //有息的高度
        if (loan.interestType == YXBInterestTypeYES) {
            height = 44+74;
        }
    }
    
    return height;
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

-(void)jiekuanBeginEditIsMoveKeyBoard:(BOOL)isMove
{
    //move the main view, so that the keyboard does not hide it.
    if (isMove) {
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:isMove];
        }

    }
}

-(void)jiekuanEndEdit
{
    [self setViewMovedUp:NO];
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
//        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
//        rect.size.height -= kOFFSET_FOR_KEYBOARD;
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


-(BOOL)isLixiCellEdit
{
    LIXiCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    BOOL isEdit = [cell isTextFieldEdit];
    return isEdit;
}

@end
