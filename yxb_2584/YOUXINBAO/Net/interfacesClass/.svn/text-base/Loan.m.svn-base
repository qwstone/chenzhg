#import <objc/runtime.h>
#import "Loan.h"
#import "TInstallmentLoan.h"
#import "TCompensationNote.h"


@implementation Loan
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
    NSMutableArray * compensatinNoteArray = [NSMutableArray new];
    for (NSDictionary * dic in self.compensationNoteList) {
        TCompensationNote * compensatinNote = [[TCompensationNote alloc]init];
        [compensatinNote decodeWithDic:dic];
        [compensatinNoteArray addObject:compensatinNote];
    }
    self.installmentList = installmentLoanArray;
    self.compensationNoteList = compensatinNoteArray;
    
    
}


-(void) decodeWithSubArray:(NSArray*) arr withPropertyName:(NSString*) name {
    if ([name isEqualToString:@"installmentList"]) {
        self.installmentList = [NSArray arrayWithArray:arr];
        NSLog(@"installmentList = %@", self.installmentList);
    }
    if ([name isEqualToString:@"compensationNoteList"]) {
        self.compensationNoteList = [NSArray arrayWithArray:arr];
    }
}

+ (NSString *)getLoanPeriodWith:(LoanPeriod)loanPeriod
{
    switch (loanPeriod) {
        case LoanPeriod_DAY_1:
            return @"1天";
            break;
        case LoanPeriod_DAY_2:
            return @"2天";
            break;
        case LoanPeriod_DAY_3:
            return @"3天";
            break;
        case LoanPeriod_DAY_4:
            return @"4天";
            break;
        case LoanPeriod_DAY_5:
            return @"5天";
            break;
        case LoanPeriod_DAY_6:
            return @"6天";
            break;
        case LoanPeriod_WEEK_1:
            return @"1周";
            break;
        case LoanPeriod_WEEK_2:
            return @"2周";
            break;
        case LoanPeriod_WEEK_3:
            return @"3周";
            break;
        case LoanPeriod_MONTH_1:
            return @"1个月";
            break;
        case LoanPeriod_MONTH_2:
            return @"2个月";
            break;
        case LoanPeriod_MONTH_3:
            return @"3个月";
            break;
        case LoanPeriod_MONTH_4:
            return @"4个月";
            break;
        case LoanPeriod_MONTH_5:
            return @"5个月";
            break;
        case LoanPeriod_MONTH_6:
            return @"6个月";
            break;
        case LoanPeriod_MONTH_7:
            return @"7个月";
            break;
        case LoanPeriod_MONTH_8:
            return @"8个月";
            break;
        case LoanPeriod_MONTH_9:
            return @"9个月";
            break;
        case LoanPeriod_MONTH_10:
            return @"10个月";
            break;
        case LoanPeriod_MONTH_11:
            return @"11个月";
            break;
        case LoanPeriod_YEAR_1:
            return @"1年";
            break;
        default:
            break;
    }
}

- (CGFloat)interestCalculatedWithLoanPeriod:(LoanPeriod)loanPeriod money:(NSInteger)money interestRate:(CGFloat)interestRate
{
    
    if (loanPeriod <= LoanPeriod_DAY_6) {
        return money * interestRate * loanPeriod/360.0;
    }else if (loanPeriod >LoanPeriod_DAY_6 && loanPeriod <= LoanPeriod_WEEK_3){
        return money * interestRate *(loanPeriod-LoanPeriod_DAY_6)/52.0;
    }else if (loanPeriod > LoanPeriod_WEEK_3){
        return money * interestRate *(loanPeriod - LoanPeriod_WEEK_3)/12.0;
    }else{
        return 0;
    }

 }

- (CGFloat)interestRateWithLoanPeriod:(LoanPeriod)loanPeriod money:(NSInteger)money interest:(CGFloat)interest//利率
{
    CGFloat interestRate = 0;
    if (money <= 0) {
        interestRate = 0;
    }else{
        if (loanPeriod <= LoanPeriod_DAY_6) {
            interestRate = interest/(money * ((loanPeriod+1)/360.0));
        }else if (loanPeriod >LoanPeriod_DAY_6 && loanPeriod <= LoanPeriod_WEEK_3){
            interestRate = interest/(money * (loanPeriod-LoanPeriod_DAY_6)/52.0);
        }else if (loanPeriod > LoanPeriod_WEEK_3){
            interestRate = interest/(money * (loanPeriod - LoanPeriod_WEEK_3)/12.0);
        }else{
            interestRate = 0;
        }

    }
    
    return interestRate;
  
}

/*
-(LoanInterestCalculateType)loanInterestCalculateType
{
    //归纳利息的计算方式银行息 自定义 还是无息
    self.loanInterestCalculateType = LoanInterestCalculateTypeCustom;
    if (self.useBankRate == 1) {
        self.loanInterestCalculateType = LoanInterestCalculateTypeBank;
    }
    else
    {
        if (self.interestType == LoanInterestTypeNone) {
            self.loanInterestCalculateType = LoanInterestCalculateTypeNone;
            
        }
        
    }
    
    return _loanInterestCalculateType;

}

*/

@end
