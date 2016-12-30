//
//  MyLoanListBottomView.h
//  YOUXINBAO
//
//  Created by CH10 on 16/2/18.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    canRenJuJue = 2001,//残忍拒绝
    dianHuaLianXi,//电话联系
    faQiXinJieKuan,//发起新借款
    juJueShouKuan,//拒绝收款
    juJueYanQi,//拒绝延期
    quXiaoJieKuan,//取消借款
    quLuZhiShiPin,//去录制视频
    quShenHeShiPin,//去审核视频
    queRenShouKuan,//确认收款
    
    //2010
    queRenWeiShouKuanXianXia,//确认未收款（线下）
    queRenWeiShouKuan,//确认未收款
    queRenYiShouKuanxianxia,//确认已收款（线下）
    queRenYiShouKuan,//确认已收款
    shenQingYanQi,//申请延期
    tiXingDuiFangShouKuan,//提醒对方收款
    tiXingLuZhiShiPin,//提醒录制视频
    tiXingQueRen,//提醒确认
    tiXingShenHeShiPin,//提醒审核视频
    tiXingShiPinShenHe,//提醒视频审核
    
    //2020
    tiXingChongLuShiPin,//提醒重录视频
    tongYiBingZhiFu,//同意并支付
    tongYiYanQi,//同意延期
    woYaoCuiKuan,//我要催款
    woYaoHuanKuanLong,//我要还款(长图)
    woYaoHuanKuan,//我要还款（短图）
    chongXinLuZhiShiPin,//重新录制视频
    woYaoCuiKuanLong,//我要催款（长图）
    quXiaoYanQi,//取消延期
    cuiShouFuWu,//催收服务
    
    //2030  修改利息后  对方为应答的情况下  直觉拒绝
    canRenJuJueLong
    
}myLoanListBottomImgCode;





@protocol MyLoanListBottomViewDelegate <NSObject>

-(void)bottomClickedBtnId:(myLoanListBottomImgCode)bottomBtnId;

@end



@interface MyLoanListBottomView : UIView

@property (nonatomic,copy) NSString *bottomButtonID;
@property (nonatomic,assign)id<MyLoanListBottomViewDelegate>delegate;

//-(MyLoanListBottomView *)initWithFrame:(CGRect)rect andBtnIds:(NSArray*)btnIds;
/**
 根据按钮个数显示不同的样式
 */
-(void)displayWithBtnIds:(NSArray*)btnIds;
@end
