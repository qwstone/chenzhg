#import <objc/runtime.h>
#import "ProfitUserBuyDetail.h"
#import "ProfitUserBuyDetailTips.h"


@implementation ProfitUserBuyDetail

-(void)dealloc
{
//  [super dealloc];
}

-(void)decodeWithSubArray:(NSArray *)arr withPropertyName:(NSString *)name
{
    if ([name isEqualToString:@"iProfitUserBuyDetailTips"])
    {
        self.iProfitUserBuyDetailTips = [[NSMutableArray alloc] init];
        for (int i = 0; i < [arr count]; i++)
        {
            NSDictionary* dicClass = [arr objectAtIndex:i];
            ProfitUserBuyDetailTips* obj = [[ProfitUserBuyDetailTips alloc] init];
            [obj decodeWithDic:dicClass];
            [self.iProfitUserBuyDetailTips addObject:obj];
        }
    }

}

@end
