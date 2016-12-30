//
//  DebtScheduleTopView.h
//  YOUXINBAO
//
//  Created by Feili on 15/4/30.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RepaymentNoteData.h"


typedef NS_ENUM(NSInteger, TuhaoScheduleType)
{
    TuhaoScheduleTypeQueren = 200,//电话确认
    TuhaoScheduleTypeMianqian = 300,//约见面签
    TuhaoScheduleTypeDaozhang = 400,//借款到账
    TuhaoScheduleTypeHuankuaning = 500,//还款中
    TuhaoScheduleTypeWancheng = 600,//还款完成
};

@interface DebtScheduleTopView : UIView

@property(nonatomic,strong)RepaymentNoteData *model;
@property(nonatomic,assign)NSInteger schedule;
-(void)showSchedulePabel;

@end
