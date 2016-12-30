//
//  AAFlowImageModel.h
//  YOUXINBAO
//
//  Created by CH10 on 15/4/2.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseData.h"

@interface AAFlowImageModel : BaseData

@property (nonatomic,assign) NSInteger height;
@property (nonatomic,assign) NSInteger width;
@property (nonatomic,copy) NSString *url;
//0 审核中 1审核成功 2 审核失败
@property (nonatomic,assign) NSInteger status;
@property (nonatomic,assign) NSInteger userid;

- (id)initWithDic:(NSDictionary *)dic;

@end
