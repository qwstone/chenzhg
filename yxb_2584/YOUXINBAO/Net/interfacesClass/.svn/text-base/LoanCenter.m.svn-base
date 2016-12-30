#import <objc/runtime.h>
#import "LoanCenter.h"
#import "TInstallmentLoan.h"


@implementation LoanCenter
@dynamic errCode;

-(void)dealloc
{
//  [super dealloc];
}

- (void)decodeWithDic:(NSDictionary *)dic {
    [super decodeWithDic:dic];
    NSMutableArray *installmentLoanArray = [NSMutableArray new];
    for (NSDictionary *dic in self.installmentList) {
        TInstallmentLoan *installmentLoan = [[TInstallmentLoan alloc] init];
        [installmentLoan decodeWithDic:dic];
        [installmentLoanArray addObject:installmentLoan];
    }
    self.installmentList = installmentLoanArray;
}


-(void) decodeWithSubArray:(NSArray*) arr withPropertyName:(NSString*) name {
    if ([name isEqualToString:@"installmentList"]) {
        self.installmentList = (NSMutableArray *)[NSArray arrayWithArray:arr];
        NSLog(@"installmentList = %@", self.installmentList);
    }
}

@end
