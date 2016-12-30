//
//  AAFlowImageModel.m
//  YOUXINBAO
//
//  Created by CH10 on 15/4/2.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AAFlowImageModel.h"

@implementation AAFlowImageModel

- (id)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.height = [[dic objectForKey:@"height"] integerValue];
        self.width = [[dic objectForKey:@"width"] integerValue];
        self.url = [dic objectForKey:@"url"];
        self.status = [[dic objectForKey:@"status"] integerValue];
        self.userid = [[dic objectForKey:@"userid"] integerValue];
    }
    
    return self;
}

@end
