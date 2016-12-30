#import <objc/runtime.h>
#import "CommerceBanner.h"
#import "CommerceIndexPageData.h"
#import "GoodsResume.h"
#import "FlashSale.h"

@implementation CommerceIndexPageData

@dynamic errCode;
- (void)decodeWithDic:(NSDictionary *)dic {
    [super decodeWithDic:dic];
    
    NSMutableArray *bannersArr = [NSMutableArray new];
    for (NSDictionary *dic in self.commerceBannerList) {
        CommerceBanner *banner = [[CommerceBanner alloc] init];
        [banner decodeWithDic:dic];
        [bannersArr addObject:banner];
    }
    self.commerceBannerList = bannersArr;
    
    NSMutableArray *electronicsList = [NSMutableArray new];
    for (NSDictionary *dic in self.electronicsList) {
        GoodsResume *resume = [[GoodsResume alloc] init];
        [resume decodeWithDic:dic];
        [electronicsList addObject:resume];
    }
    self.electronicsList = electronicsList;
    
    NSMutableArray *trainingList = [NSMutableArray new];
    for (NSDictionary *dic in self.trainingList) {
        GoodsResume *resume = [[GoodsResume alloc] init];
        [resume decodeWithDic:dic];
        [trainingList addObject:resume];
    }
    self.trainingList = trainingList;
    
    NSMutableArray *fashionList = [NSMutableArray new];
    for (NSDictionary *dic in self.fashionList) {
        GoodsResume *resume = [[GoodsResume alloc] init];
        [resume decodeWithDic:dic];
        [fashionList addObject:resume];
    }
    self.fashionList = fashionList;
    
    NSMutableArray *beautyList = [NSMutableArray new];
    for (NSDictionary *dic in self.beautyList) {
        GoodsResume *resume = [[GoodsResume alloc] init];
        [resume decodeWithDic:dic];
        [beautyList addObject:resume];
    }
    self.beautyList = beautyList;
    
    NSMutableArray *flashSaleList = [NSMutableArray new];
    for (NSDictionary *dic in self.flashSaleList) {
        FlashSale *flash = [[FlashSale alloc] init];
        [flash decodeWithDic:dic];
        [flashSaleList addObject:flash];
    }
    self.flashSaleList = flashSaleList;
}

-(void) decodeWithSubArray:(NSArray*) arr withPropertyName:(NSString*) name {
    if ([name isEqualToString:@"electronicsList"]) {
        self.electronicsList = (NSMutableArray *)[NSArray arrayWithArray:arr];
        //        NSLog(@"installmentList = %@", self.installmentList);
    }else if ([name isEqualToString:@"commerceBannerList"]) {
        self.commerceBannerList = (NSMutableArray *)[NSArray arrayWithArray:arr];
        //        NSLog(@"installmentList = %@", self.installmentList);
    }else if ([name isEqualToString:@"trainingList"]) {
        self.trainingList = (NSMutableArray *)[NSArray arrayWithArray:arr];

    }else if ([name isEqualToString:@"fashionList"]) {
        self.fashionList = (NSMutableArray *)[NSArray arrayWithArray:arr];
        
    }else if ([name isEqualToString:@"beautyList"]) {
        self.beautyList = (NSMutableArray *)[NSArray arrayWithArray:arr];
        
    }else if ([name isEqualToString:@"flashSaleList"]) {
        self.flashSaleList = (NSMutableArray *)[NSArray arrayWithArray:arr];
        
    }
}



-(void)dealloc
{
//  [super dealloc];
}

@end
