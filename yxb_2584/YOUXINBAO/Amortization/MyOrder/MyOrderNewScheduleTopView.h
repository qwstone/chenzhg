//
//  MyOrderNewScheduleTopView.h
//  YOUXINBAO
//
//  Created by zjp on 15/7/15.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXBTool.h"
#import "OrderDownPayment.h"
#import "CommerceOrderDetail.h"
#import "CommerceOrder.h"
#import "UIImageView+WebCache.h"
@interface MyOrderNewScheduleTopView : UIView

@property (nonatomic, strong) UILabel* titleLabel; //主标题
@property (nonatomic, strong) UILabel *subTitle;//副标题
@property (nonatomic, strong) UILabel* stagePriceLabel;
@property (nonatomic, strong) UILabel* allMonthLabel;
@property (nonatomic, strong) UIImageView* imgView;
@property (nonatomic, strong) UILabel* paymentLabel;
@property (nonatomic, strong) UILabel *firstPayLabel;//首付
@property (nonatomic, strong) UILabel *couponLabel;//优惠label
@property (nonatomic, strong) UILabel *fenqiLabel;//优惠label

@property(nonatomic,retain)   UILabel *statusLabel;
@property(nonatomic,strong) UIView *line;
//是否显示0服务费
@property(nonatomic,strong) NSString *isNoServiceCharge;
/**
 * 是否 无服务费 “1” 无服务费 “0” 需要服务费
 */
@property(nonatomic,strong) UIImageView *serviceLogo;//是否需要服务费


@property(nonatomic,strong)OrderDownPayment     *PaymentModel;
@property(nonatomic,strong)CommerceOrderDetail     *OrderDetailModel;
@property(nonatomic,strong)CommerceOrder        *OrderListModel;

@property(nonatomic,strong) BaseData *model;
@end
