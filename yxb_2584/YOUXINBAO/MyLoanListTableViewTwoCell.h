//
//  MyLoanListTableViewTwoCell.h
//  YOUXINBAO
//
//  Created by CH10 on 16/2/16.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//
/*
 1101 申请借款
 1102 提醒确认
 1103 取消借款
 1104 收款成功
 1105 上传视频
 1106 拒绝收款
 1107 提醒审核
 
 1201 支付成功
 1202 发起放款
 1203 提醒收款
 1204 婉拒
 1205 提醒录制视频
 1206 审核通过
 1207 提醒录制视频（和1205重了）
 1208 提醒重录
 
 2101 其他还款方式（亲，我已还款，麻烦确认一下）
 2102 延期提醒
 2103 其他还款方式（逾期）
 2104 提醒收款
 2105 还款成功（当期）
 2106 还款成功（2期）
 2107 还款成功（当期，逾期）
 2108 还款成功 （2期，逾期）
 2109 已还清
 
 
 2201 催款（高窄）
 2202 拒绝延期
 2203 同意延期
 2204 催款
 2205 未收到线下还款
 2206 确认线下已还款
 2207 确认收款
 2208 取消延期
 2209 审核未通过
 
 2210 服务费2元
 2211 服务费5元
 2212 服务费10元
 2213 服务费标准图片
 2214 拒绝部分还款
 2215 同意部分还款
 2216 同意延期申请
 */
#import <UIKit/UIKit.h>
#import "YXBLoanDialogue.h"

typedef enum{
    
    /**申请借款*/
    picShenQingJieKuan = 1101,
    /**提醒确认*/
    picTiXingQueRen,
    /**取消借款*/
    picQuXiaoJieKuan,
    /**收款成功*/
    picShouKuanChengGong,
    /**上传视频*/
    picShangChuanShiPin,
    /**拒绝收款*/
    picJuJueShouKuan,
    /**提醒审核*/
    picTiXingShenHe,
    
    /**支付成功*/
    picZhiFuChengGong = 1201,
    /**发起放款*/
    picFaQiFangKuan,
    /**提醒收款*/
    picTiXingShouKuan,
    /**婉拒*/
    picWanJu,
    /**提醒录制视频*/
    picTiXingLuZhiShiPin,
    /**审核通过*/
    picShenHeTongGuo,
    /**提醒录制视频2*/
    picTiXingLuZhiShiPin2,
    /**提醒重录*/
    picTiXingChongLu,
    
    /**其他方式还款*/
    picQiTaFangShiHuanKuan = 2101,
    /**延期提醒*/
    picYanQiTiXing,
    /**其他方式还款(逾期)*/
    picQiTaFangShiHuanKuan2,
    /**提醒收款*/
    picTiXingShouKuan2,
    /**还款成功（当期）*/
    picHuanKuanChengGongDangQi,
    /**还款成功（多期）*/
    picHuanKuanChengGong2Qi,
    /**还款成功（当期）（逾期）*/
    picHuanKuanChengGongDangQi2,
    /**还款成功（多期）（逾期）*/
    picHuanKuanChengGong2Qi2,
    /**已还清*/
    picYiHuanQing,
    
    /**催款*/
    picCuiKuan = 2201,
    /**拒绝延期*/
    picJuJueYanQi,
    /**同意延期*/
    picTongYiYanQi,
    /**催款2*/
    picCuiKuan2,
    /**未收到线下还款*/
    picWeiShouDaoXianXiaHuanKuan,
    /**确认线下已还款*/
    picQueRenXianXiaYiHuanKuan,
    /**确认收款*/
    picQueRenShouKuan,
    /**取消延期*/
    picQuXiaoYanQi,
    /**审核未通过*/
    pciShenHeWeiTongGuo,
    
    picfuwufei2=2210,
    picfuwufei5=2211,
    picfuwufei10=2212,
    picfuwufei=2213,
    
//    2214 拒绝部分还款
    
//    2215 同意部分还款
    
//    2216 同意延期申请
    
    
}myLoanDialogPictureCode;


@interface MyLoanListTableViewTwoCell : UITableViewCell

@property(nonatomic,strong)YXBLoanDialogue *model;
@property (nonatomic,copy)void(^updateVideoClicked)();

+(instancetype)MyLoanListTableViewTwoCellWithTableView:(UITableView *)tableView;
@end
