//
//  QCPostMessageViewController.m
//  YOUXINBAO
//
//  Created by Walice on 15/7/7.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCPostMessageViewController.h"
#import "QCAddressListViewController.h"
#import "YXBTool.h"
#import "UserState.h"
#import "TResultSet.h"
#import "SmilePromptManager.h"
#import "YXBProtocolView.h"

@interface QCPostMessageViewController ()<YXBProtocolViewtDelegate>
{
    UITextField *nameField;
     UITextField *telField;

}

@end

@implementation QCPostMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackView];
    self.title=@"催款小秘书";
    self.allnumber=allNum;
    [self _initView];
    [self isRegister];
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged)
//                                                name:@"UITextFieldTextDidChangeNotification"
//                                              object:nil];
//    [[NSNotificationCenter defaultCenter]
//     removeObserver:self
//     name:@"UITextFieldTextDidChangeNotification"
//     object:nil];
   
}


- (void)isRegister{
    if ([UserState isLv2]==E_SUCESS) {
         QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
        nameField.text=userModel.user.realname;
        
    }

}

- (void)_initView{
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
    
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64)];
    scrollView.contentSize = CGSizeMake(kDeviceWidth, kDeviceHeight);
    [self.view addSubview:scrollView];

    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 19, 100, 30)];
    label.text=@"文字效果";
    label.textColor=rgb(48, 48, 48, 1);
    [scrollView addSubview:label];
    
    
    _button=[UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame=CGRectMake(kDeviceWidth-130, 15, 120, 30);
    _button.userInteractionEnabled=NO;
    [_button setImage:[UIImage imageNamed:@"wxck-hymb.png"] forState:UIControlStateNormal];
    [scrollView addSubview:_button];
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(10,_button.bottom+10, kDeviceWidth-20, 150)];
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.textColor= rgb(167, 167, 167, 1);
    _textView.backgroundColor=[UIColor clearColor];
    _textView.layer.borderColor=rgb(226, 226, 226, 1).CGColor;
    _textView.layer.borderWidth=1;
    _textView.layer.masksToBounds=YES;
    _textView.text=[NSString stringWithFormat:@"    %@",self.string];
    _textView.delegate = self;
    [scrollView addSubview:_textView];
    
    UILabel *bottomlabel=[[UILabel alloc]initWithFrame:CGRectMake(_textView.width-40, _textView.bottom-20, 50, 12)];
    bottomlabel.font=[UIFont systemFontOfSize:12];
    bottomlabel.text=[NSString stringWithFormat:@"%ld/%ld",(unsigned long)_string.length,(long)self.allnumber];
    bottomlabel.textColor=rgb(201, 201, 201, 1);
    [scrollView addSubview:bottomlabel];
    
    _currentNum = bottomlabel;
    
    UILabel *redlabel=[[UILabel alloc]initWithFrame:CGRectMake(10, _textView.bottom+30, kDeviceWidth-20, 50)];
    redlabel.font=[UIFont systemFontOfSize:14];
    redlabel.text=@"短信发送将以催款小秘书身份通知对方\n请告诉小秘书如下信息,确保准确通知到他";
    redlabel.textAlignment=NSTextAlignmentCenter;
    redlabel.numberOfLines=2;
    redlabel.textColor=rgb(224, 6, 6, 1);
    [scrollView addSubview:redlabel];
    
 
    [self CreateTextFieldWithFrame:CGRectMake(10, redlabel.bottom+20, kDeviceWidth-20, 50) withCapacity:@"  您的姓名" withSecureTextEntry:NO withTargrt:self withTag:101 view:scrollView];
    nameField=(UITextField *)[scrollView viewWithTag:101];
    nameField.delegate=self;
    UILabel *leftView1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10, nameField.height)];
    nameField.leftViewMode = UITextFieldViewModeAlways;
    nameField.leftView = leftView1;
    nameField.layer.borderColor=rgb(214, 214, 214, 1).CGColor;
    nameField.layer.borderWidth=1;
    nameField.layer.masksToBounds=YES;
    
    [self CreateTextFieldWithFrame:CGRectMake(10, nameField.bottom+12, kDeviceWidth-20, 50) withCapacity:@"  Ta的手机号" withSecureTextEntry:NO withTargrt:self withTag:102 view:scrollView];
    telField=(UITextField *)[scrollView viewWithTag:102];
    telField.layer.borderColor=rgb(214, 214, 214, 1).CGColor;
    telField.layer.borderWidth=1;
    telField.delegate=self;
    telField.keyboardType=UIKeyboardTypeNumberPad;
    UILabel *leftView2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10, telField.height)];
    telField.leftViewMode = UITextFieldViewModeAlways;
    telField.leftView = leftView2;
    telField.layer.masksToBounds=YES;
    
    UIButton *telButton=[UIButton buttonWithType:UIButtonTypeCustom];
    telButton.frame=CGRectMake(telField.width-40, 10, 40, 30);
    [telButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [telButton setImage:[UIImage imageNamed:@"wxck-tel.png" ] forState:UIControlStateNormal];
    [telField addSubview:telButton];
    
  
    _postButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _postButton.frame=CGRectMake(10, telField.bottom+30, kDeviceWidth-20, 50);
    _postButton.tag=103;
    [_postButton setImage:[UIImage imageNamed:@"wxck-sendbut.png"] forState:UIControlStateNormal];
    [_postButton addTarget:self action:@selector(postAction) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:_postButton];
    
/*
    YXBProtocolView *view=[[YXBProtocolView alloc]initWithType:TYPE_TO_SMILE Frame:CGRectMake(0, _postButton.top-25,kDeviceWidth, 20) location:VIEWAlignmentCenter];
    view.delegate=self;
    [scrollView addSubview:view];
 */
    
    
}

- (void)huanyuanAction{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"是否放弃已编辑的文案" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 2003;
    [alert show];
    
   
}

- (void)buttonAction{
  
    QCAddressListViewController *list=[[QCAddressListViewController alloc]init];
    list.isSecretary=YES;
    list.delegate=self;
    list.isWeixiao=YES;
    [self.navigationController pushViewController:list animated:YES];
}

- (void)postAction{
    if ((long)_textView.text.length<=4) {
        [YXBTool showAlertViewWithString:[NSString stringWithFormat:@"请输入%d字内的文案内容",allNum]];
        return;
    }
    if ((long)_textView.text.length>70) {
        [YXBTool showAlertViewWithString:[NSString stringWithFormat:@"字数最多%d",allNum]];
        return;
    }
 
    if (nameField.text.length>10) {
        [YXBTool showAlertViewWithString:@"姓名最多输入10个字"];
        return;
    }
    if ([nameField.text isEqualToString:@""]) {
        [YXBTool showAlertViewWithString:@"请输入您的姓名"];
        return;
    }
    if ([telField.text isEqualToString:@""]||telField.text.length<11) {
        [YXBTool showAlertViewWithString:@"请输入正确的手机号"];
        return;
    }
    
   
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"是否确认发送" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alter.tag = 2002;
    [alter show];
    
    
}

- (void)MySecretaryPushAction:(NSString *)tel{

    telField.text=tel;

}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    _textView.textColor=[UIColor blackColor];
    [_button setImage:[UIImage imageNamed:@"wxck-hymb2.png"] forState:UIControlStateNormal];
    _button.userInteractionEnabled=YES;
    [_button addTarget:self action:@selector(huanyuanAction) forControlEvents:UIControlEventTouchUpInside];
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    
    if([text isEqualToString:@"\n"]) {
        [_textView resignFirstResponder];
        return NO;
    }
    
    NSInteger gapIndex = 4; //
    
    if (![text isEqualToString:@""]) {
        if (textView.text.length-gapIndex+1 > allNum)
        {
            [YXBTool showAlertViewWithString:[NSString stringWithFormat:@"字数最多%d",allNum]];
            return NO;
            
        }
    }
    if (![text isEqualToString:@""]) {
        self.currentNum.text=[NSString stringWithFormat:@"%ld/%ld",(long)textView.text.length-gapIndex+1,(long)allNum];
    }else {
        if (textView.text.length <= gapIndex) {
            return NO;
            
        }
       self.currentNum.text=[NSString stringWithFormat:@"%ld/%ld",(long)textView.text.length-gapIndex-1,(long)allNum];
    }

    NSMutableString *str = [[NSMutableString alloc] initWithString:_textView.text];
    
    [str replaceCharactersInRange:range withString:text];
    

    return YES;


}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (alertView.tag==2002&&buttonIndex==1) {
        [self httpDowloadWithListStyle];
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"您的催款短信已发送" message:@"接收时间受信号影响,若有延时,请耐心等待" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        alter.tag = 2004;
        [alter show];
    }
    if (alertView.tag==2003&&buttonIndex==1) {
        _textView.text=[NSString stringWithFormat:@"    %@",self.string];
    }
    if (alertView.tag==2004&&buttonIndex==0) {
        [self.navigationController popViewControllerAnimated:YES];
    }

}

- (void)httpDowloadWithListStyle
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak QCPostMessageViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterView show];
        }
        
    } param:^(NSString *s) {
        
        SmilePromptManager *_activityM = (SmilePromptManager *)[assginHtttperator getAopInstance:[SmilePromptManager class] returnValue:[TResultSet class]];
        
        //[_activityM submitMessage:this.promptID messageContent:_textView.text cellNumber:telField.text name:nameField.text];
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        
        NSString *userToken = userModel.user.yxbToken;
        [_activityM submitMessage:userToken promptID:this.promptID messageContent:_textView.text cellNumber:telField.text name:nameField.text];
        
        
    } complete:^(TResultSet * r, int taskid) {
        
        
        
    }];
    [self.iHttpOperator connect];
    
}

- (void)tapAction{
 
    [self.view endEditing:YES];
    
    
}

- (void)checkButton:(UIButton *)sender{
    
    
    if (sender.selected==YES) {
        _postButton.userInteractionEnabled=YES;
        _postButton.alpha=1;
        
    }
    else if (sender.selected==NO){
        
        _postButton.userInteractionEnabled=NO;
        _postButton.alpha=0.3;
    }


}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
