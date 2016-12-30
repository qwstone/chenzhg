//
//  FriendDetailItemModel.h
//  YOUXINBAO
//
//  Created by Feili on 15/5/13.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendDetailItemModel : NSObject

@property(nonatomic,strong)NSString *itemKey;
@property(nonatomic,strong)NSString *itemValue;
@property(nonatomic,assign)BOOL     isEditable;//是否可编辑
@end
