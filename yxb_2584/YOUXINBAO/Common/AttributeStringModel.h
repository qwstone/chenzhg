//
//  AttributeStringModel.h
//  YOUXINBAO
//
//  Created by Feili on 15/5/19.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AttributeStringModel : NSObject
@property(nonatomic,strong)NSString *attributeName;//属性名称
@property(nonatomic,strong)NSObject *attributeValue;//属性值
@property(nonatomic,assign)NSRange  attributeRange;//属性范围
@end
