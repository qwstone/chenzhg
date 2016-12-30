//
//  YXBLoanCenterNoRecordView.h
//  YOUXINBAO
//
//  Created by CH10 on 16/2/24.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXBLoanCenterNoRecordView : UIView
/**
 *type  0 我欠谁钱，谁欠我钱，未成交
 *      1 已还清
 *      2 电子借条
 *      3 已还清
 *      4 待催收
 *      3 催收中
 *      4 催收结束
 */
@property (nonatomic,assign)NSInteger type;

@end
