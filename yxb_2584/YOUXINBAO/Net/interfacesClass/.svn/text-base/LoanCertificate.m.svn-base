#import <objc/runtime.h>
#import "LoanCertificate.h"
#import "LoanMoreInfoDetail.h"


@implementation LoanCertificate

-(void)dealloc
{
//  [super dealloc];
}
-(void) decodeWithSubArray:(NSArray*) arr withPropertyName:(NSString*) name {
    if ([name isEqualToString:@"participants"]) {
        self.participants = [[NSMutableArray alloc] init];
        for (int i = 0; i < [arr count]; i++) {
            NSDictionary* dicClass = [arr objectAtIndex:i];
            LoanMoreInfoDetail* obj = [[LoanMoreInfoDetail alloc] init];
            [obj decodeWithDic:dicClass];
            [self.participants addObject:obj];
        }
    }
}
@end
