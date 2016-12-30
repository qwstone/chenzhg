#import <objc/runtime.h>
#import "RepaymentNoteData.h"
#import "InstallmentDetail.h"


@implementation RepaymentNoteData
@dynamic errCode;

-(void)dealloc
{
//  [super dealloc];
}

-(void) decodeWithSubArray:(NSArray*) arr withPropertyName:(NSString*) name {
    if ([name isEqualToString:@"installmentDetailList"]) {
        self.installmentDetailList = [[NSMutableArray alloc] init];
        for (int i = 0; i < [arr count]; i++) {
            NSDictionary* dicClass = [arr objectAtIndex:i];
            InstallmentDetail* obj = [[InstallmentDetail alloc] init];
            [obj decodeWithDic:dicClass];
            [self.installmentDetailList addObject:obj];
        }
    }
    
}


@end
