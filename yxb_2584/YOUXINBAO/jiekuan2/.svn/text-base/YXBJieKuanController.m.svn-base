//
//  YXBJieKuanController.m
//  YOUXINBAO
//
//  Created by Feili on 16/1/26.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "YXBJieKuanController.h"
#import "QCSwitchView.h"
#import "YXBJieKuanSheZhiController.h"
#import "YXBHuanKuanSheZhiController.h"
#import "AATimePickerView.h"
#import "JieKuanInstance.h"
#import "LoanConfirmViewController.h"
#import "UIAlertView+Block.h"
#import "YXBTool.h"
#import "StatusHttp.h"
#import "HttpOperator.h"
#import "CreateLoanResponse.h"
#import "ILAlertView.h"
#define YXBJieKuanControllerHeaderViewTag 5000
#define WXLoanNetNumber 2048


@interface YXBJieKuanController ()<QCSwitchViewDelegate,UIScrollViewDelegate,YXBJieKuanControllerDelegate,UIAlertViewDelegate>
{
    UIButton *settingButton;
    UIScrollView *rootScrollView;
    UIButton *topBtn;
    NSMutableAttributedString *mAttStri;
    UITextView*tishiLab;
    UIView*tishiview;
}
@property (nonatomic,strong)YXBJieKuanSheZhiController *jiekuanVC;
@property (nonatomic,strong)YXBHuanKuanSheZhiController *huankuanVC;
//@property (strong, nonatomic) HttpOperator* iHttpOperator;



@end

@implementation YXBJieKuanController

-(void)dealloc
{
    JieKuanInstance *loanInstance = [JieKuanInstance shareInstance];
    loanInstance.yxbLoan = nil;
}




-(void)leftClicked
{
    JieKuanInstance *loanInstance = [JieKuanInstance shareInstance];
    loanInstance.yxbLoan = nil;

    if ([_jiekuanVC isMoneyCellEdit]) {
        [_jiekuanVC.view endEditing:YES];
        return;
    }
    if ([_huankuanVC isLixiCellEdit]) {
        [_huankuanVC.view endEditing:YES];
        return;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"返回将丢失您填写的信息,是否确定返回?" message:nil delegate:nil cancelButtonTitle:@"确定返回" otherButtonTitles:@"留在此页", nil];
    [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
        
        if (buttonIndex == 0) {
            [super leftClicked];
        }
        
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftView];
    self.view.backgroundColor = kRGB(239, 239, 239);
//    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    
    self.title = @"找好友借款";
    [self initViews];
    // Do any additional setup after loading the view.
}

-(void)initViews
{
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
    [self.view addGestureRecognizer:singleTap];

    //上部可切换的tab view
    
    /*
    QCSwitchView *switchView = [[QCSwitchView alloc] initWithFrame:ccr(x, y, w, h)];
    switchView.delegate = self;
    [self.view addSubview:switchView];
    */
    
    NSString *stringNameSelected = @"JieKuanTopBar1";
    UIImage *image = [UIImage imageNamed:stringNameSelected];
    CGFloat x = 15, y = 10, w = kDeviceWidth-30;
    CGFloat rrr = (image.size.height * w)/image.size.width;
    CGFloat h = rrr;
    topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    topBtn.frame = ccr(x, y, w, h);
    [topBtn addTarget:self action:@selector(topBtnAction) forControlEvents:UIControlEventTouchUpInside];
    topBtn.backgroundColor = [UIColor clearColor];
    [topBtn setBackgroundImage:[UIImage imageNamed:stringNameSelected] forState:UIControlStateNormal];
    [self.view addSubview:topBtn];
    //借款设置
    x = 15;
    y = topBtn.bottom + 5;
    w = kDeviceWidth - 30;
    h = 60;
    
    
    UIImageView *bgimage = [[UIImageView alloc] initWithFrame:ccr(x, y, w, h)];
    UIImage *bgimageV = [UIImage imageNamed:@"JieKuanbgtop.png"];
//    bgimageV = [bgimageV stretchableImageWithLeftCapWidth:100 topCapHeight:bgimageV.size.height];
    h = [YXBTool heightWithSize:bgimageV.size width:w];
    bgimage.image = bgimageV;
    bgimage.frame = ccr(x, y, w, h);
    [bgimage addGestureRecognizer:singleTap];
    [self.view addSubview:bgimage];
    


    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setBackgroundImage:[UIImage imageNamed:@"JieKuanbgtop.png"] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
    btn.frame = ccr(x, y - 3, w, h);
    [btn setTitle:@"   1 借款信息" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    btn.userInteractionEnabled = NO;
    btn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    btn.titleEdgeInsets = UIEdgeInsetsMake(4, 0, 20, 0);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.hidden = YES;
    settingButton = btn;
//    [settingButton addTarget:self action:@selector(topBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    //下一步按钮
    
    stringNameSelected = @"jiekuanNext.png";

    UIImage *sImage = [UIImage imageNamed:stringNameSelected];
    h = [YXBTool heightWithSize:sImage.size width:kDeviceWidth - 30];
    x = 15, w = kDeviceWidth - 30,y = kDeviceHeight - 64 - h - 15;
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    bottomBtn.backgroundColor = [UIColor lightGrayColor];
    bottomBtn.frame = ccr(x, y-40, w, h);
    stringNameSelected = @"jiekuanNext.png";
    [bottomBtn setImage:[UIImage imageNamed:stringNameSelected] forState:UIControlStateNormal];
    [bottomBtn setBackgroundImage:sImage forState:UIControlStateNormal];
    
    [bottomBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    bottomBtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bottomBtn];
    
    UIButton *shoufeiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    bottomBtn.backgroundColor = [UIColor lightGrayColor];
    shoufeiBtn.frame = ccr(x, y+10, w, h);
    NSString *stringNameSelected1 = @"shoufeiBtn.png";  [shoufeiBtn setImage:[UIImage imageNamed:stringNameSelected1] forState:UIControlStateNormal];
//    [shoufeiBtn setBackgroundImage:sImage forState:UIControlStateNormal];
    
    [shoufeiBtn addTarget:self action:@selector(setInfoViewFrame) forControlEvents:UIControlEventTouchUpInside];
    shoufeiBtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:shoufeiBtn];

    

    w = kDeviceWidth;

    rootScrollView = [[UIScrollView alloc] initWithFrame:ccr(0, btn.bottom, w, kDeviceHeight - btn.bottom - bottomBtn.height - 64 -35)];
    rootScrollView.contentSize = CGSizeMake(kDeviceWidth * 2, rootScrollView.height);
    rootScrollView.pagingEnabled = YES;
    rootScrollView.scrollEnabled = NO;
//    scrollView.backgroundColor = [UIColor brownColor];
    rootScrollView.delegate = self;
    rootScrollView.bounces = NO;
    [rootScrollView addGestureRecognizer:singleTap];
    [self.view addSubview:rootScrollView];
    
    
    if (self.yxbLoan == nil) {
        self.yxbLoan = [[YXBLoan alloc] init];
    }
    
    QCUserModel *model = [[QCUserManager sharedInstance] getLoginUser];
    
    JieKuanInstance *loanInstance = [JieKuanInstance shareInstance];
    if (loanInstance.yxbLoan == nil) {
        loanInstance.yxbLoan = [[YXBLoan alloc] init];
        loanInstance.yxbLoan.loanType = YXBLoanTypeChangGuiJieKuan;
        loanInstance.yxbLoan.interestType = YXBInterestTypeNO;
        loanInstance.yxbLoan.interest = @"0";
        loanInstance.yxbLoan.yxbToken = model.user.yxbToken;
        loanInstance.yxbLoan.borrowerId = model.user.t_id;
    }
    
    
    
    //添加tableView
    self.jiekuanVC = [[YXBJieKuanSheZhiController alloc] init];
    _jiekuanVC.viewFrame = ccr(0, 0, rootScrollView.width, rootScrollView.height-40);
//    _jiekuanVC.yxbLoan = _yxbLoan;
     [_jiekuanVC.view addGestureRecognizer:singleTap];
    [rootScrollView addSubview:_jiekuanVC.view];
    
    self.huankuanVC = [[YXBHuanKuanSheZhiController alloc] init];
    _huankuanVC.viewFrame = ccr(rootScrollView.width, 0, rootScrollView.width, rootScrollView.height-40);
//    _huankuanVC.yxbLoan = _yxbLoan;
    [_huankuanVC.view addGestureRecognizer:singleTap];

    [rootScrollView addSubview:_huankuanVC.view];
    

    //添加提示lable
    tishiview=[[UIView alloc]initWithFrame:ccr(0, bottomBtn.frame.origin.y+bottomBtn.frame.size.height, kDeviceWidth, 60)];
    tishiview.backgroundColor=[UIColor whiteColor];
    tishiLab=[[UITextView alloc]initWithFrame:CGRectMake(20, 0, kDeviceWidth-40, 60)];
    tishiLab.backgroundColor=[UIColor clearColor];
    tishiLab.text=@"收费标准:\n100-5000元收取2元,5001-10000元收取5元,10000以上收取10元";
    NSMutableAttributedString*mAttStri1 = [[NSMutableAttributedString alloc] initWithString:tishiLab.text];
    [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(17,1
                                                                                        )];
     [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(33,1)];
    [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(45,2)];
   [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13.0] range:NSMakeRange(0, 5)];
    tishiLab.attributedText=mAttStri1;
    [tishiview addSubview:tishiLab];
    tishiview.hidden=YES;
    tishiLab.editable = NO;
    [tishiLab addGestureRecognizer:singleTap];
    [tishiview addGestureRecognizer:singleTap];
    [self.view addSubview:tishiview];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    NSString *stringNameSelected = @"JieKuanTopBar1";
    NSString *stringNameUnSelected = @"JieKuanTopBar2";

    if (scrollView.contentOffset.x >= scrollView.width) {
        [settingButton setTitle:@"    2 还款设置" forState:UIControlStateNormal];
//        [topBtn setImage:[UIImage imageNamed:stringNameUnSelected] forState:UIControlStateNormal];
        [topBtn setBackgroundImage:[UIImage imageNamed:stringNameUnSelected] forState:UIControlStateNormal];

        if (scrollView.contentOffset.x == scrollView.width) {
            [self.huankuanVC refreshData];

        }

    }
    else if (scrollView.contentOffset.x < scrollView.width) {
        [settingButton setTitle:@"    1 借款信息" forState:UIControlStateNormal];
        if (scrollView.contentOffset.x <= 0) {
//            [topBtn setImage:[UIImage imageNamed:stringNameSelected] forState:UIControlStateNormal];
            [topBtn setBackgroundImage:[UIImage imageNamed:stringNameSelected] forState:UIControlStateNormal];


        }
    }

}

#pragma -mark  switchViewDelegate
-(void)switchViewDidSelectedIndex:(NSInteger)index
{
//    UIButton *topBtn = [self.view viewWithTag:YXBJieKuanControllerHeaderViewTag];
    if (index == 0) {
        [settingButton setTitle:@"  1 借款信息" forState:UIControlStateNormal];
    }
    else if (index == 1)
    {
        [settingButton setTitle:@"    2 还款设置" forState:UIControlStateNormal];

    }
}




-(void)viewWillDisappear:(BOOL)animated
{
    UIWindow *mWindow = [[[UIApplication sharedApplication] delegate] window];
    
    for (UIView *view in mWindow.subviews) {
        if ([view isKindOfClass:[AATimePickerView class]]) {
            [view removeFromSuperview];
        }
    }
    [super viewWillDisappear:YES];
}

-(void)loadView
{
    [super loadView];
}

-(void)AlertShowBtn
{
    YXBLoan *loan = [JieKuanInstance shareInstance].yxbLoan;
    NSString*fuwufei;
     if (([loan.money integerValue]>=100)&&([loan.money integerValue]<=5000))
     {
         fuwufei=@"2";
     }
   else  if (([loan.money integerValue]>5000)&&([loan.money integerValue]<=10000))
    {
        fuwufei=@"5";
    }
    if ([loan.money integerValue]>10000)
    {
        fuwufei=@"10";
    }
    
    NSString *AlertMessage = [NSString stringWithFormat:@"借款成功后无忧借条将收取 %@ 元服务费",fuwufei];
//    mAttStri = [[NSMutableAttributedString alloc] initWithString:AlertMessage];
//    NSRange range = [AlertMessage rangeOfString:[NSString stringWithFormat:@"%@",fuwufei]];
//       [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
//   UILabel*fuwuLab=[[UILabel alloc]init];
//    fuwuLab.attributedText=mAttStri;
    
//   
       [ILAlertView showWithTitle:nil
                       message:AlertMessage
              closeButtonTitle:@"确定"
             secondButtonTitle:@"取消"
               tappedSecondButton:^{
                   [UIView animateWithDuration:0.5 animations:^{
                       rootScrollView.contentOffset = CGPointMake(rootScrollView.width, 0);
                       
                   }];
                   [self.huankuanVC refreshData];
               }];
    ILAlertView*alterView=[[ILAlertView alloc]init];
//    UIAlertView*alterView =[[UIAlertView alloc] initWithTitle:nil message:AlertMessage delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//   [alterView show];
    alterView.tag = 10010;

}
-(void)nextAction
{
   
//    [self.view endEditing:YES];
    tishiview.hidden=YES;
    YXBLoan *loan = [JieKuanInstance shareInstance].yxbLoan;

    if (rootScrollView.contentOffset.x < rootScrollView.width) {
        if (loan.money != nil && loan.backTime != nil) {
            if ([loan.money integerValue] >= [YXBJieKuanMinMoney integerValue] &&
                [loan.money integerValue] <= [YXBJieKuanMaxMoney integerValue])
            {
                [self AlertShowBtn];
                

            }
            else
            {
                if ([loan.money integerValue] < [YXBJieKuanMinMoney integerValue]) {
//                    [YXBTool showAlertViewWithString:[NSString stringWithFormat:@"借款金额最低限额%@元",YXBJieKuanMinMoney]];
                    [ProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"借款金额不能小于%@元",YXBJieKuanMinMoney]];
                }
                else if ([loan.money integerValue] > [YXBJieKuanMaxMoney integerValue])
                {
                    [ProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"借款金额最高限额100万"]];

                }
//                [ProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"借款金额%@——%@元之间",YXBJieKuanMinMoney,YXBJieKuanMaxMoney]];

            }

        }
        
        else
        {
            if (loan.money == nil) {
                [ProgressHUD showErrorWithStatus:@"借款金额不能为空!"];
            }else if(loan.backTime == nil)
            {
                [ProgressHUD showErrorWithStatus:@"还款时间不能为空!"];

            }
        }
    }
    else
    {
//        [ProgressHUD showSuccessWithStatus:@"提交信息"];
        
        if (loan.interestType == YXBInterestTypeYES) {
            
            //关闭利率不能超过100%限制
            //有利息
            //if ([_huankuanVC.loanRate floatValue]>=100){
                
            //    [ProgressHUD showWithStatus:@"利率不能超过100%请重新设置。"];
            //    return;
            //}
            if ([_huankuanVC.loanRate floatValue]>24) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"根据国家法律规定，民间借贷的年利率超过24%的部分法律不予保护，超过36%的部分法院不予支持。" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:@"再想想", nil];
                alert.tag = 2300;
                [alert show];
                return;
            }
            if (loan.interestType == YXBInterestTypeYES) {
                if ([loan.interest integerValue] <= 0) {
                    
                    [ProgressHUD showErrorWithStatus:@"利息输入有误,请重新输入!"];
                    return;
                    
                }
                
            }

        }
        
        NSLog(@"loanDetail:==\n%@",[JieKuanInstance shareInstance].yxbLoan);
        LoanConfirmViewController *loanConfirmVC = [[LoanConfirmViewController alloc] init];
        loanConfirmVC.loanRate = _huankuanVC.loanRate;
        loanConfirmVC.yxbLoanModel = [JieKuanInstance shareInstance].yxbLoan;
        [self.navigationController pushViewController:loanConfirmVC animated:YES];
        rootScrollView.contentOffset = CGPointMake(0, 0);
    }
}
#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 10010) {
        if (buttonIndex == 1) {
            [UIView animateWithDuration:0.5 animations:^{
                rootScrollView.contentOffset = CGPointMake(rootScrollView.width, 0);
                
            }];
            [self.huankuanVC refreshData];
        }
    }
    else{
    if (buttonIndex==0) {
//        NSLog(@"loanDetail:==\n%@",[JieKuanInstance shareInstance].yxbLoan);
        LoanConfirmViewController *loanConfirmVC = [[LoanConfirmViewController alloc] init];
        loanConfirmVC.loanRate = _huankuanVC.loanRate;
        loanConfirmVC.yxbLoanModel = [JieKuanInstance shareInstance].yxbLoan;

        [self.navigationController pushViewController:loanConfirmVC animated:YES];
        rootScrollView.contentOffset = CGPointMake(0, 0);
    }
    }
}

- (void)willPresentAlertView:(UIAlertView *)alertView {
    
    // 遍历 UIAlertView 所包含的所有控件
    
    for (UIView *tempView in alertView.subviews) {
         if ([tempView isKindOfClass:[UILabel class]]) {
            
            // 当该控件为一个 UILabel 时
            
            UILabel *tempLabel = (UILabel *) tempView;
                       if ([tempLabel.text isEqualToString:alertView.message]) {
                
                // 调整对齐方式
                tempLabel.textAlignment = UITextAlignmentLeft;
                
                // 调整字体大小
                [tempLabel setFont:[UIFont systemFontOfSize:15.0]];
                [tempLabel setTextColor:[UIColor redColor]];
            }        }
            }
    
}
//顶部选择栏
-(void)topBtnAction
{
//    [self.view endEditing:YES];
    tishiview.hidden=YES;
    if ([_jiekuanVC isMoneyCellEdit]) {
        [self.view endEditing:YES];
    }
    else
    {
        YXBLoan *loan = [JieKuanInstance shareInstance].yxbLoan;
        
        if (rootScrollView.contentOffset.x < rootScrollView.width) {
            if (loan.money != nil && loan.backTime != nil) {
               
                if ([loan.money integerValue] >= [YXBJieKuanMinMoney integerValue] &&
                    [loan.money integerValue] <= [YXBJieKuanMaxMoney integerValue])
                {
//                    [UIView animateWithDuration:0.5 animations:^{
//                        
//                        rootScrollView.contentOffset = CGPointMake(rootScrollView.width, 0);
//                        
//                    }];
                    [self AlertShowBtn];
                    [self.huankuanVC refreshData];
                    
                }
                else
                {
                    
                    if ([loan.money integerValue] < [YXBJieKuanMinMoney integerValue]) {
                        [ProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"借款金额不能小于%@元",YXBJieKuanMinMoney]];
                    }
                    else if ([loan.money integerValue] > [YXBJieKuanMaxMoney integerValue])
                    {
                        [ProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"借款金额最高限额100万"]];
                        
                    }


                }
                
            }
            
            else
            {
                if (loan.money == nil) {
                    [ProgressHUD showErrorWithStatus:@"借款金额不能为空!"];
                }else if(loan.backTime == nil)
                {
                    [ProgressHUD showErrorWithStatus:@"还款时间不能为空!"];
                    
                }
            }
        }
        else
        {
            //        [ProgressHUD showSuccessWithStatus:@"提交信息"];
            
            
            [UIView animateWithDuration:0.5 animations:^{
                
                rootScrollView.contentOffset = CGPointMake(0, 0);
                
            }];
            
        }

    }
}
- (void)setInfoViewFrame{
    
    tishiview.hidden=NO;
    }
- (void)handleSingleTap{
    
    tishiview.hidden=YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
