//
//  QCBorrowManageViewController.m
//  YOUXINBAO
//
//  Created by Walice on 15/6/30.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBorrowManageViewController.h"
#import "BorrowManageCell.h"
#import "AAManager.h"
#import "AALoanUserMemberInfo.h"
#import "UIImageView+WebCache.h"
#import "AAReceiptViewController.h"

#define MessageCenterPageNOStart 1

@interface QCBorrowManageViewController ()

@end

@implementation QCBorrowManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    [self setTitle:@"借条管理"];
    [self createUI];
}

- (void)createUI{
    self.dataArray=[NSMutableArray array];
    
    _tableView = [[QCBaseTableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64) style:UITableViewStyleGrouped refreshFooter:YES];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.refreshDelegate = self;
    
    [self.view addSubview:_tableView];
   
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 80)];
    _tableView.tableHeaderView=view;
    
    _textLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, kDeviceWidth, 40)];
    _textLabel.font=[UIFont systemFontOfSize:20];
    _textLabel.textColor=rgb(48, 48, 48, 1);
    [view addSubview:_textLabel];
    
    _perLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 45, 150, 40)];
    _perLabel.textColor=rgb(120, 120, 120, 1);
    [view addSubview:_perLabel];
   _allLabel=[[UILabel alloc]initWithFrame:CGRectMake(_perLabel.right+5, 45, 60, 40)];
    _allLabel.textColor=rgb(120, 120, 120, 1);
    [view addSubview:_allLabel];
    _payLabel=[[UILabel alloc]initWithFrame:CGRectMake(_allLabel.right+5, 45, kDeviceWidth-_allLabel.width-_perLabel.width, 40)];
    _payLabel.textColor=rgb(120, 120, 120, 1);
    [view addSubview:_payLabel];
    

    
}



#pragma mark -----------------------------------------------HttpDownLoad

- (void)httpDowloadWithListStyle
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak QCBorrowManageViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:this cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterView show];
            [this.tableView reloadDeals];
        }
        
    } param:^(NSString *s) {
    
        [this httpLoadParams:assginHtttperator];
    } complete:^(AALoanDetail * r, int taskid) {

        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
}
- (void)httpLoadParams:(HttpOperator *)assginHtttperator{
    AAManager *_activityM = (AAManager *)[assginHtttperator getAopInstance:[AAManager class] returnValue:[AALoanDetail class]];
    
    
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    
    //        if (style == L_myList) {
    NSString *userToken = userModel.user.yxbToken;
    if ((userToken != nil) && [userToken length] > 0)
    {
        
        
        [_activityM getAALoanDetail:userToken AALoanID:self.AALoanId];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您尚未登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    

}
- (void)httpLoadComplete:(AALoanDetail *)r{
    
    self.textLabel.text=[NSString stringWithFormat:@"%@",r.title];
    self.textLabel.font=[UIFont systemFontOfSize:17];
    
    self.perLabel.text=[NSString stringWithFormat:@"每人收款:%@",r.money];
    self.perLabel.font=[UIFont systemFontOfSize:14];
    NSRange range1=[self.perLabel.text rangeOfString:[NSString stringWithFormat:@"%@",r.money]];
    NSMutableAttributedString *aText=[[NSMutableAttributedString alloc]initWithString:self.perLabel.text];
    [aText addAttribute:NSForegroundColorAttributeName value:rgb(221, 11, 12, 1) range:range1];
    self.perLabel.attributedText=aText;
    
    
    self.allLabel.text=[NSString stringWithFormat:@"共%ld人",(long)r.sumPeople];
    self.allLabel.font=[UIFont systemFontOfSize:14];
    NSRange range2=[self.allLabel.text rangeOfString:[NSString stringWithFormat:@"%ld",(long)r.sumPeople]];
    NSMutableAttributedString *aText1=[[NSMutableAttributedString alloc]initWithString:self.allLabel.text];
    [aText1 addAttribute:NSForegroundColorAttributeName value:rgb(0,0,0, 1) range:range2];
    self.allLabel.attributedText=aText1;
    
    
    self.payLabel.text=[NSString stringWithFormat:@"%ld人已还款",(long)r.alreadyPayPeople];
    self.payLabel.font=[UIFont systemFontOfSize:14];;
    
    
    if (r.iAALoanUserMemberInfo.count != 0 && r.iAALoanUserMemberInfo.count%20 == 0) {
        self.tableView.hasFooter = YES;
    }else {
        //数据加载不足一页的时候,将加载更多取消掉
        self.tableView.hasFooter = NO;
    }
    self.detail=r;
    [self.tableView reloadDeals];
    //如果刷新的是第一页,则需要将之前刷新的移除掉,不然第一页的数据会反复出现
    if (page==MessageCenterPageNOStart) {
        [self.dataArray removeAllObjects];
    }
    [self.dataArray addObjectsFromArray:_detail.iAALoanUserMemberInfo];
    [self.tableView reloadData];


}


#pragma mark  --------------------------- refresh
//下拉刷新
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    page = MessageCenterPageNOStart;
    [self httpDowloadWithListStyle];
}
//加载更多
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float h = scrollView.contentOffset.y + scrollView.height - scrollView.contentSize.height;
    if (h > 30 && !self.tableView.isRefresh && self.tableView.hasFooter == YES) {
        if (_dataArray.count%20==0) {
            page ++;
            [self httpDowloadWithListStyle];
        }else {
            
        }
    }
    
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"cell";
    BorrowManageCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[BorrowManageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    AALoanUserMemberInfo *model=_detail.iAALoanUserMemberInfo[indexPath.row];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"useimg"]];
    cell.nameLabel.text=model.nickName;
    cell.timeLabel.text=model.time;
    if (model.stateOfAmount==1) {
        cell.stateLabel.text=@"已还款";
        cell.stateLabel.textColor=rgb(59, 179, 115, 1);
    }else if (model.stateOfAmount==5)
    {
        cell.stateLabel.text=@"已关闭";
        cell.stateLabel.textColor=rgb(222, 13, 9, 1);

    }
    else{
        cell.stateLabel.text=@"未还款";
        cell.stateLabel.textColor=rgb(222, 13, 9, 1);
    
    }
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 15;
    }
    else{
    
        return 0;
    }
    
  
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = rgb(238, 236, 246, 1.0);
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AALoanUserMemberInfo *model=_detail.iAALoanUserMemberInfo[indexPath.row];
    AAReceiptViewController *receipt = [[AAReceiptViewController alloc] init];
    receipt.loanId = model.loanID;
    [self.navigationController pushViewController:receipt animated:YES];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self httpDowloadWithListStyle];

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
