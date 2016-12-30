//
//  QCAddressListViewController.m
//  YOUXINBAO
//
//  Created by ZHANGMIAO on 14-3-4.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCAddressListViewController.h"
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

#define kAddTag 30070
#define kAddedTag 30071
#define kInviteTag 30072

@interface QCAddressListViewController ()

@property (nonatomic,retain) NSMutableDictionary *typeDic;
@property (nonatomic,retain) NSMutableArray *typeArr;

@end

@implementation QCAddressListViewController

- (void)dealloc
{
    Release(_typeDic);
    Release(_typeArr);
    Release(_searchByName);
    Release(_contactDic);
    Release(_cover);
    [_listContent release];
    [_tableView release];
    [_searchBar release];
    self.iHttpOperator = nil;
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        _listContent = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title  = @"手机通讯录";
    

    self.typeArr = [NSMutableArray new];
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftAction)];
    
    //按名字搜索结果
    NSMutableArray *nameIDArray = [[NSMutableArray alloc] init];
    self.searchByName = nameIDArray;
    [nameIDArray release];
    
    //存储联系人字典
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    self.contactDic = dic;
    [dic release];
    
    //重置搜索库
    [[SearchCoreManager share] Reset];
    
    [self createUI];
    
}

- (void)loadData {
    self.typeDic = [NSMutableDictionary new];
   //电话号码
    NSMutableArray *phonesArr = [NSMutableArray new];
    //统计数组
    NSMutableArray *counts = [NSMutableArray new];
    for (NSMutableArray *section in _listContent) {
        NSNumber *count = [NSNumber numberWithInt:(int)section.count];
        [counts addObject:count];
        
        if (section.count != 0) {
            for (QCAddressBook *addressBook in section) {
                if (addressBook.tel != nil) {
                    NSString *phone = addressBook.tel;
                    [phonesArr addObject:phone];
                    
                }
            }
        }
    }
    NSMutableString *phoneNumbs = [NSMutableString new];
    for (int i = 0; i<phonesArr.count; i++) {
        
        NSString *phoneStr = [phonesArr objectAtIndex:i];
        NSMutableString *appendStr = [NSMutableString new];
        if (i < phonesArr.count-1) {
            appendStr = [NSMutableString stringWithFormat:@"%@,",phoneStr];
        }else {
            appendStr = [NSMutableString stringWithFormat:@"%@",phoneStr];
        }
        [phoneNumbs appendString:appendStr];
    }

    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[[HttpOperator alloc]init]autorelease];
        
    }
    [self.iHttpOperator cancel];
    __block HttpOperator * assginHtttperator = _iHttpOperator;
    __block QCAddressListViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
        }
        
    } param:^(NSString *s) {
        
        QCUserModel *localUser = [[QCUserManager sharedInstance] getLoginUser];
        User *user = localUser.user;
        NSString *userName = user.username;
        
        TFriendRelationManager* _currFriend = (TFriendRelationManager *)  [assginHtttperator getAopInstance:[TFriendRelationManager class] returnValue:[NSSkyArray class]];
        
        [_currFriend getTFriendRelationByPhoneBook:userName withPhoneArr:phoneNumbs];
        
    } complete:^(NSSkyArray *r, int taskid) {
        if (r.iArray.count != 0) {
            TResultSet *testResult = [r.iArray lastObject];
            NSInteger errCode = testResult.errCode;
            
            if (errCode == 0) {
                int index = 0;
                for (int i = 0; i<counts.count; i++) {
                    NSMutableArray *section = [NSMutableArray new];
                    NSInteger count = [[counts objectAtIndex:i] integerValue];
                    for (int j = 0; j<count; j++) {
                        TResultSet *result = [r.iArray objectAtIndex:index];
                        NSString *phoneNum = [phonesArr objectAtIndex:index];
                        [this.typeDic setValue:[NSNumber numberWithInt:(int)result.resInteger] forKey:phoneNum];
                        [section addObject:result];
                        index++;
                    }
                    [this.typeArr addObject:section];
                }
                
                [this.tableView reloadData];

                
            } else {
//                [this showLoadingWithTitle:testResult.errString imageName:nil];
//                [this performSelector:@selector(hideLoading) withObject:nil afterDelay:2];
            }
        }
        
    }];
    [self.iHttpOperator connect];
    
}
- (void)httpLoadParams:(HttpOperator *)assginHtttperator{

    

}

- (void)createUI
{
    //搜索视图
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 42)];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    [headerView release];
    
    _searchBar = [[QCSearchBar alloc]initWithFrame: CGRectMake(15, 6, kDeviceWidth-15*2, 30)];
    _searchBar.delegate = self;

    
    
    [headerView addSubview:_searchBar];
    if (self.isSousuo == YES) {
        [_searchBar.textField becomeFirstResponder];
    }

    
    //标示图
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, headerView.bottom, kDeviceWidth, kDeviceHeight-20-44-headerView.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    if (KDeviceOSVersion>=7.0) {
        _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        _tableView.separatorInset = UIEdgeInsetsMake(0, -20, 0, 0);
    }
    if (KDeviceOSVersion>=6.0) {
        _tableView.sectionIndexColor = rgb(85, 85, 85, 1);
    }
    
//    _tableView.separatorColor = rgb(255, 221, 202, 1);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    _cover = [[UIControl alloc] initWithFrame:CGRectMake(0, 42, kDeviceWidth, kDeviceHeight)];
    _cover.backgroundColor = [UIColor colorWithWhite:0 alpha:.3];
    _cover.hidden = YES;
    [_cover addTarget:self action:@selector(coverAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cover];
    
    //获取通讯录信息
    NSMutableArray *addressBookTemp = [NSMutableArray array];
    ABAddressBookRef addressBooks = NULL;

    
    if ([[UIDevice currentDevice].systemVersion floatValue]>=6.0) {
        if (&ABAddressBookCreateWithOptions != NULL){
            
            CFErrorRef errorRef = NULL;
            addressBooks = ABAddressBookCreateWithOptions(nil, &errorRef);
            
            if (!addressBooks){
                if (errorRef) CFRelease(errorRef);
                
                return;
            }

            
        }
    }
    else
    {
        addressBooks =ABAddressBookCreate();
    }
    
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBooks);
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBooks);
    
    
    for (NSInteger i = 0; i < nPeople; i++)
    {
        QCAddressBook *addressBook = [[QCAddressBook alloc] init];
        ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
        CFStringRef abName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
        CFStringRef abLastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
        CFStringRef abFullName = ABRecordCopyCompositeName(person);
        
        //地址
        ABMultiValueRef address = ABRecordCopyValue(person, kABPersonAddressProperty);
        for(int j = 0; j < ABMultiValueGetCount(address); j++)
        {
            NSDictionary* personaddress =(NSDictionary*) ABMultiValueCopyValueAtIndex(address, j);
            NSString* city = [personaddress valueForKey:(NSString *)kABPersonAddressStateKey];
            addressBook.city = city;
        }
//        //电话
//        ABMultiValueRef phones = (ABMultiValueRef) ABRecordCopyValue(person, kABPersonPhoneProperty);
        
        /*
         Save thumbnail image - performance decreasing
         UIImage *personImage = nil;
         if (person != nil && ABPersonHasImageData(person)) {
         if ( &ABPersonCopyImageDataWithFormat != nil ) {
         // iOS >= 4.1
         CFDataRef contactThumbnailData = ABPersonCopyImageDataWithFormat(person, kABPersonImageFormatThumbnail);
         personImage = [[UIImage imageWithData:(NSData*)contactThumbnailData] thumbnailImage:CGSizeMake(44, 44)];
         CFRelease(contactThumbnailData);
         CFDataRef contactImageData = ABPersonCopyImageDataWithFormat(person, kABPersonImageFormatOriginalSize);
         CFRelease(contactImageData);
         
         } else {
         // iOS < 4.1
         CFDataRef contactImageData = ABPersonCopyImageData(person);
         personImage = [[UIImage imageWithData:(NSData*)contactImageData] thumbnailImage:CGSizeMake(44, 44)];
         CFRelease(contactImageData);
         }
         }
         [addressBook setThumbnail:personImage];
         */
        
        NSString *nameString = (NSString *)abName;
        NSString *lastNameString = (NSString *)abLastName;
        
        if ((id)abFullName != nil) {
            nameString = (NSString *)abFullName;
        } else {
            if ((id)abLastName != nil)
            {
                nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastNameString];
            }
        }
        
        addressBook.name = nameString;
        addressBook.recordID = (int)ABRecordGetRecordID(person);;
        addressBook.rowSelected = NO;
        
        ABPropertyID multiProperties[] = {
            kABPersonPhoneProperty,
            kABPersonEmailProperty
        };
        NSInteger multiPropertiesTotal = sizeof(multiProperties) / sizeof(ABPropertyID);
        for (NSInteger j = 0; j < multiPropertiesTotal; j++) {
            ABPropertyID property = multiProperties[j];
            ABMultiValueRef valuesRef = ABRecordCopyValue(person, property);
            NSInteger valuesCount = 0;
            if (valuesRef != nil) valuesCount = ABMultiValueGetCount(valuesRef);
            
            if (valuesCount == 0) {
                CFRelease(valuesRef);
                continue;
            }
            
            for (NSInteger k = 0; k < valuesCount; k++) {
                CFStringRef value = ABMultiValueCopyValueAtIndex(valuesRef, k);
                switch (j) {
                    case 0: {// Phone number
                        if (k == 0) {
                            
                            addressBook.tel = [self telephoneWithReformat:(NSString*)value];
                        }else if (k == 1) {
                            addressBook.tel2 = [self telephoneWithReformat:(NSString*)value];
                        }
                        break;
                    }
                    case 1: {// Email
                        addressBook.email = (NSString*)value;
                        break;
                    }
                }
                CFRelease(value);
            }
            CFRelease(valuesRef);
        }
//        NSLog(@"%@",addressBook);     
        //存储
        [self.contactDic setObject:addressBook forKey:[NSNumber numberWithInteger:addressBook.recordID]];
        //添加到搜索库
        [[SearchCoreManager share] AddContact:[NSNumber numberWithInteger:addressBook.recordID] name:addressBook.name phone:nil];
        if (addressBook.tel.length != 0) {
            
            [addressBookTemp addObject:addressBook];
        }
        [addressBook release];
        
        if (abName) CFRelease(abName);
        if (abLastName) CFRelease(abLastName);
        if (abFullName) CFRelease(abFullName);
    }
    
    CFRelease(allPeople);
    CFRelease(addressBooks);
    
    // Sort data
    UILocalizedIndexedCollation *theCollation = [UILocalizedIndexedCollation currentCollation];
    for (QCAddressBook *addressBook in addressBookTemp) {
        NSInteger sect = [theCollation sectionForObject:addressBook
                                collationStringSelector:@selector(name)];
        addressBook.sectionNumber = sect;
    }
    
    NSInteger highSection = [[theCollation sectionTitles] count];
    NSMutableArray *sectionArrays = [NSMutableArray arrayWithCapacity:highSection];
    for (int i=0; i<=highSection; i++) {
        NSMutableArray *sectionArray = [NSMutableArray arrayWithCapacity:1];
        [sectionArrays addObject:sectionArray];
    }
    
    for (QCAddressBook *addressBook in addressBookTemp) {
        [(NSMutableArray *)[sectionArrays objectAtIndex:addressBook.sectionNumber] addObject:addressBook];
    }
    int i = 0;
    for (NSMutableArray *sectionArray in sectionArrays) {
        i++;
        //通讯录纯数字姓名不加入排序数组
        if (i <= KLetterNum) {
        
        NSArray *sortedSection = [theCollation sortedArrayFromArray:sectionArray collationStringSelector:@selector(name)];
        [_listContent addObject:sortedSection];
            
        }
    }

}

#pragma mark UITableViewDataSource & UITableViewDelegate

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [[NSArray arrayWithObject:UITableViewIndexSearch] arrayByAddingObjectsFromArray:
            [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles]];
}

//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
//{
//    
//    if (title == UITableViewIndexSearch) {
//        [tableView scrollRectToVisible:self.searchDisplayController.searchBar.frame animated:NO];
//        return -1;
//    } else {
//        return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index-1];
//    }
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([_searchBar.text length] <= 0) {
        return [_listContent count];
    } else {
        return 1;
    }
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return [[_listContent objectAtIndex:section] count] ? [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section] : nil;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [[_listContent objectAtIndex:section] count] ? tableView.sectionHeaderHeight : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_searchBar.text length] <= 0) {
        return [[_listContent objectAtIndex:section] count];
    } else {
        return self.searchByName.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *kCustomCellID = @"Cell";
	AddressListCell *cell = [tableView dequeueReusableCellWithIdentifier:kCustomCellID];
	if (cell == nil)
	{
		cell = [[[AddressListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCustomCellID] autorelease];
        cell.selectedBackgroundView = [[[UIView alloc]init]autorelease];
        cell.selectedBackgroundView.backgroundColor = rgb(255, 221, 201, 0.5);

	}
//
//    if (self.typeArr.count > 0 && self.typeArr != nil) {
//        
//        cell.result = [[self.typeArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
//    }
//        cell.addressBook = (QCAddressBook *)[[_listContent objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
// 
//    if (_searchBar.text.length <= 0) {
//
//    }
//
//    else {
//        NSArray *sectionArr = [self.searchByName sortedArrayUsingSelector:@selector(compare:)];
//        cell.localId = [sectionArr objectAtIndex:indexPath.row];
//
//    }

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (self.isSecretary==YES) {
    
        QCAddressBook *addressBook = nil;
        if ([_searchBar.text length] <= 0) {
            addressBook = (QCAddressBook*)[[_listContent objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            if([self.delegate respondsToSelector:@selector(MySecretaryPushAction:)]){
                [self.delegate MySecretaryPushAction:addressBook.tel];
            };
            [self.navigationController popViewControllerAnimated:YES];}
    }
    else{
    
        [self tableView:_tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
        [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    QCAddressBook *addressBook = nil;
    if ([_searchBar.text length] <= 0) {
        addressBook = (QCAddressBook*)[[_listContent objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
        
    }else {
        NSNumber *localID = nil;
        NSArray *sectionArr = [self.searchByName sortedArrayUsingSelector:@selector(compare:)];
        localID = [sectionArr objectAtIndex:indexPath.row];
        
        //姓名匹配 获取对应匹配的拼音串 及高亮位置
        addressBook = [self.contactDic objectForKey:localID];
    }
    
    BOOL checked = !addressBook.rowSelected;
    addressBook.rowSelected = checked;
    
    // Enabled rightButtonItem
    
    UITableViewCell *cell =[_tableView cellForRowAtIndexPath:indexPath];
    UIButton *button = (UIButton *)cell.accessoryView;
//    [button setSelected:checked];

    if (button.tag == kAddTag) {
        QCAddFriendViewController *addVC = [[QCAddFriendViewController alloc] initWithUserType:YES];
        addVC.addressBook = addressBook;
        [self.navigationController pushViewController:addVC animated:YES];
        [addVC release];
        
    }else if (button.tag == kAddedTag) {
//        QCAddFriendViewController *addVC = [[QCAddFriendViewController alloc] initWithUserType:NO];
//        addVC.addressBook = addressBook;
//        [self.navigationController pushViewController:addVC animated:YES];
//        [addVC release];
        
    }else {
        QCFriendInviteViewController * inviteView = [[QCFriendInviteViewController alloc]init];
        inviteView.addressBook = addressBook;
        [self.navigationController pushViewController:inviteView animated:YES];
        [inviteView release];
        
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        [self.searchDisplayController.searchResultsTableView reloadData];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *title = [[_listContent objectAtIndex:section] count] ? [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section] : nil;
//    NSLog(@"%@",title);
    if ([_searchBar.text length] <= 0) {
        UIView * subView = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 22)] autorelease];
        subView.backgroundColor = rgb(255, 221, 202, 1);
        [self CreateLabel:[NSString stringWithFormat:@"%@",title] frame:CGRectMake(10, 0, 50, 20) withView:subView textAlignment:1 fontSize:15 textColor:rgb(51, 51, 51, 1)];
        return subView;
    } else {
        UIView * subView = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 22)] autorelease];
        subView.backgroundColor = rgb(255, 221, 202, 1);
        return subView;
    }
}

- (void)checkButtonTapped:(id)sender event:(id)event
{
	NSSet *touches = [event allTouches];
	UITouch *touch = [touches anyObject];
	CGPoint currentTouchPosition = [touch locationInView:_tableView];
	NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint: currentTouchPosition];
	
	if (indexPath != nil)
	{
		[self tableView:_tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
	}
    
}
//
//#pragma mark --------- UISearchBar--------------------
//
//- (void) letSearchBarLostFocus:(UISearchBar *)sb {
//    [sb resignFirstResponder];
////    [sb setShowsCancelButton:NO animated:YES];
//}
//- (void) letSearchBarGainFocus:(UISearchBar *)sb {
////    [sb setShowsCancelButton:YES animated:YES];
//    [sb setShowsCancelButton:YES animated:NO];
//
//}
//
//- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
//{
//    [self letSearchBarGainFocus:searchBar];
//}
//
//
//- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
//{
//    [self letSearchBarLostFocus:searchBar];
//}
//
//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
//{
//    [self letSearchBarLostFocus:searchBar];
//
//	[_tableView reloadData];
//}
//
//- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
//{
//    [self letSearchBarLostFocus:searchBar];
//
//	[_tableView reloadData];
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    [self letSearchBarLostFocus:_searchBar];
//}
#pragma mark - QCSearchBar Delegate
- (void)QCSearchBarDidBeginEditing:(QCSearchBar *)searchBar {
    _cover.hidden = NO;

}

- (void)QCSearchBarDidEndEditing:(QCSearchBar *)searchBar {
    _cover.hidden = YES;

}

- (void)QCSearchBarshouldChangeCharacters:(QCSearchBar *)searchBar {
    if (searchBar.text.length == 0) {
        _cover.hidden = NO;
        
    }else {
        _cover.hidden = YES;
    }
    [[SearchCoreManager share] Search:_searchBar.text searchArray:nil nameMatch:self.searchByName phoneMatch:nil];
    [_tableView reloadData];
}

- (void)QCSearchBarShouldClear:(QCSearchBar *)searchBar {
    _cover.hidden = YES;
    
    [_tableView reloadData];
}

- (void)QCSearchBarDidSearch:(QCSearchBar *)searchBar {
    _cover.hidden = YES;
}

#pragma mark - Private Methods
- (NSString*)telephoneWithReformat:(NSString *)value
{
    NSMutableString *string = [NSMutableString new];
    for (int i = 0; i<value.length; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subStr = [value substringWithRange:range];
        if ([subStr isEqualToString:@"-"]) {
            subStr = @"";
        }else if ([subStr isEqualToString:@" "]) {
            subStr = @"";
        }else if ([subStr isEqualToString:@"("]) {
            subStr = @"";
        }else if ([subStr isEqualToString:@")"]) {
            subStr = @"";
        }
        
        [string appendString:subStr];
    }
    
    
    return (NSString *)string;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [_searchBar resignFirstResponder];
    _searchBar.isVisible = NO;
    if (self.iHttpOperator != nil) {
        [self.iHttpOperator cancel];
    }
}

//隐藏Tabbar
//- (void)viewWillAppear:(BOOL)animated
//{
//    [UIView animateWithDuration:0.35 animations:^{
//        NSArray * view = [self.tabBarController.view subviews];
//        UIView *subview = [view objectAtIndex:1];
//        subview.frame = CGRectMake(0, kDeviceHeight-49, kDeviceWidth, 49);
//    }];
//}
- (void)leftAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)coverAction:(UIControl *)cover {
    [_tableView reloadData];
    
    [_searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
