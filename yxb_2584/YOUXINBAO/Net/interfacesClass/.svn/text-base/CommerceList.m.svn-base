#import <objc/runtime.h>
#import "CommerceList.h"
#import "GoodsResume.h"


@implementation CommerceList

@dynamic errCode;
- (void)decodeWithDic:(NSDictionary *)dic {
    [super decodeWithDic:dic];
    
    NSMutableArray *resumeArray = [NSMutableArray new];
    for (NSDictionary *dic in self.goodsResumeList) {
        GoodsResume *resume = [[GoodsResume alloc] init];
        [resume decodeWithDic:dic];
        [resumeArray addObject:resume];
    }
    self.goodsResumeList = resumeArray;
    
}

-(void) decodeWithSubArray:(NSArray*) arr withPropertyName:(NSString*) name {
    if ([name isEqualToString:@"goodsResumeList"]) {
        self.goodsResumeList = (NSMutableArray *)[NSArray arrayWithArray:arr];
        //        NSLog(@"installmentList = %@", self.installmentList);
    }else if ([name isEqualToString:@"categoryArray"]) {
        
        self.categoryArray = (NSMutableArray *)[NSArray arrayWithArray:arr];
    }
}

-(void)dealloc
{
//  [super dealloc];
}

@end
