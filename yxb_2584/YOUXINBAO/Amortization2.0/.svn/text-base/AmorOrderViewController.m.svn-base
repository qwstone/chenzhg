//
//  AmorOrderViewController.m
//  YOUXINBAO
//
//  Created by Feili on 15/9/15.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AmorOrderViewController.h"
#import "PayScrollView.h"
#import "GuaranteeStages.h"

@interface AmorOrderViewController ()

@property (nonatomic,strong)PayScrollView *payScrollView;
@end

@implementation AmorOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadCustomViews];
    
    // Do any additional setup after loading the view.
}

-(void)loadCustomViews
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 7; i ++) {
        GuaranteeStages *model = [[GuaranteeStages alloc] init];
        model.shouldPayTime = @"--.--";
        model.actualPayTime = @"--.--";
        model.payMoney = @"--.--";
        model.hasOverdue = @"0";
        model.hasPayCompleted = @"0";
        [array addObject:model];
    }
    
    
    CGFloat x = 0,y = 100, w = kDeviceWidth, h = 140;
    self.payScrollView = [[PayScrollView alloc] initWithFrame:CGRectMake(x, y, w, h) array:array];
    _payScrollView.modelArray = array;
    [self.view addSubview:_payScrollView];
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
