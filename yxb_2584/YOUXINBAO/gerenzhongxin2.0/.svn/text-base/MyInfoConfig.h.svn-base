//
//  MyInfoConfig.h
//  YOUXINBAO
//
//  Created by Feili on 15/9/25.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#ifndef YOUXINBAO_MyInfoConfig_h
#define YOUXINBAO_MyInfoConfig_h


#endif


typedef NS_ENUM(NSInteger, MoneyButtonType)
{
    MoneyButtonTypeZonge = 10,//总额
    MoneyButtonTypeZongCash,//现金
    MoneyButtonTypeLiCai,   //理财
    MoneyButtonTypeRedBag,//红包
    MoneyButtonTypeNewZongE,//新总额 改版之后加
    MoneyButtonTypeZuoRiShouYi,//昨日收益
    MoneyButtonTypeLeiJiShouYi,//累计收益

};

//个人中心各个条目枚举
typedef NS_ENUM(NSInteger, MyInfoItemType)
{
    MyInfoItemTypeMoney = 10,//资金明细
    MyInfoItemTypeSafeCenter,//安全中心
    MyInfoItemTypeLoanCenter,//借条中心
    MyInfoItemTypeLiCai,     //无忧理财
    MyInfoItemTypeTimeOrder,//分期订单
    MyInfoItemTypeTimeDanbao,//分期担保
    MyInfoItemTypeCoupon,//优惠券
    MyInfoItemTypeTaskCenter,//任务中心
    MyInfoItemTypeSettings,//设置
    MyInfoItemTypeAboutUs,//关于无忧借条
    MyInfoItemTypeTouZiJiLu//投资记录
};


@protocol MyYXBHeaderViewDelegate <NSObject>

//充值
-(void)chongzhi;

//提现
-(void)tixian;

-(void)getQuickMark;

-(void)moneySelected;

//二维码事件
-(void)qrCodeAction;

-(void)leftClicked;

-(void)headerToSettings;


@end
