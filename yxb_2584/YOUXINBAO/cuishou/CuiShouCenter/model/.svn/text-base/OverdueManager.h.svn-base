//
//  OverdueManager.h
//  YOUXINBAO
//
//  Created by 密码是111 on 2016/12/9.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSSkyArray.h"
@interface OverdueManager : NSObject

/**
 * 获取 催收中心数据
 *
 * @param pageNum
 * @param usertoken
 * @param state
 *            0待催收 1催收中 2催收结束
 * @return OverdueLoanData 类型TList
 *
 * @author SKY
 * @date 2016年12月9日
 */

-(NSSkyArray *)getOverdueLoanList:(NSInteger)pageNum usertoken:(NSString *)userToken state:(NSInteger)state;


/**
 * 获取诉讼中心数据
 *
 * @param pageNum
 * @param usertoken
 * @param state
 *            0待诉讼 1诉讼中 2诉讼结束
 * @return OverdueLoanData 类型TList
 *
 * @author SKY
 * @date 2016年12月9日
 */

-(NSSkyArray *)getLawsuitLoanList: (NSInteger)pageNum usertoken:(NSString *)userToken state: (NSInteger)state;



/**
 * 获取可以合并诉讼的借条
 * @param pageNum
 * @param usertoken
 * @param loanID 借条id
 * @return 返回全部数据不分页
 *         OverdueLoanData 类型TList
 *
 * @author SKY
 * @date   2016年12月9日
 */
-(NSSkyArray *)getLawsuitMerge: (NSString *)userToken loanID: (NSInteger)loanID;
@end
