#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface CreateBlankNote : BaseData


@property (nonatomic, strong) NSString* token;

@property (nonatomic, strong) NSString* money;

@property (nonatomic, assign) NSInteger borrowNumber;

@property (nonatomic, assign) NSInteger repaymentType;

@property (nonatomic, assign) NSInteger repaymentMonth;

@property (nonatomic, strong) NSString* yearRate;

@end
