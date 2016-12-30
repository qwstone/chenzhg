//
//  AddressDBManager.m
//  YOUXINBAO
//
//  Created by Feili on 15/10/9.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AddressDBManager.h"
#import "YXBTool.h"
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
#import "AddressBookModel.h"

@interface AddressDBManager ()
@property(nonatomic,assign)BOOL isSavingAddressBook;//正在保存通讯录
@property(nonatomic,strong)NSMutableArray *tempArray;//保存的上一次通讯录数据
@property (nonatomic) ABAddressBookRef addressBook;
@property (nonatomic,assign)BOOL hasRegister;//已注册监听


@end

@implementation AddressDBManager



+ (instancetype)shareInstance {
    
    static AddressDBManager *instance = nil;
    
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        
        instance = [[[self class] alloc] init];
        
        [instance openDB];
        
    });
    
    return instance;
}

//注册监听
- (void)registerCallback {
    if (!_addressBook) {
        CFErrorRef errorRef = NULL;
        _addressBook = ABAddressBookCreateWithOptions(nil, &errorRef);

    }

    if (!_hasRegister) {
//        ABAddressBookRegisterExternalChangeCallback(_addressBook, addressCallback, self);
        ABAddressBookRegisterExternalChangeCallback(_addressBook, addressCallback, (__bridge void *)(self));
        _hasRegister = YES ;
    }
}

//注销监听
- (void)unregisterCallback {
    if (_hasRegister) {
        ABAddressBookUnregisterExternalChangeCallback(_addressBook, nil, (__bridge void *)(self));
        _hasRegister = NO;
    }
}

//添加回调方法
void addressCallback(ABAddressBookRef addressBook, CFDictionaryRef info, void *context)
{


    NSLog(@"通讯录有变化");
}

- (void)openDB {
    [self createDirWithDirName];
    //加载数据模型文件
    NSURL *url = [[NSBundle mainBundle] URLForResource:DBAddressBookModelName withExtension:@"momd"];
    NSManagedObjectModel *dataModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
    
    //打开数据库
    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:dataModel];
    
    NSString *filePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/DBNew/AddressBookModel.sqlite"];
    NSLog(@"%@",filePath);
    NSURL *dbURL = [NSURL fileURLWithPath:filePath];
    NSError *error;
    
    [store addPersistentStoreWithType:NSSQLiteStoreType
                        configuration:nil URL:dbURL
                              options:nil error:&error];
    
    if (error) {
        NSLog(@"打开数据库出错-%@",error);
    } else {
        NSLog(@"打开数据库成功");
    }
    
    //创建数据操作对象
    self.context = [[NSManagedObjectContext alloc] init];
    self.context.persistentStoreCoordinator = store;
}

//创建文件夹
-(NSString *)createDirWithDirName
{
    NSString * orderId = [NSString stringWithFormat:@"DBNew"];
    NSString *documentsPath =[YXBTool dirDoc];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:orderId];
    
    BOOL isDir = FALSE;
    
    if (![fileManager fileExistsAtPath:testDirectory isDirectory:&isDir]) {
        // 创建目录
        
        NSLog(@"文件夹不存在，需要创建");
        BOOL res=[fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
        if (res)
        {
            NSLog(@"文件夹创建成功");
        }
        else
        {
            
            NSLog(@"文件夹创建失败");
            
        }
        
    }
    else
    {
        NSLog(@"文件夹已存在");
        
    }
    
    return testDirectory;
    
}

/**
 *  @author zhangjinpeng
 *
 *
 *  @param
 *
 *  @return 创建mo对象
 */
- (NSManagedObject *)createMO:(NSString *)entityName {
    
    if (entityName.length == 0) {
        return nil;
    }
    
    //根据实体名称，创建mo对象
    NSManagedObject *mo = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:self.context];
    
    return mo;
}

/**
 *  @author zhangjinpeng
 *
 *
 *  @param
 AgentContractNew *user = (User *)[dbManager createMO:@"AgentContractNew"];
 1.批量保存
 for (int i=0; i<20; i++) {
 AgentContractNew *user = (User *)[dbManager createMO:@"User"];
 user.name = [NSString stringWithFormat:@"zhang-%d",i];
 [user setValue:@8000 forKey:@"orderId"];
 
 [dbManager saveManagerObj:user];
 }
 
 
 2.保存user对象
 userMO 指向了一个user对象
 NSManagedObject *user = [dbManager createMO:@"AgentContractNew"];
 [user setValue:@"小明" forKey:@"name"];
 [user setValue:@8000 forKey:@"orderId"];
 [dbManager saveManagerObj:user];
 *
 *  @return 增加，保存数据
 */
- (void)saveManagerObj:(NSManagedObject *)mo {
    
    [self.context insertObject:mo];
    
    NSError *error = nil;
    if ([self.context save:&error]) {
        if (error) {
            NSLog(@"保存 ---%@",error);
        }
//        NSLog(@"保存%@成功",mo);
    } else {
        if (error) {
            NSLog(@"保存 ---%@",error);
        }

//        NSLog(@"保存%@失败：%@",mo,error);
    }
    
}

/**
 *  @author zhangjinpeng
 *
 *
 *  @param 单线程异步查询    条件：列   NSPredicate *predicate = [NSPredicate predicateWithFormat:@"orderId = 8000"];
 *
 *  @return 数组（包含所有用户）
 */
- (NSArray *)query:(NSString *)entifyName
         predicate:(NSPredicate *)predicate {
    
    if (entifyName.length == 0) {
        return nil;
    }
    
    
    //1.创建查询请求对象
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entifyName];
    //定义排序字段
//    NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey:@"pinyin" ascending:YES];
//    request.sortDescriptors = @[sortDesc];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"pinyin" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    
    request.sortDescriptors = @[sortDescriptor];

    //分页查询 limit： 一页的数量
    int page = 0;
    [request setFetchLimit:NSIntegerMax];
    [request setFetchOffset:page*5];
    request.predicate = predicate;
    NSArray *array = [self.context executeFetchRequest:request error:nil];
    //    NSLog(@"%d",array.count);
    return array;
}


/**
 *  @author zhangjinpeng
 *
 *
 *  @param NSArray *users = [dbManager query:@"AgentContractNew" predicate:predicate];
 NSManagedObject *user = users[0];
 [user setValue:@"小明" forKey:@"name"];
 [dbManager updateManagerObj:user];
 *
 *  @return 修改对象
 */
- (void)updateManagerObj:(NSManagedObject *)mo {
    
    if (mo == nil) {
        return;
    }
    
    NSError *error = nil;
    if ([self.context save:&error]) {
        NSLog(@"保存%@成功",mo);
    } else {
        NSLog(@"保存%@失败：%@",mo,error);
    }
    
}

/**
 *  @author zhangjinpeng
 *
 *
 *  @param  NSArray *users = [dbManager query:@"AgentContractNew" predicate:predicate];
 NSManagedObject *user = users[0];
 [dbManager removeManagerObj:user];
 *
 *  @return 删除对象
 */
- (void)removeManagerObj:(NSManagedObject *)mo {
    
    if (mo == nil) {
        return;
    }
    
    [self.context deleteObject:mo];
    
    //[self.context save:nil];
}

//更新通信录
-(void)reloadAddressBook
{
//    if (self.completeBlock) {
//        self.completeBlock(_tempArray,onAddressBookCompleteBlockTimesSavedData);
//    }
    if (_isSavingAddressBook) {
        return;
    }

    @synchronized(self)
    {
        if (_isSavingAddressBook == NO) {
            [self clearAddressBooks];
            [self readAddressBook];

        }

    }

}

-(void)readAddressBook
{
    if (self.dataArray != nil && [self.dataArray count] > 0) {
        [self.dataArray removeAllObjects];
    }
    else
    {
        self.dataArray = [NSMutableArray array];
    }
    //获取通讯录信息
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted || ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied) {
        [ProgressHUD dismiss];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请开启访问通讯录功能,获取通讯录好友" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [alert show];
        });
        
    }
    
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
//        addressBooks =ABAddressBookCreate();
        CFErrorRef errorRef = NULL;
        addressBooks = ABAddressBookCreateWithOptions(nil, &errorRef);

    }
    
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBooks);
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBooks);
    
//    if (!_addressBook) {
//        self.addressBook = addressBooks;
//        //注册通讯录变化消息
//        [self registerCallback];
//        
//    }

    
    for (NSInteger i = 0; i < nPeople; i++)
    {
        self.isSavingAddressBook = YES;
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
                addressBook.maxPinyin=[[YXBTool pinyinWithText:addressBook.name]uppercaseString];
                addressBook.resStatus = [self resStatusWithTempArrayAndTel:addressBook.tel];

                [self.dataArray addObject:addressBook];
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
    
    
//    [self saveAddressArray:self.dataArray];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:hasSavedAddressBook];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.dataArray = [NSMutableArray arrayWithArray:[self.dataArray sortedArrayWithOptions:NSSortConcurrent usingComparator:^NSComparisonResult(QCAddressBook *obj1, QCAddressBook *obj2) {
        
        return [obj1.pinyin compare:obj2.pinyin];
    }]];
    
    
    self.tempArray = [NSMutableArray arrayWithArray:self.dataArray];

    self.isSavingAddressBook = NO;
    if (self.completeBlock) {
        self.completeBlock(_dataArray,onAddressBookCompleteBlockTimesNewData);
        [self resetBlock];
        
    }

    
}


//保存通讯录数组
-(void)saveAddressArray:(NSMutableArray *)addressBookArray
{
    @synchronized(self) {
//
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            _isSavingAddressBook = YES;
            [self clearAddressBooks];
            for (QCAddressBook *book in addressBookArray)
            {
                [self saveAddressBook:book];
                
            }
            _isSavingAddressBook = NO;
            
            
        });

    }
}

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

//汉字转拼音
-(NSString *)pinyinWithText:(NSString *)hanziText
{
    NSMutableString *ms = [[NSMutableString alloc] initWithString:@""];
    
    if ([hanziText length]) {
        ms = [[NSMutableString alloc] initWithString:hanziText];
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
        }
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
        }
    }
    [ms replaceOccurrencesOfString:@" " withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, ms.length)];
    return [ms lowercaseString];
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
//    model.resStatus = [NSNumber numberWithInteger:[self resStatusWithTempArrayAndTel:model.tel]];
    model.maxPinyin=[addressBook.pinyin uppercaseString];
    
    //查询状态
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:DBAddressBookModelName];
//    request.predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"tel = '%@'",model.tel]];
//    NSArray *result = [self.context executeFetchRequest:request error:nil];
//    if (result && [result count] > 0) {
//        AddressBookModel *tModel = result[0];
//        model.resStatus = tModel.resStatus;
//    }
//    else
//    {
//        model.resStatus = [NSNumber numberWithInteger:-1];
//    }
    
    [[AddressDBManager shareInstance] saveManagerObj:model];
    
}

-(NSInteger)resStatusWithTempArrayAndTel:(NSString *)tel
{
    NSInteger status = -1;
    if (_tempArray && [_tempArray count] > 0) {
        for (QCAddressBook *book in _tempArray) {
            if ([book.tel isEqualToString:tel]) {
                status = book.resStatus;
                
                return status;
            }
        }
    }
    
    return status;
}

-(void)clearAddressBooks
{
    NSArray *users = [[AddressDBManager shareInstance] query:DBAddressBookModelName predicate:nil];
    for (NSManagedObject *user in users) {
        [[AddressDBManager shareInstance] removeManagerObj:user];
        
    }
    
    
}

//读取本地数据
-(NSMutableArray *)readLocalAddressBook
{
    NSMutableArray *array = [NSMutableArray array];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:hasSavedAddressBook] integerValue] == 1)
    { //数据库里有数据
        array = [self loadAddressBookSavedData];
    }
    else
    {
        //数据库里没有数据
        [self reloadAddressBook];
        if (_dataArray != nil) {
            array = [NSMutableArray arrayWithArray:_dataArray];
        }
        
    }
    
    return array;

}

//读取本地数据
-(void)readLocalAddressBookWithCompleteBlock:(onAddressBookCompleteBlock)completeBlock
{

    self.completeBlock = completeBlock;
    if (self.isSavingAddressBook == NO) {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:hasSavedAddressBook] integerValue] == 1)
        { //数据库里有数据
            [self loadAddressBookSavedData];
        }
        else
        {
            //数据库里没有数据，首次读取通讯录
            [self reloadAddressBook];
            if (_dataArray != nil) {
                [NSMutableArray arrayWithArray:_dataArray];
            }
            
        }

    }
    else
    {
        
//        如果正在保存通讯录，先回调之前的数据， 保存完之后直接回调传进来的这个block
        if (_tempArray != nil && [_tempArray count] > 0) {
            self.completeBlock(_tempArray,onAddressBookCompleteBlockTimesSavedData);
        }

    }
}


-(NSMutableArray *)loadAddressBookSavedData
{
    
    NSMutableArray *friendArray = [NSMutableArray array];
    
    //读取数据库
    NSArray *users = [[AddressDBManager shareInstance] query:DBAddressBookModelName predicate:nil];
    
    
    for (AddressBookModel *model in users)
    {
//        NSLog(@"model.name----%@",model.name);
        QCAddressBook *addressBook = [[QCAddressBook alloc] init];
        addressBook.city = model.city;
        addressBook.name = model.name;
        addressBook.recordID = [model.recordID integerValue];
        addressBook.rowSelected = [model.rowSelected boolValue];
        addressBook.tel = model.tel;
        addressBook.tel2 = model.tel2;
        addressBook.pinyin = model.pinyin;
        addressBook.maxPinyin = model.maxPinyin;
        addressBook.resStatus = [model.resStatus integerValue];
        if (addressBook.name != nil && [addressBook.name length] > 0 && addressBook.tel != nil)
        {
            [friendArray addObject:addressBook];
            
        }
        
        
    }
    
    self.tempArray = [NSMutableArray arrayWithArray:friendArray];

    if (self.completeBlock) {
        self.completeBlock(friendArray,onAddressBookCompleteBlockTimesSavedData);
        if (!self.isSavingAddressBook) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self reloadAddressBook];
                
            });

        }

    }

    return friendArray;
}

-(void)resetBlock
{
    if (_completeBlock) {
        _completeBlock = nil;
    }
}

//取消通讯录的回调
-(void)cancel
{
    [self resetBlock];
}

@end
