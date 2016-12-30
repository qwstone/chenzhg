//
//  SafeCenterController.m
//  YOUXINBAO
//
//  Created by Walice on 15/9/25.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "SafeCenterController.h"
#import "AuthenticationViewController.h"
#import "StudentVerifyViewController.h"
#import "GestureViewController.h"
#import "PasswordViewController.h"
#import "PayPassworldViewController.h"
#import "SafeCell.h"
#import "xiugaiPayPwViewController.h"

@interface SafeCenterController ()

@end

@implementation SafeCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    [self setTitle:@"安全中心"];
    self.view.backgroundColor = rgb(237, 237, 246, 1);
    [self _createUI];

    
}
- (void)_createUI{
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
//    
//    UILabel *tishilabel = [[UILabel alloc] initWithFrame:CGRectMake(27,self.tableView.frame.size.height , kDeviceWidth-54, 20)];
//    
//    tishilabel.text = @"如果无法修改支付密码，请拨打400 6688 658，由客服协助您进行修改。";
//    tishilabel.userInteractionEnabled = YES;
//    tishilabel.font=[UIFont systemFontOfSize:13];
//    tishilabel.textAlignment=NSTextAlignmentRight;
//    tishilabel.textColor=rgb(149, 149, 149, 1);
//    [self.view addSubview:tishilabel];
    UITextView *footer = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 40)];
    footer.editable=NO;
    footer.backgroundColor=[UIColor clearColor];
    NSString *jiechujine = [NSString stringWithFormat:@"如无法修改支付密码，请拨打%@，由客服协助您进行修改。",@"400 6688 658"];
//    footer.textColor = [UIColor redColor];//rgb(160, 160, 160, 1);rgb(51, 204, 255, 1)
    NSMutableAttributedString* strLabel2 = [[NSMutableAttributedString alloc] initWithString:jiechujine];
    [strLabel2 addAttribute:NSForegroundColorAttributeName value:rgb(51, 204, 255, 1)
                      range:[jiechujine rangeOfString:@"400 6688 658"]];
    [strLabel2 addAttribute:NSForegroundColorAttributeName value: rgb(160, 160, 160, 1)
                      range:[jiechujine rangeOfString:[NSString stringWithFormat:@"如无法修改支付密码，请拨打"]]];
    [strLabel2 addAttribute:NSForegroundColorAttributeName value: rgb(160, 160, 160, 1)
                      range:[jiechujine rangeOfString:[NSString stringWithFormat:@"，由客服协助您进行修改。"]]];
    
    footer.attributedText = strLabel2;
//    footer.text = @"如无法修改支付密码，请拨打400 6688 658，由客服协助您进行修改。";
    
    footer.font = [UIFont systemFontOfSize:13];
    footer.textAlignment = NSTextAlignmentLeft;
    
//    _tableView.tableFooterView = footer;
    


}

//viewForHeader与heightForHeader搭配使用可以调整section的高度
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 20)];
    view.backgroundColor =[UIColor clearColor];
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{


    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 2;
    

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString * cellId = @"messageCell";
    SafeCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[SafeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
      QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    if (indexPath.section==0&&indexPath.row==0) {
        cell.nameLabel.text=@"身份认证";
        if (userModel.user.accountStatus == 4) {
            cell.detailLabel.text=@"已认证";
        }
        else{
        
            cell.detailLabel.text=@"未认证";
        }
    
    }
    else if (indexPath.section==0&&indexPath.row==1){
        if (userModel.user.studentStatus == 2) {
            cell.detailLabel.text=@"已认证";

        }
        else{
            
            cell.detailLabel.text=@"未认证";
        }
    
        cell.nameLabel.text=@"学生认证";
    }
    else if (indexPath.section==1&&indexPath.row==0){
    
        cell.nameLabel.text=@"手势密码";
        if (userModel.gestureOpen) {
            cell.detailLabel.text=@"已开启";
        }
        else{
            cell.detailLabel.text=@"未开启";
        }
    }

    else if(indexPath.section==1&&indexPath.row==1){

   

    
        cell.nameLabel.text=@"修改登录密码";
    }
//
//    else if (indexPath.section==2&&indexPath.row==0){
//        
//        cell.nameLabel.text=@"修改支付密码";
//    }
//    else if (indexPath.section==2&&indexPath.row==1){
//        
//        cell.nameLabel.text=@"忘记支付密码";
//    }
  


    
    
    
    
    

    //cell.accessoryView = cellIndicator;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.section==0&&indexPath.row==0) {
        AuthenticationViewController *authentication=[[AuthenticationViewController alloc]init];
        [self.navigationController pushViewController:authentication animated:YES];
       
    }
    else if (indexPath.section==0&&indexPath.row==1){
        
        StudentVerifyViewController *student=[[StudentVerifyViewController alloc]init];
        [self.navigationController pushViewController:student animated:YES];
    }
    else if (indexPath.section==1&&indexPath.row==0){
        
        GestureViewController *gesture=[[GestureViewController alloc]init];
        [self.navigationController pushViewController:gesture animated:YES];
  
    }
    else if(indexPath.section==1&&indexPath.row==1){
        PasswordViewController *pass=[[PasswordViewController alloc]init];
        [self.navigationController pushViewController:pass animated:YES];
        
    }
//    else if(indexPath.section==2&&indexPath.row==0){
//        
//        QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
//               if (userModel.user.accountStatus == 4)
//        {
//        PayPassworldViewController *paypass=[[PayPassworldViewController alloc]init];
//            [self.navigationController pushViewController:paypass animated:YES];
//        }
//        else{
//            [self ShowAlert1];
//
//            
//        }
//        
//    }
//    else if(indexPath.section==2&&indexPath.row==1){
//        QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
//        if(userModel.user.accountStatus == 4)
//        {
//                    xiugaiPayPwViewController *xiugai=[[xiugaiPayPwViewController alloc]init];
//                    [self.navigationController pushViewController:xiugai animated:YES];
//
//        }
//        else{
//            [self ShowAlert1];
//            
//        }
//
//        
//    }


}
-(void)ShowAlert1
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"  您还没进行身份认证,请认证身份后再来吧！ "
                                                  delegate:self
                                         cancelButtonTitle:@"知道了"
                                         otherButtonTitles:@"去认证"
                          　　　　　　　　　　　　　　　　　　,nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex//点击弹窗按钮后
{
    NSLog(@"buttonIndex:%ld",(long)buttonIndex);
    
    if (buttonIndex == 0) {//取消
        NSLog(@"取消");
    }else if (buttonIndex == 1){//确定
        AuthenticationViewController *authentication=[[AuthenticationViewController alloc]init];
        [self.navigationController pushViewController:authentication animated:YES];
        NSLog(@"确定");
    }
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
     QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    NSIndexPath *index1=[NSIndexPath indexPathForRow:0 inSection:1];
    SafeCell *cell1=(SafeCell *)[_tableView cellForRowAtIndexPath:index1];
    if (userModel.gestureOpen) {
        cell1.detailLabel.text=@"已开启";
    }
    else{
        cell1.detailLabel.text=@"未开启";
    
    }
    //身份认证
    NSIndexPath *index2=[NSIndexPath indexPathForRow:0 inSection:0];
    SafeCell *cell2=(SafeCell *)[_tableView cellForRowAtIndexPath:index2];
    if (userModel.user.accountStatus == 4) {
        cell2.detailLabel.text=@"已认证";
        
    }
    else{
        
        cell2.detailLabel.text=@"未认证";
    }
    
    //学生认证
    NSIndexPath *index3=[NSIndexPath indexPathForRow:1 inSection:0];
    SafeCell *cell3=(SafeCell *)[_tableView cellForRowAtIndexPath:index3];
    if (userModel.user.studentStatus == 2) {
        cell3.detailLabel.text=@"已认证";
        
    }
    else{
        
        cell3.detailLabel.text=@"未认证";
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
