//
//  OverdueManager.m
//  YOUXINBAO
//
//  Created by 密码是111 on 2016/12/9.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "OverdueManager.h"

@implementation OverdueManager

-(NSSkyArray *)getOverdueLoanList:(NSInteger)pageNum usertoken:(NSString *)userToken state:(NSInteger)state{
   return [[NSSkyArray alloc]init];
    
}
-(NSSkyArray *)getLawsuitLoanList: (NSInteger)pageNum usertoken:(NSString *)userToken state: (NSInteger)state{
    return [[NSSkyArray alloc]init];
    
}
-(NSSkyArray *)getLawsuitMerge: (NSString *)userToken loanID: (NSInteger)loanID{
    return [[NSSkyArray alloc]init];
}
@end
