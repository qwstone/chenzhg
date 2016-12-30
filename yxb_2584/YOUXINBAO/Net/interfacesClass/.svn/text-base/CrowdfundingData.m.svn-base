#import <objc/runtime.h>
#import "CrowdfundingData.h"
#import "CrowdfundingPerson.h"

@implementation CrowdfundingData
@dynamic errCode;
-(void)dealloc
{
//  [super dealloc];
}
- (void)decodeWithDic:(NSDictionary *)dic {
    [super decodeWithDic:dic];
    
}

-(void) decodeWithSubArray:(NSArray*) arr withPropertyName:(NSString*) name {
    if ([name isEqualToString:@"crowdfundingPerson"]) {
        self.crowdfundingPerson = [[NSMutableArray alloc] init];
        for (int i = 0; i < [arr count]; i++) {
            NSDictionary* dicClass = [arr objectAtIndex:i];
            CrowdfundingPerson * obj = [[CrowdfundingPerson alloc] init];
            [obj decodeWithDic:dicClass];
            [self.crowdfundingPerson addObject:obj];
        }
    }
}
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        self.crowdfundingPerson = [[NSMutableArray alloc] init];
//    }
//    return self;
//}
@end
