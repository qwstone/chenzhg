//
//  TLoanLog.h
//  YOUXINBAO
//
//  Created by 张淼 on 15/4/13.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "BaseData.h"

@interface TLoanLog : BaseData

@property (nonatomic,assign)NSInteger id;

/**
 * identifier field
 */

@property (nonatomic,assign) NSInteger t_id;


/**  field  auto_increment */

/**
 * field  错误编号
 */

@property (nonatomic,assign) NSInteger errCode;

/**
 * field  错误提示
 */

@property (nonatomic,assign) NSString * errString;

/**
 * field  借贷单 id
 */

@property (nonatomic,assign) NSInteger loanId;

/**
 * 【借款中】    1->申请
 * 【借款中】    11->修改
 * 【借款中】    12->借款人取消
 * 【借款中】    21->同意
 * 【借款中】    22->婉拒
 * 【借款中】    23->同意修改并借款
 * 【借款中】    24->放款(友信宝-线上)
 * 【借款中】    25->放款(非友信宝-线下)
 * 【借款中】    26->确认借款已收款(非友信宝-线下)
 * 【借款中】    27->确认借款未收款(非友信宝-线下)
 * 【还款中】    31->还款(友信宝-线上)
 * 【还款中】    32->还款(非友信宝-线下)
 * 【还款中】    33->确认还款已收款(非友信宝-线下)
 * 【还款中】    34->确认还款未收款(非友信宝-线下)
 * 【还款中】    41->延期
 * 【还款中】    42->同意延期
 * 【还款中】    43->拒绝延期
 * 【还款中】    44->取消延期
 * 【借款中】    51->快速放款
 * 【借款中】    52->确认快速放款
 * 【借款中】    53->拒绝快速放款
 */

@property (nonatomic,assign) NSInteger operationType;

/**
 * field  操作者 id
 */

@property (nonatomic,assign) NSInteger operatorId;

/**
 * field  操作日期
 */

@property (nonatomic,copy) NSString * operationDate;

/**
 * field  借款人动态
 */
@property (nonatomic,strong) NSString *borrowerNote;
/**
 * field  放款人动态
 */

@property (nonatomic,strong) NSString *lenderNote;


/**
 * field  发起者名字
 */

@property (nonatomic, copy) NSString * creatorName;

/**
 * field  发起者身份证号
 */

@property (nonatomic, copy) NSString * creatorIdCardNo;

/**
 * field  借条生成提示
 */

@property (nonatomic,copy) NSString * loanCenterValidNote;

/**
 * field  信息类型 1->普通信息; 2->逾期信息
 */
@property (nonatomic,assign) NSInteger msgType;
/**
 * field  信息类型 msgType 为 2->逾期信息 时显示
 */
@property (nonatomic,copy) NSString * msgDetail;
@end
