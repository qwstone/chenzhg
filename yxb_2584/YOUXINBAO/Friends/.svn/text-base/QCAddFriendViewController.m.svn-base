//
//  QCAddFriendViewController.m
//  YOUXINBAO
//
//  Created by ZHANGMIAO on 14-3-4.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCAddFriendViewController.h"
#import "TResultSet.h"
#import "TFriendRelationManager.h"

@interface QCAddFriendViewController ()<UITextFieldDelegate> {
    UIControl *_cover;
    UITextField *_messageText;
}

@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *telLabel1;



@end

@implementation QCAddFriendViewController
- (void)dealloc{
    NSLog(@"QCAddFriendViewController is dealloc");
    Release(_messageText);
    Release(_cover);
    Release(_addressBook);
    self.iHttpOperator = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithUserType:(BOOL)isAdd {
    self = [super init];

    if (self) {
        self.isAdd = isAdd;
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"详细资料";
    //self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = rgb(238, 236, 246, 1.0);
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftAction)];
    [self createUI];
}

- (void)createUI
{
    /*
    //line
    [self createlineViewOrigin:CGPointMake(10, 90)];
    [self createlineViewOrigin:CGPointMake(10, 130)];
//    [self createlineViewOrigin:CGPointMake(10, 170)];

    //头像
    UIImageView * touxiangImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 41.5, 41)];
    touxiangImage.image = [UIImage imageNamed:@"useimg"];
    [self.view addSubview:touxiangImage];
    [touxiangImage release];
    //名字
    NSString * nameLabel = self.addressBook.name;
    //地区
//    NSString * netherlands = self.addressBook.city;
    //手机
    NSString * phoneLabel = self.addressBook.tel;
    
    if (nameLabel) {
        [self CreateLabel:nameLabel frame:CGRectMake(60, 20, 200, 20) withView:self.view textAlignment:0 fontSize:19 textColor:nil];
        [self CreateLabel:[NSString stringWithFormat:@"备注名 : %@",nameLabel] frame:CGRectMake(60, 50, 230, 20) withView:self.view textAlignment:0 fontSize:16 textColor:rgb(136, 136, 136, 1)];
        
    }
    
    if (phoneLabel) {
        [self CreateLabel:[NSString stringWithFormat:@"手机 : %@",phoneLabel] frame:CGRectMake(10, 100, 230, 20) withView:self.view textAlignment:0 fontSize:16 textColor:rgb(136, 136, 136, 1)];

    }
    */
    
    //背景
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 120)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.borderWidth = 1.0;
    bgView.layer.borderColor = [rgb(222, 222, 222, 1) CGColor];
    [self.view addSubview:bgView];
    [bgView release];
    //头像
    UIImageView * touxiangImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 20, 50, 50)];
    touxiangImage.image = [UIImage imageNamed:@"hy-usermr-icon.png"];
    touxiangImage.layer.cornerRadius=10;
    [bgView addSubview:touxiangImage];
    [touxiangImage release];
    //名字
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(touxiangImage.right+5, 25, 200, 16)];
    _nameLabel.backgroundColor = [UIColor clearColor];
    _nameLabel.textColor = rgb(41, 45, 61, 1);
    _nameLabel.font = [UIFont systemFontOfSize:16];
    _nameLabel.textAlignment = 0;
    [bgView addSubview:_nameLabel];
    
    //手机号
    _telLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(touxiangImage.right+5, _nameLabel.bottom+13, kDeviceWidth-touxiangImage.right, 14)];
    _telLabel1.backgroundColor = [UIColor clearColor];
    _telLabel1.textColor = rgb(131, 131, 131, 1);
    _telLabel1.font = [UIFont systemFontOfSize:14];
    _telLabel1.textAlignment = 0;
    
    [bgView addSubview:_telLabel1];
    
    
    if (self.addressBook.name) {
        _nameLabel.text = self.addressBook.name;
        
    }
    if (self.addressBook.tel) {
        _telLabel1.text = [NSString stringWithFormat:@"手机号 : %@",self.addressBook.tel];
        
    }

    
    //button添加
    if (self.isAdd) {
        
        [self createButtonWithframe:CGRectMake(10, bgView.bottom+20, kDeviceWidth-20, 40) withImage:@"jhy" withView:self.view withTarget:self withAcation:@selector(addButtonAction) withTag:101];
        
        _cover = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
        _cover.backgroundColor = [UIColor colorWithWhite:0 alpha:.70];
        _cover.hidden = YES;
        [_cover addTarget:self action:@selector(coverAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_cover];
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(25, 115-64, kDeviceWidth-25*2, 185)];
        backView.backgroundColor = rgb(232, 232, 232, 1);
        backView.layer.cornerRadius = 5;
        backView.layer.masksToBounds = YES;
        [_cover addSubview:backView];
        [backView release];
        
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 26, backView.width-20*2, 48)];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.text = @"请发送验证申请,对方通过后即添加其为好友。";
        messageLabel.numberOfLines = 2;
        messageLabel.textColor = rgb(51, 51, 51, 1);
        messageLabel.font = [UIFont systemFontOfSize:15];
        [backView addSubview:messageLabel];
        [messageLabel release];
        
        _messageText = [[UITextField alloc] initWithFrame:CGRectMake(20, 87, backView.width-20*2, 38)];
        _messageText.textColor = rgb(51, 51, 51, 1);
        _messageText.font = [UIFont systemFontOfSize:14];
        _messageText.returnKeyType = UIReturnKeyDone;
        _messageText.delegate = self;
        _messageText.layer.borderColor = [[UIColor grayColor] CGColor];
        _messageText.layer.borderWidth = .5;
        _messageText.layer.cornerRadius = 5;
        _messageText.layer.masksToBounds = YES;
        _messageText.clearButtonMode = UITextFieldViewModeWhileEditing;
        _messageText.backgroundColor = [UIColor whiteColor];
        [backView addSubview:_messageText];
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
        _messageText.leftView = leftView;
        _messageText.leftViewMode = UITextFieldViewModeAlways;
        [leftView release];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 139.5, backView.width, .5)];
        lineView.backgroundColor = [UIColor grayColor];
        [backView addSubview:lineView];
        [lineView release];
        
        UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 140, backView.width, backView.height-140)];
        buttonView.backgroundColor = rgb(232, 226, 224, 1);
        [backView addSubview:buttonView];
        [buttonView release];
        
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame = CGRectMake(0, 0, (buttonView.width-.5)/2, buttonView.height);
        [leftButton setTitleColor:rgb(255, 80, 0, 1) forState:UIControlStateNormal];
        [leftButton setTitle:@"发送" forState:UIControlStateNormal];
        leftButton.titleLabel.font = [UIFont systemFontOfSize:20.0];
        [leftButton addTarget:self action:@selector(sendButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [buttonView addSubview:leftButton];
        
        UIView *gapView = [[UIView alloc] initWithFrame:CGRectMake((buttonView.width-.5)/2, 0, .5, buttonView.height)];
        gapView.backgroundColor = [UIColor grayColor];
        [buttonView addSubview:gapView];
        [gapView release];
        
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.frame = CGRectMake(gapView.right, 0, (buttonView.width-.5)/2, buttonView.height);
        [rightButton setTitleColor:rgb(128, 128, 128, 1) forState:UIControlStateNormal];
        [rightButton setTitle:@"取消" forState:UIControlStateNormal];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:20.0];
        [rightButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [buttonView addSubview:rightButton];
    }
     
    
    
}

- (void)closeKeyBoard {
    [UIView animateWithDuration:1 animations:^{
        _cover.hidden = YES;
//        _messageText.text = nil;
        [_messageText resignFirstResponder];
    }];
}

#pragma mark - UITextField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_messageText resignFirstResponder];
    
    return YES;
}

#pragma mark - Actions
- (void)addButtonAction
{
    [UIView animateWithDuration:1 animations:^{
        
        _cover.hidden = NO;
        [_messageText becomeFirstResponder];
    }];
    
}

- (void)coverAction:(UIControl *)cover {
    [self closeKeyBoard];
}

- (void)cancelButtonAction:(UIButton *)button {
    _messageText.text = nil;
    [self closeKeyBoard];
}

- (void)sendButtonAction:(UIButton *)button {
    [self closeKeyBoard];
    
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[[HttpOperator alloc]init]autorelease];
        
    }
    [self.iHttpOperator cancel];
    __block HttpOperator * assginHtttperator = _iHttpOperator;
    __block QCAddFriendViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
        }
        
    } param:^(NSString *s) {
        
        [this httpLOadParams:s httpOperation:assginHtttperator];
    } complete:^(TResultSet *r, int taskid) {
        
        [this httpLoadComplete:r];
        
        
    }];
    [self.iHttpOperator connect];
    
}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    QCUserModel *localUser = [[QCUserManager sharedInstance] getLoginUser];
    User *user = localUser.user;
    
    TFriendRelationManager* _currFriend = (TFriendRelationManager *)  [httpOperation getAopInstance:[TFriendRelationManager class] returnValue:[TResultSet class]];
    
    [_currFriend addTFriendRelationByMobile:user.username withFriendName:self.addressBook.tel withNote:_messageText.text];
 
}
//请求完成
-(void)httpLoadComplete:(TResultSet *)r{
    if (r.errCode == 0) {
        [self showLoadingWithTitle:@"发送成功" imageName:nil];
        //            [this performSelector:@selector(hideLoading) withObject:nil afterDelay:2];
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self showLoadingWithTitle:r.errString imageName:nil];
        //            [this performSelector:@selector(hideLoading) withObject:nil afterDelay:2];
        
    }
}
- (void)createlineViewOrigin:(CGPoint)origin
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(origin.x, origin.y, kDeviceWidth-20, 1)];
    view.backgroundColor = rgb(222, 222, 222, 1);
    [self.view addSubview:view];
    [view release];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.iHttpOperator != nil) {
        [self.iHttpOperator cancel];
    }
}
////影藏tabBar
//- (void)viewWillAppear:(BOOL)animated
//{
//    [UIView animateWithDuration:0.35 animations:^{
//        
//        NSArray * view = [self.tabBarController.view subviews];
//        UIView *subview = [view objectAtIndex:1];
//        subview.frame = CGRectMake(-kDeviceWidth, kDeviceHeight-49, kDeviceWidth, 49);
//        
//    }];
//}


- (void)createSureButtonWithframe:(CGRect)btnframe title:(NSString *)title withView:(UIView *)cview withTarget:(id)t withAcation:(SEL)s withTag:(NSInteger)tag
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = btnframe;
    button.backgroundColor = rgb(206, 37, 48, 1.0);
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:t action:s forControlEvents:UIControlEventTouchUpInside];
    button.tag = tag;
    button.layer.cornerRadius = 3.0;
    //    [button setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    button.adjustsImageWhenHighlighted = NO;
    
    [cview addSubview:button];
}

- (void)leftAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
