#import <objc/runtime.h>
#import "GuaranteeData.h"
#import "GuaranteeStages.h"

@implementation GuaranteeData

@dynamic errCode;

-(void)dealloc
{
//  [super dealloc];
}


-(void) decodeWithSubArray:(NSArray*) arr withPropertyName:(NSString*) name {
    if ([name isEqualToString:@"guaranteeStages"]) {
        self.guaranteeStages = [[NSMutableArray alloc] init];
        for (int i = 0; i < [arr count]; i++) {
            NSDictionary* dicClass = [arr objectAtIndex:i];
            GuaranteeStages* obj = [[GuaranteeStages alloc] init];
            [obj decodeWithDic:dicClass];
            [self.guaranteeStages addObject:obj];
        }
    }
}
@end
