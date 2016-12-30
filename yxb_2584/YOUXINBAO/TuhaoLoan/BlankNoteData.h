#import <Foundation/Foundation.h> 
#import "BaseData.h"
#import "NoteSummary.h"

@interface BlankNoteData : BaseData

@property (nonatomic, assign) NSInteger blankNoteID;

@property (nonatomic, assign) NSInteger errCode;

@property (nonatomic, strong) NSString* errString;

@property (nonatomic, strong) NSString* token;

@property (nonatomic, strong) NSString* money;

@property (nonatomic, strong) NSString* nickName;

@property (nonatomic, strong) NSString* imgurl;

@property (nonatomic, assign) NSInteger borrowNumber;

@property (nonatomic, assign) NSInteger loanNumber;

@property (nonatomic, assign) NSInteger repaymentType;

@property (nonatomic, assign) NSInteger repaymentMonth;

@property (nonatomic, strong) NSString* yearRate;

@property (nonatomic, strong) NSString* time;

@property (nonatomic, strong) NSString* moneyPerMonth;

@property (nonatomic, assign) NSInteger state;

@property (nonatomic, strong) NSMutableArray *noteSummaryList;

/**
 *  @author chenglibin
 *
 *  还款方式转换成字符串
 *
 *  @param repaymentType 整数
 *
 *  @return 类型 字符串
 */
-(NSString *)repaymentStringWithType;

@end
