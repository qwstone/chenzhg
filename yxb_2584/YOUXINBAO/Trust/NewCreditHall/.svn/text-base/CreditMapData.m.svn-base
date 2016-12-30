#import <objc/runtime.h>
#import "CreditMapData.h"


@implementation CreditMapData
@dynamic errCode;

-(void)dealloc
{
//  [super dealloc];
}


-(void) decodeWithSubArray:(NSArray*) arr withPropertyName:(NSString*) name {
    if ([name isEqualToString:@"creditProviceList"]) {
        self.creditProviceList = [[NSMutableArray alloc] init];
        self.flagDic = [[NSMutableDictionary alloc] init];
        for (int i = 0; i < [arr count]; i++) {
            NSDictionary* dicClass = [arr objectAtIndex:i];
            CreditProviceMapData* obj = [[CreditProviceMapData alloc] init];
            [obj decodeWithDic:dicClass];
            [self.flagDic setObject:obj.averageFlag forKey:obj.proviceName];
            [self.creditProviceList addObject:obj];
        }
    }
    
    if ([name isEqualToString:@"loseConfidenceProviceList"]) {
        self.loseConfidenceProviceList = [[NSMutableArray alloc] init];
        self.flagDicSX = [[NSMutableDictionary alloc] init];
        for (int i = 0; i < [arr count]; i++) {
            NSDictionary* dicClass = [arr objectAtIndex:i];
            CreditProviceMapData* obj = [[CreditProviceMapData alloc] init];
            [obj decodeWithDic:dicClass];
            [self.flagDicSX setObject:obj.averageFlag forKey:obj.proviceName];
            [self.loseConfidenceProviceList addObject:obj];
        }
    }
}
@end
