//
//  MyOrderNewScheduleTopView.m
//  YOUXINBAO
//
//  Created by zjp on 15/7/15.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "MyOrderNewScheduleTopView.h"

@implementation MyOrderNewScheduleTopView



- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initViews];
    }
    
    return self;
}

- (void)initViews {
    //添加头像
#define LeftSpace 15
#define TopSpace 20
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 220)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    CGFloat x = LeftSpace, y = TopSpace, w = 100, h = 100;
    
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w,h)];
//        _imgView.contentMode = UIViewContentModeScaleAspectFill;
//    _imgView.backgroundColor = rgb(230, 230, 230, 1);
    [bgView addSubview:_imgView];
    
    //添加标题
    x = _imgView.width + 2 * x;
    w = self.width - LeftSpace - x;
    h = 40;
    self.titleLabel = [self labelWithFrame:CGRectMake(x, y, w, h) fontSize:16 textColor:[YXBTool colorWithHexString:@"#303030"]];
    //    _titleLabel.backgroundColor = [UIColor blueColor];
    _titleLabel.adjustsFontSizeToFitWidth = NO;
    _titleLabel.numberOfLines = 2;
    _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [bgView addSubview:_titleLabel];
    
    //添加副标题
    y = y + h+5,
    h = 32;
    self.subTitle = [self labelWithFrame:CGRectMake(x, y, w, h) fontSize:_titleLabel.font.pointSize - 3 textColor:[YXBTool colorWithHexString:@"#6e6e6e"]];
    //    _subTitle.backgroundColor = [UIColor yellowColor];
    _subTitle.numberOfLines = 2;
    _subTitle.lineBreakMode = NSLineBreakByTruncatingTail;
    _subTitle.adjustsFontSizeToFitWidth = NO;
    [bgView addSubview:_subTitle];
    
    //添加价格X期数  ￥5200 X 12期
    
    y = y + h + 10;
    h = 25;
    self.stagePriceLabel = [self labelWithFrame:CGRectMake(x, y, w, 16) fontSize:16 textColor:[YXBTool colorWithHexString:@"#303030"]];
    _stagePriceLabel.textAlignment = NSTextAlignmentLeft;
    _stagePriceLabel.bottom = _imgView.bottom;
    [bgView addSubview:_stagePriceLabel];
    
    //添加服务费
    self.serviceLogo = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - LeftSpace - 30, y, 30, 11)];
    [self addSubview:_serviceLogo];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, y +h + 6, self.width, 1)];
    line.backgroundColor = rgb(241, 241, 241, 1.0);
    self.line= line;
    [bgView addSubview:line];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(10,self.bounds.size.height-1, self.width, 1)];
    line1.backgroundColor = rgb(241, 241, 241, 1.0);
    self.line= line;
    [bgView addSubview:line1];

    //添加首付
    
    x = LeftSpace;
    y = y + h + 13;
    w = self.width - 2 * LeftSpace;
    
    _firstPayLabel = [self labelWithFrame:CGRectMake(x, y, w, h) fontSize:_titleLabel.font.pointSize textColor:rgb(60, 60, 60, 1.0)];
    _firstPayLabel.textAlignment = NSTextAlignmentLeft;
    [bgView addSubview:_firstPayLabel];
    
    //添加优惠
    y = y + h;
    w = self.width - 2 * LeftSpace;
    
    _fenqiLabel=[self labelWithFrame:CGRectMake(x, y, w, h) fontSize:_titleLabel.font.pointSize textColor:rgb(60, 60, 60, 1.0)];
    _fenqiLabel.textAlignment = NSTextAlignmentLeft;
    [bgView addSubview:_fenqiLabel];
    
    //添加优惠
    y = y + h;
    w = self.width - 2 * LeftSpace;
    
    _couponLabel=[self labelWithFrame:CGRectMake(x, y, w, h) fontSize:_titleLabel.font.pointSize textColor:rgb(60, 60, 60, 1.0)];
    _couponLabel.textAlignment = NSTextAlignmentLeft;
    [bgView addSubview:_couponLabel];
}

//- (void)setOrderListModel:(CommerceOrder *)OrderListModel {
//    if (_OrderListModel != OrderListModel) {
//        _OrderListModel = OrderListModel;
//        [self reloadData];
//    }
//}
//
//- (void)setPaymentModel:(OrderDownPayment *)PaymentModel {
//    if (_PaymentModel != PaymentModel) {
//        _PaymentModel = PaymentModel;
//        [self reloadData];
//    }
//}
//
//- (void)setOrderDetailModel:(CommerceOrderDetail *)OrderDetailModel {
//    if (_OrderDetailModel != OrderDetailModel) {
//        _OrderDetailModel = OrderDetailModel;
//        [self reloadData];
//    }
//}


-(void)setModel:(BaseData *)model
{
    if (_model != model) {
        _model = model;
        CommerceOrder *nModel = [self commerceOrderWithBaseData:model];
        
        NSString *imageUrl = [NSString stringWithFormat:@"%@",nModel.imageUrl];
        [_imgView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"useimg.png"]];
        _titleLabel.text = nModel.descript;//标题
        _subTitle.text = nModel.subDescripe;//副标题
        _stagePriceLabel.text =  nModel.priceWhenBuying;//商品价格
        
        //设置首付显示
        NSString *firstPay = [NSString stringWithFormat:@"首付: ￥%@",nModel.firstPayment];
        NSMutableAttributedString *aFirstPay = [[NSMutableAttributedString alloc] initWithString:firstPay];
        [aFirstPay addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#d91e3d"] range:NSMakeRange(3, [firstPay length] - 3)];
        
        _firstPayLabel.attributedText = aFirstPay;//首付
        
        //设置分期显示
        NSString *fenqiPay = [NSString stringWithFormat:@"分期: ￥%@ ×%ld %@",nModel.stagePayment,(long)nModel.stageNum,nModel.priceOfService];
        NSMutableAttributedString *fenqiatt = [[NSMutableAttributedString alloc] initWithString:fenqiPay];
        [fenqiatt addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#d91e3d"] range:[fenqiPay rangeOfString:[NSString stringWithFormat:@"￥%@",nModel.stagePayment]]];
        [fenqiatt addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#818181"] range:[fenqiPay rangeOfString:[NSString stringWithFormat:@"×"]]];
        [fenqiatt addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#818181"] range:[fenqiPay rangeOfString:[NSString stringWithFormat:@"%ld",(long)nModel.stageNum]]];
        [fenqiatt addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#818181"] range:[fenqiPay rangeOfString:[NSString stringWithFormat:@"%@",nModel.priceOfService]]];
       [fenqiatt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:[fenqiPay rangeOfString:[NSString stringWithFormat:@"%@",nModel.priceOfService]]];
        _fenqiLabel.attributedText = fenqiatt;
        
        //设置优惠显示
        NSString *coupon = [NSString stringWithFormat:@"优惠: %@ %@",nModel.couponStr,nModel.couponStr2];
        NSMutableAttributedString *aCoupon = [[NSMutableAttributedString alloc] initWithString:coupon];
        [aCoupon addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#d91e3d"] range:NSMakeRange(3, [coupon length] - 3)];
        [aCoupon addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(3, [coupon length] - 3)];
        [aCoupon addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#818181"] range:[coupon rangeOfString:[NSString stringWithFormat:@"%@",nModel.couponStr2]]];
        _couponLabel.attributedText = aCoupon;
        

    }
}


-(CommerceOrder *)commerceOrderWithBaseData:(BaseData*)baseData
{
    CommerceOrder *nOrder = [[CommerceOrder alloc] init];
    if ([baseData isKindOfClass:[CommerceOrder class]]) {
        nOrder = (CommerceOrder *)baseData;
    }else if([baseData isKindOfClass:[OrderDownPayment class]]){
        OrderDownPayment *temp = (OrderDownPayment *)baseData;
        nOrder.imageUrl = temp.imageUrl;
        nOrder.descript = temp.descripe;
        nOrder.subDescripe = temp.subDescripe;
        nOrder.stagePayment = temp.stagesMoney;
        nOrder.stageNum = temp.stagesNum;
        nOrder.firstPayment = temp.downPaymentMoney;
        //        nOrder.
    }else if([baseData isKindOfClass:[CommerceOrderDetail class]]){
        CommerceOrderDetail *temp = (CommerceOrderDetail *)baseData;
        nOrder.imageUrl = temp.imageUrl;
        nOrder.descript = temp.descript;
//        nOrder.subTitle = temp.subDescripe;
        nOrder.priceOfService = temp.priceOfService;
        nOrder.stagePayment = temp.stagesMoney;
        nOrder.stageNum = temp.stagesNum;
        nOrder.firstPayment = temp.downPaymentMoney;
        nOrder.couponStr = temp.couponStr;
        nOrder.couponStr2 = temp.couponStr2;
        nOrder.priceWhenBuying = temp.priceWhenBuying;
    }
    
    return nOrder;
    
}


-(UILabel *)labelWithFrame:(CGRect)frame fontSize:(NSInteger)fontSize textColor:(UIColor *)textColor
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    //    label.backgroundColor = [YXBTool generateRandomColor];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.minimumScaleFactor = 10.0/label.font.pointSize;
    label.adjustsFontSizeToFitWidth = YES;
    label.textColor = textColor;
    
    return label;
}

@end
