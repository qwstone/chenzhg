#import <objc/runtime.h>
#import "StudentCerInfoV2.h"


@implementation StudentCerInfoV2
@dynamic errCode;

-(void)dealloc
{
//  [super dealloc];
}


-(void) decodeWithSubArray:(NSArray*) arr withPropertyName:(NSString*) name {
    if ([name isEqualToString:@"degreeList"]) {
        self.degreeList = (NSMutableArray *)[NSArray arrayWithArray:arr];
        //        NSLog(@"installmentList = %@", self.installmentList);
    }else if ([name isEqualToString:@"graduationDateList"]) {
        self.graduationDateList = (NSMutableArray *)[NSArray arrayWithArray:arr];
        //        NSLog(@"installmentList = %@", self.installmentList);
    }
}


@end
