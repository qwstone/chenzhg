//
//  AAStepViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 15/3/23.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AAStepViewController.h"
#import "AATimePickerView.h"
#import "AACreatePickerView.h"
#import "TActivityManager.h"
#import "TResultSet.h"
#import "AAActivitiesListViewController.h"

#define kImageWidth (kDeviceWidth-80)/2
#define kImageHeight kImageWidth*2/3
#define kTimeButtonTag 1000
#define kAddressButtonTag 1001
#define kVisibleButtonTag 1002
#define kCostButtonTag 1003

#define kThemeTextTag 2000
#define kLimitTextTag 2001
#define kAverageTextTag 2002
#define kDetailTextTag 2003

@interface AAStepViewController () {
    AATimePickerView *_timePicker;  //时间选择器
    AACreatePickerView *_visiblePicker;  //可见选择器
    AACreatePickerView *_costPicker;    //付费选择器
    
    NSInteger _currentPage;   //_scrollView起始偏移量
    
    UIView *_firstView;
    UIView *_secondView;
    UIView *_thirdView;
    UIView *_fourthView;
    
    UIScrollView *_imageScrollView;     //图片滚动视图
    UIButton *_addButton;   //添加图片按钮
    NSMutableArray *_imageViewArr;      //图片视图数组
    NSMutableArray *_imageRectArr;     //图片矩形数组
    NSInteger _imageTag;    //图片显示张数
}

@property (nonatomic,copy) NSString *activityDate;  //时间
@property (nonatomic,copy) NSString *address;   //位置
@property (nonatomic,copy) NSString *longitude;  //经度
@property (nonatomic,copy) NSString *latitude;   //纬度
@property (nonatomic,copy) NSString *topic;     //主题
@property (nonatomic,assign) NSInteger capacity;    //人数上限
@property (nonatomic,copy) NSString *avgCost;   //人均费用
@property (nonatomic,copy) NSString *detail;     //活动详情
@property (nonatomic,assign) AAShowType showType;    //可见类型
@property (nonatomic,assign) AAPayType payType;     //付费方式
@property (nonatomic,assign) AAFemaleFee femaleFee;   //女生费用

@end

@implementation AAStepViewController
-(void)dealloc{
    NSLog(@"AAStepViewController is dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    // Do any additional setup after loading the view from its nib.
}

- (void)initViews {
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    [self setTitle:@"创建活动聚会"];
    
    self.scrollView.frame = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64);
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width*4, self.scrollView.height);
    _firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.width, self.scrollView.height)];
    [self.scrollView addSubview:_firstView];
    _secondView = [[UIView alloc] initWithFrame:CGRectMake(self.scrollView.width, 0, self.scrollView.width, self.scrollView.height)];
    [self.scrollView addSubview:_secondView];
    _thirdView = [[UIView alloc] initWithFrame:CGRectMake(self.scrollView.width*2, 0, self.scrollView.width, self.scrollView.height)];
    [self.scrollView addSubview:_thirdView];
    _fourthView = [[UIView alloc] initWithFrame:CGRectMake(self.scrollView.width*3, 0, self.scrollView.width, self.scrollView.height)];
    [self.scrollView addSubview:_fourthView];
    
    [self initFirstView];
    [self initSecondView];
    [self initThirdView];
    [self initFourthView];
    
//    //添加手势
//    self.scrollView.scrollEnabled = NO;
//    UISwipeGestureRecognizer* gesture = [[UISwipeGestureRecognizer alloc]
//                                         initWithTarget:self action:@selector(handleSwipe:)];
//    gesture.numberOfTouchesRequired = 1;
//    gesture.direction = UISwipeGestureRecognizerDirectionRight;
//    [self.scrollView addGestureRecognizer:gesture];
}

- (void)initFirstView {
    UIButton *time = [[UIButton alloc] initWithFrame:CGRectMake(20, 85/2, kDeviceWidth-40, 30)];
    if (self.activity.activityDate) {
        NSRange range = NSMakeRange(0, 13);
        NSString *date = [self.activity.activityDate substringWithRange:range];
        [time setTitle:date forState:UIControlStateNormal];
        
    }else {
        
        [time setTitle:@"选一个大家都不忙的时间吧" forState:UIControlStateNormal];
    }
    [time setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [time addTarget:self action:@selector(timeAction:) forControlEvents:UIControlEventTouchUpInside];
    time.tag = kTimeButtonTag;
    [_firstView addSubview:time];
    [self addLineWithFrame:CGRectMake(time.left, time.bottom+5, time.width, 1) superView:_firstView];
    
    UIButton *address = [[UIButton alloc] initWithFrame:CGRectMake(20, 210/2, kDeviceWidth-40, 30)];
    if (self.activity.destName) {
        [address setTitle:self.activity.destName forState:UIControlStateNormal];
    }else {
        [address setTitle:@"活动地点在哪？标记出来吧" forState:UIControlStateNormal];
        
    }
    [address setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [address addTarget:self action:@selector(addressAction:) forControlEvents:UIControlEventTouchUpInside];
    address.tag = kAddressButtonTag;
    [_firstView addSubview:address];
    [self addLineWithFrame:CGRectMake(address.left, address.bottom+5, address.width, 1) superView:_firstView];
    
    AATextField *theme = [[AATextField alloc] initWithFrame:CGRectMake(20, 335/2, kDeviceWidth-40, 30)];
    if (self.activity.topic) {
        theme.text = self.activity.topic;
    }else {
        theme.placeholder = @"设置一个有影响力的主题吧";
        
    }
    
    theme.selectedDelegate = self;
    theme.delegate = self;
    theme.tag = kThemeTextTag;
    theme.borderStyle = UITextBorderStyleNone;
    theme.clearButtonMode = UITextFieldViewModeWhileEditing;
    theme.textAlignment = NSTextAlignmentCenter;
    [_firstView addSubview:theme];
    [self addLineWithFrame:CGRectMake(theme.left, theme.bottom+5, theme.width, 1) superView:_firstView];
    
    UIButton *firstStep = [[UIButton alloc] initWithFrame:CGRectMake((self.scrollView.width-200)/2, self.scrollView.height-250/2, 200, 40)];
    [firstStep setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [firstStep setTitle:@"继续吧" forState:UIControlStateNormal];
    [firstStep addTarget:self action:@selector(firstStepAction:) forControlEvents:UIControlEventTouchUpInside];
    [_firstView addSubview:firstStep];
}

- (void)initSecondView {
    AATextField *limit = [[AATextField alloc] initWithFrame:CGRectMake(20, 90/2, kDeviceWidth-40, 30)];
    if (self.activity.capacity) {
        limit.text = [NSString stringWithFormat:@"%ld",(long)self.activity.capacity];
    }else {
        limit.placeholder = @"设置活动的人员上限";
        
    }
    limit.selectedDelegate = self;
    limit.delegate = self;
    limit.tag = kLimitTextTag;
    limit.keyboardType = UIKeyboardTypeNumberPad;
    limit.textAlignment = NSTextAlignmentCenter;
    limit.clearButtonMode = UITextFieldViewModeWhileEditing;
    limit.borderStyle = UITextBorderStyleNone;
    [_secondView addSubview:limit];
    [self addLineWithFrame:CGRectMake(limit.left, limit.bottom+5, limit.width, 1) superView:_secondView];
    
    UIButton *visible = [[UIButton alloc] initWithFrame:CGRectMake(20, 210/2, kDeviceWidth-40, 30)];
    [visible setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    if (self.activity.showType == AAShowTypePublic) {
        [visible setTitle:@"全部可见" forState:UIControlStateNormal];
    }else if (self.activity.showType == AAShowTypeFriend) {
        [visible setTitle:@"好友可见" forState:UIControlStateNormal];
    }else {
        [visible setTitle:@"私密邀请" forState:UIControlStateNormal];
    }
    [visible addTarget:self action:@selector(visibleAction:) forControlEvents:UIControlEventTouchUpInside];
    visible.tag = kVisibleButtonTag;
    [_secondView addSubview:visible];
    [self addLineWithFrame:CGRectMake(visible.left, visible.bottom+5, visible.width, 1) superView:_secondView];
    
    UIButton *cost = [[UIButton alloc] initWithFrame:CGRectMake(20, 330/2, kDeviceWidth-40, 30)];
    
//    if (self.femaleFee == AAFemaleFeeFree) {
//        if (self.payType == AAPayTypePrepaid) {
//            [cost setTitle:@"预付费&女士免费" forState:UIControlStateNormal];
//        }else if (self.payType == AAPayTypePostpaid) {
//            [cost setTitle:@"后付费&女士免费" forState:UIControlStateNormal];
//        }else if (self.payType == AAPayTypeFreeForAll) {
//            [cost setTitle:@"全部免费" forState:UIControlStateNormal];
//        }
//    }else if (self.femaleFee == AAFemaleFeePaid) {
//        if (self.payType == AAPayTypePrepaid) {
//            [cost setTitle:@"预付费" forState:UIControlStateNormal];
//        }else if (self.payType == AAPayTypePostpaid) {
//            [cost setTitle:@"后付费" forState:UIControlStateNormal];
//        }else if (self.payType == AAPayTypeFreeForAll) {
//            [cost setTitle:@"全部免费" forState:UIControlStateNormal];
//        }
//    }
    [cost setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cost addTarget:self action:@selector(costAction:) forControlEvents:UIControlEventTouchUpInside];
    cost.tag = kCostButtonTag;
    [_secondView addSubview:cost];
    [self addLineWithFrame:CGRectMake(cost.left, cost.bottom+5, cost.width, 1) superView:_secondView];
    
    AATextField *average = [[AATextField alloc] initWithFrame:CGRectMake(20, 450/2, kDeviceWidth-40, 30)];
    if (self.activity.avgCost) {
        average.text = [NSString stringWithFormat:@"%ld",(long)[self.activity.avgCost integerValue]];
    }else {
        average.placeholder = @"设置合理的人均费用";
        
    }
    average.selectedDelegate = self;
    average.delegate = self;
    average.tag = kAverageTextTag;
    average.keyboardType = UIKeyboardTypeNumberPad;
    average.textAlignment = NSTextAlignmentCenter;
    average.borderStyle = UITextBorderStyleNone;
    [_secondView addSubview:average];
    [self addLineWithFrame:CGRectMake(average.left, average.bottom+5, average.width, 1) superView:_secondView];
    
    UIButton *secondStep = [[UIButton alloc] initWithFrame:CGRectMake((self.scrollView.width-200)/2, self.scrollView.height-250/2, 200, 40)];
    [secondStep setTitle:@"快要完成咯" forState:UIControlStateNormal];
    [secondStep setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [secondStep addTarget:self action:@selector(secondStepAction:) forControlEvents:UIControlEventTouchUpInside];
    [_secondView addSubview:secondStep];
}

- (void)initThirdView {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 90/2, self.scrollView.width-40, 20)];
    label.text = @"上传漂亮的图才能吸引小伙伴哦";
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:17];
    [_thirdView addSubview:label];
    [self addLineWithFrame:CGRectMake(label.left, label.bottom+5, label.width, 1) superView:_thirdView];
    
    _imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 150/2, _scrollView.width, 300/2)];
    _imageScrollView.contentSize = CGSizeMake(_scrollView.width, _imageScrollView.height*2);
    [_thirdView addSubview:_imageScrollView];
    
    _addButton = [[UIButton alloc] initWithFrame:CGRectMake(70/2, 10, 240/2, 160/2)];
    [_addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_addButton setTitle:@"添加" forState:UIControlStateNormal];
    [_addButton addTarget:self action:@selector(addImageAction:) forControlEvents:UIControlEventTouchUpInside];
    [_imageScrollView addSubview:_addButton];
    
    //存储图片显示位置矩形
    _imageViewArr = [NSMutableArray new];
    _imageRectArr = [NSMutableArray new];
    _imageTag = 0;
    for (int column = 0; column < 3; column++) {
        for (int row = 0; row < 2; row++) {
            CGRect frame = CGRectMake(70/2+(10+kImageWidth)*row, 10+(10+kImageHeight)*column, kImageWidth, kImageHeight);
            [_imageRectArr addObject:[NSValue valueWithCGRect:frame]];
        }
    }
    
    AATextField *detail = [[AATextField alloc] initWithFrame:CGRectMake(20, 450/2, kDeviceWidth-40, 30)];
    if (self.activity.detail) {
        detail.text = self.activity.detail;
    }else {
        detail.placeholder = @"还有什么要嘱咐小伙伴的么？";
        
    }
    detail.selectedDelegate = self;
    detail.delegate = self;
    detail.tag = kDetailTextTag;
    detail.textAlignment = NSTextAlignmentCenter;
    detail.borderStyle = UITextBorderStyleNone;
    [_thirdView addSubview:detail];
    [self addLineWithFrame:CGRectMake(detail.left, detail.bottom+5, detail.width, 1) superView:_thirdView];
    
    UIButton *thirdStep = [[UIButton alloc] initWithFrame:CGRectMake((self.scrollView.width-200)/2, self.scrollView.height-250/2, 200, 40)];
    [thirdStep setTitle:@"等不及啦，这就发布" forState:UIControlStateNormal];
    [thirdStep setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [thirdStep addTarget:self action:@selector(thirdStepAction:) forControlEvents:UIControlEventTouchUpInside];
    [_thirdView addSubview:thirdStep];
}

- (void)initFourthView {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 90/2, self.scrollView.width-40, 80)];
    label.text = @"您的活动申请已发布，小宝正在拼命审核中，稍事休息，审核结果很快到来！";
    label.numberOfLines = 3;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:17];
    [_fourthView addSubview:label];
    
    UIButton *activity = [[UIButton alloc] initWithFrame:CGRectMake((self.scrollView.width-200)/2, self.scrollView.height-390/2, 200, 40)];
    [activity setTitle:@"我的活动" forState:UIControlStateNormal];
    [activity setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [activity addTarget:self action:@selector(mineAction:) forControlEvents:UIControlEventTouchUpInside];
    [_fourthView addSubview:activity];
    
    UIButton *nearby = [[UIButton alloc] initWithFrame:CGRectMake((self.scrollView.width-200)/2, self.scrollView.height-250/2, 200, 40)];
    [nearby setTitle:@"逛逛附近活动" forState:UIControlStateNormal];
    [nearby setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nearby addTarget:self action:@selector(nearbyAction:) forControlEvents:UIControlEventTouchUpInside];
    [_fourthView addSubview:nearby];
}

#pragma mark - Actions
- (void)timeAction:(UIButton *)button {
    if (_timePicker == nil) {
        _timePicker = [[AATimePickerView alloc] initWithFrame:CGRectMake(0, _scrollView.height, _scrollView.width, kTimeCustomHeight) withHour:YES];
        __weak AAStepViewController *this = self;
        __weak UIButton *time = (UIButton *)[_firstView viewWithTag:kTimeButtonTag];
        _timePicker.selectedBlock = ^ (NSInteger year, NSInteger month, NSInteger day, NSInteger hour, NSInteger minIndexppp, AATimePickerView *timePickerView) {
            NSString *date = [NSString stringWithFormat:@"%ld-%02ld-%02ld %02ld:00:00",(long)year,(long)month,(long)day,(long)hour];
            this.activityDate = date;
            NSRange range = NSMakeRange(0, 13);
            
            [time setTitle:[date substringWithRange:range] forState:UIControlStateNormal];
        };
        [self.view addSubview:_timePicker];
    }
    
    [self hideKeyBoardAndPickerExcept:nil];
    
    [_timePicker showPickerView];
}

- (void)addressAction:(UIButton *)button {
//    AAMapViewController *mapVC = [[AAMapViewController alloc] init];
//    mapVC.delegate = self;
//    [self.navigationController pushViewController:mapVC animated:YES];
}

- (void)visibleAction:(UIButton *)button {
    if (_visiblePicker == nil) {
        NSArray *arr = [NSArray arrayWithObjects:@[@"全部可见",@"好友可见",@"私密邀请"], nil];
        _visiblePicker = [[AACreatePickerView alloc] initWithFrame:CGRectMake(0, _scrollView.height, _scrollView.width, kCreatePickerCustomHeight) Component:1 listArr:arr];
        __weak AAStepViewController *this = self;
        __weak UIButton *visible = (UIButton *)[_secondView viewWithTag:kVisibleButtonTag];
        _visiblePicker.selectedBlock = ^ (NSString *text, AACreatePickerView *createPickerView) {
            if ([text isEqualToString:@"全部可见"]) {
                this.showType = AAShowTypePublic;
                [visible setTitle:@"全部可见" forState:UIControlStateNormal];
            }else if ([text isEqualToString:@"好友可见"]) {
                this.showType = AAShowTypeFriend;
                [visible setTitle:@"好友可见" forState:UIControlStateNormal];
            }else if ([text isEqualToString:@"私密邀请"]) {
                this.showType = AAShowTypeSecret;
                [visible setTitle:@"私密邀请" forState:UIControlStateNormal];
            }
        };
        [self.view addSubview:_visiblePicker];
    }
    
    [self hideKeyBoardAndPickerExcept:nil];
    
    [_visiblePicker showPickerView];
}

- (void)costAction:(UIButton *)button {
    if (_costPicker == nil) {
        NSArray *arr = [NSArray arrayWithObjects:@[@"预付费",@"后付费",@"全部免费"],@[@"无",@"女士免费"], nil];
        _costPicker = [[AACreatePickerView alloc] initWithFrame:CGRectMake(0, _scrollView.height, _scrollView.width, kCreatePickerCustomHeight) Component:2 listArr:arr];
        //__weak AAStepViewController *this = self;
        //__weak UIButton *cost = (UIButton *)[_secondView viewWithTag:kCostButtonTag];
        _costPicker.selectedBlock = ^ (NSString *text, AACreatePickerView *createPickerView) {
//            if ([text isEqualToString:@"预付费"]) {
//                this.payType = AAPayTypePrepaid;
//            }else if ([text isEqualToString:@"后付费"]) {
////                this.payType = AAPayTypePostpaid;
//            }else if ([text isEqualToString:@"全部免费"]) {
//                this.payType = AAPayTypeFreeForAll;
//            }else if ([text isEqualToString:@"女士免费"]) {
//                this.femaleFee = AAFemaleFeeFree;
//            }else if ([text isEqualToString:@"无"]) {
//                this.femaleFee = AAFemaleFeePaid;
//            }
//            
//            if (this.femaleFee == AAFemaleFeeFree) {
//                if (this.payType == AAPayTypePrepaid) {
//                    [cost setTitle:@"预付费&女士免费" forState:UIControlStateNormal];
//                }else if (this.payType == AAPayTypePostpaid) {
//                    [cost setTitle:@"后付费&女士免费" forState:UIControlStateNormal];
//                }else if (this.payType == AAPayTypeFreeForAll) {
//                    [cost setTitle:@"全部免费" forState:UIControlStateNormal];
//                }
//            }else if (this.femaleFee == AAFemaleFeePaid) {
//                if (this.payType == AAPayTypePrepaid) {
//                    [cost setTitle:@"预付费" forState:UIControlStateNormal];
//                }else if (this.payType == AAPayTypePostpaid) {
//                    [cost setTitle:@"后付费" forState:UIControlStateNormal];
//                }else if (this.payType == AAPayTypeFreeForAll) {
//                    [cost setTitle:@"全部免费" forState:UIControlStateNormal];
//                }
//            }
        };
        [self.view addSubview:_costPicker];
    }
    
    [self hideKeyBoardAndPickerExcept:nil];
    
    [_costPicker showPickerView];
}

- (void)firstStepAction:(UIButton *)button {
    [self scrollToPage:1];
}

- (void)secondStepAction:(UIButton *)button {
    [self scrollToPage:2];
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

- (void)thirdStepAction:(UIButton *)button {
    if (self.topic.length == 0 || self.capacity == 0 || self.avgCost.length == 0) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请完善创建信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }else {
        [self httpDowload];
        
    }
    [self scrollToPage:3];
}

- (void)mineAction:(UIButton *)button {
    self.listVC.listStyle = L_myList;
    [self.navigationController popToViewController:self.listVC animated:YES];
}

- (void)nearbyAction:(UIButton *)button {
    self.listVC.listStyle = L_nearByList;
    [self.navigationController popToViewController:self.listVC animated:YES];
}

- (IBAction)changePage:(UIPageControl *)sender {
    [self scrollToPage:sender.currentPage];
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe {
    [self scrollToPage:_currentPage-1];
}

//删除图片
- (void)deleteImageAction:(UIButton *)button {
//    NSInteger imageTag = button.tag-kDeleteButtonTag;
//    UIImageView *imageView = [_imageViewArr objectAtIndex:imageTag];
    [_imageViewArr removeObject:button.superview];
    [button.superview removeFromSuperview];
    
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

- (void)leftClicked
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -----------------------------------------------HttpDownLoad
- (void)httpDowload
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak AAStepViewController *this = self;
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
    TActivityManager* _activityM = (TActivityManager*)  [httpOperation getAopInstance:[TActivityManager class] returnValue:[TResultSet class]];
    
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    
    [_activityM createTActivity:userModel.user.t_id category:self.createType activityDate:self.activityDate topic:self.topic destName:self.address destLongitude:self.longitude destLatitude:self.latitude capacity:self.capacity showType:self.showType payType:self.payType femaleFee:self.femaleFee avgCost:self.avgCost detail:self.detail picCount:_imageViewArr.count];
}

-(void)httpLoadComplete:(TResultSet*)r {
    if (r.errCode == 0) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"创建成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
        if (_imageRectArr.count != 0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_group_t group = dispatch_group_create();
            for (int i = 1; i < _imageRectArr.count+1; i++) {
                dispatch_group_async(group, queue, ^{
                    [self sendImage:i activityId:r.resInteger];
                    
                });
            }
            
        }
        
    }else{
        NSLog(@"%@",r.errString);
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"提示" message:r.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
    }
    
}


- (void)sendImage:(NSInteger)count activityId:(NSInteger)actitvityId{
//    QCUserModel *_currUser = [[QCUserManager sharedInstance] getLoginUser];
//    NSString *userName = _currUser.user.username;
//    NSLog(@"userName tt =%@",userName);
    UIImageView *imageView = [_imageViewArr objectAtIndex:count-1];
    NSData *imgData = UIImageJPEGRepresentation(imageView.image, 1);
    NSString *Urlstring=[NSString stringWithFormat:@"%@uploadPhoto.jsp?type=5&id=%ld&pos=%ld",YXB_IP_ADRESS,(long)actitvityId,(long)count];
    NSURL *url = [NSURL URLWithString:[Urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setData:imgData forKey:@"image"];
    //    [request setContentLength:imgData.length];
    //    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d", [imgData length]]];
    //    NSLog(@"imdddd =%d",imgData.length);
    [request setFailedBlock:^{
        NSLog(@"failed");
    }];
    [request setCompletionBlock:^{
        NSLog(@"第%ld张图片上传成功",(long)count);
        
    }];
    [request startAsynchronous];


}

#pragma mark -- actionSheet   delegate
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
    
    NSValue *rectValue = [_imageRectArr objectAtIndex:_imageTag];
    
    
    //添加图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rectValue.CGRectValue];
    imageView.image = image;
    imageView.userInteractionEnabled = YES;
    [_imageScrollView addSubview:imageView];
    [_imageViewArr addObject:imageView];
    
    UIButton *delete = [[UIButton alloc] initWithFrame:CGRectMake(kImageWidth-20, 0, 20, 20)];
//    delete.tag = kDeleteButtonTag+_imageTag;
    [delete setTitle:@"×" forState:UIControlStateNormal];
    [delete setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [delete addTarget:self action:@selector(deleteImageAction:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:delete];
    _imageTag++;
    
    if (_imageTag < 6) {
        NSValue *addButtonRect = [_imageRectArr objectAtIndex:_imageTag];
        _addButton.hidden = NO;
        _addButton.frame = addButtonRect.CGRectValue;
    }else {
        _addButton.hidden = YES;
    }
    
}


#pragma mark - Private Methods
- (void)scrollToPage:(NSInteger)page {
    CGRect frame = _scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    _currentPage = page;
    [_scrollView scrollRectToVisible:frame animated:YES];
}

- (void)addLineWithFrame:(CGRect)frame superView:(UIView *)superView {
    UIView *line = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = [UIColor blackColor];
    [superView addSubview:line];
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    _pageControl.currentPage = page;
    
    [self hideKeyBoardAndPickerExcept:nil];
    
}

#pragma mark - AAMapView delegate
//- (void)AAMapViewLocationDidTouchForTitle:(NSString *)title coordinate:(CLLocationCoordinate2D)coordinate {
//    self.address = title;
//    self.longitude = [NSString stringWithFormat:@"%f",coordinate.longitude];
//    self.latitude = [NSString stringWithFormat:@"%f",coordinate.latitude];
//    
//    UIButton *address = (UIButton *)[_firstView viewWithTag:kAddressButtonTag];
//    [address setTitle:title forState:UIControlStateNormal];
//    
//}
//- (void)annotationViewForBubbleDidTouchForTitle:(NSString *)title coordinate:(CLLocationCoordinate2D)coordinate {
//    self.address = title;
//    self.longitude = [NSString stringWithFormat:@"%f",coordinate.longitude];
//    self.latitude = [NSString stringWithFormat:@"%f",coordinate.latitude];
//    
//    UIButton *address = (UIButton *)[_firstView viewWithTag:kAddressButtonTag];
//    [address setTitle:title forState:UIControlStateNormal];
//}

#pragma mark - UITextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self hideKeyBoardAndPickerExcept:textField];
    return YES;
    
}

#pragma mark - QCBaseTextField delegate
- (void)baseTextFieldSureButtonDidselected:(QCBaseTextField *)textField {
    if (textField.tag == kThemeTextTag) {
        self.topic = textField.text;
    }else if (textField.tag == kLimitTextTag) {
        self.capacity = [textField.text integerValue];
    }else if (textField.tag == kAverageTextTag) {
        self.avgCost = textField.text;
    }else if (textField.tag == kDetailTextTag) {
        self.detail = textField.text;
    }
}

//隐藏键盘和选择器
- (void)hideKeyBoardAndPickerExcept:(UITextField *)textField {
    for (int i = 0; i<4; i++) {
        UITextField *otherTextField = (UITextField *)[_scrollView viewWithTag:(kThemeTextTag+i)];
        if (![otherTextField isEqual:textField]) {
            [otherTextField resignFirstResponder];
        }
    }
    
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
