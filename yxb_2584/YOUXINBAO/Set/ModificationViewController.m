//
//  ModificationViewController.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/4/17.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "ModificationViewController.h"
#import "PersonCenterManager.h"
#import "RootViewController.h"
#import "QCLoginOneViewController.h"
#import "YXBTool.h"
#import "HomePopView.h"

#define kMaleButtonTag 20001
#define kFemaleButtonTag 20002

@interface ModificationViewController () <HomePopViewDelegate>

@property (nonatomic,assign) NSInteger isMale;

@end

@implementation ModificationViewController

- (void)dealloc {
    NSLog(@"ModificationViewController is dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    [self initView];
}

- (void)initView
{
    self.view.backgroundColor = rgb(237, 237, 246, 1);

    self.bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64)];
    self.bgScrollView.delegate = self;
    self.bgScrollView.showsVerticalScrollIndicator = FALSE;
    self.bgScrollView.showsHorizontalScrollIndicator = FALSE;
    self.bgScrollView.contentSize = CGSizeMake(kDeviceWidth, kDeviceHeight);
    [self.view addSubview:self.bgScrollView];
    _userInfoImgbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, (kDeviceWidth/2.5f))];
    _userInfoImgbg.image = [UIImage imageNamed:@"welcomebgimg.jpg"];
    [self.bgScrollView addSubview:_userInfoImgbg];
    
    _userInfoImg = [[UIImageView alloc] initWithFrame:CGRectMake((_userInfoImgbg.frame.size.width-_userInfoImgbg.height/2)/2, (_userInfoImgbg.height-_userInfoImgbg.height/2)/2, _userInfoImgbg.height/2,  _userInfoImgbg.height/2)];
    _userInfoImg.layer.cornerRadius = _userInfoImg.size.width/2;
    _userInfoImg.layer.borderColor = [UIColor whiteColor].CGColor;
    _userInfoImg.layer.borderWidth = 1.5f;
    _userInfoImg.layer.masksToBounds = YES;
    
    _userInfoImg.image = [UIImage imageNamed:@"homeUserPhoto.png"];
    [_userInfoImgbg addSubview:_userInfoImg];
    
    _userName = [[UILabel alloc] initWithFrame:CGRectMake(0, _userInfoImg.bottom+10, kDeviceWidth, 20)];
    _userName.textAlignment = NSTextAlignmentCenter;
    _userName.textColor = [UIColor whiteColor];
    _userName.font = [UIFont boldSystemFontOfSize:16];
    _userName.text = @"欢迎回来 : Liu Ran";
    [_userInfoImgbg addSubview:_userName];
    
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(15, _userInfoImgbg.bottom+15, kDeviceWidth-30, (kDeviceWidth-30)/6)];
//    _textField.layer.cornerRadius = 2;
//    _textField.layer.masksToBounds = YES;
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.font = [UIFont systemFontOfSize:15];
    _textField.delegate = self;
    _textField.layer.borderColor = [rgb(225, 225, 225, 0.8) CGColor];
    _textField.layer.borderWidth = 1;
    _textField.returnKeyType = UIReturnKeyDone;
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    [self.bgScrollView addSubview:_textField];
    
    _sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, _textField.bottom+30, kDeviceWidth-30, (kDeviceWidth-30)/6)];
    _sureBtn.backgroundColor = [UIColor clearColor];
    [_sureBtn setBackgroundImage:[UIImage imageNamed:@"ok-but"] forState:UIControlStateNormal];
    [_sureBtn addTarget:self action:@selector(sureBtnAciton:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgScrollView addSubview:_sureBtn];

    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    [_userInfoImg sd_setImageWithURL:[NSURL URLWithString:userModel.user.iconAddr] placeholderImage:[UIImage imageNamed:@"useimg"]];
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, 70, 40)];
    if ((_pushIndexPath.section == 0 && _pushIndexPath.row == 1) || self.isRegisterLogen == YES) {
       self.title = @"昵称";
        _nameLabel.text = @"新昵称 :";
        _textField.placeholder = @"  请设置1-6个字的昵称";
        _userName.text = [NSString stringWithFormat:@"终于等到你:“ %@ ”要换个昵称吗",userModel.user.nickname];
    }else{
        self.title = @"签名";
        _userName.text = [NSString stringWithFormat:@"终于等到你:“ %@ ”要换个签名吗",userModel.user.nickname];
        _textField.placeholder = @"  请设置一个签名";
        _nameLabel.text = @"新签名 :";
        
    }
    [_userName setAdjustsFontSizeToFitWidth:YES];
    _nameLabel.hidden = YES;
    UILabel *leftView2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10, _textField.height)];
    _textField.leftViewMode = UITextFieldViewModeAlways;
    _textField.leftView = leftView2;
    [self.view addSubview:_nameLabel];
    
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];

    if (self.isRegisterLogen == YES) {
        _isMale = 1;
        UILabel *left = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, _textField.height)];
        left.text = @"昵称:";
        left.backgroundColor = [UIColor clearColor];
        left.font = [UIFont systemFontOfSize:15];
        left.textAlignment = NSTextAlignmentCenter;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.leftView = left;
        [self.view addSubview:_nameLabel];
        self.title = @"登录无忧借条";
        _userName.text = [NSString stringWithFormat:@"欢迎你%@,换个昵称让好友更方便找到你！",userModel.user.nickname];
        _textField.placeholder = @"请设置14个字符以内";
        
        UIView *gender = [[UIView alloc] initWithFrame:CGRectMake(15, _textField.bottom+10, (kDeviceWidth-30), (kDeviceWidth-30)/6)];
        [_bgScrollView addSubview:gender];
        gender.backgroundColor = [UIColor whiteColor];
        gender.layer.borderColor = [rgb(225, 225, 225, 0.8) CGColor];
        gender.layer.borderWidth = 1;
        
        UILabel *sex = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, gender.height)];
        sex.backgroundColor = [UIColor clearColor];
        sex.text = @"性别:";
        sex.textAlignment = NSTextAlignmentCenter;
        sex.font = [UIFont systemFontOfSize:15];
        [gender addSubview:sex];
        
        UIView *maleView = [self createSexViewWithFrame:CGRectMake(sex.right, 0, (gender.width-sex.width-0.5)/2, gender.height) isMale:YES superView:gender];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(maleView.right, (gender.height-20)/2, 0.5, 20)];
        line.backgroundColor = rgb(225, 225, 225, 0.8);
        [gender addSubview:line];
        
        UIView *femaleView = [self createSexViewWithFrame:CGRectMake(line.right, 0, (gender.width-sex.width-0.5)/2, gender.height) isMale:NO superView:gender];
        
        NSLog(@"%@",femaleView);
        
        _sureBtn.top = gender.bottom+20;
        
        //跳过
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 60, 30);
        [btn addTarget:self action:@selector(jumpAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"跳过" forState:UIControlStateNormal];
        UIBarButtonItem *jumpItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.navigationItem.rightBarButtonItem = jumpItem;
        /*
        UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"跳过" style:UIBarButtonItemStylePlain target:self action:@selector(rightNavigationItemAction)];
        rightItem.tintColor = [UIColor whiteColor];
        self.navigationItem.rightBarButtonItem = rightItem;
        */
        
    }

}

- (void)jumpAction:(UIButton *)button {
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:RegisterToAutoLoginFlag];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController popToRootViewControllerAnimated:YES];
    //注册成功 弹窗
    HomePopView *view = [[HomePopView alloc] init];
    view.delegte = self;
    [view showHonestUser:self.indexUser];
}

- (UIView *)createSexViewWithFrame:(CGRect)frame isMale:(BOOL)isMale superView:(UIView *)superView {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    [superView addSubview:view];
    
    UIImage *image;
    UIImage *selectedImage;
    NSString *str;
    NSInteger tag;
    BOOL selected;
    if (isMale) {
        image = [UIImage imageNamed:@"zc-nanicon"];
        selectedImage = [UIImage imageNamed:@"zc-nanicon2"];
        str = @"男";
        tag = kMaleButtonTag;
        selected = YES;
    }else {
        image = [UIImage imageNamed:@"zc-nvicon"];
        selectedImage = [UIImage imageNamed:@"zc-nvicon2"];
        str = @"女";
        tag = kFemaleButtonTag;
        selected = NO;
    }
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    [button addTarget:self action:@selector(sexButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    button.selected = selected;
    button.tag = tag;
    button.center = CGPointMake(frame.size.width/3, frame.size.height/2);
    [view addSubview:button];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 15)];
    label.backgroundColor = [UIColor clearColor];
    label.text = str;
    label.font = [UIFont systemFontOfSize:15];
    label.center = CGPointMake(frame.size.width/3*2, frame.size.height/2);
    [view addSubview:label];
    
    return view;
}

- (void)sexButtonAction:(UIButton *)button {
    UIButton *male = (UIButton *)[_bgScrollView viewWithTag:kMaleButtonTag];
    UIButton *female = (UIButton *)[_bgScrollView viewWithTag:kFemaleButtonTag];
    if (button.tag == kMaleButtonTag) {
        male.selected = YES;
        female.selected = NO;
        _isMale = 1;
    }else {
        _isMale = 0;
        male.selected = NO;
        female.selected = YES;
    }
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{//限制昵称14个字符
//    if ((_pushIndexPath.section == 0 && _pushIndexPath.row == 1) || self.isRegisterLogen == YES) {
//        if (range.location >= 14) {
//            return NO; // return NO to not change text
//            
//        }else {
//            return YES;
//            
//        }
//    }
//    return YES;
//}
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
//{  //string就是此时输入的那个字符textField就是此时正在输入的那个输入框返回YES就是可以改变输入框的值NO相反
//    
//    if ([string isEqualToString:@"\n"])  //按会车可以改变
//    {
//        return YES;
//    }
//    
//    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
//    
//    if (_textField == textField)  //判断是否时我们想要限定的那个输入框
//    {
//        if ([toBeString length] > 6) { //如果输入框内容大于6则弹出警告
//            textField.text = [toBeString substringToIndex:6];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"超过最大字数不能输入了" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] ;
//            [alert show];
//            return NO;
//        }
//    }
//    return YES;
////}
//- (void)textViewDidChange:(UITextField *)textf {//限制昵称14个字符
//    if ((_pushIndexPath.section == 0 && _pushIndexPath.row == 1) || self.isRegisterLogen == YES) {
//        if (_textField.text.length >= 14){
//            _textField.text = self.textfiledtext;
//            return;
//        }
//        self.textfiledtext = _textField.text;
//    }
//}

#pragma mark --- 禁止修改表情符号 昵称 签名
- (void)textViewDidChanges:(UITextView *)textView
{
    NSRange textRange = [textView selectedRange];
    [textView setText:[self disable_emoji:[textView text]]];
    [textView setSelectedRange:textRange];
}

- (NSString *)disable_emoji:(NSString *)text
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}

- (void)rightNavigationItemAction {
    if (self.isRegisterLogen == YES) {//如果是注册进来的
//        QCLoginOneViewController *logon = [[QCLoginOneViewController alloc] init];
////        logon.isLogon = YES;
//        [self.navigationController pushViewController:logon animated:YES];
        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
    }
}

- (void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
//    [self changeUserNickName];
    return YES;
}

//结束减速
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

        CGFloat offsetY = scrollView.contentOffset.y;
        
        if (offsetY > 0) {  //向上滑动
            
        } else {

            CGFloat height = ABS(offsetY) + (kDeviceWidth/2.5f);
            CGFloat width = kDeviceWidth/(kDeviceWidth/2.5f) * height;
            
            //3.图片的x坐标向左偏移 增加宽度的一半
            CGRect frame = CGRectMake(-(width-kDeviceWidth)/2,-(height-(kDeviceWidth/2.5f)), width, height);
            
            _userInfoImgbg.frame = frame;
            _userInfoImg.frame = CGRectMake((kDeviceWidth-(kDeviceWidth/2.5f)/2)/2+(width-kDeviceWidth)/2, ((kDeviceWidth/2.5f)-(kDeviceWidth/2.5f)/2)/2+ABS(offsetY)/2, (kDeviceWidth/2.5f)/2,  (kDeviceWidth/2.5f)/2);
            _userName.top = _userInfoImg.bottom+10;
            _userName.width = width;
        }
    
    
}

- (void)sureBtnAciton:(UIButton *)sender
{
    [self.view endEditing:YES];
    if (_pushIndexPath.row == 1 || self.isRegisterLogen == YES) {
        //昵称
        if (_textField.text.length > 6 ||_textField.text.length < 1) {
            [YXBTool showAlertViewWithString:@"请输入1-6位昵称"];
            return;
        }
    }
    [self changeUserNickName];
}

#pragma mark -----------------------------------------------HttpDownLoad
- (void)changeUserNickName
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak ModificationViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
        }
        
    } param:^(NSString *s) {
        
        [this httpLOadParams:s httpOperation:assginHtttperator];
    } complete:^(TResultSet* r, int taskid) {
        
        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    PersonCenterManager* _PersonCentermanger = (PersonCenterManager*)  [httpOperation getAopInstance:[PersonCenterManager class] returnValue:[TResultSet class]];
    
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    if (self.isRegisterLogen == YES) {
        [_PersonCentermanger changeGenderAndNickname:userModel.user.yxbToken gender:self.isMale nickname:_textField.text];
        
    }else {
        if (self.pushIndexPath.section == 0 && self.pushIndexPath.row == 1) {
            [_PersonCentermanger changeUserNickName:userModel.user.yxbToken newNickName:_textField.text];
            
        }else{
            [_PersonCentermanger changeUserSignature:userModel.user.yxbToken newSignature:_textField.text];
        }
        
    }

}
//请求完成
-(void)httpLoadComplete:(TResultSet *)r{
    if (r.errCode == 0) {
        QCUserManager * userManager = [QCUserManager sharedInstance];
        QCUserModel * userModel = [userManager getLoginUser];
        if (self.isRegisterLogen == YES) {
            userModel.user.nickname = _textField.text;
            userModel.user.gender = self.isMale;
            
        }else {
            if (self.pushIndexPath.section == 0 && self.pushIndexPath.row == 1) {
                userModel.user.nickname = _textField.text;
                
            }else{
                userModel.user.signature = _textField.text;
            }
            
        }
        
        [userManager setLoginUser:userModel];
        [self.delegate setModificationValue:_textField.text withIndexPath:self.pushIndexPath];
        
        if (self.isRegisterLogen == YES) {//如果是注册进来的
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:RegisterToAutoLoginFlag];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            //注册成功 弹窗
            HomePopView *view = [[HomePopView alloc] init];
            view.delegte = self;
            [view showHonestUser:self.indexUser];
            //                [this.navigationController popToRootViewControllerAnimated:YES];
        }else {
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        NSLog(@"%@",r.errString);
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:nil message:r.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }

}
#pragma mark 任务体系 HomePopView - delegete
- (void)IWantANniversalRoll:(UINavigationController *)nav {
    AuthenticationViewController *authentic = [[AuthenticationViewController alloc] init];
    [nav pushViewController:authentic animated:YES];
}
- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
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
