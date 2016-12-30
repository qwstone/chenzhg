//
//  QCAddressListNewController.m
//  YOUXINBAO
//
//  Created by Walice on 15/9/11.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCAddressListNewController.h"
#import "AddressListCell.h"
#import "QCConst.h"
#import "QCAddressBook.h"
#import "QCLinkManCell.h"
#import "QCFriendInviteViewController.h"
#import "QCAddFriendViewController.h"
#import "SearchCoreManager.h"
#import "TFriendRelationManager.h"
#import "TFriendRelation.h"
#import "TResultSet.h"
#import "NSSkyArray.h"
#import "AddressListCell.h"
#import "YXBTool.h"
#import "TResultSet.h"
#import "AddressDBManager.h"
#import "AddressBookModel.h"
#define kAddTag 30070
#define kAddedTag 30071
#define kInviteTag 30072


@interface QCAddressListNewController ()
{
    onAddressBookCompleteBlockTimes _times;
    NSInteger appearCount;//首次刷新
}
@end

@implementation QCAddressListNewController

-(void)dealloc{
    NSLog(@"QCAddressListNewController is dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title  = @"手机通讯录";
    self.page = 0;
    appearCount = 0;
    // Do any additional setup after loading the view.
    [self initView];
}
-(void)leftClicked
{
    [ProgressHUD dismiss];
    [[AddressDBManager shareInstance] cancel];
    [self.iHttpOperator cancel];
    [super leftClicked];
}

- (void)initView{
    [self setBackView];
    //首先创建一个空的字典,用于存储最终分好组的字典
    self.contactDic=[NSMutableDictionary dictionary];
    _result=[NSMutableArray new];
    _dataArray=[NSMutableArray array];
    _searchResults=[NSMutableArray array];
    self.dataArr = [NSMutableArray array];
    [self generateDicWithAddressBookDataWithBlock];
    [self createTableView];

    
}

//- (void)getPhoneNum {
//        NSArray *users = [[AddressDBManager shareInstance] query:DBAddressBookModelName predicate:nil];
//        if (users.count==0) {
//            dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                //子线程
//                [self clearAddressBooks];
//                [self getAddressBookSaveToDB];
//
//                //回归主线程
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self.tableView reloadData];
//                });
//            });
//        }
//        else{
//            
//            [self loadAddressBookSavedData];
//            dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            [self getAddressBookSaveToDB];
//        
//            });
//
//        }
//    
//
//}

-(void)generateDicWithAddressBookDataWithBlock
{
    
    __weak typeof(self)this = self;
    
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:hasSavedAddressBook] integerValue] != 1)
    {
        [ProgressHUD showWithStatus:@"正在读取通讯录..." maskType:ProgressHUDMaskTypeNone tipsType:ProgressHUDTipsTypeLongBottom];
        
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[AddressDBManager shareInstance] readLocalAddressBookWithCompleteBlock:^(NSMutableArray *resultArray,onAddressBookCompleteBlockTimes times) {
            _times = times;
            appearCount ++;
            if (resultArray.count>0) {
                this.dataArray=resultArray;
                [this resortDataWithArray:resultArray];
                [this requestData];
            }
     
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [ProgressHUD dismiss];
                if (times == onAddressBookCompleteBlockTimesSavedData) {
                    if (appearCount == 1) {
                        [this.tableView reloadData];

                    }

                }
            });
            
            
        }];
        
        
    });
}


//-(void)clearAddressBooks
//{
//    NSArray *users = [[AddressDBManager shareInstance] query:DBAddressBookModelName predicate:nil];
//    for (NSManagedObject *user in users) {
//        [[AddressDBManager shareInstance] removeManagerObj:user];
//        
//    }
//    
//}

//通讯录保存到本地
//-(void)saveAddressBook:(QCAddressBook *)addressBook
//{
//    //保存用户数据
//    AddressBookModel *model = (AddressBookModel *)[[AddressDBManager shareInstance] createMO:DBAddressBookModelName];
//    
//    model.city = addressBook.city;
//    model.name = addressBook.name;
//    model.recordID = [NSNumber numberWithInteger:addressBook.recordID];
//    model.rowSelected = [NSNumber numberWithBool:addressBook.rowSelected];
//    model.tel = addressBook.tel;
//    model.tel2 = addressBook.tel2;
//    model.resStatus=[NSNumber numberWithInteger:addressBook.resStatus];
//    model.pinyin=addressBook.pinyin;
//    model.maxPinyin=addressBook.maxPinyin;
//    
//    [[AddressDBManager shareInstance] saveManagerObj:model];
////    [[AddressDBManager shareInstance] updateManagerObj:model];
//
//    
//}
//


//-(NSInteger)loadAddressBookSavedData
//{
//    
//    NSMutableArray *friendArray = [NSMutableArray array];
//    
//    //读取数据库
//    NSArray *users = [[AddressDBManager shareInstance] query:DBAddressBookModelName predicate:nil];
//    NSLog(@"~~~~~~~~~~~~~~~~%ld",(unsigned long)users.count);
//    for (AddressBookModel *model in users) {
//        QCAddressBook *user = [[QCAddressBook alloc] init];
//        user.city = model.city;
//        user.name = model.name;
//        user.recordID = [model.recordID integerValue];
//        user.rowSelected = [model.rowSelected boolValue];
//        user.tel = model.tel;
//        user.tel2 = model.tel2;
//        user.resStatus=[model.resStatus integerValue];
//        user.pinyin= model.pinyin;
//        user.maxPinyin=model.maxPinyin;
//        [friendArray addObject:user];
//    }
//    
//    //[self processDataWithAddresspeopleArray:friendArray];
//    [self resortDataWithArray:friendArray];
//    return [friendArray count];
//}
//

//- (void)getAddressBookSaveToDB{
//    
//    //获取通讯录信息
//    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted || ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied) {
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请开启访问通讯录功能,获取通讯录好友" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [alert show];
//        });
//        
//    }
//    
//    
//    //获取通讯录信息
//   // NSMutableArray *addressBookTemp = [NSMutableArray array];
//    //新建一个通讯录类
//    ABAddressBookRef addressBooks = NULL;
//    
//    if ([[UIDevice currentDevice].systemVersion floatValue]>=6.0) {
//        if (&ABAddressBookCreateWithOptions != NULL){
//            
//            CFErrorRef errorRef = NULL;
//            addressBooks = ABAddressBookCreateWithOptions(nil, &errorRef);
//            
//            if (!addressBooks){
//                if (errorRef) CFRelease(errorRef);
//                
//                return;
//            }
//            
//            
//        }
//    }
//    else
//    {
//        addressBooks =ABAddressBookCreate();
//    }
//    //获取通讯录中的所有人
//    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBooks);
//    //通讯录中人数
//    CFIndex nPeople = ABAddressBookGetPersonCount(addressBooks);
//    
//    //循环，获取每个人的个人信息
//    for (NSInteger i = 0; i < nPeople; i++)
//    {
//        QCAddressBook *addressBook = [[QCAddressBook alloc] init];
//        //获取个人
//        ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
//        //获取个人名字
//        CFStringRef abName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
//        CFStringRef abLastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
//        CFStringRef abFullName = ABRecordCopyCompositeName(person);
//        
//        
//        NSString *nameString = (__bridge NSString *)abName;
//        NSString *lastNameString = (__bridge NSString *)abLastName;
//        
//        if ((__bridge id)abFullName != nil) {
//            nameString = (__bridge NSString *)abFullName;
//        } else {
//            if ((__bridge id)abLastName != nil)
//            {
//                nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastNameString];
//            }
//        }
//        
//        addressBook.name = nameString;
//        addressBook.recordID = (int)ABRecordGetRecordID(person);;
//        addressBook.rowSelected = NO;
//        addressBook.pinyin=[YXBTool pinyinWithText:addressBook.name];
//        addressBook.maxPinyin=[[YXBTool pinyinWithText:addressBook.name]uppercaseString];
//        addressBook.resStatus=-1;
//    
//        
//        ABPropertyID multiProperties[] = {
//            kABPersonPhoneProperty,
//            kABPersonEmailProperty
//        };
//        NSInteger multiPropertiesTotal = sizeof(multiProperties) / sizeof(ABPropertyID);
//        for (NSInteger j = 0; j < multiPropertiesTotal; j++) {
//            ABPropertyID property = multiProperties[j];
//            ABMultiValueRef valuesRef = ABRecordCopyValue(person, property);
//            NSInteger valuesCount = 0;
//            if (valuesRef != nil) valuesCount = ABMultiValueGetCount(valuesRef);
//            
//            if (valuesCount == 0) {
//                CFRelease(valuesRef);
//                continue;
//            }
//            //获取电话号码和email
//            for (NSInteger k = 0; k < valuesCount; k++) {
//                CFStringRef value = ABMultiValueCopyValueAtIndex(valuesRef, k);
//                switch (j) {
//                    case 0: {// Phone number
//                        if (k == 0) {
//                            
//                            addressBook.tel = (__bridge NSString*)value;
//                            
//                        }else if (k == 1) {
//                            addressBook.tel2 = (__bridge NSString*)value;
//                            
//                        }
//                        break;
//                    }
//                    case 1: {// Email
//                        addressBook.email = (__bridge NSString*)value;
//                        break;
//                    }
//                }
//                CFRelease(value);
//            }
//            
//     
//            CFRelease(valuesRef);
//        }
//        
//        //存储
//        if (addressBook.name!=nil&&addressBook.tel!=nil) {
//            [self.dataArray addObject:addressBook];
//        }
//        
//        
//    }
////将读取的通讯录进行分组
//
//    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:hasSavedAddressBook];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//
//    [self resortDataWithArray:self.dataArray];
//    //请求网络数据
//    [self requestData];
//    
//}


- (void)resortDataWithArray:(NSMutableArray *)AAarray{
    
    self.dataArr= AAarray;
    //首先创建一个空的字典,用于存储最终分好组的字典
//    self.contactDic=[NSMutableDictionary dictionary];
    [self.contactDic removeAllObjects];
    //对得到的通讯录中的所有好友进行遍历
    if (AAarray!=nil) {
        for (QCAddressBook *addressBook in AAarray) {
            if ([addressBook.name isKindOfClass:[NSNull class]]) {
                //return;
                continue;
            }
            else{
                //取出姓名的第一个首字母
                //NSString *pinyin=[YXBTool pinyinWithText:addressBook.name];
                if (addressBook.pinyin.length>=1) {
                    NSString *t=[addressBook.pinyin substringWithRange:NSMakeRange(0, 1)];
                    NSString *s=[t uppercaseString];
                    //在字典里寻找这个首字母,对应的value(是一个数组)
                    NSMutableArray *array=[self.contactDic objectForKey:s];
                    //如果得到的是个空的数组,也就是现在还没有对应的key,value,那么创建一个新的数组,将key,value存进去,也把相应遍历出来的好友添加进数组
                    if (array==nil) {
                        NSMutableArray *data=[NSMutableArray array];
                        if ([self CharacterData:s]) {
                            [self.contactDic setObject:data forKey:s];
                        }
                        else{
                            [self.contactDic setObject:data forKey:@"#"];
                            
                        }
                        
                        [data addObject:addressBook];
                    }
                    //如果已经有了对应的key,value,就将遍历出来的好友添加到数组
                    else{
                        [array addObject:addressBook];
                        
                    }
                    
                }
                
                
            }
        }
    }

    
    NSArray *allkeys=[self.contactDic allKeys];
    NSArray *aaaa =[allkeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    self.result = [NSMutableArray arrayWithArray:aaaa];
   if (self.result.count>0) {
        if ([self.result[0] isEqualToString:@"#"]) {
            [self.result removeObject:self.result[0]];
            [self.result addObject:@"#"];
        }
    }
    
//[self.tableView reloadData];
}
//将读取的通讯录进行分组
//- (void)resortData
//{
//    //首先创建一个空的字典,用于存储最终分好组的字典
//    self.contactDic=[NSMutableDictionary dictionary];
//    //对得到的通讯录中的所有好友进行遍历
//    for (QCAddressBook *addressBook in self.dataArray) {
//
//        //NSLog(@"~~~~~~~~%@",addressBook.name);
//
////        NSLog(@"~~~~~~~~%@",addressBook.name);
//
//        if ([addressBook.name isKindOfClass:[NSNull class]]) {
//            //return;
//            continue;
//        }
//        else{
//            //取出姓名的第一个首字母
//            NSString *pinyin=[YXBTool pinyinWithText:addressBook.name];
//            if (pinyin.length>=1) {
//                NSString *t=[pinyin substringWithRange:NSMakeRange(0, 1)];
//                NSString *s=[t uppercaseString];
//                //在字典里寻找这个首字母,对应的value(是一个数组)
//                
//                NSMutableArray *array=[self.contactDic objectForKey:s];
//                //如果得到的是个空的数组,也就是现在还没有对应的key,value,那么创建一个新的数组,将key,value存进去,也把相应遍历出来的好友添加进数组
//                if (array==nil) {
//                    NSMutableArray *data=[NSMutableArray array];
//                    if ([self CharacterData:s]) {
//                        [self.contactDic setObject:data forKey:s];
//                    }
//                    else{
//                        [self.contactDic setObject:data forKey:@"#"];
//                        
//                    }
//                    
//                    [data addObject:addressBook];
//                }
//                //如果已经有了对应的key,value,就将遍历出来的好友添加到数组
//                else{
//                    [array addObject:addressBook];
//                    
//                }
//
//            }
//            }
//
//    }
//    
//    NSArray *allkeys=[self.contactDic allKeys];
//    NSArray *aaaa =[allkeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//        
//        return [obj1 compare:obj2 options:NSNumericSearch];
//    }];
//    self.result = [NSMutableArray arrayWithArray:aaaa];
//    if (self.result.count>0) {
//        if ([self.result[0] isEqualToString:@"#"]) {
//            [self.result removeObject:self.result[0]];
//            [self.result addObject:@"#"];
//        }
//    }
//    
//}

- (BOOL)CharacterData:(NSString *)s{

    NSArray *array=@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    
   return [array containsObject:s];
    
    
}
//请求网络数据
- (void)requestData{
    self.phonesArr=[NSMutableArray array];
    self.phoneNum=[NSMutableString new];
    NSMutableArray *nameArray = [NSMutableArray array];
    
    for (QCAddressBook *addressBook in self.dataArray) {
        if ((addressBook.tel !=nil)) {
            NSString *phone = addressBook.tel;
            [_phonesArr addObject:phone];
            NSString *realName = [YXBTool base64EncodedWithString:addressBook.name];
            [nameArray addObject:realName];
            
        }
    }
    
        for (int i = 0; i<_phonesArr.count; i++) {
    
            NSString *phoneStr = [_phonesArr objectAtIndex:i];
            NSMutableString *appendStr = [NSMutableString new];
            if (i < _phonesArr.count-1) {
                appendStr = [NSMutableString stringWithFormat:@"%@|%@,",phoneStr,nameArray[i]];
            }else {
                appendStr = [NSMutableString stringWithFormat:@"%@|%@",phoneStr,nameArray[i]];
            }
            [_phoneNum appendString:appendStr];
}
  



    if (self.iHttpOperator == nil) {
        self.iHttpOperator =[[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __block HttpOperator * assginHtttperator = _iHttpOperator;
    __block QCAddressListNewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        [assginHtttperator stopAnimation];
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:this cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterView show];
//            [this.tableView reloadDeals];
        }
        
    } param:^(NSString *s) {
        

        [this httpLOadParams:s httpOperation:assginHtttperator];


        

    } complete:^(NSSkyArray *r, int taskid) {

        [this httpLoadComplete:r];
        
    }];
    
    [self.iHttpOperator connect];

    

}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    QCUserModel *localUser = [[QCUserManager sharedInstance] getLoginUser];
    User *user = localUser.user;
    NSString *userName = user.username;
    
    TFriendRelationManager* _currFriend = (TFriendRelationManager *)  [httpOperation getAopInstance:[TFriendRelationManager class] returnValue:[NSSkyArray class]];
    
//    [_currFriend getTFriendRelationByPhoneBook:userName withPhoneArr:self.phoneNum];
    [_currFriend getTFriendRelationByPhoneBookStoreV2:userName withPhoneArr:self.phoneNum];

    

}
//请求完成
-(void)httpLoadComplete:(NSSkyArray *)r{
    if (r.errCode==0) {
        
        if (r.iArray.count!=0&&self.dataArray.count!=0) {
            
            
            if (_times == onAddressBookCompleteBlockTimesNewData) {
                [[AddressDBManager shareInstance] saveAddressArray:self.dataArray];

            }
//            [self clearAddressBooks];
//            NSArray *users = [[AddressDBManager shareInstance] query:DBAddressBookModelName predicate:nil];
//            if (users.count==0) {
//                for (int i=0; i<r.iArray.count;i++) {
//                    QCAddressBook *book=self.dataArray[i];
//                    [self saveAddressBook:book];
//                }
//                
//            }
            
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                for (int i=0;i<r.iArray.count && i<_dataArray.count;i++) {
                    TResultSet *result=r.iArray[i];
                    QCAddressBook *book=self.dataArray[i];
                    book.resStatus=[[NSNumber numberWithInt:(int)result.resInteger] integerValue];
                    
                    
                }

                [self resortDataWithArray:self.dataArray];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.tableView reloadData];

                });
                
                
            });

            

            
        }
        else if (r.iArray.count)
            
            
            //            [this.tableView reloadDeals];
            [self.tableView reloadData];
        // [ProgressHUD showSuccessWithStatus:@"匹配完成"];
        
    }
    else{
        
        //[ProgressHUD showErrorWithStatus:r.errString];
    }

}

-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0 , kDeviceWidth,kDeviceHeight-64) style:UITableViewStylePlain ];
   //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = rgb(242, 239, 248, 1);
    _tableView.delegate=self;
    _tableView.dataSource=self;
//    _tableView.refreshDelegate=self;
    [self.view addSubview:_tableView];

    
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    
    self.tableView.sectionIndexColor = [UIColor lightGrayColor];
    
    
    self.topSearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 40)];
    self.topSearchBar.backgroundColor =rgb(238, 238, 238, 1);
    self.topSearchBar.backgroundImage = [self imageWithColor:[UIColor clearColor] size:self.topSearchBar.bounds.size];
    _topSearchBar.placeholder = @"搜索联系人";
    
    //_topSearchBar.layer.borderWidth = 0.3;
    //_topSearchBar.layer.borderColor = rgb(180, 180, 180, 1.0).CGColor;
    _topSearchBar.delegate = self;
    _tableView.tableHeaderView=_topSearchBar;
    
    self.mySearchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:_topSearchBar contentsController:self];
    _mySearchDisplayController.active = NO;
    _mySearchDisplayController.searchResultsDataSource = self;
    _mySearchDisplayController.searchResultsDelegate = self;
    _mySearchDisplayController.delegate= self;
    _mySearchDisplayController.searchResultsTableView.backgroundColor = rgb(242, 239, 248, 0.98);
    

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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
   
    return (tableView == self.tableView) ? self.contactDic.count : 1;
    

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *data = [NSArray array];
    if (section < [_result count]) {
        data=[self.contactDic objectForKey:_result[section]];

    }
    return (tableView == self.tableView) ? data.count : self.searchResults.count;

 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *informationIdentifier = @"AlreadyVisaInterviewCell";
    AddressListCell* cell = [tableView dequeueReusableCellWithIdentifier:informationIdentifier];
    if (cell == nil) {
        cell = [[AddressListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:informationIdentifier];
        cell.clipsToBounds = YES;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.delegate=self;
        
    }
    if (_topSearchBar.text.length <= 0) {
        cell.searchText=_topSearchBar.text;
    }
    
    NSArray *data=[self.contactDic objectForKey:_result[indexPath.section]];
    
    QCAddressBook *book = [[QCAddressBook alloc] init];
//    if (indexPath.row < [data count]) {
//        book=(tableView == self.tableView) ? data[indexPath.row]: self.searchResults[indexPath.row];
        if (tableView==self.tableView) {
            book=data[indexPath.row];
        }
        else{
            book=self.searchResults[indexPath.row];
        }
        cell.model=book;
        NSLog(@"%@",cell.model);

 //   }

    
    cell.model=book;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSString *str=@"";
    if (section<[_result count]) {
        str=_result[section];
    }
    return (tableView == self.tableView) ? str:nil;
}
//计算高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return (tableView == self.tableView) ? 20:0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

//设置索引条
-(NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView
{

    
    return (tableView == self.tableView) ? self.result:nil;

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSArray *data=[self.contactDic objectForKey:_result[indexPath.section]];
    QCAddressBook *book=(tableView == self.tableView) ? data[indexPath.row]: self.searchResults[indexPath.row];
    if (book.resStatus==0) {
        
        QCAddFriendViewController *addVC = [[QCAddFriendViewController alloc] initWithUserType:YES];
        addVC.addressBook = book;
        [self.navigationController pushViewController:addVC animated:YES];
        
        
    }
    else if (book.resStatus==-1){
    
        QCFriendInviteViewController * inviteView = [[QCFriendInviteViewController alloc]init];
        inviteView.addressBook = book;
        [self.navigationController pushViewController:inviteView animated:YES];
    
    }
    

}

#pragma mark - UISearchDisplayController 代理

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    
    
    NSString *s = [NSString stringWithFormat:@"name CONTAINS '%@'|| tel BEGINSWITH '%@'||_pinyin CONTAINS[cd] '%@'||_maxPinyin CONTAINS[cd] '%@'",searchString,searchString,searchString,searchString];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:s];
    
    self.searchResults = [self.dataArr filteredArrayUsingPredicate:predicate];

    
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    
    
    return YES;
}
#pragma QCAddressListDelegate
- (void)QCAddressListPushAction: (NSInteger)btnTag addressBook:(QCAddressBook *)addressBook{

    if (btnTag == kAddTag) {
        QCAddFriendViewController *addVC = [[QCAddFriendViewController alloc] initWithUserType:YES];
        addVC.addressBook = addressBook;
        [self.navigationController pushViewController:addVC animated:YES];

        
    }else if (btnTag == kAddedTag) {
        //        QCAddFriendViewController *addVC = [[QCAddFriendViewController alloc] initWithUserType:NO];
        //        addVC.addressBook = addressBook;
        //        [self.navigationController pushViewController:addVC animated:YES];
        //        [addVC release];
        
    }else {
        QCFriendInviteViewController * inviteView = [[QCFriendInviteViewController alloc]init];
        inviteView.addressBook = addressBook;
        [self.navigationController pushViewController:inviteView animated:YES];
        
    }
    

}

- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView{

    [self requestData];

}
//-(void)leftClicked
//{
//    //    [ProgressHUD dismiss];
//    [self.navigationController popViewControllerAnimated:YES];
//    [self.iHttpOperator cancel];
//    
//}


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
