//
//  QCSearchDishonestController.m
//  YOUXINBAO
//
//  Created by Walice on 15/10/22.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCSearchDishonestController.h"
#import "QCSearchBar.h"
#import "DishonestyTableViewCell.h"
//#import "TDishonestBoardManager.h"
#import "DishonestyListViewController.h"
#import "CreditCenterManager.h"
#define AddFriendsMenuCellHeight 60
#define SearchDishonestMenuControllerSearchHolder @"     身份证号/手机号"
@interface QCSearchDishonestController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    UITextField *contactfield;
}
@property(nonatomic,strong)QCSearchBar *searchBar;//自定义搜索栏
@property(nonatomic,strong)UITableView *tableView;//
@property(nonatomic,strong)NSMutableArray *dataArray;//数据源
@property(nonatomic,strong)UIButton *secondBtn;//第二栏 跳至联系人按钮
@property(nonatomic,strong)HttpOperator * iHttpOperator;
@property(nonatomic,strong)UILabel *emptyLabel;
@property(nonatomic,strong)UISearchBar *topSearchBar;
@property(nonatomic,strong)UISearchDisplayController *mySearchDisplayController;
@property(nonatomic,strong)NSString *searchText;//搜索的文字
@property(nonatomic,strong)NSMutableArray *iArray;

@end

@implementation QCSearchDishonestController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"失信榜"];
    self.view.backgroundColor = rgb(240,240,240,1);
    _searchText = @"";
    self.dataArray = [NSMutableArray array];
    self.iArray=[NSMutableArray array];
    [self loadSearchViews1];
    [self setBackView];

    // Do any additional setup after loading the view.
}


-(void)loadSearchViews1
{

    
    self.topSearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 40)];
    _topSearchBar.backgroundColor = [UIColor whiteColor];
    _topSearchBar.backgroundImage = [self imageWithColor:[UIColor clearColor] size:_topSearchBar.bounds.size];
    _topSearchBar.placeholder = @" ";
    //    _topSearchBar.keyboardType = UIKeyboardTypeNumberPad;
    [_topSearchBar setContentMode:UIViewContentModeLeft];
    _topSearchBar.layer.borderWidth = 1.0;
    _topSearchBar.layer.borderColor = rgb(223, 223, 223, 1.0).CGColor;
    _topSearchBar.delegate = self;
    [_topSearchBar setImage:[UIImage new] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [self.view addSubview:_topSearchBar];
 

 
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake((kDeviceWidth-200)/2, 200, 200, 60)];
    label.hidden=YES;
    label.tag=1001;
    [self.view addSubview:label];
    
    contactfield = [[UITextField alloc] initWithFrame:CGRectMake(20, 2, 200, _topSearchBar.height)];
    contactfield.font = [UIFont systemFontOfSize:14];
    contactfield.textColor = rgb(136, 136, 140, 1.0);
    contactfield.textAlignment = NSTextAlignmentLeft;
    contactfield.text = SearchDishonestMenuControllerSearchHolder;
    contactfield.userInteractionEnabled = NO;
    [_topSearchBar addSubview:contactfield];
    
    
    
    UIImageView *contactImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 12, 16, 16)];
    contactImage.image = [UIImage imageNamed:@"friend_search_bar_icon_normal"];
    [contactfield addSubview:contactImage];
    
    [_topSearchBar addSubview:contactfield];
    
    
    
    self.mySearchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:_topSearchBar contentsController:self];
    _mySearchDisplayController.active = NO;
    _mySearchDisplayController.searchResultsDataSource = self;
    _mySearchDisplayController.searchResultsDelegate = self;
    _mySearchDisplayController.searchResultsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

//取消searchbar背景色
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


#pragma -mark UITableViewDelegate&dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return AddFriendsMenuCellHeight;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"cellID";
    DishonestyTableViewCell * cell = [self.searchDisplayController.searchResultsTableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[DishonestyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectedBackgroundView = [[UIView alloc]init];
        cell.selectedBackgroundView.backgroundColor = kViewBackground;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    cell.model=_dataArray[indexPath.row];

    return cell;
    
}


#pragma UISearchDisplayDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.searchText = searchText;
     [self.dataArray removeAllObjects];
    UITableView *tableView1 = self.searchDisplayController.searchResultsTableView;
    for( UIView *subview in tableView1.subviews ) {
        if( [subview class] == [UILabel class] ) {
            UILabel *lbl = (UILabel*)subview; // sv changed to subview.
            lbl.numberOfLines=2;
            lbl.text = nil;
        }
        
    }
    
    
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [self loadFriendData];
}

#pragma -mark 搜索好友网络请求
-(void)loadFriendData
{
    
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak QCSearchDishonestController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error)
     {
         
         [this httpLoadError:error];
         
     } param:^(NSString *s) {

         [this httpLoadParams:assginHtttperator];
         
     } complete:^(NSSkyArray *r, int taskid)
     {
        
         [this httpLoadComplete:r];
  
     }];
    
    [self.iHttpOperator connect];
}
- (void)httpLoadParams:(HttpOperator *)assginHtttperator{
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    
    NSString *userToken = userModel.user.yxbToken;
    
    CreditCenterManager *manager = (CreditCenterManager *)[assginHtttperator getAopInstance:[CreditCenterManager class] returnValue:[NSSkyArray class]];
    [manager searchTDishonestBoardRecord:userToken queryInfo:_searchText];
    

}
- (void)httpLoadComplete:(NSSkyArray *)r{
    NSLog(@"%@",r);
    if (r.errCode==0&&r.iArray.count==0) {
        UITableView *tableView1 = self.searchDisplayController.searchResultsTableView;
        for( UIView *subview in tableView1.subviews ) {
            if( [subview class] == [UILabel class] ) {
                UILabel *lbl = (UILabel*)subview; // sv changed to subview.
                //lbl.numberOfLines=2;
                lbl.font=[UIFont systemFontOfSize:14];
//                lbl.text = [NSString stringWithFormat:@"用户%@\n信用记录不错哦!",self.searchText];
                lbl.text=r.errString;
            }
        }
    }
    else if (r.errCode==0&&r.iArray.count!=0){
        
        if((self.dataArray != nil) && ([self.dataArray count] > 0))
        {
            [self.dataArray removeAllObjects];
            self.dataArray =r.iArray;
            
        }
        else
        {
            self.dataArray=r.iArray;
        }
        
        [self reloadSearchTableview];
    
    }
    else if(r.errCode==7){
         [self.dataArray removeAllObjects];
        UITableView *tableView1 = self.searchDisplayController.searchResultsTableView;
        for( UIView *subview in tableView1.subviews ) {
            if( [subview class] == [UILabel class] ) {
                UILabel *lbl = (UILabel*)subview; // sv changed to subview.
                //lbl.numberOfLines=2;
                lbl.font=[UIFont systemFontOfSize:14];
                lbl.text = r.errString;
            }
    
    }
    }
}

#pragma -mark 刷新搜索tableview
-(void)reloadSearchTableview
{
    [self.searchDisplayController.searchResultsTableView reloadData];
}

#pragma UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    if ([searchBar.text isEqualToString:@""]) {
        contactfield.text = SearchDishonestMenuControllerSearchHolder;
        
    }
    else
    {
        contactfield.text = @"";
        
    }
    return YES;
}

-(BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([searchBar.text isEqualToString:@""] && [text length] > 0) {
        contactfield.text = @"";
        
    }
    else
    {
        NSMutableString *mText = [[NSMutableString alloc] initWithString:searchBar.text];
        [mText replaceCharactersInRange:range withString:text];
        if ([searchBar.text isEqualToString:@""]) {
            contactfield.text = SearchDishonestMenuControllerSearchHolder;
            
        }
        else
        {
            contactfield.text = @"";
            
        }
        
    }
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    contactfield.text = SearchDishonestMenuControllerSearchHolder;
    
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
