//
//  LoanDetailsNewViewController.m
//  YOUXINBAO
//
//  Created by Feili on 15/7/27.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanDetailsNewViewController.h"
#import "DetailsFooterView.h"
#import "LoanDetailCell.h"
#import "LoanDetailShiJianCell.h"
#import "LoanDetailShiChangCell.h"
#import "LoanDetailLiXiCell.h"
#import "LoanDetailLiXiDetailCell.h"
#import "LoanDetailHuanKuanCell.h"

#define LoanDetailsNewViewControllerBottomHeight 50

@interface LoanDetailsNewViewController ()<UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate,DetailsFooterViewDelegate,LoanDetailValueChangedDelegate,SliderViewDelegate,HeaderViewDelegate>
{
    DetailsFooterView *_bottomView;
}

@property(nonatomic, strong)QCBaseTableView *tableView;
@property(nonatomic, strong)NSMutableArray  *cellHeightArray;
@end

@implementation LoanDetailsNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackView];
    [self setTitle:@"借款详情"];
    [self addGesture];
    [self createViews];
    [self loadDefaultData];

    [self.tableView reloadDeals];
}

-(void)addGesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myEndEditting)];
    [self.view addGestureRecognizer:tap];
}

-(void)myEndEditting
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)loadDefaultData
{
    //判断是否是新创建的借款
    if (_loan == nil) {
        _loan = [[Loan alloc]init];
        _loan.interestType = LoanInterestTypePost; //默认后息
        _loan.repayType = LoanRepayTypeMoneyFull; //0---全额  1----分期
        _loan.expectBorrowDate = [AATimePickerView getCurrentTime];
        _loan.loanPeriod = LoanPeriod_WEEK_1; //默认一周
        _loan.interestType = FREE; //默认无息
        _loan.useBankRate = 0; //0——>不使用银行利率  1——>使用银行利率
//        _loan.loanInterestCalculateType = LoanInterestCalculateTypeNone;//默认无息
    }
    else
    {
        //查看借款详情
    }
    
    //设置各个cell的高度
    self.cellHeightArray = [NSMutableArray arrayWithObjects:@"50",@"50",@"100",@"50",@"160",@"50",@"0", nil];
}

-(void)createViews
{
    //创建底部点击按钮
    [self createBottomView];
    [self createMyTableView];
}

-(void)createMyTableView
{
    CGFloat x = 0, y = 0, w = kDeviceWidth, h = kDeviceHeight - _bottomView.height;
    self.tableView = [[QCBaseTableView alloc] initWithFrame:CGRectMake(x, y, w, h) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    if (_loan != nil) {
        _tableView.refreshDelegate = self;

//    }
    
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
}

-(void)createBottomView
{
    
    CGFloat x = 0 , h = LoanDetailsNewViewControllerBottomHeight ,y = kDeviceHeight - h, w = kDeviceWidth;
    _bottomView = [[DetailsFooterView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    _bottomView.delegate = self;
}

#pragma mark  底部按钮回调
- (void)footerViewbuttonActionWithSender:(UIButton *)sender
{
    [ProgressHUD showSuccessWithStatus:sender.titleLabel.text];
}

#pragma uitableviewDelegate & datasource &refreshDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_cellHeightArray count];
//    return 4;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_cellHeightArray[indexPath.row] floatValue];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) this = self;
    //借款金额
    if (indexPath.row == LoanDetailCellTypeJinE)
    {
        static NSString *firstCell = @"firstCell";
        LoanDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:firstCell];
        if (cell == nil) {
            cell = [[LoanDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textfieldEndBlock = ^(NSString *text){
                
                this.loan.money = text;
            };

        }
        LoginModel *model = [[LoginModel alloc] init];
        model.titleName = @"借款金额";
        model.text = _loan.money;
        cell.model = model;
        return cell;

    }else if (indexPath.row == LoanDetailCellTypeShiJian)
    {
        static NSString *firstCell = @"shijianCell";
        LoanDetailShiJianCell *cell = [tableView dequeueReusableCellWithIdentifier:firstCell];
        if (cell == nil) {
            cell = [[LoanDetailShiJianCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        cell.delegate = self;
        LoginModel *model = [[LoginModel alloc] init];
        model.titleName = @"用款时间";
        model.text = _loan.expectBorrowDate;
        cell.model = model;
        cell.loan = self.loan;
        return cell;

        
    }else if (indexPath.row == LoanDetailCellTypeShiChang)
    {
        static NSString *firstCell = @"shichangCell";
        LoanDetailShiChangCell *cell = [tableView dequeueReusableCellWithIdentifier:firstCell];
        if (cell == nil) {
            cell = [[LoanDetailShiChangCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        cell.delegate = self;
        LoginModel *model = [[LoginModel alloc] init];
        model.titleName = @"借款时长";
        model.text = [Loan getLoanPeriodWith:_loan.loanPeriod];
        cell.model = model;
        return cell;

        
    }else if (indexPath.row == LoanDetailCellTypeLiXi)
    {
        static NSString *firstCell = @"lixiCell";
        LoanDetailLiXiCell *cell = [tableView dequeueReusableCellWithIdentifier:firstCell];
        if (cell == nil) {
            cell = [[LoanDetailLiXiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        cell.delegate = self;
        cell.updateDelegate = self;
        LoginModel *model = [[LoginModel alloc] init];
        model.titleName = @"利息";
        model.text = _loan.expectBorrowDate;
        cell.model = model;
        cell.loan = self.loan;
        return cell;

        
    }else if (indexPath.row == LoanDetailCellTypeLiXiDetail)
    {
        static NSString *firstCell = @"lixiDetailCell";
        LoanDetailLiXiDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:firstCell];
        if (cell == nil) {
            cell = [[LoanDetailLiXiDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.clipsToBounds = YES;
        }
        cell.delegate = self;
        LoginModel *model = [[LoginModel alloc] init];
        model.titleName = @"";
        model.text = _loan.expectBorrowDate;
        cell.loan = self.loan;
        return cell;

        
    }else if (indexPath.row == LoanDetailCellTypeHuanKuanFangShi)
    {
        static NSString *firstCell = @"huankuanCell";
        LoanDetailHuanKuanCell *cell = [tableView dequeueReusableCellWithIdentifier:firstCell];
        if (cell == nil) {
            cell = [[LoanDetailHuanKuanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        cell.delegate = self;
        LoginModel *model = [[LoginModel alloc] init];
        model.titleName = @"";
        model.text = _loan.expectBorrowDate;
        //        cell.model = model;
        return cell;

        
    }else if (indexPath.row == LoanDetailCellTypeHuanKuanDetail)
    {
        static NSString *firstCell = @"huankuanCell";
        LoanDetailHuanKuanCell *cell = [tableView dequeueReusableCellWithIdentifier:firstCell];
        if (cell == nil) {
            cell = [[LoanDetailHuanKuanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        cell.delegate = self;
        LoginModel *model = [[LoginModel alloc] init];
        model.titleName = @"";
        model.text = _loan.expectBorrowDate;
        //        cell.model = model;
        return cell;

        
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView
{
    [tableView reloadDeals];
}

#pragma -mark CellDelegate
-(void)updateLoanDetailWithLoan:(id)loan
{
    self.loan = loan;
    /*
    if (_loan.loanInterestCalculateType == LoanInterestCalculateTypeNone) {
        
        _cellHeightArray[LoanDetailCellTypeLiXiDetail] = @"0";
    }
    else
    {
        _cellHeightArray[LoanDetailCellTypeLiXiDetail] = @"160";
    }
    
    */
    [_tableView reloadData];
    
}
#pragma -mark shichangDelegate
#pragma mark  滑竿delegateAction
- (void)changesValue:(LoanPeriod)loanPeriod
{//滑动时
    
    self.loan.loanPeriod = loanPeriod;
    [_tableView reloadData];

    
}

- (void)sliderFinsh:(LoanPeriod)loanPeriod
{//滑动结束
    
    self.loan.loanPeriod = loanPeriod;
    [_tableView reloadData];
}

#pragma -mark lixi选择
-(void)headerViewSelectedIndex:(NSInteger)index
{
    [ProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%ld",(long)index]];
}



@end
