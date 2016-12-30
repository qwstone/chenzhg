//
//  OverdueModel.h
//  YOUXINBAO
//
//  Created by CH10 on 15/10/29.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OverdueModel : NSObject






/**
 是否需要弹框   1需要； 0不需要；
 */
@property(nonatomic,assign) NSInteger needPop;

/**
 跳转到友借友还详情页面参数
 参数1: 1普通 2闪电;
 参数2: 是否为放款人  1是，0不是;
 参数3：借款单ID;
 参数4 : 借款单类型 1位普通借款单，2通信录好友，3微信好友;
 */
@property (nonatomic,copy)NSString *loanDetail;
/**
 *loanID借款单ID
 */
@property (nonatomic,copy)NSString *loanDetail2;
/**
 借条中心是否有新的消息记录  -1 没有  1-5分别对应借条中心哪个标签页有新数据
 */
@property (nonatomic,copy)NSString *showNewLoan;

/**
 对应ID的那个cell 设为高亮
 */
@property (nonatomic,copy)NSString *HighLightID;
+(instancetype)shareOverdueModel;
@end
