#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface RepaymentNoteData : BaseData

@property (nonatomic, assign) NSInteger repaymentNoteID;

@property (nonatomic, assign) NSInteger state;

@property (nonatomic, assign) NSInteger errCode;

@property (nonatomic, strong) NSString* errString;

@property (nonatomic, strong) NSString* creditorName;

@property (nonatomic, assign) NSInteger isTuhao;

@property (nonatomic, strong) NSString* debtorName;

@property (nonatomic, strong) NSString* money;

@property (nonatomic, strong) NSString* repaymentMode;

@property (nonatomic, strong) NSString* time;

@property (nonatomic, strong) NSString* moneyPerMonth;//利息金额

@property (nonatomic, strong) NSString* yearRate;//年利率
@property (nonatomic, strong) NSMutableArray *installmentDetailList;

/**
 * 审核失败原因
 */

@property (nonatomic, strong) NSString* reviewFailReason;


@end
