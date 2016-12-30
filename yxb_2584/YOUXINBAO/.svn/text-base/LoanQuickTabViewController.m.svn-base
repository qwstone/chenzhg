//
//  LoanQuickTabViewController.m
//  YOUXINBAO
//
//  Created by Feili on 15/7/2.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanQuickTabViewController.h"
#import "LoanDetailsViewController.h"
#import "QClendToViewController.h"
#define LoanQuickListLeftLeft 15

@interface LoanQuickTabViewController ()
{
    UISegmentedControl *_segmentControl;
    UIScrollView *_scrollView;
}

@property (nonatomic,strong)LoanDetailsViewController *loanDetailVC;
@property (nonatomic,strong)QClendToViewController *quickVC;
@end

@implementation LoanQuickTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackView];
    [self setTitle:@"向好友借出"];
    //添加顶部选择栏
    [self initTopSegmentControl];
    [self loadScrollView];
    _segmentControl.selectedSegmentIndex = 0;
    _scrollView.contentOffset = CGPointMake(0, 0);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initTopSegmentControl
{
    _segmentControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"闪电无息",@"高级借出", nil]];
    _segmentControl.frame = CGRectMake(LoanQuickListLeftLeft, LoanQuickListLeftLeft, kDeviceWidth-2*LoanQuickListLeftLeft, 40);
    _segmentControl.selectedSegmentIndex = 0;
    _segmentControl.layer.cornerRadius = 5.0;
    _segmentControl.backgroundColor = [UIColor whiteColor];
    _segmentControl.tintColor = rgb(221, 101, 115, 1.0);
    [_segmentControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"SnellRoundhand-Bold" size:16],NSFontAttributeName ,nil];
    
    [_segmentControl setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    [self.view addSubview:_segmentControl];
    
    
    
}

-(void)loadScrollView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _segmentControl.bottom, kDeviceWidth, kDeviceHeight - 64 - _segmentControl.bottom)];
    _scrollView.scrollEnabled = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(2 * kDeviceWidth, _scrollView.height);
    [self.view addSubview:_scrollView];
    
    self.loanDetailVC = [[LoanDetailsViewController alloc] init];
    self.loanDetailVC.isShowVedioCertifict = NO;
    if (_lendMyFriend != nil) {
        _loanDetailVC.lendMyFriend = _lendMyFriend;
        
    }
    _loanDetailVC.bOrL = BorrowerORLendersQuickLend;
    _loanDetailVC.segmentHeight = _segmentControl.bottom;
    _loanDetailVC.view.frame = CGRectMake(kDeviceWidth, 0, kDeviceWidth, _scrollView.height);
    [_scrollView addSubview:_loanDetailVC.view];
    
    self.quickVC = [[QClendToViewController alloc] init];
    _quickVC.friendID = _friendID;
    _quickVC.view.frame = CGRectMake(0, 0, kDeviceWidth, _scrollView.height);
    [_scrollView addSubview:_quickVC.view];

}


//事件
-(void)segmentAction:(UISegmentedControl *)Seg
{
    [self.view endEditing:YES];
    NSInteger index = Seg.selectedSegmentIndex;
    if (index == 1) {
        _scrollView.contentOffset = CGPointMake(kDeviceWidth, 0);
    }
    else
    {
        _scrollView.contentOffset = CGPointMake(0, 0);

    }
}

@end
