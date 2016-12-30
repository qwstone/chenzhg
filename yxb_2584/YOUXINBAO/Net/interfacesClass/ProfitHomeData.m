#import <objc/runtime.h>
#import "ProfitHomeData.h"
#import "ProfitDetailOfMonth.h"


@implementation ProfitHomeData

@dynamic errCode;
- (void)decodeWithDic:(NSDictionary *)dic {
    [super decodeWithDic:dic];
//    iProfitDetailOfMonth
    NSMutableArray *profitArray = [NSMutableArray new];
    for (NSDictionary *dic in self.iProfitDetailOfMonth) {
        ProfitDetailOfMonth *month = [[ProfitDetailOfMonth alloc] init];
        [month decodeWithDic:dic];
        [profitArray addObject:month];
    }
    self.iProfitDetailOfMonth = profitArray;
    
}

-(void) decodeWithSubArray:(NSArray*) arr withPropertyName:(NSString*) name {
    if ([name isEqualToString:@"iProfitDetailOfMonth"]) {
        self.iProfitDetailOfMonth = (NSMutableArray *)[NSArray arrayWithArray:arr];
        //        NSLog(@"installmentList = %@", self.installmentList);
    }
}



-(void)dealloc
{
//  [super dealloc];
}

@end
