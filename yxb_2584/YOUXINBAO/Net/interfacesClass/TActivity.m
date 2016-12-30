//
//  TActivity.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/3/9.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "TActivity.h"
#import "TActivityMember.h"

@implementation TActivity
@dynamic errCode;

- (void)decodeWithDic:(NSDictionary *)dic {
    [super decodeWithDic:dic];
    NSMutableArray *memberArray = [NSMutableArray new];
    for (NSDictionary *dic in self.participants) {
        TActivityMember *member = [[TActivityMember alloc] init];
        [member decodeWithDic:dic];
        [memberArray addObject:member];
    }
    self.participants = memberArray;
}


-(void) decodeWithSubArray:(NSArray*) arr withPropertyName:(NSString*) name {
    if ([name isEqualToString:@"previewPics"]) {
        self.previewPics = [NSArray arrayWithArray:arr];
        NSLog(@"previewPics = %@", self.previewPics);
    }
    else  if ([name isEqualToString:@"postWallPics"]) {
        self.postWallPics = [NSArray arrayWithArray:arr];
        NSLog(@"postWallPics = %@", self.postWallPics);
    }else if ([name isEqualToString:@"participants"]) {
        self.participants = [NSArray arrayWithArray:arr];
        NSLog(@"postWallPics = %@", self.postWallPics);
    }
}

@end
