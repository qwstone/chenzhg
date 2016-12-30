//
//  AgentContract.m
//  DiTui
//
//  Created by zjp on 15/5/30.
//  Copyright (c) 2015年 YXBao. All rights reserved.
//

#import "DBManager.h"
#import "YXBTool.h"
#import "User.h"
#import "TFriendRelation.h"
@implementation DBManager

+ (instancetype)shareInstance {
    
    static DBManager *intance = nil;
    
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        
        intance = [[[self class] alloc] init];
        
        [intance openDB];
        
    });
    
    return intance;
}

- (void)openDB {
    [self createDirWithDirName];
    //加载数据模型文件
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"QCfriendModel" withExtension:@"momd"];
    NSManagedObjectModel *dataModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
    
    //打开数据库
    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:dataModel];
    
    NSString *filePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/DBNew/coredata.sqlite"];
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
        NSLog(@"保存%@成功",mo);
    } else {
        NSLog(@"保存%@失败：%@",mo,error);
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
//    NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey:@"orderId" ascending:NO];
//    request.sortDescriptors = @[sortDesc];
    
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
    
    [self.context save:nil];
}

// 清空数据库
+(void)clearDataBaseWhenExit
{

    [self reSetDB];
}

//清空好友数据库
+(void)reSetDB
{
    NSArray *users = [[DBManager shareInstance] query:@"QCFriendModel" predicate:nil];
    for (NSManagedObject *user in users) {
        [[DBManager shareInstance] removeManagerObj:user];
        
    }
    
}
//保存数据到本地数据库
-(void)saveFriendRelationsToDB:(NSMutableDictionary *)dic{
    @synchronized(self) {
        [self clearAddressBooks];
        NSArray *allDicKeys = [dic allKeys];
        for (int i = 0; i < allDicKeys.count; i++) {
            NSArray *value = [dic objectForKey:allDicKeys[i]];
            for (User *user in value) {
                
                QCFriendModel *model = (QCFriendModel *)[[DBManager shareInstance] createMO:DBFriendModelName];
                model.nickname = user.nickname;
                model.username = user.username;
                model.yxbId = user.yxbId;
                model.realName = user.realname;
                model.iconAddr = user.iconAddr;
                model.userId = [NSString stringWithFormat:@"%ld",(long)user.t_id];
                [[DBManager shareInstance] saveManagerObj:model];
            }
        }

    }
}
-(NSMutableArray *)readLocalFriendRelationsDB{
    NSMutableArray *array = [NSMutableArray array];

    array = [self loadSavedData];

//    NSMutableArray *array = [NSMutableArray array];
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:hasSavedFriendDB] integerValue] == 1)
//    {//数据库有数据
//        array = [self loadSavedData];
//    }else{//数据库没有数据
////        [self reloadFriendRelationsDB];
////        if (_dataArray != nil) {
////            array = [NSMutableArray arrayWithArray:_dataArray];
////        }
//        if (self.completeBlock) {
//            
//            self.completeBlock([NSMutableArray arrayWithCapacity:0]);
//        }
//    }
    return array;
}

//读取本地数据，构造网络请求返回的数据结构
-(NSMutableArray *)loadSavedData
{
    
    NSMutableArray *friendArray = [NSMutableArray array];
    
    //读取数据库
    NSArray *users = [[DBManager shareInstance] query:DBFriendModelName predicate:nil];
    
    for (QCFriendModel *model in users) {
        User *user = [[User alloc] init];
        user.yxbId = model.yxbId;
        user.t_id = [model.userId integerValue];
        user.username = model.username;
        user.nickname = model.nickname;
        user.iconAddr = model.iconAddr;
        user.realname = model.realName;
        user.nameSpell = [YXBTool pinyinWithText:model.nickname];
        
        TFriendRelation *fuser = [[TFriendRelation alloc] init];
        fuser.errCode = 0;
        fuser.friendUser = user;
        [friendArray addObject:fuser];
    }
    
    if (self.completeBlock) {
        
        self.completeBlock(friendArray);
    }
    return friendArray;
}

//-(NSMutableArray *)loadAddressBookSavedData
//{
//    
//    NSMutableArray *friendArray = [NSMutableArray array];
//    
//    //读取数据库
//    NSArray *users = [[AddressDBManager shareInstance] query:DBAddressBookModelName predicate:nil];
//    
//    
//    for (AddressBookModel *model in users)
//    {
//        //        NSLog(@"model.name----%@",model.name);
//        QCAddressBook *addressBook = [[QCAddressBook alloc] init];
//        addressBook.city = model.city;
//        addressBook.name = model.name;
//        addressBook.recordID = [model.recordID integerValue];
//        addressBook.rowSelected = [model.rowSelected boolValue];
//        addressBook.tel = model.tel;
//        addressBook.tel2 = model.tel2;
//        addressBook.pinyin = model.pinyin;
//        
//        if (addressBook.name != nil && [addressBook.name length] > 0 && addressBook.tel != nil)
//        {
//            [friendArray addObject:addressBook];
//            
//        }
//        
//        
//    }
//    
//    if (self.completeBlock) {
//        self.completeBlock(friendArray);
//        if (!self.isSavingAddressBook) {
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                [self reloadAddressBook];
//                
//            });
//            
//        }
//        
//    }
//    
//    self.tempArray = [NSMutableArray arrayWithArray:friendArray];
//    return friendArray;
//}



//更新数据库
-(void)reloadFriendRelationsDB{
    [self clearAddressBooks];

}
-(void)clearAddressBooks
{
    NSArray *friends = [[DBManager shareInstance] query:DBFriendModelName predicate:nil];
    for (NSManagedObject *friend in friends) {
        [[DBManager shareInstance] removeManagerObj:friend];
    }
}


//读取本地数据block回调
-(void)readLocalFriendRelationsDBWithCompleteBlock:(onFriendRelationsDBCompleteBlock)completeBlock
{
    self.completeBlock = completeBlock;
    [self readLocalFriendRelationsDB];

    
}

-(void)cancel
{
    if (_completeBlock != nil) {
        _completeBlock = nil;
    }
}


@end
