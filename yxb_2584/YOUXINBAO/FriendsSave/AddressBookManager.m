//
//  AddressBookManager.m
//  YOUXINBAO
//
//  Created by Feili on 15/10/19.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AddressBookManager.h"
#import "AddressDBManager.h"
#import "QCAddressBook.h"
#import "YXBTool.h"
#import "AddressBookModel.h"
#import <AddressBookUI/AddressBookUI.h>

static AddressBookManager *addressBookInstance = nil;

@implementation AddressBookManager

+ (instancetype)shareInstance {
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        
        addressBookInstance = [[[self class] alloc] init];
        
    });
    
    return addressBookInstance;
}


//更新通信录
-(void)reloadAddressBookWithDelegate:(id<AddressBookManagerCompleteDelegate>)delegate
{
    _delegate = delegate;
    if (delegate == nil) {
        //简单同步通讯录，没有回调
        dispatch_queue_t queue1 = dispatch_queue_create("com.dispatch.writedb", DISPATCH_QUEUE_SERIAL);
        dispatch_async(queue1, ^{
            
            [self clearAddressBooks];
            [self readAddressBook];
        });

    }
    else
    {
        //读取通讯录之后回调
        if (_addressBookSaveStatus == AddressBookSaveStatusLoading) {
            //如果正在读取中，则返回，，，，用上一次的数据做更新
            return;
        }
        else if(_addressBookSaveStatus == AddressBookSaveStatusDefault)
        {
            //如果通讯录里没有数据，读取数据，保存到数据库之后回调保存成功的方法
            //简单同步通讯录，没有回调
            dispatch_queue_t queue1 = dispatch_queue_create("com.dispatch.writedb", DISPATCH_QUEUE_SERIAL);

            dispatch_async(queue1, ^{
                [self clearAddressBooks];
                [self readAddressBook];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    _addressBookSaveStatus = AddressBookSaveStatusComplete;
                    if (_delegate && [_delegate respondsToSelector:@selector(addressBookHasCompleted)])
                    {
                        [_delegate addressBookHasCompleted];
                    }
                });
            });

        }
        else if(_addressBookSaveStatus == AddressBookSaveStatusComplete)
        {
            //如果通讯录里面有数据，则使用旧的数据直接返回，随后重新读取通讯录，成功之后再调一次回调
            if (_delegate && [_delegate respondsToSelector:@selector(addressBookHasCompleted)])
            {
                [_delegate addressBookHasCompleted];
            }
            
            _addressBookSaveStatus = AddressBookSaveStatusComplete;
            [self reloadAddressBookWithDelegate:_delegate];
            
            
        }
    }
    
}



-(void)readAddressBook
{
    //获取通讯录信息
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted || ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied) {
        
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
    [[AddressDBManager shareInstance] saveManagerObj:model];
    
}

-(void)clearAddressBooks
{
    NSArray *users = [[AddressDBManager shareInstance] query:DBAddressBookModelName predicate:nil];
    for (NSManagedObject *user in users) {
        [[AddressDBManager shareInstance] removeManagerObj:user];
        
    }
    
}


@end
