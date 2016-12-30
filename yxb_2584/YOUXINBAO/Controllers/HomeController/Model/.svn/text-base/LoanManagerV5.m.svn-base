//
//  LoanManagerV5.m
//  YOUXINBAO
//
//  Created by zjp on 16/1/26.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanManagerV5.h"
#import "YXBLoan.h"
#import "CreateLoanResponse.h"
#import "LoanMoreInfo.h"
#import "LoanListItem.h"
#import "LoanCertificate.h"
@implementation LoanManagerV5


/**
 * 创建和编辑借款单
 *
 * @param loan
 *            借款单详情
 * @return
 */
- (CreateLoanResponse *)__yxb_service__createYXBLoan:(YXBLoan*)loan {
    return [[CreateLoanResponse alloc]init];
}

/**
 * 获取我的借款单信息
 * @param userToken
 * @param loanID
 * @return
 *
 * @author SKY
 * @date   2016年2月16日
 */
-(YXBLoanInfoDetails *)getLoanInfoDetails:(NSString *)userToken loanID:(NSInteger)loanID{
    return [[YXBLoanInfoDetails alloc] init];
}
/**
 * 获取我的借款单信息
 * @param userToken
 * @param loanID
 * @return
 *
 * @author SKY
 * @date   2016年2月16日
 */
-(YXBLoanInfoDetails *)getLoanInfoDetailsV2:(NSString *)userToken loanID:(NSInteger)loanID{
    return [[YXBLoanInfoDetails alloc] init];
}
/**
 * 用户点击我的借条底部按钮
 *
 * @param userToken
 * @param loanID
 * @param bottomButtonID
 * @return
 *
 * @author SKY
 * @date 2016年2月16日
 */
-(TResultSet *)clickBottomButton:(NSString *)userToken loanID:(NSInteger)loanID bottomButtonID:(NSInteger)bottomButtonID{
    return [[TResultSet alloc] init];
}

/**
 * 发送对话
 *
 * @param userToken
 * @param loanID
 *            借款单ID
 * @param textNum
 *            聊天文字编号
 * @return
 *
 * @author SKY
 * @date 2016年2月16日
 */
-(TResultSet *)loanChat:(NSString *)userToken loanID:(NSInteger)loanID textNum:(NSString *)textNum{
    return [[TResultSet alloc] init];
}

/**
 * 获取更多信息
 *
 * @param userToken
 * @param loanID
 * @return
 *
 * @author SKY
 * @date 2016年1月30日
 */
- (LoanMoreInfo*)getLoanMoreInfo:(NSString *)userToken loanID:(NSInteger)loanID{
    return [[LoanMoreInfo alloc]init];
}
/**
 * 获取借条中心列表数据
 *
 * @param userToken
 * @param pageNum
 * @param loanType
 *            1谁欠我钱; 2我欠谁钱; 3未成交; 4已还清; 5电子借条
 * @return NSSkyArray列表中返回LoanListItem类数组
 *
 * @author SKY
 * @date 2016年1月30日
 */
-(NSSkyArray *)getLoanListData:(NSString *)userToken pageNum:(NSInteger)pageNum loanType:(NSInteger)loanType{
    return [[NSSkyArray alloc] init];
}

/**
 * 获取借条详情（老CA认证页面）
 *
 * @param userToken
 * @param loanID
 * @return
 *
 * @author SKY
 * @date 2016年1月30日
 */
- (LoanCertificate*)getLoanCertificate:(NSString *)userToken loanID:(NSInteger)loanID{

    return [[LoanCertificate alloc]init];
}
/**
 * 申请延期
 *
 * @param userToken
 * @param loanID
 * @param compensationMoney
 *            补偿金额
 * @param daleyTime
 *            延期至时间
 * @return
 *
 * @author SKY
 * @date 2016年2月17日
 */
- (YXBLoanInfoDetails *)applyDelay:(NSString *)userToken loanID:(NSInteger)loanID compensationMoney:(NSString *)compensationMoney daleyTime:(NSString *)daleyTime{

    return [[YXBLoanInfoDetails alloc]init];
}
/**
 *
 * @param userToken
 *            用户token
 * @param pageNum
 * @param loanID
 *            借款单id
 * @return
 *
 * @author SKY
 * @date 2016年3月24日
 */
-(NSSkyArray *)getPreserveCer:(NSString *)userToken pageNum:(NSInteger)pageNum loanID:(NSInteger)loanID{

    return [[NSSkyArray alloc]init];
}
/**
 * 添加录制视频
 * @param userToken 用户tokn
 * @param verifyVideoUrl 视频地址
 * @param loanId 借款单id
 * @return
 */

-(TResultSet *)uploadVideo:(NSString *)userToken verifyVideoUrl:(NSString *)verifyVideoUrl loanId:(NSInteger)loanId{
    
    return [[TResultSet alloc]init];
}

@end
