//
//  MergeViewController.m
//  YOUXINBAO
//
//  Created by pro on 2016/12/12.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "MergeViewController.h"
#import "OverdueLoanData.h"
#import "OverdueManager.h"
#import "MergeCell.h"
#import "MyLoanViewController.h"
#import "Payment_payLawsuit.h"

@interface MergeViewController ()<UITableViewDelegate,UITableViewDataSource,QCBaseTableViewDelegate>

@property (retain, nonatomic) HttpOperator  *   iHttpOperator;
@property (weak, nonatomic) QCBaseTableView *   MergeTable;

/**
 数据
 */
@property (strong, nonatomic) NSMutableArray*   dataArray;



/**
 底部申请按钮
 */
@property (weak, nonatomic) UIButton        *   ApplicationBtn;



/**
 记录选中框
 */
@property (nonatomic, assign) NSInteger previousSelectIndex;
@property (nonatomic, assign) NSInteger currentSelectIndex;
@property (nonatomic, strong) NSMutableArray * selectArray;//保存选中按钮tag
@property (nonatomic, strong) NSMutableArray * unselectArray;//保存从选中状态更改为非选中状态的index
@property (nonatomic, strong) NSMutableArray * moneyArray;//保存选中行数的金额
@property (nonatomic, assign) NSInteger sumMoney;//总金额

@end

@implementation MergeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    [self setTitle:@"法院诉讼申请"];
}


- (void)viewWillAppear:(BOOL)animated{
    self.dataArray =   [NSMutableArray array];
    self.selectArray = [NSMutableArray array];
    self.unselectArray = [NSMutableArray array];
    self.moneyArray= [NSMutableArray array];
    [super viewWillAppear:animated];
    [self httpRequestLigationCenter];

}


-(void)initUI{
    [self setBackView];
    self.view.backgroundColor = rgb(233, 233, 233, 1);
    [self createTableView];
}




/**
 初始化Tableview
 */
-(void)createTableView{
    
    //诉讼列表
    QCBaseTableView *tableView = [[QCBaseTableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64 - kDeviceWidth/640*121) style:UITableViewStylePlain refreshFooter:YES];
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _MergeTable.clipsToBounds = YES;
    
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.refreshDelegate = self;
    
    [self.view addSubview:tableView];
    self.MergeTable = tableView;
    
    //底部申请按钮
    UIButton * tApplicationBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, tableView.bottom+1, kDeviceWidth, kDeviceWidth/640*121)];
    [tApplicationBtn setBackgroundImage:[UIImage imageNamed:@"CuiShouBtn"] forState:UIControlStateNormal];
    [tApplicationBtn addTarget:self action:@selector(ApplicationBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tApplicationBtn];
    self.ApplicationBtn = tApplicationBtn;
}



#pragma mark - 数据请求
-(void)httpRequestLigationCenter{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
    }
    [self.iHttpOperator cancel];
    __block HttpOperator * assginHtttperator = _iHttpOperator;
    __block MergeViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
        [this stopDefaultAnimation];
        
        //        [this layoutDefaultAnimation];
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        if (error == EHttp_Operator_Failed) {
            [ProgressHUD showErrorWithStatus:@"加载失败,请检查手机网络"];
            [this.MergeTable reloadDeals];
        }
        
    } param:^(NSString *s) {
        OverdueManager *overduemanager = (OverdueManager*)[assginHtttperator getAopInstance:[OverdueManager class] returnValue:[NSSkyArray class]];
        [overduemanager getLawsuitMerge:[YXBTool getUserToken] loanID:_loanId];
        
        
    } complete:^(NSSkyArray *r, int taskid){
        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
}

-(void)httpLoadComplete:(NSSkyArray *)r{
    [self.MergeTable reloadDeals];
    if (r.errCode == 0) {
        //发送成功
        if (r.iArray.count>0) {
            [self.dataArray addObjectsFromArray:r.iArray];
        }
        
    }else{
        //        [self.dataArray removeAllObjects];
        //        [ProgressHUD showErrorWithStatus:r.errString];
    }
    
    [self.MergeTable reloadData];
}
#pragma mark - QCBaseTableViewDelegate
//下拉加载
-(void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView{
    [_dataArray removeAllObjects];
    _MergeTable.tableFooterView = nil;
    [self httpRequestLigationCenter];
}
#pragma mark - UITableViewDataSource


//header height
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1f;
}

//foot  height
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 40;
    }else{
        return 0.1f;
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 40)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [YXBTool colorWithHexString:@"#adadad"];
        label.backgroundColor = [YXBTool colorWithHexString:@"#ededed"];
        label.text = @"- 该借条可以合并借条 -";
        
        return label;
    }else{
        return nil;
    }
}



//区
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

//行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else{
        return _dataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * IdentifierStr = @"LitigationCell";
    MergeCell *cell = [tableView dequeueReusableCellWithIdentifier:IdentifierStr];
    if (cell == nil) {
        cell = [[MergeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IdentifierStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 0  && indexPath.row == 0) {
        [cell.selectBtn setImage:[UIImage imageNamed:@"LitigationSelected"] forState:UIControlStateNormal];//RadioButton-Unselected
        cell.selectBtn.userInteractionEnabled = NO;
    }
    cell.selectBtn.tag = indexPath.row + 10;
   
    if (indexPath.section == 0) {
        cell.model = _model;
    }
    if (_dataArray.count && indexPath.section == 1) {
        OverdueLoanData * model = _dataArray[indexPath.row];
        cell.model = model;
    }
    
    //选中框更换   刷新cell
    cell.backselectBtnIndex = ^(NSInteger current){
        if (current == 0) {
            return ;
        }

        NSIndexPath * cupath = [NSIndexPath indexPathForRow:current-10 inSection:1];

        [_unselectArray removeAllObjects];//只会记录一条
        if ([_selectArray containsObject:cupath]) {
            [_selectArray removeObject:cupath];
            [_unselectArray addObject:cupath];
        }else{
            [_selectArray addObject:cupath];
        };
        
        //刷新之前选中cell和当前选中cell
        [_MergeTable reloadRowsAtIndexPaths:_selectArray withRowAnimation:UITableViewRowAnimationNone];
        [_MergeTable reloadRowsAtIndexPaths:_unselectArray withRowAnimation:UITableViewRowAnimationNone];

    };
    //更新按钮状态
    [cell updateSelectBtnWithCellSection:indexPath.section SelectArray:_selectArray andUnSelectArray:_unselectArray];
    
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 121.0f;
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    OverdueLoanData * model = nil;
//    if (_dataArray.count>indexPath.row) {
//        model = [_dataArray objectAtIndex:indexPath.row];
//        MyLoanViewController *myLoanListVC = [[MyLoanViewController alloc] init];
//        myLoanListVC.loanID = model.loanID;
//        [self.navigationController pushViewController:myLoanListVC animated:YES];
//    }
//}

/**
 批量申请诉讼按钮
 */
-(void)ApplicationBtnAction{
    
    if (_dataArray!=nil) {
        if(_selectArray.count!=0)
        {
            for (int i=0; i< _selectArray.count;i++) {
                NSInteger rownumber=[_selectArray[i] row] ;
                self.model=[_dataArray objectAtIndex:rownumber];
                NSString* money=self.model.money;
                 [self.moneyArray addObject:money];
                //总金额
               _sumMoney=_sumMoney+ [_moneyArray[i] intValue]+_money;
                if (_sumMoney>=10000) {
                    [self AlertViewSuccess];
                }
                else{
                    [self AlertViewFailure];
                }
                
               
            }
 
        }
        else{
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择要合并的诉讼借条" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
   
}
#pragma mark - UIAlterView PaySuccess
-(void)AlertViewSuccess
{
    UIAlertView*alert = [[UIAlertView alloc] initWithTitle:nil message:@"1.法律诉讼服务采取预付佣金方式，法院或我方拒绝受理，将全款退还到您现金账户\n2.请认真填写诉讼材料，方便我们与您及时沟通，并给债务人送达法院“传票”\n3.请仔细阅读《专业诉讼服务条款》内容" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",  nil];
    alert.tag=89898989;
    [alert show];
}
#pragma mark - UIAlterView PayFailure
-(void)AlertViewFailure
{
    UIAlertView*alert = [[UIAlertView alloc] initWithTitle:nil message:@"目前只接受借款金额10000及以上的借款单！" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil,  nil];
    alert.tag=89898988;
    [alert show];
}

#pragma mark - UIAlterView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag==89898989){
        
        if(buttonIndex==1){
            if (_dataArray!=nil) {
                Payment_payLawsuit*Payment_payLawsuitModel = [[Payment_payLawsuit alloc] init];
                Payment_payLawsuitModel.loanIds=[NSString stringWithFormat:@"%ld",(long)self.loanId];
                Payment_payLawsuitModel.loanNums=[NSString stringWithFormat:@"%ld",(long)_selectArray.count+1];
                NSString *url = [YXBPaymentUtils getFullWebUrl:Payment_payLawsuitModel];
                [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"预支付"];
            }
        }
        
        else if(buttonIndex==0){
            NSLog(@"kkkkk！！！！！！！！！！！！！！！！！！！");
            
        }
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
