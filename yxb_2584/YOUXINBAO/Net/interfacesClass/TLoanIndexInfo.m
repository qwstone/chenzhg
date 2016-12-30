#import <objc/runtime.h>
#import "TLoanIndexInfo.h"
#import "TLoanIndexPersonRank.h"

@implementation TLoanIndexInfo
@dynamic errCode;

-(void)dealloc
{
//  [super dealloc];
}

-(void) decodeWithSubArray:(NSArray*) arr withPropertyName:(NSString*) name {
    if ([name isEqualToString:@"iTLoanIndexPersonRank"]) {
        self.iTLoanIndexPersonRank = [[NSMutableArray alloc] init];
        for (int i = 0; i < [arr count]; i++) {
            NSDictionary* dicClass = [arr objectAtIndex:i];
            TLoanIndexPersonRank* obj = [[TLoanIndexPersonRank alloc] init];
            [obj decodeWithDic:dicClass];
            [self.iTLoanIndexPersonRank addObject:obj];
        }
    }
}

@end
