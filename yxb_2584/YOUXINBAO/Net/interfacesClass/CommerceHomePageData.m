#import <objc/runtime.h>
#import "CommerceHomePageData.h"
#import "GoodsResume.h"
#import "CommerceBanner.h"


@implementation CommerceHomePageData

@dynamic errCode;
- (void)decodeWithDic:(NSDictionary *)dic {
    [super decodeWithDic:dic];

    NSMutableArray *resumeArray = [NSMutableArray new];
    for (NSDictionary *dic in self.goodsResumeList) {
        GoodsResume *resume = [[GoodsResume alloc] init];
        [resume decodeWithDic:dic];
        [resumeArray addObject:resume];
    }
    self.goodsResumeList = resumeArray;
    
    NSMutableArray *bannersArr = [NSMutableArray new];
    for (NSDictionary *dic in self.commerceBannerList) {
        CommerceBanner *banner = [[CommerceBanner alloc] init];
        [banner decodeWithDic:dic];
        [bannersArr addObject:banner];
    }
    self.commerceBannerList = bannersArr;
}

-(void) decodeWithSubArray:(NSArray*) arr withPropertyName:(NSString*) name {
    if ([name isEqualToString:@"goodsResumeList"]) {
        self.goodsResumeList = (NSMutableArray *)[NSArray arrayWithArray:arr];
        //        NSLog(@"installmentList = %@", self.installmentList);
    }else if ([name isEqualToString:@"commerceBannerList"]) {
        self.commerceBannerList = (NSMutableArray *)[NSArray arrayWithArray:arr];
        //        NSLog(@"installmentList = %@", self.installmentList);
    }else if ([name isEqualToString:@"categoryImageUrl"]) {
        
        self.categoryImageUrl = (NSMutableArray *)[NSArray arrayWithArray:arr];
    }
}

-(void)dealloc
{
//  [super dealloc];
}

@end
