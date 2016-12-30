//
//  QCSecretaryListViewController.m
//  YOUXINBAO
//
//  Created by Walice on 15/7/7.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCSecretaryListViewController.h"
#import "QCPostMessageViewController.h"
#import "SmilePromptManager.h"
#import "QCSecretaryListCell.h"

@interface QCSecretaryListViewController ()
{

    NSInteger page;
}

@end

@implementation QCSecretaryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBackView];
    [self _initView];
    self.title=@"催款小秘书";
}

- (void)_initView{
    self.view.backgroundColor = rgb(238, 236, 246, 1.0);
    self.dataArray=[NSMutableArray array];
    self.array=[NSArray arrayWithObjects:@"朋友",@"亲戚",@"同学",@"同事", nil];
    
    self.style=QCFriend;
    _tableView = [[QCBaseTableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64) style:UITableViewStylePlain refreshFooter:YES];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.refreshDelegate = self;
    
    [self.view addSubview:_tableView];
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 50)];
    view.backgroundColor=[UIColor whiteColor];
    _tableView.tableHeaderView=view;
    
    _relationLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 18,100, 14)];
    _relationLabel.text=@"关系";
    _relationLabel.font=[UIFont systemFontOfSize:14];
    _relationLabel.textColor=rgb(48, 48, 48, 1);
    [view addSubview:_relationLabel];
    
    _relationButton=[[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth-100, 0, 100, 50)];
    [_relationButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    _relationButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [_relationButton setTitle:self.array[0] forState:UIControlStateNormal];
    [_relationButton setTitleColor:rgb(166, 166, 166, 1) forState:UIControlStateNormal];
    [view addSubview:_relationButton];
    
    UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(80, 15, 10, 18)];
    imgView.image=[UIImage imageNamed:@"wxck-next.png"];
    [_relationButton addSubview:imgView];

}

- (void)buttonAction{

        if (_pickerView == nil) {
            _pickerView=[[UIPickerView alloc]initWithFrame:CGRectMake(0,kDeviceWidth-64+100+30, kDeviceWidth, 100)];
            _pickerView.backgroundColor=[UIColor whiteColor];
            _pickerView.dataSource=self;
            _pickerView.delegate=self;
            [self.view addSubview:_pickerView];
            
//            _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            _sureButton.frame = CGRectMake(10, _pickerView.origin.y-10, kDeviceWidth-20, 40);
//            _sureButton.backgroundColor = [UIColor clearColor];
//            [_sureButton setImage:[UIImage imageNamed:@"register_sure.png"] forState:UIControlStateNormal];
//            [_sureButton addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
//            [self.view addSubview:_sureButton];
//
            
            _sendBackImage = [[UIView alloc]initWithFrame:CGRectMake(0, _pickerView.origin.y-20, kDeviceWidth, 50)];
            _sendBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(0,_pickerView.origin.y-10, kDeviceWidth, 40)];
            _sendBackImage.backgroundColor = [UIColor whiteColor];
            _sendBackImage.layer.borderWidth = 1.0;
            _sendBackImage.layer.borderColor = [rgb(255, 156, 146, 1) CGColor];
            [self.view addSubview:_sendBackImage];
            
            _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _sureButton.frame = CGRectMake(0, _pickerView.origin.y-10, kDeviceWidth, 40);
            _sureButton.backgroundColor = [UIColor clearColor];
            [_sureButton setImage:[UIImage imageNamed:@"register_sure.png"] forState:UIControlStateNormal];
            [_sureButton addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:_sureButton];
            
            
        }
    
    [UIView animateWithDuration:.3 animations:^{
        
        _pickerView.top = kDeviceHeight-64-_pickerView.height;
        _sureButton.bottom = _pickerView.top+30;
        _sendBackImage.bottom=_pickerView.top+30;
        
    }];
    
}


#pragma mark -----------------------------------------------HttpDownLoad
- (void)httpDowloadWithListStyle
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak QCSecretaryListViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterView show];
            [this.tableView reloadDeals];
        }
        
    } param:^(NSString *s) {
        
        SmilePromptManager *_activityM = (SmilePromptManager *)[assginHtttperator getAopInstance:[SmilePromptManager class] returnValue:[NSSkyArray class]];
        
        [_activityM getSmilePromptItem:page type:this.style];
        
        
    } complete:^(NSSkyArray * r, int taskid) {
        if (r.errCode==0) {
            if (r.iArray.count != 0 && r.iArray.count%20 == 0) {
                this.tableView.hasFooter = YES;
            }else {
                //数据加载不足一页的事后,将加载更多取消掉
                this.tableView.hasFooter = NO;
            }
            
            [this.tableView reloadDeals];
            //判断如果没有数据的时候,显示的图片
            if (page==1&&r.iArray.count==0) {
                
                UILabel *label= [[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth/2-40, 0, kDeviceWidth, _tableView.height)];
                label.text=@"暂无数据";
                label.contentMode=UIViewContentModeCenter;
                label.textColor=[UIColor blueColor];
                label.backgroundColor=[UIColor clearColor];
                _tableView.tableFooterView=label;
                return ;
            }
            
            self.tableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectZero];
            
            
            //如果刷新的是第一页,则需要将之前刷新的移除掉,不然第一页的数据会反复出现
            if (page==MessageCenterPageNOStart) {
                [this.dataArray removeAllObjects];
            }
            [this.dataArray addObjectsFromArray:r.iArray];
            [this.tableView reloadData];
            
        }
        
        
        
    }];
    [self.iHttpOperator connect];
    
}

- (void)sureAction{
    page=MessageCenterPageNOStart;
    [self httpDowloadWithListStyle];
    [self hidePickerView];
}

- (void)hidePickerView {
    [UIView animateWithDuration:.3 animations:^{
        
        _pickerView.top = kDeviceHeight-64+_sureButton.height;
        _sureButton.bottom = _pickerView.top;
        _sendBackImage.bottom=_pickerView.top;
    }];
}

#pragma mark  --------------------------- refresh
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    page=MessageCenterPageNOStart;
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

#pragma mark -pickerView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.array.count;
    
}
//#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *str= self.array[row];
    return str;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{   NSString *str= self.array[row];
    [_relationButton setTitle:str forState:UIControlStateNormal];
    
    self.style=row;
}




#pragma mark -tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
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
    view.backgroundColor = [UIColor clearColor];
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * identifier = @"cell";
    QCSecretaryListCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[QCSecretaryListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.model=_dataArray[indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QCPostMessageViewController *controller = [[QCPostMessageViewController alloc] init];
    
    SmilePromptItem *model=_dataArray[indexPath.row];
    controller.string=model.descript;
    controller.promptID=model.itemID;
    [self.navigationController pushViewController:controller animated:YES];
    
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
