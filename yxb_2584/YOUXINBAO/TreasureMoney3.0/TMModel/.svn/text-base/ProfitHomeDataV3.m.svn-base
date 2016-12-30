#import <objc/runtime.h>
#import "ProfitHomeDataV3.h"
#import "ProfitRegularBrief.h"
#import "ProfitBannerData.h"
@implementation ProfitHomeDataV3

-(void)dealloc
{
//  [super dealloc];
}


-(void) decodeWithSubArray:(NSArray*) arr withPropertyName:(NSString*) name {
    if ([name isEqualToString:@"iProfitBannerData"]) {
        self.iProfitBannerData = [[NSMutableArray alloc] init];
        for (int i = 0; i < [arr count]; i++) {
            NSDictionary* dicClass = [arr objectAtIndex:i];
            ProfitBannerData* obj = [[ProfitBannerData alloc] init];
            [obj decodeWithDic:dicClass];
            [self.iProfitBannerData addObject:obj];
        }
    }
    
    if ([name isEqualToString:@"iProfitRegularBrief"]) {
        self.iProfitRegularBrief = [[NSMutableArray alloc] init];
        for (int i = 0; i < [arr count]; i++) {
            NSDictionary* dicClass = [arr objectAtIndex:i];
            ProfitRegularBrief* obj = [[ProfitRegularBrief alloc] init];
            [obj decodeWithDic:dicClass];
            [self.iProfitRegularBrief addObject:obj];
        }
    }

}
@end
