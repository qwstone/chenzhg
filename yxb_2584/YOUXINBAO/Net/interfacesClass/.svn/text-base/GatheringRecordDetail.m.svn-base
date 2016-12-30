#import <objc/runtime.h>
#import "GatheringRecordDetail.h"
#import "GatheringRecordFriend.h"


@implementation GatheringRecordDetail
@dynamic errCode;

-(void)dealloc
{
//  [super dealloc];
}

-(void) decodeWithSubArray:(NSArray*) arr withPropertyName:(NSString*) name {
    if ([name isEqualToString:@"iGatheringRecordFriend"]) {
        self.iGatheringRecordFriend = [[NSMutableArray alloc] init];
        for (int i = 0; i < [arr count]; i++) {
            NSDictionary* dicClass = [arr objectAtIndex:i];
            GatheringRecordFriend* obj = [[GatheringRecordFriend alloc] init];
            [obj decodeWithDic:dicClass];
            [self.iGatheringRecordFriend addObject:obj];
        }
    }
    
    
}

@end
