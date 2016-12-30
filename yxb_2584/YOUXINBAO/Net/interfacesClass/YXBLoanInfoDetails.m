#import <objc/runtime.h>
#import "YXBLoanInfoDetails.h"
#import "YXBLoanDialogue.h"
#import "YXBLoanChat.h"
@implementation YXBLoanInfoDetails

-(void)dealloc
{
//  [super dealloc];
}
-(void) decodeWithSubArray:(NSArray*) arr withPropertyName:(NSString*) name {
    if ([name isEqualToString:@"iYXBLoanDialogue"]) {
        self.iYXBLoanDialogue = [[NSMutableArray alloc] init];
        for (int i = 0; i < [arr count]; i++) {
            NSDictionary* dicClass = [arr objectAtIndex:i];
            YXBLoanDialogue* obj = [[YXBLoanDialogue alloc] init];
            [obj decodeWithDic:dicClass];
            [self.iYXBLoanDialogue addObject:obj];
        }
    }else if ([name isEqualToString:@"iYXBLoanChat"]){
        self.iYXBLoanChat = [[NSMutableArray alloc] init];
        for (int i = 0; i < [arr count]; i++) {
            NSDictionary* dicClass = [arr objectAtIndex:i];
            YXBLoanChat* obj = [[YXBLoanChat alloc] init];
            [obj decodeWithDic:dicClass];
            [self.iYXBLoanChat addObject:obj];
        }
    }
}
@end
