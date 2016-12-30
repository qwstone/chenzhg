#import <objc/runtime.h>
#import "CommerceDetailV2.h"
#import "GuaranteeStages.h"


@implementation CommerceDetailV2
@dynamic errCode;

-(void)dealloc
{
//  [super dealloc];
}

-(void) decodeWithSubArray:(NSArray*) arr withPropertyName:(NSString*) name {
    if ([name isEqualToString:@"guaranteeStages"])
    {
        self.guaranteeStages = [NSMutableArray array];
//        [self.guaranteeStages removeAllObjects];
        for (int i = 0; i < [arr count]; i++) {
            NSDictionary* dicClass = [arr objectAtIndex:i];
            GuaranteeStages* obj = [[GuaranteeStages alloc] init];
            [obj decodeWithDic:dicClass];
            [self.guaranteeStages addObject:obj];
        }

        //        NSLog(@"installmentList = %@", self.installmentList);
    }
}


@end
