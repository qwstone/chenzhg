#import <Foundation/Foundation.h> 
#import "BaseData.h"



typedef enum {
    // 分期借款单状态
    
    /**
     * 【  申请中   】	0-> 未打款
     */
    NOT_PAY = 0,
    /**
     * 【  还款中   】	100-> 待打款
     */
    NEEDREPAY_ONTIME = 100,
    /**
     * 【  还款中   】	150-> 待打款-超时
     */
    NEEDREPAY_DELAY = 150,
    /**
     * 【还款中】	200-> 待收款(按时全额)
     */
    NEEDRECEIVE_ONTIME = 200,
    /**
     * 【还款中】	250-> 待收款(延期全额)
     */
    NEEDRECEIVE_DELAY = 250,
    /**
     * 【历史记录】	300-> 按时还款成功
     */
    REPAYED_ONTIME = 300,
    
    /**
     * 【历史记录】	350-> 超时还款成功
     */
    REPAYED_DELAY = 350,
    
    
}InstallmentLoan;

@interface TInstallmentLoan : BaseData

@property (nonatomic, assign) InstallmentLoan status;

@property (nonatomic, strong) NSString* money;

@property (nonatomic, strong) NSString* note;

@property (nonatomic, strong) NSString* realRepayDate;

@property (nonatomic, strong) NSString* expectRepayDate;

@property (nonatomic, assign) NSInteger periodNo;

@end
