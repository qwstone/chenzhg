//
//  QCAACollectMoneyController.m
//  YOUXINBAO
//
//  Created by Walice on 15/6/19.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCAACollectMoneyController.h"
#import "AACollectCell.h"
#import "AverageManager.h"
#import "AAReceivablesDetailViewController.h"
#import "GatheringRecordDetail.h"
#import "QCCollectMoneyListController.h"
#import "AAActivity.h"
#import "AAReceivablesDetailViewController.h"
#import "Payment_AverageBack.h"
#import "FriendSelecteViewController.h"

@interface QCAACollectMoneyController ()<QCFriendsViewControllerBackDelegate>{
    
    UITextView *_textView;
    UILabel *textViewplacehide;
    UILabel *breifLabel;
    UIView *baseView;
    NSString *abctext;
    NSMutableString *str;
}

@end

@implementation QCAACollectMoneyController
-(void)dealloc{
    NSLog(@"QCAACollectMoneyController is dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    if ([self.state isEqualToString:@"收款"]) {
        [self setTitle:@"活动聚会收款"];
    }
    else if ([self.state isEqualToString:@"退款"]){
    
        [self setTitle:@"活动聚会退款"];
    }
    else if (self.isCreate){
    
        [self setTitle:@"AA收款"];
    }
    [self _initViews];

}

- (void)_initViews{
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeSystem];
    rightButton.frame=CGRectMake(0, 0, 68, 33);
    [rightButton setTitle:@"收款记录" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem=rightItem;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64) style:UITableViewStylePlain ];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = kCustomBackground;
    [self.view addSubview:_tableView];
    
    baseView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 200)];
    _tableView.tableFooterView=baseView;
    
//    breifLabel=[[UILabel alloc]initWithFrame:CGRectMake(120, 15, kDeviceWidth-130, 20)];
//    breifLabel.font=[UIFont systemFontOfSize:12];
//    breifLabe]l.textColor=rgb(97, 97, 97, 1);
//    [baseView addSubview:breifLabel];
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 42, kDeviceWidth-20, 95)];
    _textView.font = [UIFont systemFontOfSize:16];
    _textView.backgroundColor=[UIColor whiteColor];
    _textView.layer.borderColor=(__bridge CGColorRef)([UIColor grayColor]);
    _textView.layer.borderWidth=1;
    _textView.layer.cornerRadius=6;
    _textView.layer.masksToBounds=YES;
    _textView.tag=1001;
    _textView.delegate = self;
    _tableView.tableFooterView.userInteractionEnabled=YES;
    [baseView addSubview:_textView];
    
    textViewplacehide = [[UILabel alloc]initWithFrame:CGRectMake(20, 40, kDeviceWidth-50, 40)];
    textViewplacehide.numberOfLines=0;
    textViewplacehide.enabled = NO;
    textViewplacehide.font = [UIFont systemFontOfSize:16];
    textViewplacehide.textColor = [UIColor grayColor];
    textViewplacehide.text = @"需要跟好友说点什么吗?(25个字以内)";
    textViewplacehide.backgroundColor = [UIColor clearColor];
    [baseView addSubview: textViewplacehide];
    
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(10, _textView.bottom+20, kDeviceWidth-20, 46);
    [button setBackgroundImage:[UIImage imageNamed:@"blue-but2.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(ConfirmSubmit) forControlEvents:UIControlEventTouchUpInside];
    if (self.isCreate) {
        [button setTitle:@"向友信宝好友收款" forState:UIControlStateNormal];
    }
    else{
        [button setTitle:@"确认" forState:UIControlStateNormal];}
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [baseView addSubview:button];
    


}
- (void)rightButtonAction{
    QCCollectMoneyListController *moneyList=[[QCCollectMoneyListController alloc]init];
    [self.navigationController pushViewController:moneyList animated:YES];
    

}

- (void)tapAction{
//    AACollectCell *secondCell = (AACollectCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
//     AACollectCell *thirdCell = (AACollectCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
//    [secondCell.textView resignFirstResponder];
//    [thirdCell.textView resignFirstResponder];
    [self.view endEditing:YES];

}

//- (void)calculate{
//    
//    AACollectCell *secondCell = (AACollectCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
//    AACollectCell *thirdCell = (AACollectCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
//    
//    float value=thirdCell.textView.text.floatValue/secondCell.textView.text.floatValue;
//   
//    if (self.isCreate||[self.state isEqualToString:@"收款"]) {
//        abctext=[NSString stringWithFormat:@"向其他%ld人,每人收取%.2f元",(long)secondCell.textView.text.integerValue-1,value];
//    }
//    else if([self.state isEqualToString:@"退款"]){
//        
//       abctext=[NSString stringWithFormat:@"向其他%ld人,每人退款%.2f元",(long)secondCell.textView.text.integerValue-1,value];
//
//    }
//
//    NSRange range1=[abctext rangeOfString:[NSString stringWithFormat:@"%ld",(long)secondCell.textView.text.integerValue-1]];
//    NSRange range2=[abctext rangeOfString:[NSString stringWithFormat:@"%.2lf",value]];
//    NSMutableAttributedString *aText=[[NSMutableAttributedString alloc]initWithString:abctext];
//    [aText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:range1];
//    [aText addAttribute:NSForegroundColorAttributeName value:rgb(48, 48, 48, 1) range:range1];
//    [aText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:range2];
//    [aText addAttribute:NSForegroundColorAttributeName value:rgb(48, 48, 48, 1) range:range2];
//    breifLabel.attributedText=aText;
//    
//    
//
//}
//#pragma 自定义delegate
//- (void)AAcollectAction:(UITextView *)textView{
//    AACollectCell *firstCell = (AACollectCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//    AACollectCell *secondCell = (AACollectCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
//    AACollectCell *thirdCell = (AACollectCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
//
//    
//        if ([firstCell.textView.text isEqualToString:@""]||[secondCell.textView.text isEqualToString:@""]||[thirdCell.textView.text isEqualToString:@""]) {
//
//            return;
//        }
//        [self calculate];
//
//    
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
    return 3;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"cell";
    AACollectCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[AACollectCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }

    if (self.isCreate) {
    
        if (indexPath.row==0) {
        cell.leftLabel.text=@"主题";
        cell.textViewplacehide.text = @"小伙伴速速付款";
        [cell.textView becomeFirstResponder];
       
    }
        if (indexPath.row==1) {
        cell.leftLabel.text=@"AA人数";
        // cell.textViewplacehide.text = @"2-20人(包括自己)";
            cell.textViewplacehide.text=@"限20人内";
         cell.textView.keyboardType = UIKeyboardTypeNumberPad;
        
    }
        if (indexPath.row==2) {
        //cell.leftLabel.text=@"总金额";
             cell.leftLabel.text=@"人均金额";
       
        //cell.textViewplacehide.text = @"最高10万元";
                cell.textViewplacehide.text=@"人均金额最高5000元";
            
        cell.textView.keyboardType = UIKeyboardTypeNumberPad;
        
    }
}
    else{
        if (indexPath.row==0) {
            cell.leftLabel.text=@"主题";
            cell.textViewplacehide.text = nil;
            cell.textView.text=self.abctitle;
            cell.textView.userInteractionEnabled=NO;
           // [cell.textView becomeFirstResponder];
            
        }
        if (indexPath.row==1) {
            cell.leftLabel.text=@"AA人数";
            cell.textViewplacehide.text =nil;
            cell.textView.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.useridArray.count];
            cell.textView.userInteractionEnabled=NO;
            cell.textView.keyboardType = UIKeyboardTypeNumberPad;
            
        }
        if (indexPath.row==2) {
            cell.leftLabel.text=@"人均金额";
           // cell.leftLabel.text=@"总金额";
            if ([self.state isEqualToString:@"退款"]) {
                //double value=self.activity.avgCost.integerValue*self.useridArray.count;
                double value=self.activity.avgCost.integerValue;
                cell.textViewplacehide.text=[NSString stringWithFormat:@"最高%.1f元",value];
   
            }
            else{
                cell.textViewplacehide.text = @"人均金额最高5000元";
  
            }
            cell.textView.keyboardType = UIKeyboardTypeNumberPad;
            [cell.textView becomeFirstResponder];
        }
    
    
    }
    return cell;
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






- (void)textViewDidBeginEditing:(UITextView *)textView{

    if (textView.tag==1001) {
        NSLog(@"将要开始编辑");
        CGFloat offset=self.view.frame.size.height-(baseView.frame.origin.y+baseView.frame.size.height+200);
       
        NSLog(@"aa %f",offset);
        if (offset<=0) {
            [UIView animateWithDuration:0.3 animations:^{
                CGRect frame=self.view.frame;
                frame.origin.y=offset;
                self.view.frame=frame;
            }];
        }
    }


}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.tag==1001) {
        NSLog(@"将要编辑结束");
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame=self.view.frame;
            frame.origin.y=64.0;
            self.view.frame=frame;
        }];

    }
   

}

- (void)ConfirmSubmit{
    [self.view endEditing:YES];
    AACollectCell *firstCell = (AACollectCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    AACollectCell *secondCell = (AACollectCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    AACollectCell *thirdCell = (AACollectCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    _detail=[[GatheringRecordDetail alloc]init];
    _detail.title=firstCell.textView.text;
    _detail.peopleSum=secondCell.textView.text.integerValue;
    _detail.money=thirdCell.textView.text;
    _detail.describe=_textView.text;
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    
 
    _detail.nickName = userModel.user.nickname;
    _detail.imageUrl=userModel.user.iconAddr;



    if (firstCell.textView.text.length>15) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"主题不能超过15个字" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
//    if (secondCell.textView.text.integerValue <2) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"AA人数最低为2人" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
//        return;
//    }
    if (secondCell.textView.text.integerValue ==0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"AA人数不能为0人" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if (secondCell.textView.text.integerValue>20) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"AA人数最多为20人" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
        
    }
    if (thirdCell.textView.text.integerValue==0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"金额不能为空" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if ([self.state isEqualToString:@"退款"]&&thirdCell.textView.text.integerValue>self.activity.avgCost.integerValue) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"AA金额最高为人均金额" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
        
    }
    if (thirdCell.textView.text.integerValue==0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"金额不能为0元" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
        
        return;
    }
    if (thirdCell.textView.text.integerValue >5000) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"人均金额最高5000元" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        

        return;
    }
    
    if (_textView.text.length>25) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"给好友留言最多不能超过25个字" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
  
    double value=thirdCell.textView.text.integerValue/secondCell.textView.text.integerValue;
    _detail.moneyPerPeople=[NSString stringWithFormat:@".2%lf",value];
    
    
    if (self.isCreate) {
//        AAReceivablesDetailViewController *detailCtrl=[[AAReceivablesDetailViewController alloc]init];
//        _detail.recordId = -1;
//        detailCtrl.backModel=_detail;
//        [self.navigationController pushViewController:detailCtrl animated:YES];
        /*
        QCFriendsViewController * friendsViewController = [[QCFriendsViewController alloc]init];
        friendsViewController.isAAshoukuan = YES;
        friendsViewController.delegate = self;
        friendsViewController.isAAshoukuanNumeber=secondCell.textView.text.integerValue;
        if ([firstCell.textView.text isEqualToString:@""]) {
            firstCell.textView.text=@"小伙伴速速付款";
            firstCell.textViewplacehide.hidden=YES;
        }
        friendsViewController.subject=firstCell.textView.text;
        friendsViewController.allNum=secondCell.textView.text;
        friendsViewController.allMoney=thirdCell.textView.text;
        friendsViewController.desc=_textView.text;
        [self.navigationController pushViewController:friendsViewController animated:YES];
        */
        
        FriendSelecteViewController *controller = [[FriendSelecteViewController alloc] init];
        controller.friendType = LoanNewFriendTypeAAShouKuan;
        controller.delegate = self;
        controller.maxNames = secondCell.textView.text.integerValue;
        [self.navigationController pushViewController:controller animated:YES];

        
    }
    else if([self.state isEqualToString:@"退款"]) {
//        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        //NSString *userToken = userModel.user.yxbToken;
//        NSString *urlstr = [NSString stringWithFormat:@"webView/user/AverageBack.jsp"];
//        PayJsonTools *paytools = [[PayJsonTools alloc] init];
        str=[[NSMutableString alloc]init];
        if (_useridArray.count!=0) {
            for (id object in _useridArray) {
                [str appendFormat:@"%@|",object];
                
            }
            [str deleteCharactersInRange:NSMakeRange(str.length-1, 1)];
        }
        else if (_useridArray.count==0){
            [str appendString:@""];
            
        }
//
//        paytools.iOnJsonStr = ^(NSString *s){
//            NSLog(@"%@",s);
////            
////            NSArray *arg = [Dic objectForKey:@"args"];
//            
//            
//            NSString *dic = [NSString stringWithFormat:@"&money=%ld&userArr=%@&activityId=%ld&json=%@",(long)thirdCell.textView.text.integerValue*self.useridArray.count,str,(long)self.activityId,s];
//            
//            NSString *urlstrs = [YXBTool getURL:urlstr params:dic];
//            NSLog(@"%@",urlstrs);
//            [YXBTool jumpInnerSafaryWithUrl:urlstrs hasTopBar:NO titleName:@"退款"];
//        };
        
        Payment_AverageBack *payModel = [[Payment_AverageBack alloc] init];
        payModel.money = [NSString stringWithFormat:@"%ld",(long)thirdCell.textView.text.integerValue*self.useridArray.count];
        payModel.activityId=[NSString stringWithFormat:@"%ld",(long)self.activityId];
        payModel.title=firstCell.textView.text;
        payModel.sumPeople=[NSString stringWithFormat:@"%ld",(long)self.useridArray.count];
        payModel.descript=_textView.text;
        payModel.mode=[NSString stringWithFormat:@"%d",2];
        payModel.userArr=str;
        
        
        NSString *url = [YXBPaymentUtils getFullWebUrl:payModel];
        [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"支付"];
        
        
//        AverageManager *manager = [paytools getAopInstance:[AverageManager class]];
//        [manager createAAAverage:userToken title:self.abctitle sumPeople:self.useridArray.count sumMoney:thirdCell.textView.text.integerValue descript:_textView.text mode:2 tokenArr:str];
    }else if([self.state isEqualToString:@"收款"]) {

        
        [self httpDowloadWithListStyle];
        
    }
    

    
    
}


#pragma mark --- QCFriendsViewController delegate
- (void)QCFriendsViewControllerBackAction:(NSInteger)recordId {

    self.record=recordId;
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 100111) {
        if (buttonIndex == 0) {
            AAReceivablesDetailViewController *controller = [[AAReceivablesDetailViewController alloc] init];
            controller.record=self.record;
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
    
}


- (void)httpDowloadWithListStyle
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak QCAACollectMoneyController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:this cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterView show];
        }
        
    } param:^(NSString *s) {
        
        
        [this httpLOadParams:s httpOperation:assginHtttperator];
    } complete:^(NSSkyArray * r, int taskid) {
        
        [YXBTool showAlertViewWithString:r.errString];
        NSLog(@"提交成功");
        
    }];
    [self.iHttpOperator connect];
    
}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    AverageManager *manager = (AverageManager *)[httpOperation getAopInstance:[AverageManager class] returnValue:[TResultSet class]];
    
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    
    //        if (style == L_myList) {
    NSString *userToken = userModel.user.yxbToken;
    if ((userToken != nil) && [userToken length] > 0)
    {    AACollectCell *thirdCell = (AACollectCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        
        str=[[NSMutableString alloc]init];
        if (self.useridArray.count!=0) {
            for (id object in self.useridArray) {
                [str appendFormat:@"%@|",object];
                
            }
            [str deleteCharactersInRange:NSMakeRange(str.length-1, 1)];
        }
        else if (self.useridArray.count==0){
            [str appendString:@""];
            
        }
        if ([self.state isEqualToString:@"退款"]) {
            //                [manager createAAAverage:userToken title:this.abctitle sumPeople:this.useridArray.count sumMoney:thirdCell.textView.text.integerValue descript:_textView.text mode:2 tokenArr:str];
        }
        
        else{
            [manager createAAAverage:userToken title:self.abctitle sumPeople:self.useridArray.count sumMoney:thirdCell.textView.text.integerValue descript:_textView.text mode:1 tokenArr:str couponId:0];}
        
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您尚未登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }

}

//- (void)viewWillAppear:(BOOL)animated{
//
//    AACollectCell *firstCell = (AACollectCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//   
//    AACollectCell *secondCell = (AACollectCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
//    AACollectCell *thirdCell = (AACollectCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
//   
//    if (self.isCreate) {
//        firstCell.textViewplacehide.text = @"小伙伴速速付款";
//        secondCell.textViewplacehide.text=@"限20人内";
//        thirdCell.textViewplacehide.text=@"人均金额最高5000元";
//        
//        firstCell.textView.text=nil;
//        secondCell.textView.text=nil;
//        thirdCell.textView.text=nil;
//        _textView.text=nil;
//    }
//  
//}

//创建AA收款
- (void)createAACollectMoneyRequestWithNames:(NSString *)names
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak typeof(self)this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        
        [this httpLoadParamsTwo:assginHtttperator names:names];
    } complete:^(TResultSet * r, int taskid) {
        
        [this httpLoadCompleteTwo:r];
    }];
    [self.iHttpOperator connect];
    
}

- (void)httpLoadParamsTwo:(HttpOperator *)assginHtttperator names:(NSString *)names{
    
    AACollectCell *firstCell = (AACollectCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    AACollectCell *secondCell = (AACollectCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    AACollectCell *thirdCell = (AACollectCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];

    AverageManager *manager = (AverageManager *)[assginHtttperator getAopInstance:[AverageManager class] returnValue:[TResultSet class]];
    
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    
    //        if (style == L_myList) {
    NSString *userToken = userModel.user.yxbToken;
    if ((userToken != nil) && [userToken length] > 0)
    {
//        [manager createAAAverage:userToken title:firstCell.textView.text sumPeople:secondCell sumMoney:<#(NSInteger)#> descript:<#(NSString *)#> mode:<#(NSInteger)#> tokenArr:<#(NSString *)#> couponId:<#(NSInteger)#>]
        [manager createAAAverage:userToken title:firstCell.textView.text sumPeople:secondCell.textView.text.integerValue sumMoney:thirdCell.textView.text.integerValue descript:_textView.text mode:1 tokenArr:names couponId:0];
        
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您尚未登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    
    
    
}
- (void)httpLoadCompleteTwo:(TResultSet *)r{
    
    if (r.errCode == 0) {
        
        //            [YXBTool showAlertViewWithString:@"发起AA收款成功!\n请在右上角收款记录查看。"];
        [self QCFriendsViewControllerBackAction:r.resInteger];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"发起AA收款成功!\n请在右上角收款记录查看。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        alert.tag = 100111;
        [alert show];
        [self leftClicked];
        
    }
    else
    {
        [ProgressHUD showErrorWithStatus:r.errString];
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
