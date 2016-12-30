//
//  QCConsultLixiView.m
//  YOUXINBAO
//
//  Created by pro on 16/5/24.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//
#define cWidth  kDeviceWidth/750*580
#define cHeight kDeviceWidth/750*375



#import "QCConsultLixiView.h"
#import "CustomTextField.h"

@implementation QCConsultLixiView
{
    UILabel * consultTitle;
    UILabel * oldLixi;
    UILabel * newLixi;
    UITextField * inputNewLixi;
    UILabel * consultExplain;
    UIButton * cancel;
    UIButton * sure;
    
    NSInteger time;
    NSTimer * LixiTimer;
}



-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = rgb(102, 102, 102, 0.7);
        time = 0;
        [self createView];
        
        //开启定时器
        time = 0;
        LixiTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(startTimer) userInfo:nil repeats:YES];

    }
    return self;
}


-(void)startTimer
{
    //已输入  停止定时器
    if (![inputNewLixi.text isEqualToString:@""]) {
        [LixiTimer invalidate];
        return;
    }
    time++;
    if (time > 2 ) {
        //弹出提示框  关闭定时器
        [ProgressHUD showWithStatus:@"请输入新利息金额" maskType:ProgressHUDMaskTypeNone tipsType:ProgressHUDTipsTypeBottom];
        [LixiTimer invalidate];
    }
}



- (void)createView{
    
    UIView * bg = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/750*85, kDeviceWidth/750*400, cWidth, cHeight)];
    bg.layer.cornerRadius = 5;
    bg.backgroundColor = [YXBTool colorWithHexString:@"#f6f6f6"];
    [self addSubview:bg];
    
    //495*320
    consultTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, kDeviceWidth/750*44, cWidth, kDeviceWidth/750*40)];
    consultTitle.font = [UIFont boldSystemFontOfSize:kDeviceWidth/750*40];
    consultTitle.text = @"利息协商";
    consultTitle.textAlignment = NSTextAlignmentCenter;
    consultTitle.textColor = [YXBTool colorWithHexString:@"#323232"];
    [bg addSubview:consultTitle];
    
    
    
    oldLixi = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/750*50, kDeviceWidth/750*111, cWidth-kDeviceWidth/750*50, kDeviceWidth/750*36)];
//    oldLixi.backgroundColor = [UIColor grayColor];
    oldLixi.textColor = [UIColor redColor];
    oldLixi.font = [UIFont systemFontOfSize:kDeviceWidth/750*27];
    [bg addSubview:oldLixi];
    
    
    newLixi = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/750*50, oldLixi.bottom + kDeviceWidth/750*27, kDeviceWidth/750*100, kDeviceWidth/750*36)];
//    newLixi.backgroundColor = [UIColor grayColor];
    newLixi.textColor = [YXBTool colorWithHexString:@"A3A3A3"];
    newLixi.font = [UIFont systemFontOfSize:kDeviceWidth/750*27];
    newLixi.text = @"新利息: ";
    [bg addSubview:newLixi];
    
    
    inputNewLixi = [[CustomTextField alloc] initWithFrame:CGRectMake(newLixi.right, newLixi.frame.origin.y -kDeviceWidth/750*15, kDeviceWidth/750*258, kDeviceWidth/750*66)];
    inputNewLixi.delegate = self;
    inputNewLixi.textAlignment = NSTextAlignmentCenter;
    inputNewLixi.font = [UIFont boldSystemFontOfSize:kDeviceWidth/750*27];
    inputNewLixi.textColor = [YXBTool colorWithHexString:@"#ED3026"];
    inputNewLixi.borderStyle = UITextBorderStyleLine;
    inputNewLixi.layer.borderColor = [[YXBTool colorWithHexString:@"#BFBFBF"] CGColor];
    inputNewLixi.layer.borderWidth = 1.0;
    inputNewLixi.keyboardType = UIKeyboardTypeNumberPad;
    [bg addSubview:inputNewLixi];
    
    
    UILabel * yuan = [[UILabel alloc] initWithFrame:CGRectMake(inputNewLixi.right, newLixi.frame.origin.y, kDeviceWidth/750*40, kDeviceWidth/750*36)];
    yuan.text = @" 元";
    yuan.textColor = [YXBTool colorWithHexString:@"#323232"];
    yuan.font = [UIFont systemFontOfSize:kDeviceWidth/750*27];
    [bg addSubview:yuan];
    
    
    consultExplain = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/750*50, inputNewLixi.bottom + kDeviceWidth/750*14, cWidth-kDeviceWidth/750*50, kDeviceWidth/750*23)];
    consultExplain.textColor = [YXBTool colorWithHexString:@"#4c4b4b"];
    consultExplain.font = [UIFont systemFontOfSize:kDeviceWidth/750*20];
    NSString *Explain = @"*利息仅能修改一次,请谨慎填写!";
    NSMutableAttributedString* ExplainStr = [[NSMutableAttributedString alloc] initWithString:Explain];
    [ExplainStr addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#fd6500"] range:[Explain rangeOfString:@"*"]];
    consultExplain.attributedText = ExplainStr;
    [bg addSubview:consultExplain];
    
    
    
    
    
    UIView * line1 = [[UIView alloc] initWithFrame:CGRectMake(0, kDeviceWidth/750*(375-99), cWidth, 1)];
    line1.backgroundColor = [YXBTool colorWithHexString:@"A3A3A3"];
    [bg addSubview:line1];
    
    cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    cancel.frame = CGRectMake(0, kDeviceWidth/750*(375-98), (cWidth-1)/2, kDeviceWidth/750*98);
    [cancel setTitleColor:[YXBTool colorWithHexString:@"#3E96E8"] forState:UIControlStateNormal];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancelConsultLixi) forControlEvents:UIControlEventTouchUpInside];
    [bg addSubview:cancel];
    
    UIView * line2 = [[UIView alloc] initWithFrame:CGRectMake((cWidth-1)/2, kDeviceWidth/750*(375-98), 1, kDeviceWidth/750*98)];
    line2.backgroundColor = [YXBTool colorWithHexString:@"A3A3A3"];
    [bg addSubview:line2];
   
    
    
    sure = [UIButton buttonWithType:UIButtonTypeCustom];
    sure.frame = CGRectMake((cWidth-1)/2+1, kDeviceWidth/750*(375-98), (cWidth-1)/2, kDeviceWidth/750*98);
    [sure setTitleColor:[YXBTool colorWithHexString:@"#3E96E8"] forState:UIControlStateNormal];
    [sure setTitle:@"确定" forState:UIControlStateNormal];
    [sure addTarget:self action:@selector(sureConsultLixi) forControlEvents:UIControlEventTouchUpInside];
    [bg addSubview:sure];


    
}




- (void)setdata{

    NSString *jiechujine = [NSString stringWithFormat:@"原利息: %@元",_model.interest];
    NSMutableAttributedString* strLabel2 = [[NSMutableAttributedString alloc] initWithString:jiechujine];
    [strLabel2 addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#A3A3A3"] range:[jiechujine rangeOfString:@"原利息: "]];
    [strLabel2 addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#323232"]
                      range:[jiechujine rangeOfString:@"元"]];
    [strLabel2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]
                      range:[jiechujine rangeOfString:[NSString stringWithFormat:@"元"]]];
    oldLixi.attributedText = strLabel2;

}



#pragma mark   -----------------  UITextDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([@"0123456789" rangeOfString:string].location == NSNotFound && ![string isEqualToString:@""]) {
        return NO;
    }
    if ([textField.text isEqualToString:@"0"] && [@"0123456789" rangeOfString:string].location != NSNotFound ) {
        textField.text = string;
        return NO;
    }
  
    
    return YES;
    
}







#pragma mark   ----------------- action


- (void)cancelConsultLixi
{
    [LixiTimer invalidate];
    [self removeFromSuperview];
}





-(void)sureConsultLixi
{
    
    //关闭定时器
    [LixiTimer invalidate];

    NSInteger days = [YXBTool numberOfDaysBetween:_model.enrolmentTime and: _model.payBackTime] + 1;
    NSInteger lixi = [inputNewLixi.text integerValue];
    CGFloat lilv = [YXBTool lilvWithMoney:[_model.money integerValue] timeInterval:days lixi:lixi];
    NSString *lilvStr = [NSString stringWithFormat:@"%.1f",lilv];
//
//
    //关闭利率不能超过100%限制
    //if ([lilvStr floatValue]>=100){
    //    [ProgressHUD showWithStatus:@"利率不能超过100%请重新设置。"];
    //    return;
    //}
    if ([lilvStr floatValue]>24) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"根据国家法律规定，民间借贷的年利率超过24%的部分法律不予保护，超过36%的部分法院不予支持。" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:@"再想想", nil];
        [alert show];
        return;
    }
    if ([inputNewLixi.text integerValue] <= 0) {
            [ProgressHUD showErrorWithStatus:@"利息输入有误,请重新输入!"];
        return;
    }
    if ([inputNewLixi.text isEqualToString:_model.interest]) {
        [ProgressHUD showErrorWithStatus:@"利息未发生改变,请重新输入!"];
        return;
    }
    if ([self.delegate respondsToSelector:@selector(ConsultlixiConfirmClick:)]){
        [self.delegate ConsultlixiConfirmClick:inputNewLixi.text];
    }
    
}


#pragma mark    ------------- AlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
     
        if ([self.delegate respondsToSelector:@selector(ConsultlixiConfirmClick:)]){
            [self.delegate ConsultlixiConfirmClick:inputNewLixi.text];
        }
    }
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
