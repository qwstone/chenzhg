#import <objc/runtime.h>
#import "BlankNoteData.h"


@implementation BlankNoteData


@dynamic errCode;
-(void)dealloc
{
//  [super dealloc];
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.noteSummaryList = nil;
    }
    return self;
}

-(NSString *)repaymentStringWithType
{
    NSString *repaymentStr = @"";
    NSArray *array = [NSArray arrayWithObjects:@"全额",@"分期", nil];
    if (_repaymentType < [array count]) {
        repaymentStr = array[_repaymentType];
        
    }
    
    return repaymentStr;
}

-(void) decodeWithSubArray:(NSArray*) arr withPropertyName:(NSString*) name {
    if ([name isEqualToString:@"noteSummaryList"]) {
        self.noteSummaryList = [[NSMutableArray alloc] init];
        for (int i = 0; i < [arr count]; i++) {
            NSDictionary* dicClass = [arr objectAtIndex:i];
            NoteSummary* obj = [[NoteSummary alloc] init];
            [obj decodeWithDic:dicClass];
            [self.noteSummaryList addObject:obj];
        }
    }

}


@end
