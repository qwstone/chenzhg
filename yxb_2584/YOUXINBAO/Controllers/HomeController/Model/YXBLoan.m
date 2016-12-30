#import <objc/runtime.h>
#import "YXBLoan.h"


@implementation YXBLoan

-(void)dealloc
{
//  [super dealloc];
}

-(NSString *)description
{
    NSString *cDescription = [NSString stringWithFormat:@"loanType==%ld\n loanFriendType==%ld\n money=%@\n backTime==%@\n purpose==%@\n useBankRate==%ld\n repayType==%ld\n interestType==%ld\n interest==%@\n  duration==%@\n",(long)self.loanType,(long)self.loanFriendType,self.money,self.backTime,self.purpose,(long)self.useBankRate,(long)self.repayType,(long)self.interestType,self.interest, self.duration];
    return cDescription;
}

@end
