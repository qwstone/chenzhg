//
//  QCSelectRefundViewController.m
//  YOUXINBAO
//
//  Created by zjp on 15/6/19.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCSelectRefundViewController.h"
#import "QCSelectRefunCell.h"
#import "YXBTool.h"
#import "QCAACollectMoneyController.h"

#define UISegmentedControlKongxi    15
@interface QCSelectRefundViewController ()<UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate>{
    UIView     * _botView;
}
@property(nonatomic,strong)NSMutableArray *contacts;
@end

@implementation QCSelectRefundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    


    [self createView];
    
    [self createBottomView];
}


- (void)createBottomView {
    _botView = [[UIView alloc] initWithFrame:CGRectMake(0, kDeviceHeight-kDeviceWidth/320*50-64, kDeviceWidth, kDeviceWidth/320*50)];
    [self.view addSubview:_botView];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth/320*50)];
    [button addTarget:self action:@selector(bottomAction) forControlEvents:UIControlEventTouchUpInside];
    if ([self.state isEqualToString:@"退款"]) {
        [button setBackgroundImage:[UIImage imageNamed:@"AA-tuikbut"] forState:UIControlStateNormal];
        [_botView addSubview:button];
    }else if ([self.state isEqualToString:@"收款"]){
        //    //毛玻璃
        button.frame = CGRectMake(0, 0, kDeviceWidth, kDeviceWidth/320*50);
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
        effectview.frame = CGRectMake(0, 0, kDeviceWidth, kDeviceWidth/320*50);
        effectview.alpha = 0.8;
        effectview.userInteractionEnabled = YES;
        [_botView addSubview:effectview];
        [button setBackgroundColor:rgb(255, 255, 255, 0.6)];
//        [button setBackgroundColor:[UIColor clearColor]];
        [button setTitle:@"收  款" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        //
        [_botView addSubview:button];
    }


}

- (void)bottomAction {
    NSLog(@"退款");
    if (self.useridArr.count > 0 || self.useridArr != nil) {
        [self.useridArr removeAllObjects];
    }
    for (int i = 0; i < self.contacts.count; i++) {
        NSMutableDictionary *dic = self.contacts[i];
        if ([dic[@"checked"] isEqualToString:@"YES"]) {
            ActivityMember *data = self.participants[i];
            [self.useridArr addObject:[NSString stringWithFormat:@"%ld",(long)data.userId]];
        }
    }
    if (self.useridArr.count > 20 ) {
        //            [YXBTool showAlertViewWithString:[NSString stringWithFormat:@"请选择%ld个好友",(long)self.isAAshoukuanNumeber]];
        [ProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"最多选择选择20人"]];
        return;
    }else if (self.useridArr.count < 1){
        [ProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"最少选择选择1人"]];
        
        return;
    }
//    if (self.useridArr.count == 1) {
//        ActivityMember *data = self.participants[0];
//        if ([self.useridArr[0] integerValue] == data.userId) {
//            if ([self.state isEqualToString:@"收款"]) {
//                [ProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"最少向除自己以外的一个好友收款"]];
//            }else {
//                [ProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"最少向除自己以外的一个好友退款"]];
//            }
//            return;
//        }
//    }
//    if (self.useridArr.count < 2 || self.useridArr.count > 20) {
//        [YXBTool showAlertViewWithString:@"选择用户应在2-20人之间"];
//        return;
//    }
    QCAACollectMoneyController *aactrl=[[QCAACollectMoneyController alloc]init];
    aactrl.useridArray=self.useridArr;
    aactrl.activity = _activity;
    aactrl.abctitle=self.titltext;
    aactrl.state = self.state;
    aactrl.activityId = self.activityId;
    [self.navigationController pushViewController:aactrl animated:YES];

    NSLog(@"%@",self.useridArr);

}
- (void)createView {
    [self setBackView];
//    [self setTitle:self.titltext];
     self.contacts = [NSMutableArray array];
    self.useridArr = [NSMutableArray array];
//    [self.participants removeObjectAtIndex:0];
//    for (ActivityMember *data in self.participants) {
//        if (data.type == 1) {
//            [self.participants removeObject:data];
//        }
//    }

    for (int i = 0; i < self.participants.count; i++) {
        ActivityMember *data = self.participants[i];
        if (data.type == M_CREATED) {
            [self.participants removeObjectAtIndex:i];
        }
    }

    for (int i = 0; i <self.participants.count; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:@"YES" forKey:@"checked"];
        [self.contacts addObject:dic];
    }
    self.view.backgroundColor = rgb(238, 236, 246, 1.0);
    NSArray *arr = [[NSArray alloc]initWithObjects:@"全部",@"已签到",@"自定义", nil];
    self.segment = [[UISegmentedControl alloc]initWithItems:arr];
    [self.segment setTintColor:rgb(231, 27, 27, 1)];
    self.segment.backgroundColor = [UIColor whiteColor];
    self.segment.layer.cornerRadius = 5.0;
    self.segment.frame = CGRectMake(10, UISegmentedControlKongxi, kDeviceWidth-20, 40);
    self.segment.selectedSegmentIndex = 0;
    [self.segment addTarget:self action:@selector(segmentchange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segment];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0+self.segment.bottom+UISegmentedControlKongxi, kDeviceWidth, kDeviceHeight-64-self.segment.bottom-UISegmentedControlKongxi) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];

}
#pragma mark --- segmentchangedelegate
-(void)segmentchange:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    NSLog(@"Index %ld", (long)Index);
    switch (Index) {
        case 0:
            [self allSelect];
            break;
        case 1:
            [self qiandaoSelect];
            break;
        case 2:
            [self zidingyiSelect];
            break;
    }
}

- (void)zidingyiSelect {
    NSArray *anArrayOfIndexPath = [NSArray arrayWithArray:[_tableView indexPathsForVisibleRows]];
    for (int i = 0; i < [anArrayOfIndexPath count]; i++) {
        NSIndexPath *indexPath= [anArrayOfIndexPath objectAtIndex:i];
        QCSelectRefunCell *cell = (QCSelectRefunCell*)[_tableView cellForRowAtIndexPath:indexPath];
        NSUInteger row = [indexPath row];
        NSMutableDictionary *dic = [self.contacts objectAtIndex:row];
        [dic setObject:@"NO" forKey:@"checked"];
        [cell setChecked:NO];
        ActivityMember *data = self.participants[i];
        if (data.type == 1) {
            [dic setValue:@"YES" forKey:@"checked"];
            [cell setChecked:YES];
        }
    }
//    for (int i = 0; i < self.participants.count; i++) {
//         NSMutableDictionary *dic = [self.contacts objectAtIndex:i];
//        [dic setValue:@"NO" forKey:@"checked"];
//    }
    for (NSDictionary *dic in self.contacts) {
        [dic setValue:@"NO" forKey:@"checked"];
    }
    [_tableView reloadData];
}
- (void)qiandaoSelect {
    NSArray *anArrayOfIndexPath = [NSArray arrayWithArray:[_tableView indexPathsForVisibleRows]];
    for (int i = 0; i < [anArrayOfIndexPath count]; i++) {
        NSIndexPath *indexPath= [anArrayOfIndexPath objectAtIndex:i];
        QCSelectRefunCell *cell = (QCSelectRefunCell*)[_tableView cellForRowAtIndexPath:indexPath];
        NSUInteger row = [indexPath row];
        NSMutableDictionary *dic = [self.contacts objectAtIndex:row];
        ActivityMember *data = self.participants[i];
        if (data.type == 4 || data.type == 1) {
            [dic setValue:@"YES" forKey:@"checked"];
        }else {
            [dic setValue:@"NO" forKey:@"checked"];
        }
        [cell setChecked:YES];
    }
    for (int i = 0; i <self.participants.count; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        ActivityMember *data = self.participants[i];
        if (data.type == 4 || data.type == 1) {
            [dic setValue:@"YES" forKey:@"checked"];
        }else {
            [dic setValue:@"NO" forKey:@"checked"];
        }
    }
     [_tableView reloadData];
}

- (void)allSelect {
    NSArray *anArrayOfIndexPath = [NSArray arrayWithArray:[_tableView indexPathsForVisibleRows]];
    for (int i = 0; i < [anArrayOfIndexPath count]; i++) {
        NSIndexPath *indexPath= [anArrayOfIndexPath objectAtIndex:i];
        QCSelectRefunCell *cell = (QCSelectRefunCell*)[_tableView cellForRowAtIndexPath:indexPath];
        NSUInteger row = [indexPath row];
        NSMutableDictionary *dic = [self.contacts objectAtIndex:row];
        [dic setObject:@"YES" forKey:@"checked"];
        [cell setChecked:YES];
    }
    for (NSDictionary *dic in self.contacts) {
        [dic setValue:@"YES" forKey:@"checked"];
    }
    [_tableView reloadData];
}


#pragma mark - UIScrollView delegate
//滑动时，不断的调用此协议方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"Y坐标的偏移量：%f",scrollView.contentOffset.y);
////    NSLog(@"X坐标的偏移量：%f",scrollView.contentOffset.x);

//    if (scrollView.contentOffset.y>scrollView.frame.size.height) {
//        _tableView.height = kDeviceHeight-64-self.segment.bottom - kDeviceWidth/320*50-10;
//    }else {
//        _tableView.height = kDeviceHeight-64-self.segment.bottom;
//    }
    CGPoint contentOffsetPoint = scrollView.contentOffset;
    CGRect frame = scrollView.frame;
    if (contentOffsetPoint.y < 0) {
        [UIView animateWithDuration:0.3 animations:^{
            _botView.transform = CGAffineTransformIdentity;
        }];
    }else if (contentOffsetPoint.y == 0){
    }else {
    
        if (contentOffsetPoint.y >= scrollView.contentSize.height - frame.size.height){
            if (scrollView.contentSize.height > frame.size.height-kDeviceWidth/320*50) {
                [UIView animateWithDuration:0.3 animations:^{
                    _botView.transform = CGAffineTransformMakeTranslation(0, kDeviceWidth/320*50);
                }];
            }

        }else {
            [UIView animateWithDuration:0.3 animations:^{
                _botView.transform = CGAffineTransformIdentity;
            }];
        }
    }
//    NSLog(@"X坐标的偏移量：%f",scrollView.contentSize.height);
//    NSLog(@"z坐标的偏移量：%f", frame.size.height);
//    NSLog(@"y坐标的偏移量：%f",contentOffsetPoint.y);
}


#pragma mark --- tableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *View = [[UIView alloc] init];
    View.backgroundColor = [UIColor whiteColor];
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(10, 12, (kDeviceWidth-120)/2, 1)];
    UIView *topView1 = [[UIView alloc] initWithFrame:CGRectMake( (kDeviceWidth-120)/2+10+100, 12,  (kDeviceWidth-120)/2, 1)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((kDeviceWidth-120)/2+10, 0, 100, 25)];
    label.textColor =rgb(150, 150, 150, 1);
    topView.backgroundColor = rgb(230, 230, 230, 1);
    topView1.backgroundColor = rgb(230, 230, 230, 1);
    label.text = @"参与名单";
    label.textAlignment = NSTextAlignmentCenter;
    [View addSubview:topView1];
    [View addSubview:topView];
    [View addSubview:label];
    return View;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 25;
}

#pragma mark --- tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 65;
    
}

//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
//{
//
//    return 100;
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _participants.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID  =@"cellID";
    QCSelectRefunCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == Nil) {
        cell = [[QCSelectRefunCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    NSUInteger row = [indexPath row];
    NSMutableDictionary *dic = [self.contacts objectAtIndex:row];
    if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {
        [dic setObject:@"NO" forKey:@"checked"];
        [cell setChecked:NO];
        
    }else {
        [dic setObject:@"YES" forKey:@"checked"];
        [cell setChecked:YES];
    }
    cell.model = self.participants[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    ActivityMember *data = self.participants[indexPath.row];
    QCSelectRefunCell *cell = (QCSelectRefunCell*)[tableView cellForRowAtIndexPath:indexPath];
    NSUInteger row = [indexPath row];
    NSMutableDictionary *dic = [self.contacts objectAtIndex:row];
    if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {
        [dic setObject:@"YES" forKey:@"checked"];
        [cell setChecked:YES];
    }else {
        [dic setObject:@"NO" forKey:@"checked"];
        [cell setChecked:NO];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

//- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}
//-(BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
//{
//       return YES;
//}
@end
