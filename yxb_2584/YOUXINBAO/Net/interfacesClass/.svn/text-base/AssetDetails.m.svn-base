#import <objc/runtime.h>
#import "AssetDetails.h"
#import "AssetParticipation.h"


@implementation AssetDetails

-(void)dealloc
{
//  [super dealloc];
}
-(void) decodeWithSubArray:(NSArray*) arr withPropertyName:(NSString*) name {
    if ([name isEqualToString:@"participationList"]) {
        self.participationList = [[NSMutableArray alloc] init];
        for (int i = 0; i < [arr count]; i++) {
            NSDictionary* dicClass = [arr objectAtIndex:i];
            AssetParticipation* obj = [[AssetParticipation alloc] init];
            [obj decodeWithDic:dicClass];
            [self.participationList addObject:obj];
        }
    }
}
@end
