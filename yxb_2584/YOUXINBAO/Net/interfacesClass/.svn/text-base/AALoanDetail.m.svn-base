#import <objc/runtime.h>
#import "AALoanDetail.h"
#import "AALoanUserMemberInfo.h"


@implementation AALoanDetail
@dynamic errCode;

-(void)dealloc
{
//  [super dealloc];
}

- (void)decodeWithDic:(NSDictionary *)dic {
    [super decodeWithDic:dic];

}

-(void) decodeWithSubArray:(NSArray*) arr withPropertyName:(NSString*) name {
    if ([name isEqualToString:@"iAALoanUserMemberInfo"]) {
        self.iAALoanUserMemberInfo = [[NSMutableArray alloc] init];
        for (int i = 0; i < [arr count]; i++) {
            NSDictionary* dicClass = [arr objectAtIndex:i];
            AALoanUserMemberInfo* obj = [[AALoanUserMemberInfo alloc] init];
            [obj decodeWithDic:dicClass];
            [self.iAALoanUserMemberInfo addObject:obj];
        }
    }
}

@end
