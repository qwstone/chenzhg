//
//  QCFeedbackViewController.m
//  YOUXINBAO
//
//  Created by 张淼 on 14-6-4.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCFeedbackViewController.h"
#import "PersonCenterManager.h"
#import "TFeedbackLogManager.h"
#import "HttpOperator.h"
#import "TResultSet.h"
#import "YXBTool.h"
#import "QCAboutUsViewController.h"

@interface QCFeedbackViewController ()<UITextViewDelegate>
{

    UITextView * _textView;
    UILabel * textViewplacehide;
}

@end

@implementation QCFeedbackViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setnavigationItem];
    [self createUI];
}

- (void)setnavigationItem
{
    self.title = @"意见反馈";
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftAction)];


}

- (void)createUI
{
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(20, 20, kDeviceWidth-40, 200)];
    _textView.font = [UIFont systemFontOfSize:15];
 //   _textView.backgroundColor=[UIColor whiteColor];
//    _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _textView.layer.borderColor=rgb(214, 214, 214, 1).CGColor;
    _textView.layer.borderWidth=1;
    _textView.layer.cornerRadius=6;
    _textView.layer.masksToBounds=YES;
    [_textView becomeFirstResponder];
    _textView.delegate = self;
    [self.view addSubview:_textView];

    textViewplacehide = [[UILabel alloc]initWithFrame:CGRectMake(30, 25, kDeviceWidth-50, 40)];
    textViewplacehide.numberOfLines=0;
    textViewplacehide.enabled = NO;
    textViewplacehide.font = [UIFont systemFontOfSize:15];
    textViewplacehide.textColor = [UIColor grayColor];
    textViewplacehide.text = @"您的意见是我们改正的标准,您的建议是我们进步的来源";
    textViewplacehide.backgroundColor = [UIColor clearColor];
    [self.view addSubview: textViewplacehide];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20, 240, kDeviceWidth, 30)];
    label.text=@"客服电话: 400-6688-658";
    label.userInteractionEnabled = YES;
    [self.view addSubview:label];
    //添加打电话事件
    UIControl *control = [[UIControl alloc] initWithFrame:label.bounds];
    control.userInteractionEnabled = YES;
    [control addTarget:self action:@selector(callWaiter) forControlEvents:UIControlEventTouchUpInside];
    [label addSubview:control];
    
    
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(20, 300, kDeviceWidth-40, 46);
    [button setBackgroundImage:[UIImage imageNamed:@"blue-but2.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(ConfirmSubmit) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"确认提交" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
}

-(void)callWaiter
{
    [YXBTool callTelphoneWithNum:YXBCompanyTelephoneNO];
}
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length>0) {
        textViewplacehide.hidden = YES;
    }else{
        if (textView.text.length ==0) {
            textViewplacehide.hidden = NO;
        }
        
        
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }


        return YES;
}

#pragma mark --------------------------------Action
- (void)leftAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

//- (void)secondAction
//{
//    NSLog(@"second");
//    [self changeUserNickName];
//}


- (void)ConfirmSubmit
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak QCFeedbackViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        [this stopDefaultAnimation];
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        [this httpLoadParams:assginHtttperator];
        
    } complete:^(TResultSet* r, int taskid) {
        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
}
- (void)httpLoadParams:(HttpOperator *)assginHtttperator{
    
    TFeedbackLogManager *manager = (TFeedbackLogManager *)[assginHtttperator getAopInstance:[TFeedbackLogManager class] returnValue:[TResultSet class]];
    
    
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    
    //        if (style == L_myList) {
    NSString *userToken = userModel.user.yxbToken;
    if ((userToken != nil) && [userToken length] > 0&&_textView.text.length>0)
    {
        
        [manager addNewTFeedbackLog:userToken note:_textView.text];
        
    }
    else
    {
        if (_textView.text.length==0&&userToken.length>0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"写点东西吧" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
        else if (userToken.length==0){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您尚未登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    }

}
- (void)httpLoadComplete:(TResultSet *)r{

    UIAlertView * alertView;
    if (r.errCode == 0) {
        if (alertView == nil) {
            alertView = [[UIAlertView alloc]initWithTitle:nil message:@"您的建议我们已经收到,感谢您的支持,诚信的路上无忧借条一直陪伴" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }
        
    }


}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    [self.navigationController popViewControllerAnimated:YES];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
