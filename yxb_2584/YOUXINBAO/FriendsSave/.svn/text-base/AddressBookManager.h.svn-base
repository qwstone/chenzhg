//
//  AddressBookManager.h
//  YOUXINBAO
//
//  Created by Feili on 15/10/19.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

//个人中心各个条目枚举
typedef NS_ENUM(NSInteger, AddressBookSaveStatus)
{

    AddressBookSaveStatusDefault  = 100, //未读取通讯录
    AddressBookSaveStatusLoading  = 101, //未读取通讯录
    AddressBookSaveStatusComplete = 102, //已读取通讯录

};

@protocol AddressBookManagerCompleteDelegate <NSObject>

@optional
-(void)addressBookHasCompleted;

@end

@interface AddressBookManager : NSObject
+ (instancetype)shareInstance;

@property (nonatomic,assign)AddressBookSaveStatus addressBookSaveStatus;//通讯录状态
@property (nonatomic,assign)id<AddressBookManagerCompleteDelegate>delegate;



@end
