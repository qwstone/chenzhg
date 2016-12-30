//
//  AAReceiptViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 15/7/1.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AAReceiptViewController.h"
#import "AAManager.h"
#import "TLoanOfAAActivity.h"
#import "Payment_aaLoanPay.h"
#import "YXBTool.h"

@interface AAReceiptViewController ()<UIAlertViewDelegate>

@property (nonatomic,strong) TLoanOfAAActivity *loanDetail;

@end

@implementation AAReceiptViewController

-(void)dealloc{
    NSLog(@"AAReceiptViewController is dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"借条详情"];
    [self setNavigationButtonItrmWithiamge:@"down" withRightOrleft:@"right" withtargrt:self withAction:@selector(capture)];
    [self setBackView];
    [self httpDowload];
    [self.number setAdjustsFontSizeToFitWidth:YES];
    
    
//    UIButton *buttonclose = [[UIButton alloc] initWithFrame:_repayIcon.bounds];
//    buttonclose.layer.cornerRadius = 5;
//    [buttonclose setBackgroundImage:[UIImage imageNamed:@"blue-but2"] forState:UIControlStateNormal];
//    [buttonclose setTitle:@"关闭" forState:UIControlStateNormal];
//    [buttonclose addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
//    [_repayIcon addSubview:buttonclose];
    // Do any additional setup after loading the view from its nib.
}

//获取借款单的快照图片
- (void)capture {
    
    if (_jieJuDetail == nil) {
        return;
    }
    
    UIGraphicsBeginImageContextWithOptions(_jieJuDetail.bounds.size, _jieJuDetail.opaque, 0.0);
    [_jieJuDetail.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    NSLog(@"%f,%f",img.size.height,img.size.width);
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

//保存图片到相册成功之后调用的方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    //保存成功
    UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"保存成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alterView show];
}

- (void)setLoanDetail:(TLoanOfAAActivity *)loanDetail {
    _loanDetail = loanDetail;
    [self refreshData];
}

- (IBAction)repayAction:(UIButton *)sender {
    if (sender.tag == 8888) {
        Payment_aaLoanPay *payModel = [[Payment_aaLoanPay alloc] init];
        payModel.money = _loanDetail.money;
        payModel.aaLoanId = [NSString stringWithFormat:@"%ld",(long)_loanDetail.loanOfAAActivityID] ;
        NSString *url = [YXBPaymentUtils getFullWebUrl:payModel];
        [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"支付"];
    }else if (sender.tag == 9999){
        [self closeAction];
    }
}

- (void)closeAction {
    UIAlertView *arv = [[UIAlertView alloc] initWithTitle:nil message:@"是否确定关闭？" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    arv.tag = 10001;
    [arv show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 10001) {
        if (buttonIndex == 0) {
            
        }else if (buttonIndex == 1){
            [self closeHttp];
        }
    }
}

- (void)refreshData {
    _number.text = _loanDetail.serialNo;
    _borrowName.text = _loanDetail.borrowerRealname;
    _borrowTel.text = _loanDetail.borrowerUserPhone;
    _borrowId.text = _loanDetail.borrowerIdCardNo;
    _loanName.text = _loanDetail.lenderRealname;
    _loanTel.text = _loanDetail.lenderUserPhone;
    _loanIdentify.text = _loanDetail.lenderIdCardNo;
    _borrowMoney.text = _loanDetail.money;
    _repayTime.text = _loanDetail.time;
    _acitivityTime.text = _loanDetail.remark;
    
    if (_loanDetail.status) {
        _effectiveImage.image = [UIImage imageNamed:@"youxiao"];
        _repayIcon.hidden = NO;
        _repayIcon.tag = 8888;
        _number.width = kDeviceWidth - 78 - 100;
    }else {
        _effectiveImage.image = [UIImage imageNamed:@"wuxiao"];
        _repayIcon.hidden = YES;
        _number.width = kDeviceWidth - 78;
    }
    
    if (_loanDetail.memberType == 1 && _loanDetail.status) {
        _repayIcon.tag = 9999;
        _repayIcon.hidden = NO;
        [_repayIcon setBackgroundImage:[UIImage imageNamed:@"blue-but2"] forState:UIControlStateNormal];
        [_repayIcon setTitle:@"关闭" forState:UIControlStateNormal];
    }else {

    }
    
//    QCUserModel *model = [[QCUserManager sharedInstance] getLoginUser];
//    if ([model.user.username isEqualToString:_loanDetail.lenderRealname] ||
//        _loanDetail.status == 1) {
//        
//    }
//    else
//    {
//        

}

//- (void)leftAction
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}

#pragma mark - Http
- (void)httpDowload {
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak AAReceiptViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        [this httpLOadParams:s httpOperation:assginHtttperator];
        
    } complete:^(TLoanOfAAActivity* r, int taskid) {
        
        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation{
    AAManager* _manager = (AAManager*)  [httpOperation getAopInstance:[AAManager class] returnValue:[TLoanOfAAActivity class]];
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    
    [_manager getTLoanOfAAActivity:userModel.user.yxbToken loanID:self.loanId];

}
//请求完成
-(void)httpLoadComplete:(TLoanOfAAActivity*)r{
    if (r.errCode == 0) {
        self.loanDetail = r;
        
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:r.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }

}

- (void)closeHttp {
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak AAReceiptViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
        }
        
    } param:^(NSString *s) {
        
        [this closeHttpLOadParams:s httpOperation:assginHtttperator];
    } complete:^(TLoanOfAAActivity* r, int taskid) {
        [this closeHttpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    


}
//上传参数
- (void)closeHttpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    AAManager* _manager = (AAManager*)  [httpOperation getAopInstance:[AAManager class] returnValue:[TLoanOfAAActivity class]];
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    
    [_manager closeTLoanOfAAActivity:userModel.user.yxbToken loanID:self.loanId];

}
//请求完成
-(void)closeHttpLoadComplete:(TLoanOfAAActivity*)r{
    if (r.errCode == 0) {
        self.loanDetail = r;
        
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:r.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
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
