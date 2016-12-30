#import <objc/runtime.h>
#import "CommerceDetail.h"
#import "StagesInterest.h"

@implementation CommerceDetail
@dynamic errCode;
-(void)dealloc
{
//  [super dealloc];
}

- (void)decodeWithDic:(NSDictionary *)dic {
    [super decodeWithDic:dic];
    
    NSMutableArray *interestArray = [NSMutableArray new];
    for (NSDictionary *dic in self.stagesInterestList) {
        StagesInterest *interest = [[StagesInterest alloc] init];
        [interest decodeWithDic:dic];
        [interestArray addObject:interest];
    }
    self.stagesInterestList = interestArray;
    
}

-(void) decodeWithSubArray:(NSArray*) arr withPropertyName:(NSString*) name {
    if ([name isEqualToString:@"stagesInterestList"]) {
        self.stagesInterestList = (NSMutableArray *)[NSArray arrayWithArray:arr];
        //        NSLog(@"installmentList = %@", self.installmentList);
    }else if ([name isEqualToString:@"imageUrlArray"]) {
        
        self.imageUrlArray = (NSMutableArray *)[NSArray arrayWithArray:arr];
    }else if ([name isEqualToString:@"downPayment"]) {
        
        self.downPayment = (NSMutableArray *)[NSArray arrayWithArray:arr];
    }
}

@end
