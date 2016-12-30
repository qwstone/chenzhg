//
//  AADiscussionViewController.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/3/20.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AADiscussionViewController.h"
#import "DetailsHeaderView.h"
#import "MessageTableViewCell.h"
#import "TChatManager.h"
#import "QCUserManager.h"
#import "NSSkyArray.h"
#import "UIImageView+WebCache.h"
#import "CPBTimerManager.h"

typedef enum {
    M_addChatMessage =0,
    M_getHistory,
    M_getCurrt,
}ChatHttpStyle;

@interface AADiscussionViewController ()<UITableViewDataSource,UITableViewDelegate,CPBTimerDelegate,QCBaseTableViewDelegate>
{
    DetailsHeaderView * _headerView;
    
    UIView * textbgView;
    UITextField * _textField;
    UIButton * sendBtn;
//    NSArray * ms;
    CGSize msSize;
    NSMutableArray * messageArray;
    CPBTimerManager *  _timerManager;
    
    
}

@property (nonatomic,strong)QCBaseTableView * tableView;

@end

@implementation AADiscussionViewController

-(void)dealloc{
    NSLog(@"AADiscussionViewController is dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"讨论"];
    messageArray = [[NSMutableArray alloc]init];
//    ms = @[@"是打发奥法阿斯",@"我再发假发发飞雷神身份爱上发奥法",@"爱上发顺丰",@"啊沙发全额付是打发第三方发的发顺丰阿发生的as奥法飞阿斯阿啊打发发送发送发发阿斯发顺丰阿斯发送发送发顺丰阿斯阿萨德发生的发顺丰是",@"  阿斯发送",@"阿萨德发生的发送啊",@"阿萨德发生的阿斯发顺丰",@"爱上发顺丰",@"阿萨阿萨德发生的发送发生法士大夫阿萨德发顺丰奥法爱上发顺丰阿萨帝发送发送阿斯发生的发顺丰阿萨德发顺丰阿萨德发顺丰德发顺丰",@"未发生受到 ",@"3换个地方  ",@"放是短发是"];
    [self initView];
    [self getkeyboundheight];
    [self httpChatWithStyle:M_getCurrt];
}

- (void)keyboardShow:(NSNotification *)aNotification
{
    NSDictionary *info = [aNotification userInfo];
    NSValue * aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyBoardSize = [aValue CGRectValue].size;

    [UIView animateWithDuration:0.35 animations:^{
        textbgView.frame = CGRectMake(0, kDeviceHeight-keyBoardSize.height-64-50, kDeviceWidth, 50);
        _tableView.frame = CGRectMake(0, _headerView.frame.size.height+15, kDeviceWidth, kDeviceHeight-_headerView.frame.size.height-64-50-keyBoardSize.height-15);
        if (_tableView.contentSize.height>_tableView.contentOffset.y) {
            _tableView.contentOffset = CGPointMake(0, _tableView.contentSize.height-_tableView.frame.size.height);

        }

    }];
}

- (void)keyboardHide:(NSNotification *)aNotification
{
    
    [UIView animateWithDuration:0.35 animations:^{
        textbgView.frame = CGRectMake(0, kDeviceHeight-64-50, kDeviceWidth, 50);
        _tableView.frame = CGRectMake(0, _headerView.frame.size.height+15, kDeviceWidth, kDeviceHeight-_headerView.frame.size.height-64-50-15);
    }];}

- (void)initView
{
    _headerView  = [[DetailsHeaderView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 125)];
    [_headerView setActivityModel:(AAActivity *)_activity];
    
    [self.view addSubview:_headerView];
    
    _tableView = [[QCBaseTableView alloc]initWithFrame:CGRectMake(0, _headerView.frame.size.height+15, kDeviceWidth, kDeviceHeight-_headerView.frame.size.height-64-50-15) style:UITableViewStylePlain refreshFooter:NO];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource =self;
    _tableView.refreshDelegate = self;
    [self.view addSubview:_tableView];

    
    textbgView = [[UIView alloc]initWithFrame:CGRectMake(0, kDeviceHeight-64-50, kDeviceWidth, 50)];
    textbgView.backgroundColor = [UIColor redColor];
    [self.view addSubview:textbgView];
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 5, kDeviceWidth-80, 40)];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    [textbgView addSubview:_textField];
    
    sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(_textField.frame.size.width +10, 5, kDeviceWidth-_textField.frame.size.width-10, 40)];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    sendBtn.titleLabel.font = [UIFont boldSystemFontOfSize:19];
    [sendBtn addTarget:self action:@selector(sendBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [textbgView addSubview:sendBtn];
    
    _timerManager = [[CPBTimerManager alloc]initWithTimeInterval:5 userInfo:Nil repeats:YES];
    _timerManager.delegate = self;
}

- (void)CPBTimerManagerAction:(CPBTimerManager *)timer
{
    [self httpChatWithStyle:M_getCurrt];
}

- (void)sendBtnAction:(UIButton *)sender
{
    if (![_textField.text isEqualToString:@""] ) {
//        [messageArray addObject:_textField.text];
//        [_tableView reloadData];
        [self httpChatWithStyle:M_addChatMessage];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TChat * chat = messageArray[indexPath.row];

//    CGSize messagSize = [chat.message sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(kDeviceWidth-170, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    CGSize messagSize = [chat.message boundingRectWithSize:CGSizeMake(kDeviceWidth-170, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    msSize = messagSize;
    return messagSize.height+55;
//    NSLog(@"%f",messageSize.height);
//    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return messageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * mycellID = @"me";
    
    NSString * otherCellID = @"other";
    TChat * chetMessage = messageArray[indexPath.row];
    
    QCUserModel * userModel = [[QCUserManager  sharedInstance]getLoginUser];

    MessageTableViewCell * cell;
    if (userModel.user.t_id == chetMessage.userId) {
         cell = [tableView dequeueReusableCellWithIdentifier:mycellID];
        if (cell == Nil) {
            cell = [[MessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycellID mySelf:YES];
        }

    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:otherCellID];
        if (cell == Nil) {
            cell = [[MessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:otherCellID mySelf:NO];
        }

    }
    cell.nameLabel.text = chetMessage.realname;
    [cell.userimage sd_setImageWithURL:[NSURL URLWithString:chetMessage.iconAdrr] placeholderImage:[UIImage imageNamed:@"useimg"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    for (UIView *subView in [cell.contentView subviews]) {
        [subView removeFromSuperview];
    }
    if (userModel.user.t_id == chetMessage.userId) {
        [cell.contentView addSubview:[cell BubbleView:chetMessage.message myself:YES]];

    }else{
        [cell.contentView addSubview:[cell BubbleView:chetMessage.message myself:NO]];

    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_textField resignFirstResponder]) {
        [_textField  resignFirstResponder];
    }

}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([_textField resignFirstResponder]) {
        [_textField  resignFirstResponder];

    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    _tableView.contentOffset = CGPointMake(0, _tableView.contentSize.height-_tableView.frame.size.height);

}


#pragma mark -----------------------------------------------HttpDownLoad
- (void)httpChatWithStyle:(ChatHttpStyle)style
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak AADiscussionViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
    } param:^(NSString *s) {
        
        [this httpLOadParams:s style:style httpOperation:assginHtttperator];
    } complete:^(NSSkyArray* r, int taskid) {
        
        [this httpLoadComplete:r style:style];
    }];
    [self.iHttpOperator connect];
    
}
//上传参数
- (void)httpLOadParams:(NSString *)s style:(ChatHttpStyle)style httpOperation:(HttpOperator *)httpOperation{
    
    TChatManager* _chatM = (TChatManager*)  [httpOperation getAopInstance:[TChatManager class] returnValue:[NSSkyArray class]];
    QCUserModel  * userModel = [[QCUserManager sharedInstance]getLoginUser];
    //        if (userModel.lastMessageTime == nil) {
    userModel.lastMessageTime = @"";
    //        }
    if (userModel.firstMessageTime == nil) {
        userModel.firstMessageTime = @"";
    }
    if (style == M_addChatMessage) {
        [_chatM addTChat:7 category:0 categoryId:_activity.t_id message:_textField.text];
        
    }else if (style == M_getCurrt){
        [_chatM getCurrentTChatByCategory:0 categoryId:_activity.t_id timestamp:userModel.lastMessageTime];
        
    }else{
        [_chatM getHistoryTChatByCategory:0 categoryId:_activity.t_id timeStamp:userModel.firstMessageTime];
        
    }

}
//请求完成
-(void)httpLoadComplete:(NSSkyArray *)r style:(ChatHttpStyle)style{
    if (self.tableView.isRefresh) {
        [self.tableView reloadDeals];
    }
    if (r.errCode == 0) {
        if (style == M_getHistory) {
            NSIndexSet  *indexSe = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, r.iArray.count)];
            [messageArray insertObjects:r.iArray atIndexes:indexSe];
            [_tableView reloadData];
        }else{
            [messageArray addObjectsFromArray:r.iArray];
            [_tableView reloadData];
            
            if (_tableView.contentSize.height>_tableView.frame.size.height && _tableView.contentOffset.y) {
                _tableView.contentOffset = CGPointMake(0, _tableView.contentSize.height-_tableView.frame.size.height);
                
            }
            
        }
        QCUserManager * userManager = [QCUserManager sharedInstance];
        QCUserModel * userModel  = [userManager getLoginUser];
        
        if (style == M_addChatMessage) {
            
            
            [_textField resignFirstResponder];
            _textField.text = @"";
            TChat * Lastchat = [messageArray lastObject];
            userModel.lastMessageTime = Lastchat.createDate;
            [userManager setLoginUser:userModel];
            
        }else{
            TChat * Lastchat = [messageArray lastObject];
            userModel.lastMessageTime = Lastchat.createDate;
            [userManager setLoginUser:userModel];
            
            //                QCUserManager * userManager = [QCUserManager sharedInstance];
            //                QCUserModel * userModel  = [userManager getLoginUser];
            TChat * fistchat = messageArray[0];
            userModel.firstMessageTime = fistchat.createDate;
            [userManager setLoginUser:userModel];
        }
        
    }

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_timerManager stop];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    scrollView.scrollEnabled = NO;
}
#pragma mark  --------------------------- refresh
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    [self refreshData];
}

//历史消息
- (void)refreshData {
    [self httpChatWithStyle:M_getHistory];
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
