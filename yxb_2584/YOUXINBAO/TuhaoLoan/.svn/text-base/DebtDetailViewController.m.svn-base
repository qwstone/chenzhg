//
//  DebtDetailViewController.m
//  YOUXINBAO
//
//  Created by Feili on 15/4/29.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "DebtDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "UIAlertView+Block.h"
#import "DebtScheduleViewController.h"
#import "HttpOperator.h"
#import "AppBlankNoteManager.h"
#import "CustomIOSAlertView.h"
#import "DebtdetailAlertContentView.h"
#import "TResultSet.h"
#import "NoteSummary.h"
#import "YXBTool.h"
#import "UserState.h"
#import "StudentVerifyViewController.h"

#define DebtDetailLabelFontSize 12
#define DebtDetailLabelTagStart 2000

@interface DebtDetailViewController ()<CustomIOSAlertViewDelegate>

@property(nonatomic,strong)UIScrollView *backScrollView;
@property(nonatomic,strong)UIImageView *avatarImageView;//头像
@property(nonatomic,strong)UILabel     *userNameLabel;//用户名
@property(nonatomic,strong)NSMutableArray *elementArray;
@property(nonatomic,strong)UILabel    *monthMoneyLabel;//每月还款额
@property(nonatomic,strong)HttpOperator   *iHttpOperator;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)BlankNoteData *noteDetail;
@property(nonatomic,strong)UILabel *tintLabel;//提示



@end

@implementation DebtDetailViewController
-(void)dealloc{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.elementArray = [NSMutableArray array];
    [self addLeftNavigationItem];
    [self initView];
    [self loadModel:_model]; //加载上一个界面的model
//    [self requestData];
    // Do any additional setup after loading the view.
}

-(void)addLeftNavigationItem
{
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(backDefault)];
    [self setTitle:[NSString stringWithFormat:@"%@的白条",_model.nickName]];
    
}


-(void)initView
{
    
    //添加scrollview
    
    self.backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
    _backScrollView.contentSize = CGSizeMake(kDeviceWidth, kDeviceHeight);
//    _backScrollView.backgroundColor = [self generateRandomColor];
    [self.view addSubview:_backScrollView];

    
    
    //
    
    CGFloat x = 10,y = 10,w = 60,h = 60;
    self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    _avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
    _avatarImageView.image = [UIImage imageNamed:@"register_photo.png"];
    [self.backScrollView addSubview:_avatarImageView];
    
    self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y+h+5, w, 15)];
    _userNameLabel.textColor = [UIColor lightGrayColor];
    _userNameLabel.backgroundColor = [self generateRandomColor];
    _userNameLabel.text = @"用户名";
    _userNameLabel.minimumScaleFactor = 10.0/_userNameLabel.font.pointSize;
    _userNameLabel.adjustsFontSizeToFitWidth = YES;
    _userNameLabel.textAlignment = NSTextAlignmentCenter;
    _userNameLabel.font = [UIFont systemFontOfSize:DebtDetailLabelFontSize];
    [self.backScrollView addSubview:_userNameLabel];
    
#define SpaceXBetweenImageAndLabel 10
#define SpaceYBetweenTopAndLabel 15
    
    x = x + w + SpaceXBetweenImageAndLabel;
    y = SpaceYBetweenTopAndLabel;
    w = (kDeviceWidth - x)/2.0;
    h = 15;
    CGFloat x1 = x;
    CGFloat y1 = y;
    CGFloat w1 = w;
    CGFloat h1 = h;
    
    CGFloat const labelYSpace = 15;
    for (int i = 0; i < 3; i ++) {
        y1 = y + (h+labelYSpace)*i;
        
        UILabel *label = [self labelWithFrame:CGRectMake(x1, y1, w1, h1)];
        label.tag = DebtDetailLabelTagStart + i;
        [self.backScrollView addSubview:label];
    }


    //添加虚线
    [self dashLineWithY:y1+h+5];
    
    
    x1 = 20;
    y1 = y1+h+20;
    w1 = kDeviceWidth - x1;
    h1 = h1;
    for (int i = 0; i < 5; i ++) {
        y1 = y1 + h1+labelYSpace;
        
        UILabel *label = [self labelWithFrame:CGRectMake(x1, y1, w1, h1)];
        label.tag = DebtDetailLabelTagStart + 10 + i;
        [self.backScrollView addSubview:label];
    }
    
    self.monthMoneyLabel = [self labelWithFrame:CGRectMake(x1, y1+h1+labelYSpace * 2, w1, h1)];
    [self.backScrollView addSubview:_monthMoneyLabel];

    
    //提示label
    UILabel *tintLabel = [[UILabel alloc] initWithFrame:CGRectMake(x1, _monthMoneyLabel.origin.y+_monthMoneyLabel.height+20, w1, h1)];
    tintLabel.text = @"";
    tintLabel.font = [UIFont systemFontOfSize:13.0];
    tintLabel.textColor = [UIColor redColor];
    self.tintLabel = tintLabel;
    [self.backScrollView addSubview:tintLabel];
    
//    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    bottomBtn.backgroundColor = [UIColor lightGrayColor];
//    bottomBtn.frame = CGRectMake(0, kDeviceHeight-44-64, kDeviceWidth, 44);
//    [bottomBtn setTitle:@"找ta借款" forState:UIControlStateNormal];
////    [bottomBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    [bottomBtn addTarget:self action:@selector(findToLoan1) forControlEvents:UIControlEventTouchUpInside];
//    bottomBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
//    [self.view addSubview:bottomBtn];
}

/**
 *  @author chenglibin
 *
 *  找他借款
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10010){
        if (buttonIndex == 1) {
            
            [self toLogin];
        }
    } else if (alertView.tag == 10086){
        if (buttonIndex == 1) {
            
            [self toAuthentication];
        }
    } else if (alertView.tag == 100861){
        if (buttonIndex == 1) {
            //学生认证
            StudentVerifyViewController *stuauthentic = [[StudentVerifyViewController alloc] init];
            [self.navigationController pushViewController:stuauthentic animated:YES];
            
        }
    }
    
}
- (void)toLogin {
    QCLoginOneViewController * loginView = [[QCLoginOneViewController alloc]init];
    UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginView];
    [self.navigationController presentViewController:loginNav animated:YES completion:nil ];
}

- (void)toAuthentication {
    AuthenticationViewController *authentic = [[AuthenticationViewController alloc] init];
    [self.navigationController pushViewController:authentic animated:YES];
}
-(void)findToLoan1
{
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    if (!userModel.isLogin) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"您还没有登录，请登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alterView.tag = 10010;
        [alterView show];
        return;
    }
    
    if ([UserState isLv4] == E_NO_OPERATE) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"向土豪借款，请先完善身份信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alterView.tag = 10086;
        [alterView show];
        return;
    }else if ([UserState isLv4] == E_IN_REVIEW) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"身份认证需要一段时间审核，您可以逛逛其他功能，认证通过后，我们会通知您" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alterView show];
        return;
    }else if ([UserState isLv4] == E_FAIL_UserStateRes) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"您的身份认证失败，请从新认证" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alterView show];
        return;
    }
//    if (userModel.user.accountStatus == 1) {
//        //审核，可以借款
//        return;
//    }else if (userModel.user.accountStatus == 2) {
//        //通过
//    }else if (userModel.user.accountStatus == 3) {
//        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"向土豪借款，请先完善身份信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        alterView.tag = 10086;
//        [alterView show];
//        return;
//    }else if (userModel.user.accountStatus == 4) {
//        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"身份认证需要一段时间审核，您可以逛逛其他功能，认证通过后，我们会通知您" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        [alterView show];
//        return;
//    }else if (userModel.user.accountStatus == 0) {
//        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"向土豪借款，请先完善身份信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        alterView.tag = 10086;
//        [alterView show];
//        return;
//    }
//    
//    if (userModel.user.studentStatus == 1) {
//        //审核，可以借款
//        return;
//    }else if (userModel.user.studentStatus == 2) {
//        //通过
//    }else if (userModel.user.studentStatus == 3) {
//        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"向土豪借款，请先完善身份信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        alterView.tag = 100861;
//        [alterView show];
//        return;
//    }else if (userModel.user.studentStatus == 0) {
//        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"向土豪借款，请先完善身份信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        alterView.tag = 100861;
//        [alterView show];
//        return;
//    }

    DebtdetailAlertContentView *contentView = [self setAlertContentView];
    
    contentView.model = _model;
    
    CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
    
    // Add some custom content to the alert view
    [alertView setContainerView:contentView];
    
    // Modify the parameters
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"取消", @"确认", nil]];
//    [alertView setDelegate:self];
    
    // You may use a Block, rather than a delegate.
    [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
        if (buttonIndex == 1) {
            [self requestPay:alertView];

        }
        else
        {
            [alertView close];
 
        }
    }];
    
    [alertView setUseMotionEffects:true];
    // And launch the dialog
    [alertView show];

}

-(DebtdetailAlertContentView *)setAlertContentView
{
    DebtdetailAlertContentView *contentView = [[DebtdetailAlertContentView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth-20, 200)];
    contentView.backgroundColor = [UIColor whiteColor];
//    [self setAlertContent:contentView];
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:contentView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = contentView.bounds;
//    maskLayer.path = maskPath.CGPath;
//    contentView.layer.mask = maskLayer;
    return contentView;
}

/**
 *  @author chenglibin
 *
 *  找他借款网络请求
 */
-(void)requestPay:(CustomIOSAlertView *)alerView
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak DebtDetailViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
        
    } cancel:^(int d) {
        
        
    } error:^(int d, THttpOperatorErrorCode e) {
        
        
    } param:^(NSString *s) {
        
        [this httpLOadParams:s httpOperation:assginHtttperator];
    } complete:^(id r, int taskid) {
        [this httpLoadComplete:r];
    }];
    
    [self.iHttpOperator connect];

}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    AppBlankNoteManager* blankNote = (AppBlankNoteManager *)  [httpOperation getAopInstance:[AppBlankNoteManager class] returnValue:[TResultSet class]];
    NSString *token = @"";
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    token = userModel.user.yxbToken;
    if (token == nil) {
        token = @"";
    }
    [blankNote claimNote:token noteID:_model.blankNoteID];

}
//请求完成
-(void)httpLoadComplete:(id)r{
    NSLog(@"r=  %@",r);
    
    TResultSet *set = r;
    if (set.errCode == 0)
    {
        //            [alerView close];
        
        NSInteger blankNoteId = set.resInteger;
        if (blankNoteId >= 0) {
            [self successToScheduleWithNoteId:blankNoteId];
            
        }
        else
        {
            NSLog(@"白条id错误");
        }
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"白条借入失败" message:set.errString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        NSLog(@"白条借入失败：---%@",set.errString);
    }

}
-(void)successToScheduleWithNoteId:(NSInteger)noteId
{
    
    /*
    UIAlertView *subAlert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您的借款已申请成功,工作人员将在2小时内进行电话确认。" delegate:nil cancelButtonTitle:@"查看进度" otherButtonTitles: nil];
    [subAlert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
        
        DebtScheduleViewController *controller = [[DebtScheduleViewController alloc] init];
        controller.model = _model;
        [self.navigationController pushViewController:controller animated:YES];
    }];
    */
    
    CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
    UILabel *titleLabel = [self labelWithFrame:CGRectMake(0, 0, kDeviceWidth - 20, 80)];
    [titleLabel setNumberOfLines:0];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    titleLabel.font = [UIFont systemFontOfSize:15.0];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.text = @"您的借款已申请成功,工作人员将在2小时内进行电话确认。";
//    [self setAlertContent:titleLabel];
    // Add some custom content to the alert view
    [alertView setContainerView:titleLabel];
    
    // Modify the parameters
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"查看进度", nil]];
    [alertView setDelegate:self];
    
    // You may use a Block, rather than a delegate.
    [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
        if (buttonIndex == 0) {
            DebtScheduleViewController *controller = [[DebtScheduleViewController alloc] init];
            NoteSummary *noteSummary = [[NoteSummary alloc] init];
            noteSummary.repaymentNoteID = noteId;
            noteSummary.debtorName = _model.nickName;
            
            controller.noteSummary = noteSummary;
            [self.navigationController pushViewController:controller animated:YES];
            
        }
        [alertView close];
    }];
    
    [alertView setUseMotionEffects:true];
    // And launch the dialog
    [alertView show];


}



- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
    [alertView close];
}

/*
-(void)requestData
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __block HttpOperator * assginHtttperator = _iHttpOperator;
    //    __block DebtListViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
        
    } cancel:^(int d) {
        
        
    } error:^(int d, THttpOperatorErrorCode e) {
        
        
    } param:^(NSString *s) {
#warning --baitiao
        AppBlankNoteManager* blankNote = (AppBlankNoteManager *)  [assginHtttperator getAopInstance:[AppBlankNoteManager class] returnValue:[BlankNoteData class]];
        
//        [blankNote getNoteDetailById:1];
        
        
    } complete:^(id r, int taskid) {
        NSLog(@"r=  %@",r);
        BlankNoteData *blankData = (BlankNoteData *)r;
        if (blankData.errCode == 0) {
            self.noteDetail = blankData;
            [self loadModel:_noteDetail];

        }
        else
        {
            NSLog(@"%@==%@",[self class],blankData.errString);
        }
        
    }];
    
    [self.iHttpOperator connect];
    

}
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)loadView
//{
//    self.backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
//    _backScrollView.contentSize = CGSizeMake(kDeviceWidth, 2*kDeviceHeight);
//    _backScrollView.backgroundColor = [self generateRandomColor];
//    self.view = _backScrollView;
//}


-(void)loadModel:(BlankNoteData *)model
{
//    if (_model != model) {
//        _model = model;
    _tintLabel.text = @"现在借款,48小时内即可提款";
        [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:@"https://img0.bdstatic.com/img/image/4a75a05f8041bf84df4a4933667824811426747915.jpg"] placeholderImage:[UIImage imageNamed:@"register_photo.png"]];
        _userNameLabel.text = _model.nickName;
        self.elementArray = [NSMutableArray arrayWithObjects:
                             [NSString stringWithFormat:@"信用等级：%@",@""],
                             [NSString stringWithFormat:@"可借数量：%ld个",(long)_model.borrowNumber],
                             [NSString stringWithFormat:@"已借出：%ld个",(long)model.loanNumber
                              ], nil];
        
        for (int i = 0; i < [_elementArray count]; i ++) {
            NSInteger tag = DebtDetailLabelTagStart + i;
            UILabel *label = (UILabel *)[self.view viewWithTag:tag];
            label.text = _elementArray[i];
        }
    
    NSMutableArray *detailArray = [NSMutableArray arrayWithObjects:
                                   [NSString stringWithFormat:@"借款金额：%@",_model.money],
                                   [NSString stringWithFormat:@"还款方式：%@",[_model repaymentStringWithType]],
                                   [NSString stringWithFormat:@"还款周期：%ld个月",(long)_model.repaymentMonth],
                                   [NSString stringWithFormat:@"年化利率：%@",_model.yearRate],
                                   [NSString stringWithFormat:@"利息：%@元",[YXBTool setMoney:self.model.money yearRate:self.model.yearRate repaymentMonth:self.model.repaymentMonth]],
                                   nil];
    for (int i = 0; i < [detailArray count]; i ++) {
        NSInteger tag = DebtDetailLabelTagStart + 10 + i ;
        UILabel *label = (UILabel *)[self.view viewWithTag:tag];
        label.text = detailArray[i];
    }

    self.monthMoneyLabel.text = [NSString stringWithFormat:@"每月还款额: ￥%@",_model.moneyPerMonth];
    
    
    
    
//    }

}

-(UILabel *)labelWithFrame:(CGRect)frame
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [self generateRandomColor];
    label.font = [UIFont systemFontOfSize:DebtDetailLabelFontSize];
    return label;
}


-(void)dashLineWithY:(CGFloat)y
{
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, y, kDeviceWidth, 20)];
    [self.backScrollView addSubview:imageView1];
    
    
    UIGraphicsBeginImageContext(imageView1.frame.size);   //开始画线
    [imageView1.image drawInRect:CGRectMake(0, 0, imageView1.frame.size.width, imageView1.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
    
    
    CGFloat lengths[] = {10,5};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, [UIColor lightGrayColor].CGColor);
    
    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
    CGContextMoveToPoint(line, 0.0, 20.0);    //开始画线
    CGContextAddLineToPoint(line, kDeviceWidth, 20.0);
    CGContextStrokePath(line);
    
    imageView1.image = UIGraphicsGetImageFromCurrentImageContext();}

-(UIColor *)generateRandomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    color = [UIColor clearColor];
    return color;
    
}

-(void)setAlertContent:(UIView *)view
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;

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
