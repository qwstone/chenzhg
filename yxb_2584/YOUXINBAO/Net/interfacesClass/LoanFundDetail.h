#import <Foundation/Foundation.h> 
#import "TResultSet.h"


@interface LoanFundDetail : TResultSet
@property (nonatomic, strong) NSString* fundName;
@property (nonatomic, strong) NSString* moneyStr;
@property (nonatomic, strong) NSString* date;

@end
