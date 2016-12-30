#import <objc/runtime.h>
#import "ProfitHomeDataV2.h"


@implementation ProfitHomeDataV2
@dynamic errCode;

-(void)dealloc
{
//  [super dealloc];
}


-(void) decodeWithSubArray:(NSArray*) arr withPropertyName:(NSString*) name {
    if ([name isEqualToString:@"iProfitBannerData"]) {
        self.iProfitBannerData = (NSMutableArray *)[NSArray arrayWithArray:arr];
        //        NSLog(@"installmentList = %@", self.installmentList);
    }
}
@end
