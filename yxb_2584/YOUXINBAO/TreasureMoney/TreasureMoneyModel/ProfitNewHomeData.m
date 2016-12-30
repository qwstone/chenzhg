#import <objc/runtime.h>
#import "ProfitNewHomeData.h"
#import "ProfitBannerData.h"
#import "ProfitRoundData.h"

@implementation ProfitNewHomeData
@dynamic errCode;

-(void)dealloc
{
//  [super dealloc];
}

- (void)decodeWithDic:(NSDictionary *)dic {
    [super decodeWithDic:dic];
    //    iProfitDetailOfMonth
    NSMutableArray *profitArray = [NSMutableArray new];
    for (NSDictionary *dic in self.iProfitBannerData) {
        ProfitBannerData *banner = [[ProfitBannerData alloc] init];
        [banner decodeWithDic:dic];
        [profitArray addObject:banner];
    }
    self.iProfitBannerData = profitArray;
    
    NSMutableArray *roundArray = [NSMutableArray new];
    for (NSDictionary *dic in self.iProfitRoundDataArray) {
        ProfitRoundData *round = [[ProfitRoundData alloc] init];
        [round decodeWithDic:dic];
        [roundArray addObject:round];
    }
    self.iProfitRoundDataArray = roundArray;
}

-(void) decodeWithSubArray:(NSArray*) arr withPropertyName:(NSString*) name {
    if ([name isEqualToString:@"iProfitBannerData"]) {
        self.iProfitBannerData = (NSMutableArray *)[NSArray arrayWithArray:arr];
        //        NSLog(@"installmentList = %@", self.installmentList);
    }else if ([name isEqualToString:@"iProfitRoundDataArray"]) {
        self.iProfitRoundDataArray = (NSMutableArray *)[NSArray arrayWithArray:arr];
        //        NSLog(@"installmentList = %@", self.installmentList);
    }
}

@end
