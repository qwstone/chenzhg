#import <Foundation/Foundation.h> 
#import "BaseData.h"

//一个白条下各个借款人的还款详情
@interface NoteSummary : BaseData

@property (nonatomic, strong) NSString* time;

@property (nonatomic, strong) NSString* debtorName;

@property (nonatomic, assign) NSInteger repaymentNoteID;

@property (nonatomic, assign) NSInteger state;

@end
