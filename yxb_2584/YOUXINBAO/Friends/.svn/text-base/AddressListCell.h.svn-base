//
//  AddressListCell.h
//  YOUXINBAO
//
//  Created by Walice on 15/9/10.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TResultSet.h"

#import "QCAddressBook.h"
#import "SearchCoreManager.h"

@protocol QCAddressListDelegate <NSObject>

- (void)QCAddressListPushAction: (NSInteger)btnTag addressBook:(QCAddressBook *)addressBook;

@end

@interface AddressListCell : UITableViewCell


@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *phoneLabel;
@property(nonatomic,strong)UIButton *rightButton1;
@property(nonatomic,strong)UIButton *rightButton2;
@property(nonatomic,strong)UIButton *rightButton3;


@property(nonatomic,strong)NSArray *searchByName;
@property(nonatomic,strong)NSMutableDictionary *typeDic;



@property(nonatomic,strong)NSString *searchText;
@property(nonatomic,strong)NSNumber *localId;
@property(nonatomic,strong)QCAddressBook *model;
@property (nonatomic, assign) id <QCAddressListDelegate>delegate;
@end
