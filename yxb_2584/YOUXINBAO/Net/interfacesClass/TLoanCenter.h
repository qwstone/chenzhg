#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface TLoanCenter : BaseData

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger errCode;

@property (nonatomic, strong) NSString* errString;

@property (nonatomic, assign) NSInteger borrowerId;

@property (nonatomic, strong) NSString* borrowerRealname;

@property (nonatomic, strong) NSString* borrowerIconAddr;

@property (nonatomic, strong) NSString* borrowerIdCardNo;

@property (nonatomic, strong) NSString* borrowerUsername;

@property (nonatomic, assign) NSInteger lenderId;

@property (nonatomic, strong) NSString* lenderRealname;

@property (nonatomic, strong) NSString* lenderIconAddr;

@property (nonatomic, strong) NSString* lenderIdCardNo;

@property (nonatomic, strong) NSString* lenderUsername;

@property (nonatomic, strong) NSString* createDate;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, strong) NSString* lastModifyDate;

@property (nonatomic, assign) NSInteger loanId;

@property (nonatomic, strong) NSString* money;

@property (nonatomic, assign) NSInteger payType;

@property (nonatomic, strong) NSString* interest;

@property (nonatomic, strong) NSString* note;

@property (nonatomic, strong) NSString* realBorrowDate;

@property (nonatomic, strong) NSString* expectRepayDate;

@property (nonatomic, assign) NSInteger repayType;

@property (nonatomic, assign) NSInteger borrowerUnreadFlag;

@property (nonatomic, assign) NSInteger lenderUnreadFlag;

@end
