#import <objc/runtime.h>
#import "User.h"


@implementation User

@dynamic errCode;

-(void)dealloc
{
//  [super dealloc];
}


//返回 等级格式化字符串
-(NSString *)levelFormatWithDesc
{
    NSMutableString *str = [NSMutableString string];
    if ([_lendMoneyLevelDesc isEqualToString:@"0"]) {
        [str appendString:@"0"];
    }
    else
    {
        [str appendString:@"1"];

    }
    
    if ([_friendInviteLevelDesc isEqualToString:@"0"]) {
        [str appendString:@"0"];
    }
    else
    {
        [str appendString:@"1"];
        
    }
    
    if ([_participateLevelDesc isEqualToString:@"0"]) {
        [str appendString:@"0"];
    }
    else
    {
        [str appendString:@"1"];
        
    }
    
    if ([_lendTimesLevelDesc isEqualToString:@"0"]) {
        [str appendString:@"0"];
    }
    else
    {
        [str appendString:@"1"];
        
    }
    
    if ([_friendsSumLevelDesc isEqualToString:@"0"]) {
        [str appendString:@"0"];
    }
    else
    {
        [str appendString:@"1"];
        
    }

    return str;



}

////获取现金总额
//-(CGFloat)getCashMoney
//{
//    CGFloat money = 0;
//    CGFloat cash = [self.totalMoney floatValue] - [self.redbag floatValue];
//    if (cash >= 0) {
//        money = cash;
//    }
//    else
//    {
//        money = 0;
//    }
//    
//    return money;
//}


@end
