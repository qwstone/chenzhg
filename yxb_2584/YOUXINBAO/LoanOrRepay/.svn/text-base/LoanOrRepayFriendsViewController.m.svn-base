//
//  LoanOrRepayFriendsViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 15/7/21.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanOrRepayFriendsViewController.h"
#import "LoanOrRepayFriendsCell.h"
#import "LoanOrRepayAddressbookCell.h"
#import "UIImageView+WebCache.h"
#import "YXBTool.h"
#import "QCAddressBook.h"
#import "TFriendRelationManager.h"
#import "NSSkyArray.h"
#import "TResultSet.h"
#import "SearchCoreManager.h"
#import "StatusHttp.h"
#import "YXBPayAction.h"
#import "LoanOrRepayViewController.h"
#import "LoanConfig.h"
#import "WXApi.h"
#import "UIAlertView+Block.h"
#import <MessageUI/MFMessageComposeViewController.h>
#import "TFriendRelation.h"
#import "AddressBookModel.h"
#import "AddressDBManager.h"

#define kFooterButtonTag 30100
#define kBorrowAlertTag 30110
#define kLenderAlertTag 30111

@interface LoanOrRepayFriendsViewController ()<QCBaseTableViewDelegate,StatusHttpDelegate,MFMessageComposeViewControllerDelegate> {
    UIButton *_selectedStyleButton; //底部选中按钮
    BOOL _hasSavedAddressBook;//是否已保存
}

@property (nonatomic,strong)NSMutableArray *contactModelArray;//用于搜索
@end

@implementation LoanOrRepayFriendsViewController

-(void)dealloc{
    NSLog(@"LoanOrRepayFriendsViewController is dealloc");
}
- (void)viewDidLoad {
    
    //进入页面即 加载通讯录
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self getAddressBookSaveToDB];
//
//    });

    
    _addressBookTemp = [NSMutableArray new];
    _addTypeBook = [NSMutableArray new];
    _listContent = [NSMutableArray new];
    _contactModelArray = [NSMutableArray new];

    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self clearAddressBooks];
//        [self getAddressBookSaveToDB];
//        [self loadAddressBookSavedData];
//        
//    });

    [super viewDidLoad];
    [self setTitle:@"选择朋友"];
    [self setBackView];

    CGFloat footerH = getScreenFitSize(107);
    //搜索栏
    CGFloat headerH = getScreenFitSize(73.0/2);
    
    self.linkManListView.frame = CGRectMake(0, headerH, kDeviceWidth, kDeviceHeight-64-footerH-headerH);
    self.linkManListView.separatorColor = kLineColor;
    self.linkManListView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.linkManListView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.linkManListView.delegate = nil;
    self.linkManListView.dataSource = nil;
//    self.linkManListView.refreshDelegate = nil;
    self.linkManListView.delegate = self;
    self.linkManListView.dataSource =self;
//    self.linkManListView.refreshDelegate = self;
//    self.linkManListView.hideRefeshHeader = YES;
    self.bottomView.hidden = YES;
    if (self.noRecordView.superview != nil) {
        [self.noRecordView removeFromSuperview];
    }
    
    if (self.isFromBorrow || self.isSelectPeople) {
        UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, self.linkManListView.bottom, kDeviceWidth, footerH)];
        footer.layer.borderColor = [YXBTool colorWithHexString:@"#E0E0E0"].CGColor;
        footer.layer.borderWidth = 1.0;
        footer.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:footer];
        NSArray *images = @[@"xz-footnav1",@"xz-footnav2",@"xz-footnav3"];
        NSArray *selectedImages = @[@"xz-footnav11",@"xz-footnav22",@"xz-footnav33"];
        CGFloat footerButtonW = kDeviceWidth/images.count;
//        CGFloat footerButtonH = getScreenFitSize(82);
        CGFloat footerButtonH = footerH;
        for (int i = 0; i<images.count; i++) {
            UIButton *footerButton = [[UIButton alloc] initWithFrame:CGRectMake(footerButtonW*i, (footerH-footerButtonH)/2, footerButtonW, footerButtonH)];
            [footerButton setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
            [footerButton setImage:[UIImage imageNamed:selectedImages[i]] forState:UIControlStateSelected];
            footerButton.tag = kFooterButtonTag+i;
            [footerButton addTarget:self action:@selector(footerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [footer addSubview:footerButton];
            
            if (i != 0) {
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(footerButton.left, 0, 1, footerH)];
                line.backgroundColor = [YXBTool colorWithHexString:@"#E0E0E0"];
                [footer addSubview:line];
                
            }else {
                footerButton.backgroundColor = [YXBTool colorWithHexString:@"#EFEFEF"];
                footerButton.selected = YES;
                _selectedStyleButton = footerButton;
            }
        }
        
    }else if (self.isFromLender) {
        self.linkManListView.frame = CGRectMake(0, headerH, kDeviceWidth, kDeviceHeight-64-headerH);
    }
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    self.friendStyle = LoanOrRepayFriendsStyleYXB;

    [super viewDidAppear:YES];
}

//-(void)viewDidLayoutSubviews
//{
//    if ([self.linkManListView respondsToSelector:@selector(setSeparatorInset:)]) {
//        [self.linkManListView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
//    }
//    
//    if ([self.linkManListView respondsToSelector:@selector(setLayoutMargins:)]) {
//        [self.linkManListView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
//    }
//}
//
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsZero];
//    }
//    
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }
//}

- (void)footerButtonAction:(UIButton *)button {
    
    if (button.tag == kFooterButtonTag) {
        self.isLoanRepay = NO;
        [self.dataDictionary removeAllObjects];
        [self.sortedkeysArray removeAllObjects];
        //友信宝
        self.friendStyle = LoanOrRepayFriendsStyleYXB;
//        [self.linkManListView beginRefreshing];
        [self refreshCurrentData];
        
    }else if (button.tag == kFooterButtonTag+1) {
        self.isLoanRepay = YES;
        [self.dataDictionary removeAllObjects];
        [self.sortedkeysArray removeAllObjects];

        if (self.isSelectPeople) {
            if (self.payType == AmorOrderPayTypeOtherPay ||
                self.payType == AmorOrderPayTypeOtherPayAll ||
                self.payType == AmorOrderPayTypeSelectPeople)
            {
                [ProgressHUD showErrorWithStatus:@"通讯录功能暂不支持！"];
                self.friendStyle = LoanOrRepayFriendsStyleYXB;
                self.isLoanRepay = NO;

                return;

            }
        }
        //通讯录
        if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted || ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请开启访问通讯录功能,获取通讯录好友" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alert show];
            return;
            
        }
        
        self.friendStyle = LoanOrRepayFriendsStyleAddress;
        
        if (_addressBookTemp.count == 0) {
            //通讯录为空处理。
            [self.linkManListView reloadData];
        }else {
//            [self.linkManListView beginRefreshing];

            [self refreshCurrentData];
        }
        
        
    }else if (button.tag == kFooterButtonTag+2) {
        self.isLoanRepay = NO;
        //微信
        if (![WXApi isWXAppInstalled]) {
            [ProgressHUD showErrorWithStatus:@"请安装微信后重试！"];
            return;
        }

        NSString *title = @"您确定向微信好友借款?";
        if (self.isSelectPeople) {
            if (self.payType == AmorOrderPayTypeOtherPayAll ||
                self.payType == AmorOrderPayTypeOtherPay)
            {
                [ProgressHUD showErrorWithStatus:@"暂不支持选择微信代付！"];
                return;
//                title = @"选择微信好友担保?";

            }
            else if(self.payType == AmorOrderPayTypeSelectPeople)
            {
                title = @"选择微信好友担保?";

            }

        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:title delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        __weak typeof(self) this = self;
        if(!self.isSelectPeople)
        {
            [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
                if (buttonIndex == 1) {
                    self.loanModel.loanFriendType = YXBPayDesWeChat;
                    
                    if (self.delegate && [self.delegate respondsToSelector:@selector(createLoanDetailWithLoan:)]) {
                        [super leftClicked];
                        
                        if (_isFromSend == 0) {
                            [self.delegate createLoanDetailWithLoan:self.loanModel];
                            
                        }
                        else
                        {
                            [self.delegate callWeChatWithLoanId:self.loanModel.t_id];
                            
                        }
                    }
                    
                }
                
            }];
        }
        else
        {
            [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
                if (buttonIndex == 1) {
                    self.loanModel.loanFriendType = YXBPayDesWeChat;
                    
                    if (self.delegate && [self.delegate respondsToSelector:@selector(callWeChatWithLoanId:)])
                    {
                        
                        [self.delegate callWeChatWithLoanId:self.loanModel.t_id];
                        
                        [super leftClicked];

                    }
                    
                }
                
            }];
        }
        

    }
    
    _selectedStyleButton.backgroundColor = [UIColor clearColor];
    _selectedStyleButton.selected = NO;
    button.backgroundColor = [YXBTool colorWithHexString:@"#EFEFEF"];
    button.selected = YES;
    _selectedStyleButton = button;
}

- (void)setFriendStyle:(LoanOrRepayFriendsStyle)friendStyle {
    _friendStyle = friendStyle;
    [self getPhoneNum];
}

#pragma mark - Address book
- (void)getPhoneNum {
    
    if (_friendStyle == LoanOrRepayFriendsStyleAddress) {
    
        if(self.addressDataDictionary != nil && self.addressSortedkeysArray != nil)
        {
            self.dataDictionary = [NSMutableDictionary dictionaryWithDictionary:self.addressDataDictionary];
            self.sortedkeysArray = [NSMutableArray arrayWithArray:self.addressSortedkeysArray];

            [self refreshCurrentData];
        }
        else
        {
            NSInteger hasSaved = [[[NSUserDefaults standardUserDefaults] objectForKey:hasSavedAddressBook] integerValue];
            if (hasSaved == 1) {
                //如果数据库里有数据

                [self loadAddressBookSavedData];
                ;
            }
            else
            {
//                [self clearAddressBooks];
//                [self getAddressBookSaveToDB];
//                [self loadAddressBookSavedData];
                //友信宝好友界面已经开了一个读取的线程  读取结束之后会递归调用这个方法
                [ProgressHUD showWithStatus:@"正在读取..." maskType:ProgressHUDMaskTypeNone tipsType:ProgressHUDTipsTypeBottom];

            }

        }
    }
    else
    { //友信宝用户  下面显示通讯录好友

        if(self.addTypeBook == nil || [self.addTypeBook count] == 0)
        {

            NSInteger hasSaved = [[[NSUserDefaults standardUserDefaults] objectForKey:hasSavedAddressBook] integerValue];
            if (hasSaved == 1) {
                //如果数据库里有数据
                [self readAddressDB];
                
            }
            else
            {
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [self clearAddressBooks];
                    [self getAddressBookSaveToDB];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self getPhoneNum];
                    });

                });

//                [self loadAddressBookSavedData];
                
            }

            
            [self refreshCurrentData];


        }
        else
        {
            [self.linkManListView reloadData];
        }

    


    }

    
}

-(void)getAddressBookSaveToDB
{
    //获取通讯录信息
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted || ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请开启访问通讯录功能,获取通讯录好友" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [alert show];
        });
        
    }
    
    [_addressBookTemp removeAllObjects];
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
            NSDictionary* personaddress =(__bridge NSDictionary*) ABMultiValueCopyValueAtIndex(address, j);
            NSString* city = [personaddress valueForKey:(NSString *)kABPersonAddressStateKey];
            addressBook.city = city;
        }
        
        NSString *nameString = (__bridge NSString *)abName;
        NSString *lastNameString = (__bridge NSString *)abLastName;
        
        if ((__bridge id)abFullName != nil) {
            nameString = (__bridge NSString *)abFullName;
        } else {
            if ((__bridge id)abLastName != nil)
            {
                nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastNameString];
            }
        }
        
        addressBook.name = nameString;
        addressBook.recordID = (int)ABRecordGetRecordID(person);;
        addressBook.rowSelected = NO;
        addressBook.resStatus = -1;
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
                            
                            addressBook.tel = [self telephoneWithReformat:(__bridge NSString*)value];
                        }
                        //                        else if (k == 1) {
                        //                            addressBook.tel2 = [self telephoneWithReformat:(__bridge NSString*)value];
                        //                        }
                        break;
                    }
                    case 1: {// Email
                        addressBook.email = (__bridge NSString*)value;
                        break;
                    }
                }
                CFRelease(value);
            }
            CFRelease(valuesRef);
            
            if (addressBook.name != nil && addressBook.tel != nil) {
                addressBook.pinyin = [YXBTool pinyinWithText:addressBook.name];
                [self saveAddressBook:addressBook];

            }
            
        }
        //        NSLog(@"%@",addressBook);
        
        
        if (abName) CFRelease(abName);
        if (abLastName) CFRelease(abLastName);
        if (abFullName) CFRelease(abFullName);
        
    }
    
    CFRelease(allPeople);
    CFRelease(addressBooks);
    
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:hasSavedAddressBook];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self refreshCurrentData];

}

-(NSInteger)loadAddressBookSavedData
{
    
    NSMutableArray *friendArray = [NSMutableArray array];
    
    //读取数据库
    NSArray *users = [[AddressDBManager shareInstance] query:DBAddressBookModelName predicate:nil];
    
    NSLog(@"mmmmmmmmmmmmm");

    if (_addressBookTemp != nil && [_addressBookTemp count] > 0) {
        [_addressBookTemp removeAllObjects];
    }

    for (AddressBookModel *model in users) {
        NSLog(@"model.name----%@",model.name);
        QCAddressBook *addressBook = [[QCAddressBook alloc] init];
        addressBook.city = model.city;
        addressBook.name = model.name;
        addressBook.recordID = [model.recordID integerValue];
        addressBook.rowSelected = [model.rowSelected boolValue];
        addressBook.tel = model.tel;
        addressBook.tel2 = model.tel2;
        addressBook.pinyin = model.pinyin;
//        [friendArray addObject:addressBook];
        
        
        
        if (addressBook.name != nil && [addressBook.name length] > 0 && addressBook.tel != nil)
        {
            [_addressBookTemp addObject:addressBook];
            
        }
        
        User *user = [[User alloc] init];
        user.username = addressBook.tel;
        user.nickname = addressBook.name;
        user.nameSpell = addressBook.pinyin;
        user.t_id = -1;
        TFriendRelation *fuser = [[TFriendRelation alloc] init];
        fuser.errCode = 0;
        fuser.friendUser = user;
        [friendArray addObject:fuser];



    }
    
    NSLog(@"nnnnnnnnnnn");
    
    self.fullModelArray = [NSMutableArray arrayWithArray:friendArray] ;

    [self updateUIWithArray:friendArray isSaved:YES];

//    [self processDataWithAddresspeopleArray:friendArray];
    return [friendArray count];
}

//读取数据库获取通讯录号码
-(void)readAddressDB
{
    //读取数据库
    NSArray *users = [[AddressDBManager shareInstance] query:DBAddressBookModelName predicate:nil];
    
    NSLog(@"mmmmmmmmmmmmm");
    
    if (_addressBookTemp != nil && [_addressBookTemp count] > 0) {
        [_addressBookTemp removeAllObjects];
    }
    
    for (AddressBookModel *model in users) {
        NSLog(@"model.name----%@",model.name);
        QCAddressBook *addressBook = [[QCAddressBook alloc] init];
        addressBook.city = model.city;
        addressBook.name = model.name;
        addressBook.recordID = [model.recordID integerValue];
        addressBook.rowSelected = [model.rowSelected boolValue];
        addressBook.tel = model.tel;
        addressBook.tel2 = model.tel2;
        addressBook.pinyin = model.pinyin;
        //        [friendArray addObject:addressBook];
        
        
        
        if (addressBook.name != nil && [addressBook.name length] > 0 && addressBook.tel != nil)
        {
            [_addressBookTemp addObject:addressBook];
            
        }
        
        
    }

}

//将网络请求返回的状态添加到通讯录当中
-(void)saveAddressDataWithResStatusArray:(NSArray *)resStatusArray
{
    //读取数据库
    NSArray *users = [[AddressDBManager shareInstance] query:DBAddressBookModelName predicate:nil];
    
//    for (AddressBookModel *model in users)
    if ([users count] == [resStatusArray count])
    {
//        [self clearAddressBooks];
        for (int i = 0; i < [users count]; i ++)
        {
            TResultSet *result = resStatusArray[i];
            AddressBookModel *model = users[i];
            model.resStatus = [NSNumber numberWithInt:(int)result.resInteger];
            [[AddressDBManager shareInstance] updateManagerObj:model];
        }

    }
    else
    {
        
    }

}

-(void)clearAddressBooks
{
    NSArray *users = [[AddressDBManager shareInstance] query:DBAddressBookModelName predicate:nil];
    for (NSManagedObject *user in users) {
        [[AddressDBManager shareInstance] removeManagerObj:user];
        
    }
    
}

//通讯录保存到本地
-(void)saveAddressBook:(QCAddressBook *)addressBook
{
    //保存用户数据
    AddressBookModel *model = (AddressBookModel *)[[AddressDBManager shareInstance] createMO:DBAddressBookModelName];
    
    model.city = addressBook.city;
    model.name = addressBook.name;
    model.recordID = [NSNumber numberWithInteger:addressBook.recordID];
    model.rowSelected = [NSNumber numberWithBool:addressBook.recordID];
    model.tel = addressBook.tel;
    model.tel2 = addressBook.tel2;
    model.pinyin = addressBook.pinyin;
    model.resStatus = [NSNumber numberWithInteger:addressBook.resStatus];
    [[AddressDBManager shareInstance] saveManagerObj:model];
    
}

//将通讯录信息放到一个数组里，然后进行处理，把之前的一个步骤分成两步

-(void)processDataWithAddresspeopleArray:(NSArray *)addressArray
{
//    if (_addressBookTemp != nil && [_addressBookTemp count] > 0) {
//        [_addressBookTemp removeAllObjects];
//    }
    
    
    NSMutableArray *friendArray = [NSMutableArray array];
/*
    for (QCAddressBook *addressBook in addressArray) {
        if (addressBook.tel.length != 0) {
            if (addressBook.name != nil && [addressBook.name length] > 0 && addressBook.tel != nil)
            {
                [_addressBookTemp addObject:addressBook];
                

                
            }
        }

    }
    
    */
    
    NSLog(@"ssssss");
    if (self.friendStyle == LoanOrRepayFriendsStyleAddress) {
        
//        [_listContent removeAllObjects];
        
        for (QCAddressBook *addressBook in _addressBookTemp)
        {
            User *user = [[User alloc] init];
            user.username = addressBook.tel;
            user.nickname = addressBook.name;
            user.nameSpell = [YXBTool pinyinWithText:user.nickname];
            user.t_id = -1;
            TFriendRelation *fuser = [[TFriendRelation alloc] init];
            fuser.errCode = 0;
            fuser.friendUser = user;
            [friendArray addObject:fuser];
        }
        
        self.fullModelArray = [NSMutableArray arrayWithArray:friendArray] ;
        NSLog(@"eeeeee");

        [self updateUIWithArray:friendArray isSaved:YES];
//        NSLog(@"friendArray----%@",friendArray);
    }
}

/*
-(void)saveDataToDBWithUser:(QCAddressBook *)friendUser
{
    //保存用户数据
    AddressBookModel *model = (AddressBookModel *)[[DBManager shareInstance] createMO:@"AddressBookModel"];
    
    model.city = friendUser.city;
    model.name = friendUser.name;
    model.recordID = [NSNumber numberWithInteger:friendUser.recordID];
    model.rowSelected = [NSNumber numberWithBool:friendUser.recordID];
    model.tel = friendUser.tel;
    model.tel2 = friendUser.tel2;
    [[DBManager shareInstance] saveManagerObj:model];
    
}

*/


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

- (void)getFriendType {
    
    
    if (_friendStyle == LoanOrRepayFriendsStyleAddress && _addressBookTemp.count == 0) {
        //通讯录为空处理。
        /*
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"未读取到数据" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            
            if (buttonIndex == 1) {
//                [self.linkManListView reloadDeals];

            }
        }];
        */
        return;
    }
    
    NSMutableString *phoneNumbs = [NSMutableString stringWithFormat:@""];
    for (int i = 0; i<_addressBookTemp.count; i++) {
        
        QCAddressBook *addressBook = [_addressBookTemp objectAtIndex:i];
        NSMutableString *appendStr;
        if (i < _addressBookTemp.count-1) {
            appendStr = [NSMutableString stringWithFormat:@"%@,",addressBook.tel];
        }else {
            appendStr = [NSMutableString stringWithFormat:@"%@",addressBook.tel];
        }
        [phoneNumbs appendString:appendStr];
    }
    //    if (self.iHttpOperator == nil) {
    
    //    }
    if (self.iHttpOperator != nil) {
        [self.iHttpOperator cancel];
    }
    else
    {
        self.iHttpOperator = [[HttpOperator alloc]init];

    }
    __block HttpOperator * assginHtttperator = self.iHttpOperator;
    __block LoanOrRepayFriendsViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
        }
        
    } param:^(NSString *s) {
        
        [this httpLOadParams:s httpOperation:assginHtttperator withphoneNumbsStr:phoneNumbs];
    } complete:^(NSSkyArray *r, int taskid) {
        
        [this httpLoadCompleteAddress:r];
    }];
    [self.iHttpOperator connect];
    
    
}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation withphoneNumbsStr:(NSMutableString *)phoneNumbs
{
    QCUserModel *localUser = [[QCUserManager sharedInstance] getLoginUser];
    User *user = localUser.user;
    NSString *userName = user.username;
    
    TFriendRelationManager* _currFriend = (TFriendRelationManager *)  [httpOperation getAopInstance:[TFriendRelationManager class] returnValue:[NSSkyArray class]];
    
    [_currFriend getTFriendRelationByPhoneBook:userName withPhoneArr:phoneNumbs];
    

}
//请求完成
-(void)httpLoadCompleteAddress:(NSSkyArray *)r{
    [ProgressHUD dismiss];
    
    if (r.iArray.count != 0) {
        if (self.friendStyle == LoanOrRepayFriendsStyleAddress)
        {
            //将状态保存到本地数据库中
            if (_hasSavedAddressBook == NO) {
                //                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                ////                        [self saveAddressDataWithResStatusArray:r.iArray];
                //                    });
                _hasSavedAddressBook = YES;
                
                
            }
        }
        
        TResultSet *testResult = [r.iArray lastObject];
        NSInteger errCode = testResult.errCode;
        
        if (errCode == 0) {
            
            
            NSMutableArray *goodFriends = [NSMutableArray new];
            for (int i = 0; i<r.iArray.count && i < [self.addressBookTemp count]; i++) {
                TResultSet *result = [r.iArray objectAtIndex:i];
                if (result.resInteger == 0) {
                    //友信宝用户&&手机通讯录朋友
                    QCAddressBook *addressBook = [self.addressBookTemp objectAtIndex:i];
                    User *user = [[User alloc] init];
                    user.username = addressBook.tel;
                    user.nickname = addressBook.name;
                    user.nameSpell = [YXBTool pinyinWithText:user.nickname];
                    user.t_id = -1;
                    [goodFriends addObject:user];
                    //                        //添加到搜索库
                    //                        [[SearchCoreManager share] AddContact:[NSNumber numberWithInteger:addressBook.recordID] name:addressBook.name phone:nil];
                }
            }
            
            //友信宝用户&&手机通讯录朋友
            if (goodFriends.count == 0) {
                [self.addTypeBook removeAllObjects];
            }else {
                self.addTypeBook = goodFriends;
            }
            
            
            
        } else {
            UIAlertView *alter = [[UIAlertView alloc]initWithTitle:nil message:r.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
            //                [this showLoadingWithTitle:testResult.errString imageName:nil];
            //                [this performSelector:@selector(hideLoading) withObject:nil afterDelay:2];
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.linkManListView reloadData];
        //            [this.linkManListView reloadDeals];
        
    });

}
#pragma mark  --------------------------- refresh
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView
{
    [self refreshCurrentData];
    /*
    if (self.friendStyle == LoanOrRepayFriendsStyleYXB) {
        if (_hasSavedAddressBook == NO) {
            [self getFriendAndAddressbook];

        }
        
    }else if (self.friendStyle == LoanOrRepayFriendsStyleAddress){
        if(_hasSavedAddressBook == NO)
        {
            [self getFriendType];

        }
    }
    */
}

-(void)refreshCurrentData
{
    if (self.friendStyle == LoanOrRepayFriendsStyleYXB) {
            [self getFriendAndAddressbook];
        
    }else if (self.friendStyle == LoanOrRepayFriendsStyleAddress){
        if(_hasSavedAddressBook == NO)
        {
            [self getFriendType];
            _hasSavedAddressBook = YES;
            
        }
        
        [self.linkManListView reloadData];
        
        
    }
}

- (void)getFriendAndAddressbook {
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(queue, ^{
//        dispatch_group_t group = dispatch_group_create();
//        
//        if (self.isFromBorrow) {
//            dispatch_group_async(group, queue, ^{
//                [self getFriendType];
//            });
//        }
//        
//        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//            [self loadData];
//        });
//    });
    if (self.isFromBorrow) {
        if (_friendStyle == LoanOrRepayFriendsStyleAddress) {
            [self getFriendType];

        }
        else
        {
            [self loadSavedData];
            [self loadData];
            [self getFriendType];

        }
    }
    else
    {
        [self loadSavedData];
        [self loadData];


    }

}

#pragma mark - UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.friendStyle == LoanOrRepayFriendsStyleYXB) {
        if ([_searchBar.text length] <= 0) {
            
            return (self.addTypeBook.count == 0 ? self.sortedkeysArray.count:self.sortedkeysArray.count+1);
        } else {
            return 1;
        }
        
    }else {
        if ([_searchBar.text length] <= 0) {
            
//            return self.listContent.count;
            return [self.sortedkeysArray count];
        } else {
            return 1;
        }
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.friendStyle == LoanOrRepayFriendsStyleYXB) {
        if ([_searchBar.text length] <= 0) {
            if (section>=self.sortedkeysArray.count) {
                //推荐好友
                return self.addTypeBook.count;
            }else {
                if (self.sortedkeysArray.count != 0) {
                    
//                    NSMutableArray *nameArr = [self.sortedkeysArray objectAtIndex:section];
                    NSMutableArray *nameArr = [self.dataDictionary objectForKey:self.sortedkeysArray[section]];
                    return nameArr.count;
                    
                }else {
                    return 0;
                }
                
            }
        } else {
//            return self.searchByName.count;
            if ([self.sortedkeysArray count] == 0) {
                return 0;
            }
            else
            {
                return [[self.dataDictionary objectForKey:self.sortedkeysArray[section]] count];
                
            }

        }
        
    }else {
        
        if ([self.sortedkeysArray count] == 0) {
            return 0;
        }
        else
        {
            if ([_searchBar.text length] <= 0) {

                return [[self.dataDictionary objectForKey:self.sortedkeysArray[section]] count];
            } else {
                
                /*
                if([self.listContent count] == 1)
                {
                    return 0;
                }
                else
                {
                    NSMutableArray *nameArr = [self.listContent objectAtIndex:section];
                    return nameArr.count;
                    
                }
                */
                //            return self.searchByName.count;
                
                return [[self.dataDictionary objectForKey:self.sortedkeysArray[section]] count];

            }

        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.friendStyle == LoanOrRepayFriendsStyleYXB) {
        return (indexPath.section<self.sortedkeysArray.count ? kLinkManCellHeight : kAddressbookCellHeight);
        
    }else {
        return kAddressbookCellHeight;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_searchBar.text.length <= 0) {
        return kSectionHeight;
        
    }else {
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIColor *selectedColor = [YXBTool colorWithHexString:@"#BFBFBD"];
    
    if (self.friendStyle == LoanOrRepayFriendsStyleYXB) {
        if (indexPath.section<self.sortedkeysArray.count) {
            static NSString * cellId = @"cellID";
            LoanOrRepayFriendsCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[LoanOrRepayFriendsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.width = self.linkManListView.width;
                cell.height = kLinkManCellHeight;
                [cell closeSwipeAction];
                cell.selectedBackgroundView = [[UIView alloc]init];
                cell.selectedBackgroundView.backgroundColor = selectedColor;
                cell.m_checkImageView.hidden = YES;
            }
            cell.nameLabel.font = [UIFont systemFontOfSize:CellLabelFont];

            if (self.isFromBorrow) {
//                cell.isBorrow = YES;
                cell.cellType = LoanFriendCellTypeBorrow;
            }else if(self.isFromLender) {
//                cell.isBorrow = NO;
                cell.cellType = LoanFriendCellTypeLend;

            }else if(self.isSelectPeople)
            {
                cell.cellType = LoanFriendCellTypeSelectPeople;
            }
            
            if (self.sortedkeysArray.count != 0) {
                User *friendUser;
                if ([self.sortedkeysArray count] > 0 && indexPath.section < [self.sortedkeysArray count]) {
                    NSArray *mArray = [self.dataDictionary objectForKey:self.sortedkeysArray[indexPath.section]];
                    if (indexPath.row < [mArray count]) {
                        friendUser = [mArray objectAtIndex:indexPath.row];

                    }

                }
                
                cell.friendUser = friendUser;
            }
            
            return cell;
            
        }
        else
        {//好友下面的通讯录里面的友信宝用户
            static NSString *kCustomCellIDA = @"Cell";
            LoanOrRepayAddressbookCell *cell = [tableView dequeueReusableCellWithIdentifier:kCustomCellIDA];
            if (cell == nil)
            {
                cell = [[LoanOrRepayAddressbookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCustomCellIDA];
                cell.selectedBackgroundView = [[UIView alloc]init];
                cell.selectedBackgroundView.backgroundColor = selectedColor;
            }

            NSLog(@"[self.addTypeBook count]%ld---indexPath.section==%ld",(long)[self.addTypeBook count],(long)indexPath.section);
            
            if([self.addTypeBook count] > indexPath.row)
            {
                User *friendUser = self.addTypeBook[indexPath.row];
                cell.user = friendUser;
                cell.friendStyle = LoanOrRepayAddressbookCellStyleYXBFriend;

            }
            
            return cell;

        }
    }else if(self.friendStyle == LoanOrRepayFriendsStyleAddress)
    {
        static NSString *kCustomCellIDAD = @"CellA";
        LoanOrRepayAddressbookCell *cell = [tableView dequeueReusableCellWithIdentifier:kCustomCellIDAD];
        if (cell == nil)
        {
            cell = [[LoanOrRepayAddressbookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCustomCellIDAD];
            cell.selectedBackgroundView = [[UIView alloc]init];
            cell.selectedBackgroundView.backgroundColor = selectedColor;
            //		cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        NSArray *nameArr = [self.dataDictionary objectForKey:self.sortedkeysArray[indexPath.section]];
        if (indexPath.row < [nameArr count]) {
            User *user = nameArr[indexPath.row];
            cell.user = user;
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"nickname == %@", user.nickname];
            NSArray *filteredArray = [_addTypeBook filteredArrayUsingPredicate:predicate];
            if (filteredArray.count == 0) {
                cell.friendStyle = LoanOrRepayAddressbookCellStyleAddressNotFriend;
            }else {
                cell.friendStyle = LoanOrRepayAddressbookCellStyleAddressFriend;
            }
            
            if (self.isSelectPeople) {
                cell.friendStyle = LoanOrRepayAddressbookCellStyleAddressBlank;
                
            }

        }
        
        return cell;
    }
    else
    {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

//显示通讯录右侧索引

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (tableView !=self.linkManListView) {
        return nil;
    }else{
        NSMutableArray *titles = [[NSMutableArray alloc] init];
        [titles addObject:UITableViewIndexSearch];
        
        NSArray *searchArr = nil;
        if (self.friendStyle == LoanOrRepayFriendsStyleYXB) {
//            searchArr = self.friendArr;
        }else if (self.friendStyle == LoanOrRepayFriendsStyleAddress) {
//            searchArr = self.listContent;
            
        }
        searchArr = self.sortedkeysArray;
//        for (NSArray *nameArr in searchArr) {
////            NSString *first = [nameArr firstObject];
////            NSString *uppercaseString = [first uppercaseString];
//            
//            [titles addObject:searchArr[sectio]];
//        }
        
        
        
        return searchArr;
    }
}

// 点击目录
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    // 获取所点目录对应的indexPath值
    NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:index];
    
     if (self.friendStyle == LoanOrRepayFriendsStyleYXB) {
         if (index >= self.sortedkeysArray.count) {
             return self.sortedkeysArray.count;
         }
     }else {
//         if (index >= self.listContent.count) {
//             return self.listContent.count-1;
//         }
         
         if (index >= self.sortedkeysArray.count) {
             return self.sortedkeysArray.count;
         }

         
         
     }
    
    // 让table滚动到对应的indexPath位置
    [tableView scrollToRowAtIndexPath:selectIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    return index;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.linkManListView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.isFromBorrow) {
        NSString *friendName;
        if (self.friendStyle == LoanOrRepayFriendsStyleYXB) {
            if (indexPath.section >= self.sortedkeysArray.count) {
                //推荐好友
//                QCAddressBook *address = [self.addTypeBook objectAtIndex:indexPath.row];
                User *user = [self.addTypeBook objectAtIndex:indexPath.row];
//                User *user= tf.friendUser;
                self.loanModel.loanFriendType = 2;
                self.loanModel.lenderId = 0;
                self.loanModel.phoneNumberOfAddressBook = user.username;
                friendName = user.nickname;
            }else {
//                NSMutableArray *nameArr = [self.friendArr objectAtIndex:indexPath.section];
//                User *friendUser = [nameArr objectAtIndex:indexPath.row +1];
                User *friendUser = [[self.dataDictionary objectForKey:self.sortedkeysArray[indexPath.section]] objectAtIndex:indexPath.row];

                self.loanModel.lenderId  = friendUser.t_id;
                self.loanModel.loanFriendType = 1;
                friendName = friendUser.nickname;
            }
            
        }else if (self.friendStyle == LoanOrRepayFriendsStyleAddress)
        {
//            QCAddressBook *address;
            if (_searchBar.text.length <= 0) {
                
                /*
                NSMutableArray *nameArr = [self.listContent objectAtIndex:indexPath.section];
                address = [nameArr objectAtIndex:indexPath.row +1];
                */
                NSMutableArray *nameArr = [self.dataDictionary objectForKey:self.sortedkeysArray[indexPath.section]];
                User *user = nameArr[indexPath.row];
                
                self.loanModel.loanFriendType = 2;
                self.loanModel.lenderId = 0;
                self.loanModel.phoneNumberOfAddressBook = user.username;
                QCUserModel *model = [[QCUserManager sharedInstance] getLoginUser];
                NSString *phoneNO = @"";
                if (model != nil) {
                    phoneNO = model.user.username;
                    if ([phoneNO isEqualToString:user.username]) {
                        [ProgressHUD showErrorWithStatus:@"您不能向自己借款"];
                        return;
                    }

                }
                friendName = user.nickname;
            }else {
                
                /*
                NSNumber *localID = nil;
                NSArray *sectionArr = [self.searchByName sortedArrayUsingSelector:@selector(compare:)];
                localID = [sectionArr objectAtIndex:indexPath.row];
                
                //        //姓名匹配 获取对应匹配的拼音串 及高亮位置
                //        [[SearchCoreManager share] GetPinYin:localID pinYin:matchString matchPos:matchPos];
                address = [self.contactDic objectForKey:localID];
                
                */
                
                NSMutableArray *nameArr = [self.dataDictionary objectForKey:self.sortedkeysArray[indexPath.section]];
                User *user = nameArr[indexPath.row];

                self.loanModel.loanFriendType = 2;
                self.loanModel.lenderId = 0;
                self.loanModel.phoneNumberOfAddressBook = user.username;
                
                QCUserModel *model = [[QCUserManager sharedInstance] getLoginUser];
                NSString *phoneNO = @"";
                if (model != nil) {
                    phoneNO = model.user.username;
                    if ([phoneNO isEqualToString:user.username]) {
                        [ProgressHUD showErrorWithStatus:@"您不能向自己借款"];
                        return;
                    }
                    
                }

                
                friendName = user.nickname;
            }
            
            //短信借款
//            LoanOrRepayAddressbookCell *cell = (LoanOrRepayAddressbookCell *)[tableView cellForRowAtIndexPath:indexPath];
//            if (cell.friendStyle == LoanOrRepayAddressbookCellStyleAddressNotFriend) {
//                NSArray *arr = @[address.tel];
//                [self sendSMS:nil recipientList:arr];
//                return;
//            }
        }
        
        NSString *title = [NSString stringWithFormat:@"是否向\"%@\"发起借款",friendName];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:title delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"发起", nil];
        alert.tag = kBorrowAlertTag;
        [alert show];
        
        
    }else if (self.isFromLender){
//        NSMutableArray *nameArr = [self.friendArr objectAtIndex:indexPath.section];
//        User *friendUser = [nameArr objectAtIndex:indexPath.row +1];
        User *friendUser = [[self.dataDictionary objectForKey:self.sortedkeysArray[indexPath.section]] objectAtIndex:indexPath.row];

        self.loanModel.borrowerId  = friendUser.t_id;
        
        NSString *title = [NSString stringWithFormat:@"是否借款给\"%@\"",friendUser.nickname];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:title delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"发起", nil];
        alert.tag = kLenderAlertTag;
        [alert show];
        
    }else if (self.isSelectPeople)
    {
        if (self.friendStyle == LoanOrRepayFriendsStyleYXB) {
            
            User *friendUser = [[self.dataDictionary objectForKey:self.sortedkeysArray[indexPath.section]] objectAtIndex:indexPath.row];
            if (indexPath.section >= self.sortedkeysArray.count)
            {
                //推荐好友
                friendUser = [self.addTypeBook objectAtIndex:indexPath.row];
            }
            NSInteger friendId = friendUser.t_id;
            if (friendId != 0) {
                NSLog(@"gids---%ld",(long)friendId);
                NSString *titleStr = @"";

                if (self.payType == AmorOrderPayTypeOtherPay) {
                    titleStr = [NSString stringWithFormat:@"选择\"%@\"为你代付当前期?",friendUser.nickname];
                }else if (self.payType == AmorOrderPayTypeOtherPayAll)
                {
                    titleStr = [NSString stringWithFormat:@"选择\"%@\"为你代付全部金额?",friendUser.nickname];

                }else if (self.payType == AmorOrderPayTypeSelectPeople)
                {
                    titleStr = [NSString stringWithFormat:@"选择\"%@\"做你的担保人?",friendUser.nickname];

                }
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:titleStr delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alertView showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
                    if(buttonIndex == 1)
                    {
                        if (self.delegate && [self.delegate respondsToSelector:@selector(amorOrderDetailCallBackWithType:gid:)])
                        {
                            [self.delegate amorOrderDetailCallBackWithType:self.payType gid:[NSString stringWithFormat:@"%ld",(long)friendId]];
                            [super leftClicked];
                        }

                    }

                }];
                

            }
            else
            {
                [ProgressHUD showSuccessWithStatus:@"请选择好友"];
            }

        }else if (self.friendStyle == LoanOrRepayFriendsStyleAddress)
        {
                
                User *friendUser = [[self.dataDictionary objectForKey:self.sortedkeysArray[indexPath.section]] objectAtIndex:indexPath.row];
                NSString *friendId = friendUser.username;
                if (friendId != nil) {
                    NSLog(@"contact name---%@",friendId);
                    NSString *titleStr = @"";
                    
                    if (self.payType == AmorOrderPayTypeOtherPay) {
                        titleStr = [NSString stringWithFormat:@"选择\"%@\"为你代付当前期?",friendUser.nickname];
                    }else if (self.payType == AmorOrderPayTypeOtherPayAll)
                    {
                        titleStr = [NSString stringWithFormat:@"选择\"%@\"为你代付全部金额?",friendUser.nickname];
                        
                    }else if (self.payType == AmorOrderPayTypeSelectPeople)
                    {
                        titleStr = [NSString stringWithFormat:@"选择\"%@\"做你的担保人?",friendUser.nickname];
                        
                    }
                    
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:titleStr delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    [alertView showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
                        if(buttonIndex == 1)
                        {
                            if (self.delegate && [self.delegate respondsToSelector:@selector(amorOrderDetailCallBackWithType:gid:)])
                            {
                                [self.delegate amorOrderDetailCallBackWithType:self.payType gid:[NSString stringWithFormat:@"%@",friendId]];
                                [super leftClicked];
                            }
                            
                        }
                        
                    }];
                    
                    
                }
                else
                {
                    [ProgressHUD showSuccessWithStatus:@"请选择好友"];
                }
                
        }

    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.friendStyle == LoanOrRepayFriendsStyleYXB) {

        UIView * subView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kSectionHeight)];
        subView.backgroundColor = CellHeaderColor;
        
        
        NSString *title;
        if (section < self.sortedkeysArray.count) {
            if (self.sortedkeysArray.count != 0) {
//                NSMutableArray *nameArr = [self.friendArr objectAtIndex:section];
//                NSString *first = [nameArr firstObject];
                NSString *first = self.sortedkeysArray[section];
                NSString *uppercaseString = first.uppercaseString;
                title = uppercaseString;
                
            }
            
        }else {
            title = @"推荐好友";
        }
        [self CreateLabel:title frame:CGRectMake(15, 0, 100, kSectionHeight) withView:subView textAlignment:0 fontSize:14 textColor:kCellHeaderTextColor];
        
        return subView;
        
    }else {
        UIView * subView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kSectionHeight)];
        subView.backgroundColor = CellHeaderColor;
        
        
        NSString *title;
        if (self.sortedkeysArray.count != 0) {
//            NSMutableArray *nameArr = [self.listContent objectAtIndex:section];
//            NSString *first = [nameArr firstObject];
//            NSString *uppercaseString = first.uppercaseString;
//            title = uppercaseString;
            
            NSString *first = self.sortedkeysArray[section];
            NSString *uppercaseString = first.uppercaseString;
            title = uppercaseString;

            
        }
        
        [self CreateLabel:title frame:CGRectMake(15, 0, 100, kSectionHeight) withView:subView textAlignment:0 fontSize:14 textColor:kCellHeaderTextColor];
        
        return subView;
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    if (self.friendStyle == LoanOrRepayFriendsStyleYXB)
    {
        if([searchText isEqualToString:@""])
        {
            [self.view endEditing:YES];
            [_searchBar endEditing:YES];
            [self fileterFullModelArrayWithKey:@""];
            [self loadSavedData];
            _searchBar.showsCancelButton = NO;

            
            
        }
        else
        {
            [self fileterFullModelArrayWithKey:searchText];
            
        }
        
    }
    else
    {
        if([searchText isEqualToString:@""])
        {
            [self.view endEditing:YES];
            [_searchBar endEditing:YES];
            [self fileterFullModelArrayWithKey:@""];
//            [self loadSavedData];
            self.friendStyle = LoanOrRepayFriendsStyleAddress;
            _searchBar.showsCancelButton = NO;

            
            
        }
        else
        {
            [self fileterFullModelArrayWithKey:searchText];
            
        }

    }
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    if (_friendStyle == LoanOrRepayFriendsStyleYXB) {
        [self.view endEditing:YES];
        [_searchBar endEditing:YES];
        _searchBar.text = @"";
        [self fileterFullModelArrayWithKey:@""];

        
//        [self setSelectedCell];
        
        [self loadSavedData];
        _searchBar.showsCancelButton = NO;
        

    }
    else
    {
        if (_friendStyle == LoanOrRepayFriendsStyleAddress) {
            [self.view endEditing:YES];
            [_searchBar endEditing:YES];
            _searchBar.text = @"";
//            [self fileterFullModelArrayWithKey:@""];
            if(self.addressDataDictionary != nil && self.addressSortedkeysArray != nil)
            {
                self.dataDictionary = [NSMutableDictionary dictionaryWithDictionary:self.addressDataDictionary];
                self.sortedkeysArray = [NSMutableArray arrayWithArray:self.addressSortedkeysArray];
                
                [self refreshCurrentData];
            }
            
            [self setSelectedCell];
            
            //    [self loadSavedData];
            self.friendStyle = LoanOrRepayFriendsStyleAddress;
            _searchBar.showsCancelButton = NO;
            
            
        }

    }

    
}



#pragma mark - http delegates
- (void)httpCompleteWithResultSet:(TResultSet *)set withHttpTag:(NSInteger)tag
{
    [ProgressHUD dismiss];
    if (set.errCode == 0) {
//        [self performSelector:@selector(hideLoading) withObject:nil afterDelay:2];
        
        for (UIViewController *viewController in self.navigationController.viewControllers) {
            if ([viewController isKindOfClass:[AADetailsViewController class]]) {
                [self.navigationController popToViewController:viewController animated:YES];
            }else if ([viewController isKindOfClass:[LoanOrRepayViewController class]]){
                [self.navigationController popToViewController:viewController animated:YES];
            }
        }
    }else{
//        UIAlertView * alertView  = [[UIAlertView alloc]initWithTitle:@"" message:set.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alertView show];
    }
}

#pragma mark - UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        if (alertView.tag == kBorrowAlertTag) {
            StatusHttp* http = [[StatusHttp alloc]init];
            http.delegate =self;
            [ProgressHUD showWithStatus:@"正在加载..." maskType:ProgressHUDMaskTypeBlack tipsType:ProgressHUDTipsTypeLongBottom networkIndicator:YES];
            [http __yxb_service__createAndModifyTLoan:self.loanModel];
        }else if (alertView.tag == kLenderAlertTag) {
            YXBPayAction *pay = [[YXBPayAction alloc] init];
            pay.payWay = YXBPayWayFukuan;
            pay.isQuickLend = YES;
            pay.loan = self.loanModel;
            [pay payAction];
        }
        
    }
}

#pragma mark - Message Delegate
- (void)sendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients
{
    
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    
    if([MFMessageComposeViewController canSendText])
        
    {
        
        controller.body = bodyOfMessage;
        
        controller.recipients = recipients;
        
        controller.messageComposeDelegate = self;
        
        //        [self presentModalViewController:controller animated:YES];
        [self presentViewController:controller animated:YES completion:nil];
        
    }
    
}

// 处理发送完的响应结果
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    if (result == MessageComposeResultCancelled) {
        NSLog(@"Message cancelled");
    }else if (result == MessageComposeResultSent) {
//        [self showLoadingWithTitle:@"短信发送成功" imageName:@"friends_send"];
        [ProgressHUD showWithStatus:@"短信发送成功"];
        [self performSelector:@selector(hideLoading) withObject:nil afterDelay:2];
        
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        NSLog(@"Message failed")  ;
    }
}

//根据搜索过滤数据
-(void)fileterFullModelArrayWithKey:(NSString *)key
{
    //    NSMutableArray *tempSearchArray = [NSMutableArray arrayWithArray:_fullModelArray];
    
//    if (self.friendStyle == LoanOrRepayFriendsStyleYXB)
//    {
        NSMutableArray *tempSearchArray = [NSMutableArray array];
        NSLog(@"count===%@,%@",tempSearchArray,self.fullModelArray);
        
        if ([key length] > 0) {
            NSString *pinyinKey = [[YXBTool pinyinWithText:key] lowercaseString];
            for (int i = 0; i < [self.fullModelArray count]; i ++)
            {
                TFriendRelation *tf = self.fullModelArray[i];
                User *user = tf.friendUser;
                NSLog(@"nickname---%@===%@",user.nickname,[YXBTool pinyinWithText:user.nickname]);
                if ([[YXBTool pinyinWithText:user.nickname] hasPrefix:pinyinKey])
                {
                    [tempSearchArray addObject:tf];
                }
            }
            
            
        }
        
        NSLog(@"count===%@,%@",tempSearchArray,self.fullModelArray);
        //    if ([tempSearchArray count] > 0) {
        [self processDataToDicWithArray:tempSearchArray isSaved:YES];

//    }
    
    /*
    else
    {
        //通讯录好友
        
        
        NSMutableArray *tempSearchArray = [NSMutableArray array];
        NSLog(@"count===%@,%@",tempSearchArray,self.listContent);
        
        if ([key length] > 0) {
            NSString *pinyinKey = [[YXBTool pinyinWithText:key] lowercaseString];
            for (int i = 0; i < [self.listContent count]; i ++)
            {
                NSArray *contactArray = self.listContent[i];
                for (int j = 1; j < [contactArray count]; j ++) {
                    QCAddressBook *user = self.listContent[i][j];
                    NSLog(@"nickname---%@===%@",user.name,[YXBTool pinyinWithText:user.name]);
                    if (![[YXBTool pinyinWithText:user.name] hasPrefix:pinyinKey])
                    {
                        [self.listContent[i] removeObjectAtIndex:j];
                    }

                }
            }
            
            
        }
        
        NSLog(@"count===%@,%@",tempSearchArray,self.listContent);
        
    }
    
    */
    
    
}



-(void)leftClicked
{
    [[AddressDBManager shareInstance] reloadAddressBook];
    [super leftClicked];
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

