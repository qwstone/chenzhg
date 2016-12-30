//
//  QCIssueViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 15/5/9.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCIssueViewController.h"
#import "AATimePickerView.h"
#import "AACreatePickerView.h"
//#import "AAMapViewController.h"
#import "AAManager.h"
#import "AACompleteViewController.h"
#import "UserState.h"
#import "YXBTool.h"
#import "YXBProtocolView.h"
#import "AFHTTPRequestOperationManager.h"
#define kTimeButtonTag 10000
#define kAddressButtonTag 10001
#define kCostTypeTag 10002
#define kVisibleButtonTag 10003
#define kBackAlertTag 20000
#define kCreateAlterTag 20001
#define kDeleteButtonTag 20002

#define kImageWidth (kDeviceWidth-80)/2
#define kImageHeight kImageWidth*2/3
//static __weak QCIssueViewController *this = nil;

@interface QCIssueViewController ()<UIActionSheetDelegate,UITextViewDelegate,UITextFieldDelegate,QCIssueAlterDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,YXBProtocolViewtDelegate> {
    UIScrollView *_scrollView;
    QCBaseTextField *_titleField;
   
    QCBaseTextField *_limit;
    UILabel *_textViewplacehide;
    
    AATimePickerView *_timePicker;  //时间选择器
    AACreatePickerView *_visiblePicker;  //可见选择器
    AACreatePickerView *_costPicker;    //付费选择器
    
    UITextView *_textView;
    
    NSMutableArray *_imageViewArr;
    NSMutableArray *_imageRectArr;
    NSInteger _imageTag;    //图片数量
    
    YXBProtocolView *_agree;
    BOOL _agreeSelected;
//    BOOL _buttonClick;     //button是否以点击
    AFHTTPRequestOperationManager *_manager;
}

@property (nonatomic,strong) AACreateButton *time;
@property (nonatomic,strong) AACreateButton *address;
@property (nonatomic,strong) AACreateButton *costType;
@property (nonatomic,strong) AACreateButton *visible;

@property (nonatomic,strong) UIImageView *moneyBackView;
@property (nonatomic,strong) QCBaseTextField *money;
@property (nonatomic,strong) UILabel *moneyTitle;   //金额
@property (nonatomic,strong) UIView *jinE;  //

@property (nonatomic,strong) UILabel *numLimit; //字数限制

@property (nonatomic,strong) UIView *pictureView;
@property (nonatomic,strong) UIButton *addButton;
@property (nonatomic,strong) NSMutableString *imageUrl;

@end

@implementation QCIssueViewController

- (void)dealloc {
    [self removeKeyBoundNotification];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    [self setTitle:@"创建活动聚会"];
    
    //发布
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 60, 30);
    [btn addTarget:self action:@selector(createAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitle:@"发布" forState:UIControlStateNormal];
    UIBarButtonItem *createItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = createItem;

    //初始化数据
    [self initializeData];
    
    [self _initViews];
    
    
    [self getkeyboundheight];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)_initViews {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_scrollView];
    
    _jinE = [[UIView alloc] initWithFrame:CGRectMake(0, 200, kDeviceWidth, 50)];
    _jinE.backgroundColor = rgb(241, 240, 248, 1);
    _jinE.hidden = YES;
    _scrollView.contentSize = CGSizeMake(kDeviceWidth, 568+kImageWidth*2+40);
    [_scrollView addSubview:_jinE];
    
    NSArray *labelTitles = @[@"活动名称",@"活动时间",@"活动地点",@"付费类型",@"金      额",@"人数上限",@"可见类型"];
    for (int i = 0; i<7; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 30.0/2+(30.0+20)*i, 70, 20)];
        label.text = labelTitles[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = rgb(48, 48, 48, 1);
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:15];
        [_scrollView addSubview:label];
        
        if (i == 4) {
            _moneyTitle = label;
            _moneyTitle.hidden = YES;
        }
        
        if (i == 3 || i == 4 || i == 6) {
            [self addLineWithPoint:CGPointMake(0, label.bottom+30.0/2)];
        }else {
            [self addLineWithPoint:CGPointMake(20, label.bottom+30.0/2)];
        }
    }

    _titleField = [[QCBaseTextField alloc] initWithFrame:CGRectMake(105, 30.0/2, kDeviceWidth-120, 20)];
    _titleField.placeholder = @"请输入活动名称";
//    _titleField.textAlignment = NSTextAlignmentCenter;
    _titleField.delegate = self;
    _titleField.borderStyle = UITextBorderStyleNone;
    _titleField.backgroundColor = [UIColor clearColor];
    _titleField.font = [UIFont systemFontOfSize:14];
    [_scrollView addSubview:_titleField];
    
    _time = [[AACreateButton alloc] initWithFrame:CGRectMake(105, 50, kDeviceWidth-105, 50) andRightImage:@"next"];
    _time.textLabel.text = @"活动时间";
    _time.tag = kTimeButtonTag;
    [_time addTarget:self action:@selector(AAButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_time];
    
    _address = [[AACreateButton alloc] initWithFrame:CGRectMake(105, 100, kDeviceWidth-105, 50) andRightImage:@"location-icon"];
    _address.textLabel.text = @"活动地点";
    _address.tag = kAddressButtonTag;
    [_address addTarget:self action:@selector(AAButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_address];
    
//    _costType = [[AACreateButton alloc] initWithFrame:CGRectMake(105, 150, kDeviceWidth-105, 50) andRightImage:@"next"];
    _costType = [[AACreateButton alloc] initWithFrame:CGRectMake(105, 150, kDeviceWidth-105, 50) andRightImage:nil];
    _costType.textLabel.text = @"免费";
    _costType.tag = kCostTypeTag;
    [_costType addTarget:self action:@selector(AAButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_costType];
    
    UIButton *question = [[UIButton alloc] initWithFrame:CGRectMake(_costType.width-_costType.height-1, 0, _costType.height, _costType.height)];
    [question setImage:[UIImage imageNamed:@"AA_ques-icon"] forState:UIControlStateNormal];
//    question.backgroundColor = [UIColor lightGrayColor];
    [question addTarget:self action:@selector(questionAction:) forControlEvents:UIControlEventTouchUpInside];
    [_costType addSubview:question];
    
    //输入框边框图
    UIImage *boardImage = [UIImage imageNamed:@"numinput"];
    boardImage = [boardImage resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    
    _moneyBackView = [[UIImageView alloc] initWithFrame:CGRectMake(105, 200+5, kDeviceWidth-120, 40)];
    _moneyBackView.image = boardImage;
    _moneyBackView.userInteractionEnabled = YES;
    [_scrollView addSubview:_moneyBackView];
    _moneyBackView.hidden = YES;
    
    _money = [[QCBaseTextField alloc] initWithFrame:CGRectMake(10, 0, kDeviceWidth-130, 40)];
    _money.delegate = self;
    _money.placeholder = @"请输入金额";
//    _money.text = @"0";
    _money.borderStyle = UITextBorderStyleNone;
//    _money.textAlignment = NSTextAlignmentCenter;
//    _money.background = boardImage;
    _money.keyboardType = UIKeyboardTypeNumberPad;
//    _money.contentMode = UIViewContentModeScaleAspectFill;
    _money.font = [UIFont systemFontOfSize:14];
//    _money.enabled = NO;
    [_moneyBackView addSubview:_money];
    
    UIButton *jiaButton = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth-60, 250+5, 40, 40)];
    [jiaButton setImage:[UIImage imageNamed:@"jia-icon"] forState:UIControlStateNormal];
    [jiaButton addTarget:self action:@selector(jiaButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:jiaButton];
    
    UIButton *jianButton = [[UIButton alloc] initWithFrame:CGRectMake(105, 250+5, 40, 40)];
    [jianButton setImage:[UIImage imageNamed:@"jian-icon"] forState:UIControlStateNormal];
    [jianButton addTarget:self action:@selector(jianButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:jianButton];
    
    _limit = [[QCBaseTextField alloc] initWithFrame:CGRectMake(150, 250+5, kDeviceWidth-215, 40)];
    _limit.text = @"10";
    _limit.delegate = self;
    _limit.borderStyle = UITextBorderStyleNone;
    _limit.textAlignment = NSTextAlignmentCenter;
    _limit.keyboardType = UIKeyboardTypeNumberPad;
    _limit.background = boardImage;
    _limit.font = [UIFont systemFontOfSize:14];
    [_scrollView addSubview:_limit];
    
    _visible = [[AACreateButton alloc] initWithFrame:CGRectMake(105, 300, kDeviceWidth-105, 50) andRightImage:@"next"];
    _visible.textLabel.text = @"全部可见";
    _visible.tag = kVisibleButtonTag;
    [_visible addTarget:self action:@selector(AAButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_visible];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 350, kDeviceWidth, 300+kDeviceHeight)];
    footerView.backgroundColor = rgb(241, 240, 248, 1);
    [_scrollView addSubview:footerView];
    
    UIButton *telButton = [[UIButton alloc] initWithFrame:CGRectMake(110, 10+3.5, 25.0/2, 26.0/2)];
    [telButton setImage:[UIImage imageNamed:@"right-icon"] forState:UIControlStateSelected];
    [telButton setImage:[UIImage imageNamed:@"rightcheck-icon"] forState:UIControlStateNormal];
    telButton.contentMode = UIViewContentModeCenter;
    telButton.selected = YES;
    [telButton addTarget:self action:@selector(telSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:telButton];
    
    
    UILabel *tel = [[UILabel alloc] initWithFrame:CGRectMake(130, 10, kDeviceWidth-190, 20)];
    tel.text = @"显示我的手机号";
    tel.backgroundColor = [UIColor clearColor];
    tel.textColor = rgb(97, 97, 97, 1);
    tel.font = [UIFont systemFontOfSize:13];
    [footerView addSubview:tel];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(15, 40, kDeviceWidth-30, 75)];
    _textView.layer.borderColor = rgb(214, 214, 214, 1).CGColor;
    _textView.layer.borderWidth = 0.5;
    _textView.delegate = self;
    _textView.backgroundColor = [UIColor whiteColor];
    [footerView addSubview:_textView];
    
    UIView *sureView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 49)];
    sureView.backgroundColor = [UIColor whiteColor];
    
    CALayer *upLayer = [CALayer layer];
    upLayer.backgroundColor = [rgb(255, 156, 146, 1) CGColor];
    upLayer.frame = CGRectMake(0, 0, kDeviceWidth, 1);
    [sureView.layer addSublayer:upLayer];
    
    CALayer *downLayer = [CALayer layer];
    downLayer.backgroundColor = [rgb(255, 156, 146, 1) CGColor];
    downLayer.frame = CGRectMake(0, 49-1, kDeviceWidth, 1);
    [sureView.layer addSublayer:downLayer];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"register_sure"] forState:UIControlStateNormal];
    button.frame = CGRectMake((kDeviceWidth-300)/2, (49-40)/2, 300, 40);
    [button addTarget:self action:@selector(closeTextViewAction) forControlEvents:UIControlEventTouchUpInside];
    [sureView addSubview:button];
    
    _textView.inputAccessoryView = sureView;
    
    _textViewplacehide = [[UILabel alloc]initWithFrame:CGRectMake(8, 8, kDeviceWidth, 15)];
    _textViewplacehide.enabled = NO;
    _textViewplacehide.font = [UIFont systemFontOfSize:14];
    _textViewplacehide.textColor = rgb(210, 210, 210, 1);
    _textViewplacehide.text = @"还有什么要嘱咐小伙伴的么?";
    _textViewplacehide.backgroundColor = [UIColor clearColor];
    [_textView addSubview: _textViewplacehide];
    
    _numLimit = [[UILabel alloc] initWithFrame:CGRectMake(_textView.width-50, _textView.height-20, 50, 15)];
    _numLimit.backgroundColor = [UIColor clearColor];
    _numLimit.textColor = rgb(210, 210, 210, 1);
    _numLimit.text = @"0/2000";
    _numLimit.font = [UIFont systemFontOfSize:12];
    [_textView addSubview:_numLimit];
    
    UILabel *picLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, _textView.bottom+20, kDeviceWidth-30, 20)];
    picLabel.font = [UIFont systemFontOfSize:14];
    picLabel.textColor = rgb(97, 97, 97, 1);
    picLabel.backgroundColor = [UIColor clearColor];
    picLabel.text = @"上传漂亮的图片才能吸引小伙伴哦~";
    [footerView addSubview:picLabel];
    
    UIView *picLine = [[UIView alloc] initWithFrame:CGRectMake(15, picLabel.bottom, kDeviceWidth-30, 0.5)];
    picLine.backgroundColor = rgb(214, 214, 214, 1);
    [footerView addSubview:picLine];
    
    //发起图片
    _pictureView = [[UIView alloc] initWithFrame:CGRectMake(0, picLine.bottom+10, kDeviceWidth, 2*kImageWidth+40)];
    _pictureView.backgroundColor = [UIColor clearColor];
    [footerView addSubview:_pictureView];
    
    CGFloat leftOrigin = 30;
    CGFloat gap = 20;
    
    _addButton = [[UIButton alloc] initWithFrame:CGRectMake(leftOrigin, 10, kImageWidth, kImageHeight)];
//    [_addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [_addButton setTitle:@"添加" forState:UIControlStateNormal];
    [_addButton addTarget:self action:@selector(addImageAction:) forControlEvents:UIControlEventTouchUpInside];
    _addButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _addButton.layer.borderWidth = 0.5;
    [_pictureView addSubview:_addButton];
    
    UIImageView *camera = [[UIImageView alloc] initWithFrame:CGRectMake((kImageWidth-40)/2, kImageHeight/4, 40, 33)];
    camera.image = [UIImage imageNamed:@"camera"];
    [_addButton addSubview:camera];
    
    UILabel *picCount = [[UILabel alloc] initWithFrame:CGRectMake(0, camera.bottom+5, kImageWidth, 15)];
    picCount.backgroundColor = [UIColor clearColor];
    picCount.textColor = [UIColor lightGrayColor];
    picCount.text = @"最多6张";
    picCount.font = [UIFont systemFontOfSize:13];
    picCount.textAlignment = NSTextAlignmentCenter;
    [_addButton addSubview:picCount];
    
    //存储图片显示位置矩形

    for (int column = 0; column < 3; column++) {
        for (int row = 0; row < 2; row++) {
            CGRect frame = CGRectMake(leftOrigin+(gap+kImageWidth)*row, 10+(10+kImageHeight)*column, kImageWidth, kImageHeight);
            [_imageRectArr addObject:[NSValue valueWithCGRect:frame]];
        }
    }
    
    _agree = [[YXBProtocolView alloc] initWithType:TYPE_TO_AA_CREATE Frame:CGRectMake(15, _pictureView.bottom+10, kDeviceWidth-30, 17) location:VIEWAlignmentLeft];
    _agree.tongyi.frame = CGRectMake(0, (_agree.height-12.5)/2, 12.5, 12.5);
    [_agree.tongyi setBackgroundImage:[UIImage imageNamed:@"zc-check"] forState:UIControlStateNormal];
    [_agree.tongyi setBackgroundImage:[UIImage imageNamed:@"zc-checked"] forState:UIControlStateSelected];
    [_agree.tongyitiaokuan setTitleColor:rgb(52, 142, 250, 1) forState:UIControlStateNormal];
    _agree.delegate = self;
    [footerView addSubview:_agree];

    
    //发起新活动传值
    if (_activity != nil) {
        _titleField.text = _activity.topic;
//        _money.text = _activity.avgCost;
        _limit.text = [NSString stringWithFormat:@"%ld",(long)_activity.capacity];
        _textView.text = _activity.detail;
        if (_textView.text.length == 0) {
            _textViewplacehide.hidden = NO;
        }else{
            _textViewplacehide.hidden = YES;
        }
        
        if (_activity.showMobile) {
            telButton.selected = YES;
        }else {
            telButton.selected = NO;
        }
        
        //活动时间
        NSRange range1 = NSMakeRange(0, 11);
        NSRange range2 = NSMakeRange(11, 2);
        NSRange range3 = NSMakeRange(14, 2);
        
        if (_activity.activityDate != nil && _activity.activityDate.length != 0) {
            
            NSString *timeTitle = [NSString stringWithFormat:@"%@      %@:%@",[_activity.activityDate substringWithRange:range1],[_activity.activityDate substringWithRange:range2],[_activity.activityDate substringWithRange:range3]];
            _time.textLabel.text = timeTitle;
        }
        
        _address.textLabel.text = _activity.destName;
        
        //付费类型
        if (_activity.payType == AAPayTypeFree) {
//            _money.enabled = NO;
            _jinE.hidden = YES;
            _moneyBackView.hidden = YES;
            _moneyTitle.hidden = YES;
            _money.text = nil;
            _costType.textLabel.text = @"免费";
            
//            [_costPicker selectedRow:0 inComponent:0];
        }else if (_activity.payType == AAPayTypePrepaid) {
//            _money.enabled = YES;
            _jinE.hidden = NO;
            _moneyBackView.hidden = NO;
            _moneyTitle.hidden = NO;
            _money.text = _activity.avgCost;
            _costType.textLabel.text = @"付费(先付费)";
//            [_costPicker selectedRow:1 inComponent:0];
        }else if (_activity.payType == AAPayTypeThen) {
            //            _money.enabled = YES;
            _jinE.hidden = NO;
            _moneyBackView.hidden = NO;
            _moneyTitle.hidden = NO;
            _money.text = _activity.avgCost;
            _costType.textLabel.text = @"预付费(后付费)";
            //            [_costPicker selectedRow:1 inComponent:0];
        }
        
        //可见类型
        if (_activity.showType == AAShowTypePublic) {
            _visible.textLabel.text = @"全部可见";
//            [_visiblePicker selectedRow:0 inComponent:0];
        }else if (_activity.showType == AAShowTypeFriend) {
            _visible.textLabel.text = @"好友可见";
//            [_visiblePicker selectedRow:1 inComponent:0];
        }else if (_activity.showType == AAShowTypeSecret) {
            _visible.textLabel.text = @"私密邀请";
//            [_visiblePicker selectedRow:2 inComponent:0];
        }
        
        //上传图片
        
    }
}

- (void)setActivity:(AAActivity *)activity {
//    _activity = activity;
    if (_activity == nil) {
        _activity = [[AAActivity alloc] init];
    }
    _activity.t_id = activity.t_id;
    _activity.topic = activity.topic;
    _activity.avgCost = activity.avgCost;
    _activity.payType = activity.payType;
    _activity.capacity = activity.capacity;
    _activity.detail = activity.detail;
    _activity.activityDate = activity.activityDate;
    _activity.showType = activity.showType;
    _activity.destLatitude = activity.destLatitude;
    _activity.destLongitude = activity.destLongitude;
    _activity.destName = activity.destName;
    _activity.showMobile = activity.showMobile;
//    _activity.postWallPics = activity.postWallPics;
}

- (void)initializeData {
    _agreeSelected = YES;
    _isFailed = NO;
    _imageUrl = [NSMutableString new];
    
    _imageViewArr = [NSMutableArray new];
    _imageRectArr = [NSMutableArray new];
    _imageTag = 0;
    
    if (!_activity) {
        self.activity = [[AAActivity alloc] init];
        self.activity.avgCost = @"0";
        self.activity.showType = AAShowTypePublic;
        self.activity.payType = AAPayTypeFree;
        self.activity.capacity = 10;
        self.activity.showMobile = 1;
        self.activity.category = self.category;
    }

}

- (NSString *)subStringWithImageUrl:(NSString *)url {
    //去掉换行符
    NSMutableString *responseString = [NSMutableString stringWithString:url];
    NSString *search = @"\n";
    NSString *replace = @"";
    
    NSRange substr = [responseString rangeOfString:search];
    
    while (substr.location != NSNotFound) {
        [responseString replaceCharactersInRange:substr withString:replace];
        substr = [responseString rangeOfString:search];
    }
    
    url = responseString;
    return url;
}

#pragma mark - ProtocolView delegate
- (void)checkButton:(UIButton *)sender {
//    sender.selected = !sender.selected;
    
    if (!sender.selected) {
        _agreeSelected = NO;
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"请先勾选用AA活动发起服务协议" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        
    }else{
        _agreeSelected = YES;
    }
}

#pragma mark - Http request
- (void)updatePictures:(NSInteger)index {
    //上传图片
    UIImage *image = ((UIImageView *)[_imageViewArr objectAtIndex:index]).image;
    float compressionQuality = 1.0;
    
    //图片压缩至低于600K
    NSData *imgData;
    do {
        imgData = UIImageJPEGRepresentation(image, compressionQuality);
        compressionQuality -= 0.1;
    } while (imgData.length > 600000);
    
    BOOL toCreate = NO;
    
    if (index == _imageViewArr.count-1) {
        toCreate = YES;
    }
    
    //    NSString * Urlstring = [NSString stringWithFormat:@"http://60.195.254.33:8083/uploadPhoto.jsp?type=6&id=%ld",(long)self.activity.t_id];
    //    NSString *Urlstring=[NSString stringWithFormat:@"%@uploadPhoto.jsp?type=6&id=%ld",YXB_IP_ADRESS,(long)self.activity.t_id];
    NSString *url1 = [NSString stringWithFormat:@"uploadBatchPhoto.jsp?type=6&id=%ld",(long)self.activity.t_id];
    NSString *Urlstring = [NSString stringWithFormat:@"%@%@",YXB_IP_ADRESS,url1];
    _manager = [AFHTTPRequestOperationManager manager];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    [_manager POST:Urlstring parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>   formData) {
//        [formData appendPartWithFormData:imgData name:@"image"];
        [formData appendPartWithFileData:imgData name:@"image" fileName:@"image.jpg" mimeType:@"image/jpg"];
    } success:^(AFHTTPRequestOperation *  operation, id responseObject) {
        if (index == 0 && self.imageUrl.length == 0) {
            [self.imageUrl appendString:[self subStringWithImageUrl:responseObject]];
        }else {
            [self.imageUrl appendFormat:@"|%@",[self subStringWithImageUrl:responseObject]];
        }
        if (toCreate) {
            self.activity.previewPics = self.imageUrl;
            [self createActivity];
        }else {
            [self updatePictures:index+1];
            
        }
    } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
        [ProgressHUD dismiss];
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"上传图片失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
        NSLog(@"failed");
    }];
//    NSURL *url = [NSURL URLWithString:[Urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    __weak QCIssueViewController *this = self;
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//    [request setAuthImageData:imgData forKey:@"image"];
//
//    [request setFailedBlock:^{
//        [ProgressHUD dismiss];
//        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"上传图片失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alterView show];
//        NSLog(@"failed");
//    }];
//    [request setCompletionBlock:^{
//        if (index == 0 && this.imageUrl.length == 0) {
//            [this.imageUrl appendString:[this subStringWithImageUrl:request.responseString]];
//        }else {
//            [this.imageUrl appendFormat:@"|%@",[this subStringWithImageUrl:request.responseString]];
//        }
//        if (toCreate) {
//            this.activity.previewPics = this.imageUrl;
//            [this createActivity];
//        }else {
//            [this updatePictures:index+1];
//            
//        }
//        
//    }];
//    
//    [request startAsynchronous];
}

- (void)createActivity {
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak QCIssueViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:this cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            
            [ProgressHUD dismiss];
        }
        
    } param:^(NSString *s) {
        
        [this httpLoadParams:assginHtttperator];
        
    } complete:^(TResultSet* r, int taskid) {

        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
}
- (void)httpLoadParams:(HttpOperator *)assginHtttperator{

    AAManager* _activityM = (AAManager*)  [assginHtttperator getAopInstance:[AAManager class] returnValue:[TResultSet class]];
    
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    self.activity.creatorToken = userModel.user.yxbToken;
    
    if (self.isFailed) {
        [_activityM __yxb_service__updateTActivity:self.activity];
        
    }else {
        self.activity.t_id = 0;
        [_activityM __yxb_service__createTActivity:self.activity];
    }

}
- (void)httpLoadComplete:(TResultSet *)r{
    [ProgressHUD dismiss];
    
    if (r.errCode == 0) {
        [self showLoadingWithTitle:@"创建成功" imageName:nil];
        AACompleteViewController *complete = [[AACompleteViewController alloc] init];
        [self.navigationController pushViewController:complete animated:YES];
        
    }else{
        NSLog(@"%@",r.errString);
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"提示" message:r.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
    }
    

}

- (void)addLineWithPoint:(CGPoint)point {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(point.x, point.y, kDeviceWidth, 0.5)];
    line.backgroundColor = rgb(214, 214, 214, 1);
    [_scrollView addSubview:line];
}

#pragma mark - UITextField delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self hideKeyBoardAndPickerExcept:textField];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    if ([textField isEqual:_limit]) {
//        NSString *resultStr = nil;
//        if (string.length == 0 || string == nil) {
//            resultStr = [textField.text substringToIndex:textField.text.length-1];
//        }else {
//            resultStr = [NSString stringWithFormat:@"%@%@",textField.text,string];
//        }
//        
//        if (resultStr.integerValue < 2 && range.length == 0) {
//            textField.text = @"2";
//            return NO;
//        }
//    }
    if ([textField isEqual:_money]) {
        NSMutableString *str = [[NSMutableString alloc] initWithString:textField.text];
        
        if ([str integerValue] == 0 && string.integerValue == 0 &&[textField.text integerValue] == 0) {
            return NO;
        }
        
    }

    
    if ([textField isEqual:_limit]) {
        if (range.location>=9) {
            return NO;
        }
    }
    return YES;

}

#pragma mark - UITextView delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
//    if([text isEqualToString:@"\n"]) {
//        [_textView resignFirstResponder];
//        return NO;
//    }
    if (range.location >=2000) {
        return NO;
    }
    
    NSInteger gapIndex = 0; //首行缩进
    NSInteger allNum = 2000;
    
    if (![text isEqualToString:@""]) {
        if (textView.text.length-gapIndex+1 > allNum)
        {
            [YXBTool showAlertViewWithString:[NSString stringWithFormat:@"字数最多%ld",(long)allNum]];
            return NO;
            
        }
    }
    if (![text isEqualToString:@""]) {
        _numLimit.text=[NSString stringWithFormat:@"%ld/%ld",(long)textView.text.length-gapIndex+1,(long)allNum];
    }else {
        if (textView.text.length <= gapIndex) {
            return NO;
            
        }
        _numLimit.text=[NSString stringWithFormat:@"%ld/%ld",(long)textView.text.length-gapIndex-1,(long)allNum];
    }
    
//    NSMutableString *str = [[NSMutableString alloc] initWithString:_textView.text];
//    
//    [str replaceCharactersInRange:range withString:text];
    
    
    return YES;

}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self hideKeyBoardAndPickerExcept:textView];
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        _textViewplacehide.hidden = NO;
    }else{
        _textViewplacehide.hidden = YES;
    }
}

#pragma mark - Keyboard notification
- (void)keyboardShow:(NSNotification *)aNotification
{
    NSDictionary *info = [aNotification userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    _scrollView.contentSize = CGSizeMake(kDeviceWidth, 568+keyboardSize.height+kImageWidth*2+40);
    if ([_textView isFirstResponder]) {
        [_scrollView setContentOffset:CGPointMake(0, _textView.bottom+100) animated:YES];
    
    }
}

- (void)keyboardHide:(NSNotification *)aNotification
{
//    NSDictionary *info = [aNotification userInfo];
//    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
//    CGSize keyboardSize = [value CGRectValue].size;
    _scrollView.contentSize = CGSizeMake(kDeviceWidth, 568+kImageWidth*2+40);
}

#pragma mark - UIActionSheet delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *picker=[[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing=YES;
    
    if (buttonIndex==0) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"对不起，您的设备不支持拍照功能。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            return;
        }
        //        NSLog(@"0");
        picker.sourceType=UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }
    if (buttonIndex==1) {
        //        NSLog(@"1");
        picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
    }
}



#pragma mark--imagePicker delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];

    [self addPictureImageWithImage:image];
    
    if (_imageTag < 6) {
        NSValue *addButtonRect = [_imageRectArr objectAtIndex:_imageTag];
        _addButton.hidden = NO;
        _addButton.frame = addButtonRect.CGRectValue;
    }else {
        _addButton.hidden = YES;
    }
    
}

- (void)addPictureImageWithImage:(UIImage *)image {
    NSValue *rectValue = [_imageRectArr objectAtIndex:_imageTag];
    
    
    //添加图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rectValue.CGRectValue];
    imageView.image = image;
    imageView.userInteractionEnabled = YES;
    [_pictureView addSubview:imageView];
    [_pictureView sendSubviewToBack:imageView];
    [_imageViewArr addObject:imageView];
    
    UIButton *delete = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 24)];
        delete.tag = kDeleteButtonTag+_imageTag;
//    [delete setTitle:@"×" forState:UIControlStateNormal];
//    [delete setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [delete setBackgroundImage:[UIImage imageNamed:@"AA_del"] forState:UIControlStateNormal];
    [delete addTarget:self action:@selector(deleteImageAction:) forControlEvents:UIControlEventTouchUpInside];
    [_pictureView addSubview:delete];
    delete.center = imageView.topLeft;
    
    _imageTag++;
}

#pragma  mark - UIButton Action
- (void)questionAction:(UIButton *)button {
    //       http://60.195.254.33:8083/webView/explain/aaExplain.jsp?t=1
    NSString *url = [YXBTool getURL:@"webView/explain/aaPayTypeExplain.jsp?t=1" params:nil];
    [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"付费帮助"];

}

//删除图片
- (void)deleteImageAction:(UIButton *)button {
    NSInteger imageTag = button.tag-kDeleteButtonTag;
    UIImageView *imageView = [_imageViewArr objectAtIndex:imageTag];
    [_imageViewArr removeObject:imageView];
    if (imageView.superview != nil) {
        [imageView removeFromSuperview];
        
    }
    
    UIButton *lastDelete = (UIButton *)[_pictureView viewWithTag:kDeleteButtonTag+_imageTag-1];
    if (lastDelete.superview != nil) {
        [lastDelete removeFromSuperview];
        
    }
    
    _imageTag--;
    
    for (int i = 0; i < _imageTag; i++) {
        UIImageView *remainImageView = [_imageViewArr objectAtIndex:i];
        NSValue *rectValue = [_imageRectArr objectAtIndex:i];
        remainImageView.frame = rectValue.CGRectValue;
    }
    
    NSValue *addButtonRect = [_imageRectArr objectAtIndex:_imageTag];
    _addButton.frame = addButtonRect.CGRectValue;
    _addButton.hidden = NO;
}


- (void)addImageAction:(UIButton *)button {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从本地相册上传", nil];
    [actionSheet showInView:self.view];
    //    UIImagePickerController *picker=[[UIImagePickerController alloc] init];
    //    picker.title = @"照片";
    //
    //    picker.delegate = self;
    //    picker.allowsEditing=YES;
    //
    //
    //    picker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    //    [self presentViewController:picker animated:YES completion:nil];
    
    
}

- (void)closeTextViewAction {
    [_textView resignFirstResponder];
}

- (void)jiaButtonAction {
    if ([_limit.text longLongValue] >= 999999999) {
        return;
    }
    _limit.text = [NSString stringWithFormat:@"%lld",([_limit.text longLongValue]+1)];
}

- (void)jianButtonAction {
    _limit.text = [NSString stringWithFormat:@"%lld",([_limit.text longLongValue]-1)];
    if (_limit.text.integerValue < 2) {
        _limit.text = @"2";
    }
}

- (void)AAButtonAction:(AACreateButton *)button {
//    if (!_buttonClick) {
//        this = self;
//        _buttonClick = !_buttonClick
//    }
    
    
    __weak QCIssueViewController *this = self;
    
    if (button.tag == kTimeButtonTag) {
        if (_timePicker == nil) {
            _timePicker = [[AATimePickerView alloc] initWithFrame:CGRectMake(0, _scrollView.height, _scrollView.width, kTimeCustomHeight) withHour:YES];
//            __weak QCIssueViewController *this = self;
//            __weak UIButton *time = (UIButton *)[_firstView viewWithTag:kTimeButtonTag];
            _timePicker.selectedBlock = ^ (NSInteger year, NSInteger month, NSInteger day, NSInteger hour, NSInteger minIndex, AATimePickerView *timePickerView) {
                NSInteger min;
                if (minIndex == 0) {
                    min = 0;
                }else {
                    min = 30;
                }
                NSString *date = [NSString stringWithFormat:@"%ld-%02ld-%02ld %02ld:%02ld:00",(long)year,(long)month,(long)day,(long)hour,(long)min];
                this.activity.activityDate = date;
                NSRange range1 = NSMakeRange(0, 11);    //日期
                NSRange range2 = NSMakeRange(11, 2);    //小时
                NSRange range3 = NSMakeRange(14, 2);    //分钟
                
                NSString *timeTitle = [NSString stringWithFormat:@"%@      %@:%@",[date substringWithRange:range1],[date substringWithRange:range2],[date substringWithRange:range3]];
                button.textLabel.text = timeTitle;
            };
            [self.view addSubview:_timePicker];
        }
        
        [self hideKeyBoardAndPickerExcept:nil];
        
        [_timePicker showPickerView];
        
    }else if (button.tag == kAddressButtonTag) {
//        AAMapViewController *mapVC = [[AAMapViewController alloc] init];
//        mapVC.delegate = self;
//        [self.navigationController pushViewController:mapVC animated:YES];

        
    }else if (button.tag == kCostTypeTag) {
        if (_costPicker == nil) {
            NSArray *arr = [NSArray arrayWithObjects:@[@"免费",@"付费(先付费)",@"预付费(后付费)"], nil];
            _costPicker = [[AACreatePickerView alloc] initWithFrame:CGRectMake(0, _scrollView.height, _scrollView.width, kCreatePickerCustomHeight) Component:1 listArr:arr];
            
//            __weak UIButton *cost = (UIButton *)[_secondView viewWithTag:kCostButtonTag];
            _costPicker.selectedBlock = ^ (NSString *text, AACreatePickerView *createPickerView) {
                if ([text isEqualToString:@"付费(先付费)"]) {
                    this.activity.payType = AAPayTypePrepaid;
                    button.textLabel.text = @"付费(先付费)";
//                    this.money.enabled = YES;
                    this.moneyBackView.hidden = NO;
                    this.jinE.hidden = NO;
                    this.moneyTitle.hidden = NO;
                }else if ([text isEqualToString:@"免费"]) {
                    this.activity.payType = AAPayTypeFree;
                    this.activity.avgCost = @"0";
//                    this.money.enabled = NO;
                    this.moneyBackView.hidden = YES;
                    this.jinE.hidden = YES;
                    this.moneyTitle.hidden = YES;
                    this.money.text = nil;
                    button.textLabel.text = @"免费";
                }else if ([text isEqualToString:@"预付费(后付费)"]) {
                    this.activity.payType = AAPayTypeThen;
                    //                    this.money.enabled = NO;
                    this.moneyBackView.hidden = NO;
                    this.jinE.hidden = NO;
                    this.moneyTitle.hidden = NO;
                    button.textLabel.text = @"预付费(后付费)";
                }
            };
            [self.view addSubview:_costPicker];
        }
        //付费类型
        if ([button.textLabel.text isEqualToString:@"免费"]) {
            
            [_costPicker selectedRow:0 inComponent:0];
        }else if ([button.textLabel.text isEqualToString:@"付费(先付费)"]) {
            [_costPicker selectedRow:1 inComponent:0];
        }else if ([button.textLabel.text isEqualToString:@"预付费(后付费)"]) {
            [_costPicker selectedRow:2 inComponent:0];
        }
        
        [self hideKeyBoardAndPickerExcept:nil];
        
        [_costPicker showPickerView];

    }else if (button.tag == kVisibleButtonTag) {
        if (_visiblePicker == nil) {
            NSArray *arr = [NSArray arrayWithObjects:@[@"全部可见",@"好友可见",@"私密邀请"], nil];
            _visiblePicker = [[AACreatePickerView alloc] initWithFrame:CGRectMake(0, _scrollView.height, _scrollView.width, kCreatePickerCustomHeight) Component:1 listArr:arr];
//            __weak QCIssueViewController *this = self;
//            __weak UIButton *visible = (UIButton *)[_secondView viewWithTag:kVisibleButtonTag];
            _visiblePicker.selectedBlock = ^ (NSString *text, AACreatePickerView *createPickerView) {
                if ([text isEqualToString:@"全部可见"]) {
                    this.activity.showType = AAShowTypePublic;
                    button.textLabel.text = @"全部可见";
                }else if ([text isEqualToString:@"好友可见"]) {
                    this.activity.showType = AAShowTypeFriend;
                    button.textLabel.text = @"好友可见";
                }else if ([text isEqualToString:@"私密邀请"]) {
                    this.activity.showType = AAShowTypeSecret;
                    button.textLabel.text = @"私密邀请";
                }
            };
            [self.view addSubview:_visiblePicker];
        }
        
        //可见类型
        if (_activity.showType == AAShowTypePublic) {
            [_visiblePicker selectedRow:0 inComponent:0];
        }else if (_activity.showType == AAShowTypeFriend) {
            [_visiblePicker selectedRow:1 inComponent:0];
        }else if (_activity.showType == AAShowTypeSecret) {
            [_visiblePicker selectedRow:2 inComponent:0];
        }
        
        [self hideKeyBoardAndPickerExcept:nil];
        
        [_visiblePicker showPickerView];

    }
}

- (void)telSelectedAction:(UIButton *)button {
    button.selected = !button.selected;
    
    _activity.showMobile = button.selected;
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

- (void)createAction:(UIButton *)button {
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    if (!userModel.isLogin) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"您还没有登录，请登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alterView.tag = 10010;
        [alterView show];
        return;
    }
    if ([self.activity.avgCost floatValue] > 0) {
        if ([UserState isLv2] == E_NO_OPERATE) {
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"参与（发起）付费的活动请先完善身份信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alterView.tag = 10086;
            [alterView show];
            return;
        }else if ([UserState isLv2] == E_IN_REVIEW) {
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"身份认证需要一段时间审核，您可以逛逛其他功能，认证通过后，我们会通知您" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alterView show];
            return;
        }else if ([UserState isLv2] == E_FAIL_UserStateRes) {
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"您的身份认证失败，请从新认证" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alterView show];
            return;
        }
    }
    //实名认证
//    if (userModel.user.accountStatus == 1) {
//        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"身份认证需要一段时间审核，您可以逛逛其他功能，认证通过后，我们会通知您" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        //        alterView.tag = 10086;
//        [alterView show];
//        return;
//    }else if (userModel.user.accountStatus == 4) {
//        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"身份认证需要一段时间审核，您可以逛逛其他功能，认证通过后，我们会通知您" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        [alterView show];
//        return;
//    }else if (userModel.user.accountStatus == 2) {
//        //通过
//    }else if (userModel.user.accountStatus == 3) {
//        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"实名认证信息，审核失败，请重新进行实名认证" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        alterView.tag = 10086;
//        [alterView show];
//        return;
//    }else if (userModel.user.accountStatus == 0) {
//        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"参与（发起）付费的活动请先完善身份信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        alterView.tag = 10086;
//        [alterView show];
//        return;
//    }
    
    if (!_agreeSelected) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"请先勾选友信宝用活动聚会发起服务协议" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }
    
    if (_titleField.text.length < 5 || _titleField.text.length > 20) {
        //活动名称要再5-20字之间
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"活动名称需在5-20字之间。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }else if (_titleField.text.length == 0 || _titleField.text == nil) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"活动名称不能为空。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }
    
    if (self.activity.activityDate.length == 0 || self.activity.activityDate == nil) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"活动时间不能为空。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }
    
    if (self.activity.destName.length == 0 || self.activity.destName == nil) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"活动地点不能为空。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }
    
    if (_limit.text.integerValue < 2) {
        //人数上限不能少于2
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"人数上限不能少于2" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;

    }else if (_limit.text.integerValue > 999999999) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"人数上限过大" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }
    
    if (!_moneyBackView.hidden && (_money.text.length == 0 || _money.text == nil)) {
        //预付费 && 金额未填
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"金额不能为空。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }
    
    if (!_moneyBackView.hidden && _money.text.integerValue == 0) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"金额不能为0元。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alter show];
        return;
    }
    
    if (_titleField.text.length != 0 && self.activity.activityDate.length != 0 && self.activity.destName.length != 0 && _limit.text.length != 0) {
        self.activity.topic = _titleField.text;
        if (_money.text.length == 0) {
            self.activity.avgCost = @"0";
        }else {
            self.activity.avgCost = _money.text;
        }
        self.activity.capacity = [_limit.text integerValue];
        self.activity.detail = _textView.text;
        
//        [self createActivity];
//        QCIssueAlter *alter = [[QCIssueAlter alloc] init];
//        alter.delegate = self;
//        [[UIApplication sharedApplication].keyWindow addSubview:alter];
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"是否确认发布活动聚会？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alter.tag = kCreateAlterTag;
        [alter show];
        
    }else {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"请完善创建信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alter show];
        return;
    }
}

- (void)leftClicked {
    if (_titleField.text.length != 0 || self.activity.activityDate.length != 0 || self.activity.destName.length != 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"是否确认放弃编辑活动聚会？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = kBackAlertTag;
        [alert show];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}

//#pragma mark - QCIssueAlter delegate
//- (void)QCIssueAlterSureButtonDidClicked {
//    [self createActivity];
//}

#pragma mark - UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex  {
    if (alertView.tag == kBackAlertTag) {
        if (buttonIndex == 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            
        }
    } else if (alertView.tag == 10010){
        if (buttonIndex == 1) {
            
            [self toLogin];
        }
    } else if (alertView.tag == 10086){
        if (buttonIndex == 1) {
            
            [self toAuthentication];
        }
    }else if (alertView.tag == kCreateAlterTag) {
        if (buttonIndex == 1) {
            [ProgressHUD showWithStatus:@"正在加载..." maskType:ProgressHUDMaskTypeNone tipsType:ProgressHUDTipsTypeLongBottom networkIndicator:YES];
            
            
            if (_imageViewArr.count == 0) {
                [self createActivity];
                
            }else {
                [self updatePictures:0];
                
            }
            
        }
    }
}

#pragma mark - AAMapView delegate
//- (void)AAMapViewLocationDidTouchForTitle:(NSString *)title coordinate:(CLLocationCoordinate2D)coordinate {
//    self.activity.destName = title;
//    self.activity.destLongitude = [NSString stringWithFormat:@"%f",coordinate.longitude];
//    self.activity.destLatitude = [NSString stringWithFormat:@"%f",coordinate.latitude];
//    
//    AACreateButton *address = (AACreateButton *)[_scrollView viewWithTag:kAddressButtonTag];
//    address.textLabel.text = title;
//    
//}

//隐藏键盘和选择器
- (void)hideKeyBoardAndPickerExcept:(UIView *)view {
    if (![view isEqual:_titleField]) {
        [_titleField resignFirstResponder];
    }
    
    if (![view isEqual:_limit]) {
        [_limit resignFirstResponder];
    }
    
    if (![view isEqual:_money]) {
        [_money resignFirstResponder];
    }
    
    if (![view isEqual:_textView]) {
        [_textView resignFirstResponder];
    }
    
//    [view becomeFirstResponder];
    
    if (_timePicker.isShow) {
        [_timePicker showPickerView];
    }
    
    if (_visiblePicker.isShow) {
        [_visiblePicker showPickerView];
    }
    
    if (_costPicker.isShow) {
        [_costPicker showPickerView];
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

//发布提示框
@implementation QCIssueAlter : UIView

- (id)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0 ,0 , kDeviceWidth, kDeviceHeight);
        self.backgroundColor = rgb(0, 0, 0, 0.2);
        
    
        UIView *alter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth-100, 120)];
        alter.center = CGPointMake(kDeviceWidth/2, kDeviceHeight/2);
        alter.layer.cornerRadius = 5;
        alter.backgroundColor = [UIColor whiteColor];
        alter.layer.masksToBounds = YES;
        [self addSubview:alter];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, alter.width, 20)];
        title.textAlignment = NSTextAlignmentCenter;
        title.text = @"是否确认发布AA活动？";
        title.backgroundColor = [UIColor clearColor];
//        title.textColor = rgb(97, 97, 97, 1);
        title.font = [UIFont systemFontOfSize:13];
        [alter addSubview:title];
        
        UIButton *right = [[UIButton alloc] initWithFrame:CGRectMake(alter.width/2-50, 50+3.5, 25.0/2, 26.0/2)];
        [right setImage:[UIImage imageNamed:@"right-icon"] forState:UIControlStateSelected];
        [right setImage:[UIImage imageNamed:@"rightcheck-icon"] forState:UIControlStateNormal];
        right.selected = YES;
        [right addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
        [alter addSubview:right];
        
        
        UILabel *provision = [[UILabel alloc] initWithFrame:CGRectMake(right.right, 50, kDeviceWidth-190, 20)];
        provision.text = @"同意活动聚会条款";
        provision.backgroundColor = [UIColor clearColor];
//        provision.textColor = rgb(97, 97, 97, 1);
        provision.font = [UIFont systemFontOfSize:13];
        [alter addSubview:provision];
        
        NSArray *nameArr = @[@"取消",@"确定"];
        for (int i = 0; i<2; i++) {
            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(i * alter.width/2, alter.height-30, alter.width/2, 30)];
            [btn setTitle:nameArr[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.layer.borderColor = rgb(191, 191, 191, 1).CGColor;
            btn.layer.borderWidth = 0.5;
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
            btn.tag = i+20000;
//            [btn setTitleColor:rgb(62, 163, 255, 1) forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            //            [btn setBackgroundImage:[UIImage imageNamed:@"blue-but.png"] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor whiteColor];
            [alter addSubview:btn];
            
        }


    }
    return self;
}

- (void)buttonAction:(UIButton *)button {
    if (button.tag == 20000) {
        
    }else if (button.tag == 20001) {
        //确定
        if ([self.delegate respondsToSelector:@selector(QCIssueAlterSureButtonDidClicked)]) {
            [self.delegate QCIssueAlterSureButtonDidClicked];
        }
    }
    [self removeFromSuperview];
}

- (void)rightAction:(UIButton *)button {
    button.selected = !button.selected;
}

@end

//
@implementation AACreateButton

- (id)initWithFrame:(CGRect)frame {
    self = [self initWithFrame:frame andRightImage:nil];
    
    return self;
}

- (id)initWithFrame:(CGRect)frame andRightImage:(NSString *)image {
    if (self = [super initWithFrame:frame]) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (frame.size.height-20)/2, frame.size.width-35, 20)];
        _textLabel.font = [UIFont systemFontOfSize:14];
        _textLabel.textColor = rgb(176, 176, 176, 1);
        _textLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_textLabel];
        
        UIImage *img = [UIImage imageNamed:image];
        CGSize size = img.size;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width-35, (frame.size.height-size.height)/2, size.width, size.height)];
        imageView.image = [UIImage imageNamed:image];
        [self addSubview:imageView];
        
    }
    
    return self;
}

@end
