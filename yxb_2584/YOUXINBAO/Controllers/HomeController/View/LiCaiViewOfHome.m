//
//  LiCaiViewOfHome.m
//  YOUXINBAO
//
//  Created by Smith_zjp on 16/8/1.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LiCaiViewOfHome.h"

@implementation LiCaiViewOfHome

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)createView {
    CGFloat linw = kDeviceWidth/640*4;
    UIView * linnn = [[UIView alloc] initWithFrame:CGRectMake(0, 0, linw+kDeviceWidth/750*2  , kDeviceWidth/750*72)];
    linnn.backgroundColor = [YXBTool colorWithHexString:@"#e84a44"];
    linnn.layer.cornerRadius = kDeviceWidth/640*2;
//    [self addSubview:linnn];

    //上半部分
    UIView * upView = [[UIView alloc] initWithFrame:CGRectMake(linw, 0, kDeviceWidth-linw, kDeviceWidth/750*72)];
    upView.backgroundColor = [UIColor whiteColor];
    [self addSubview:upView];
    UIImageView *img = [[UIImageView alloc ]initWithFrame:CGRectMake(kDeviceWidth/750*35, kDeviceWidth/750*18, kDeviceWidth/750*149, kDeviceWidth/750*36)];
    img.image = [UIImage imageNamed:@"wuyoulicainew"];
    [upView addSubview:img];

    //上边分割线
    UIView * upLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 1)];
    upLine.backgroundColor = [UIColor clearColor];
    [upView addSubview:upLine];
    
    UIButton*MoreBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    MoreBtn.frame = CGRectMake(kDeviceWidth-kDeviceWidth/640*100, 2, kDeviceWidth/640*100, upView.height);
    [MoreBtn setTitle:@"更多" forState:UIControlStateNormal];
    [MoreBtn setTitleColor:[YXBTool colorWithHexString:@"#44bbff"] forState:UIControlStateNormal];
    MoreBtn.titleLabel.font = [UIFont systemFontOfSize: 12];
    [MoreBtn addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
    [upView addSubview:MoreBtn];
    
    
    //下半部分的label放在一个view中
    UIView * downView = [[UIView alloc] initWithFrame:CGRectMake(0, upView.bottom, kDeviceWidth, kDeviceWidth/640*216-kDeviceWidth/750*72)];
    downView.backgroundColor = [UIColor whiteColor];
    [self addSubview:downView];
    
    //中间分割线
    UIView * midLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth  , 1)];
    midLine.backgroundColor = [YXBTool colorWithHexString:@"#ffe9f1"];
    [downView addSubview:midLine];
    
    //理财标题
    assetTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/640*27,0 , kDeviceWidth, kDeviceWidth/640*70)];
    assetTitle.text=@"";
    assetTitle.font = [UIFont fontWithName:@"HiraginaSansGB" size:kDeviceWidth/640*27.32];
    assetTitle.textColor = [YXBTool colorWithHexString:@"#45464B"];
    [downView addSubview:assetTitle];
    
    //年化收益
    annualizedReturn = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/640*30, assetTitle.bottom, kDeviceWidth/750*140, kDeviceWidth/640*22)];
    annualizedReturn.text=@"预期年化";
    annualizedReturn.textColor = [YXBTool colorWithHexString:@"#a8a8a8"];
    annualizedReturn.font = [UIFont fontWithName:@"ArialMT" size:kDeviceWidth/640*20.49];
    [downView addSubview:annualizedReturn];
    
    
    nianhuayilv = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/640*30, annualizedReturn.bottom+ kDeviceWidth/750*10, kDeviceWidth/750*200, kDeviceWidth/640*50)];
    nianhuayilv.textColor = [YXBTool colorWithHexString:@"#fb767d"];
    nianhuayilv.textColor = [YXBTool colorWithHexString:@"#ed2e24"];
    nianhuayilv.text = @"10.00%";
    nianhuayilv.font = [UIFont boldSystemFontOfSize:kDeviceWidth/640*42.69];
    [downView addSubview:nianhuayilv];
    
    //投资期限
    limit = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/640*292, assetTitle.bottom, kDeviceWidth/750*140, kDeviceWidth/640*22)];
    limit.text = @"投资期限";
    limit.textColor = [YXBTool colorWithHexString:@"#a8a8a8"];
    limit.font = [UIFont fontWithName:@"ArialMT" size:kDeviceWidth/640*20.49];
    [downView addSubview:limit];
    
    limitTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/640*292, limit.bottom + kDeviceWidth/750*10, kDeviceWidth/750*200, kDeviceWidth/640*50)];
    limitTitle.textColor = [YXBTool colorWithHexString:@"#606164"];

    [downView addSubview:limitTitle];
    
    //环形图
    probabilityView = [[ZFProgressView alloc] initWithFrame:CGRectMake(kDeviceWidth-kDeviceWidth/640*130, kDeviceWidth/640*34, kDeviceWidth/640*110, kDeviceWidth/640*110)];
    probabilityView.progressStrokeColor = [YXBTool colorWithHexString:@"#ed2e24"];
    probabilityView.backgroundStrokeColor = [YXBTool colorWithHexString:@"#d5d5d5"];
    probabilityView.digitTintColor  = [YXBTool colorWithHexString:@"#FF6600"];
    probabilityView.displayHasFinished = NO;
    [probabilityView setProgress:0 Animated:NO];
    [downView addSubview:probabilityView];
    
    UIButton*BackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    BackBtn.frame = downView.bounds;
    [BackBtn addTarget:self action:@selector(BackBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    //底部分割线
    UIView * downLine = [[UIView alloc] initWithFrame:CGRectMake(0, downView.frame.size.height-1, kDeviceWidth, 1)];
    downLine.backgroundColor = [UIColor clearColor];
    [downView addSubview:downLine];
    [downView addSubview:BackBtn];

}

- (void)setDic:(NSDictionary *)dic {
    _dic = dic;
    assetTitle.text =dic[@"name"];
    [probabilityView setProgress:[dic[@"percentage"] integerValue]/100.00 Animated:YES];
    
    NSString*ddd=dic[@"annualizedReturn"];
    NSString*dd2=@"%";
    nianhuayilv.text = [NSString stringWithFormat:@"%@%@",ddd,dd2];
    if (ddd != nil) {
        NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:nianhuayilv.text];
        [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kDeviceWidth/640*42.69]
                          range:[nianhuayilv.text rangeOfString:ddd]];
        [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kDeviceWidth/640*18.01]
                          range:[nianhuayilv.text rangeOfString:dd2]];
        [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#fb767d"]
                          range:[nianhuayilv.text rangeOfString:dd2]];
        nianhuayilv.attributedText=mAttStri1;
    }

    
    NSString*DataStr1=dic[@"days"];
    NSString*DataStr2=@"天";
    limitTitle.text = [NSString stringWithFormat:@"%@%@",DataStr1,DataStr2];
    if (DataStr1 != nil) {
        NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:limitTitle.text];
        [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kDeviceWidth/640*42.69]
                         range:[limitTitle.text rangeOfString:DataStr1]];
        [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kDeviceWidth/640*18.01]
                         range:[limitTitle.text rangeOfString:DataStr2]];
        [mAttStri addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#a8a8a8"]
                         range:[limitTitle.text rangeOfString:DataStr2]];
        limitTitle.attributedText=mAttStri;
    }

    
    

}


#pragma mark - ButtonAction

//跳转到产品列表
- (void)butAction:(UIButton *)button {
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    if (userModel.isLogin == YES) {
    }else {
        [self toLogin];
        return;
    }
    //判断是否已进行身份认证
    if (userModel.user.accountStatus == 4)
    {
        InvestListViewController * investListViewController = [[InvestListViewController alloc]init];
        investListViewController.hidesBottomBarWhenPushed = YES;
        [[YXBTool getCurrentNav] pushViewController:investListViewController animated:YES];
    }
    else{
        [self ShowAlertAuthent];
    }
}










//跳转到产品详情
-(void)BackBtnAction{
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    if (userModel.isLogin == YES) {
    }else {
        [self toLogin];
        return;
    }
    //判断是否已进行身份认证
    if (userModel.user.accountStatus == 4)
    {
        AssetListItem * model = [[AssetListItem alloc] init];
        model.assetID =_dic[@"id"];
        model.assetTitle =_dic[@"name"];
        NSString *idd = _dic[@"id"];
        if (idd == nil || [idd isEqualToString:@""] || idd.length == 0 ) {
            [YXBTool showAlertViewWithString:@"请求失败，请刷新"];
            return;
        }
        InvestDetailViewController * investDetailViewController = [[InvestDetailViewController alloc]init];
        investDetailViewController.assetItemModel = model;
        investDetailViewController.hidesBottomBarWhenPushed = YES;
        [[YXBTool getCurrentNav] pushViewController:investDetailViewController animated:YES];
    }
    else{
        [self ShowAlertAuthent];
    }
    
    
}

-(void)ShowAlertAuthent
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"  您还没进行身份认证,请认证身份后再来吧！ "
                                                  delegate:self
                                         cancelButtonTitle:@"知道了"
                                         otherButtonTitles:@"去认证",nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex//点击弹窗按钮后
{
    if (buttonIndex == 0) {//取消
        NSLog(@"取消");
    }else if (buttonIndex == 1){//确定
        [self toAuthentication];
        NSLog(@"确定");
    }
}
//去身份认证
- (void)toAuthentication {
    
    AuthenticationViewController *authentic = [[AuthenticationViewController alloc] init];
    authentic.hidesBottomBarWhenPushed = YES;
    [[YXBTool getCurrentNav] pushViewController:authentic animated:YES];
}

//跳出登陆页面
- (void)toLogin {
    QCLoginOneViewController * loginView = [[QCLoginOneViewController alloc]init];
    UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginView];
    //    loginNav.navigationBar.barTintColor = rgb(231, 27, 27, 1);
    //    loginView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    loginView.modalPresentationStyle = UIModalPresentationPopover;
    [[YXBTool getCurrentNav] presentViewController:loginNav animated:YES completion:nil ];
}

@end
