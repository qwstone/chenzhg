//
//  AddressBookModel.h
//  YOUXINBAO
//
//  Created by Walice on 15/10/9.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface AddressBookModel : NSManagedObject

@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * pinyin;
@property (nonatomic, retain) NSNumber * recordID;
@property (nonatomic, retain) NSNumber * resStatus;
@property (nonatomic, retain) NSNumber * rowSelected;
@property (nonatomic, retain) NSNumber * sectionNumber;
@property (nonatomic, retain) NSString * tel;
@property (nonatomic, retain) NSString * tel2;
@property (nonatomic, retain) NSString * maxPinyin;

@end
