#import <objc/runtime.h>

#import "LoanMoreInfo.h"
#import "LoanFundDetail.h"

@implementation LoanMoreInfo

-(void)dealloc
{
//  [super dealloc];
}
-(void) decodeWithSubArray:(NSArray*) arr withPropertyName:(NSString*) name {                      
    if ([name isEqualToString:@"loanFundDetails"]) {
        self.loanFundDetails = [[NSMutableArray alloc] init];
        for (int i = 0; i < [arr count]; i++) {
            NSDictionary* dicClass = [arr objectAtIndex:i];
            LoanFundDetail* obj = [[LoanFundDetail alloc] init];
            [obj decodeWithDic:dicClass];
            [self.loanFundDetails addObject:obj];
        }
    }
}
@end
