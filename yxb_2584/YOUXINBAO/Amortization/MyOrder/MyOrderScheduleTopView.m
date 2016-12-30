//
//  MyOrderScheduleTopView.m
//  YOUXINBAO
//
//  Created by Feili on 15/5/26.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "MyOrderScheduleTopView.h"
#import "OrderDownPayment.h"
#import "GoodsResume.h"
#import "CommerceOrderDetail.h"

@interface MyOrderScheduleTopView ()
@property (nonatomic, strong) UILabel* titleLabel; //主标题
@property (nonatomic, strong) UILabel *subTitle;//副标题
@property (nonatomic, strong) UILabel* stagePriceLabel;
@property (nonatomic, strong) UILabel* allMonthLabel;
@property (nonatomic, strong) UIImageView* imgView;
@property (nonatomic, strong) UILabel* paymentLabel;
@property (nonatomic, strong) UILabel *firstPayLabel;//首付
@property (nonatomic, strong) UILabel *couponLabel;//优惠label

@property(nonatomic,retain)   UILabel *statusLabel;
@property(nonatomic,strong) UIView *line;
//是否显示0服务费
@property(nonatomic,strong) NSString *isNoServiceCharge;
/**
 * 是否 无服务费 “1” 无服务费 “0” 需要服务费
 */
@property(nonatomic,strong) UIImageView *serviceLogo;//是否需要服务费

@property(nonatomic,strong)UIView *schedulePanel;//进度板
@property(nonatomic,strong)UIView *scheduleBgView;//进度板背景
@property(nonatomic,strong)UIButton *devideC;//分期合同


@end

@implementation MyOrderScheduleTopView

-(void)initViews
{
    //添加头像
#define LeftSpace 15
#define TopSpace 20
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 130+66)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    CGFloat x = LeftSpace, y = TopSpace, w = 100, h = 100;
    
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w,h)];
//    _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [bgView addSubview:_imgView];
    
    //添加标题
    x = _imgView.width + 2 * x;
    w = self.width - LeftSpace - x;
    h = 40;
    self.titleLabel = [self labelWithFrame:CGRectMake(x, y, w, h) fontSize:15 textColor:[YXBTool colorWithHexString:@"#303030"]];
//    _titleLabel.backgroundColor = [UIColor blueColor];
    _titleLabel.adjustsFontSizeToFitWidth = NO;
    _titleLabel.numberOfLines = 2;
    _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [bgView addSubview:_titleLabel];
    
    //添加副标题
    y = y + h,
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
    self.stagePriceLabel = [self labelWithFrame:CGRectMake(x, y, w, h) fontSize:_subTitle.font.pointSize textColor:[YXBTool colorWithHexString:@"#6e6e6e"]];
    _stagePriceLabel.textAlignment = NSTextAlignmentLeft;
    
    [bgView addSubview:_stagePriceLabel];
    
    //添加服务费
    self.serviceLogo = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - LeftSpace - 30, y, 30, 11)];
    [self addSubview:_serviceLogo];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, y +h + 6, self.width, 1)];
    line.backgroundColor = rgb(241, 241, 241, 1.0);
    self.line= line;
    [bgView addSubview:line];
//
//    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, y +h + 2, self.width, 1)];
//    line.backgroundColor = [UIColor lightGrayColor];
//    [self addSubview:line];
//    _allMonthLabel=[[UILabel alloc]initWithFrame:CGRectZero];
//    [self addSubview:_allMonthLabel];
    
//    _paymentLabel=[[UILabel alloc]initWithFrame:CGRectZero];
//    [self addSubview:_paymentLabel];
//    
//    _imgView=[[UIImageView alloc]initWithFrame:CGRectZero];
//    [self addSubview:_imgView];
//    
//    _statusLabel=[[UILabel alloc]initWithFrame:CGRectZero];
//    [self addSubview:_statusLabel];
//
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

    _couponLabel=[self labelWithFrame:CGRectMake(x, y, w, h) fontSize:_titleLabel.font.pointSize textColor:rgb(60, 60, 60, 1.0)];
    _firstPayLabel.textAlignment = NSTextAlignmentLeft;
    [bgView addSubview:_couponLabel];
    
    y = y + h + 20;
    h = 50;
    
    UIButton *devideC = [UIButton buttonWithType:UIButtonTypeCustom];
    devideC.backgroundColor = [UIColor whiteColor];
    devideC.frame = CGRectMake(0, y, kDeviceWidth, h);
    devideC.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [devideC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [devideC addTarget:self action:@selector(contactInfo) forControlEvents:UIControlEventTouchUpInside];
    devideC.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.devideC = devideC;
    [devideC setTitle:@"  分期合同" forState:UIControlStateNormal];
    [self addSubview:devideC];
    
    UIImageView *nextView = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/2, 0, kDeviceWidth/2-20, h)];
    nextView.contentMode = UIViewContentModeRight;
    nextView.image = [UIImage imageNamed:@"xinfenq-next.png"];
    [devideC addSubview:nextView];
    
    
    x = 0;
    y = y + h + 15;
    h = 90;
    w = self.width - 2 * x;
    [self addNewSchedulePanelWithFrame:CGRectMake(x, y, w, h)];
   
    [self isShowItemsBelowLine:NO];
}

-(void)contactInfo
{
 
    if (_delegate && [_delegate respondsToSelector:@selector(contactInfo)]) {
        [_delegate contactInfo];
    }
}

/*
//订单进度
-(void)setModel:(CommerceOrderDetail *)model
{
    if (_model != model) {
        _model = model;
        _imgView.frame=CGRectMake(10, 5, 60, 70);
        [_imgView setImageWithURL:[NSURL URLWithString:self.model.imageUrl]];
        
        _titleLabel.frame=CGRectMake(80, 5, kDeviceWidth-80, 50);
        _titleLabel.font=[UIFont systemFontOfSize:15];
        _titleLabel.text=self.model.descript;
        
        
        _stagePriceLabel.frame=CGRectMake(80, 50,70, 25);
        _stagePriceLabel.textColor=[UIColor redColor];
        _stagePriceLabel.text=[NSString stringWithFormat:@"￥%@",self.model.stagesMoney];
        
        
        _allMonthLabel.frame=CGRectMake(150, 52, 40, 20);
        _allMonthLabel.font=[UIFont systemFontOfSize:13];
        _allMonthLabel.text=[NSString stringWithFormat:@" x %ld",self.model.stagesNum];
        
        
        _paymentLabel.frame=CGRectMake(55, 85, 70, 25);
        _paymentLabel.textColor=[UIColor redColor];
        _paymentLabel.text=[NSString stringWithFormat:@"￥%@",self.model.downPaymentMoney];
        //状态label
        _statusLabel.frame=CGRectMake(kDeviceWidth-60, 90, 80, 25);
        
        
//        _schedulePanel.top = _paymentLabel.bottom;
        //首付
//        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 85, 50, 25)];
//        label.text=@"首付 :";
////        [self addSubview:label];
//        //元
//        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(123, 85, 20, 25)];
//        label1.text=@"元";
//        [self addSubview:label1];
        
        self.schedulePanel.layer.contents = (id)[UIImage imageNamed:[self imageNameWithState:_model.orderState]].CGImage;

        

    }
}

*/

/*

//订单列表
-(void)setOrder:(CommerceOrder *)order
{
    if (_order != order) {
        _order = order;
        [_imgView setImageWithURL:[NSURL URLWithString:_order.imageUrl] placeholderImage:[UIImage imageNamed:@"user-icon.png"]];
        _titleLabel.text = _order.descript;
        _subTitle.text = _order.subTitle;
        //获取 钱数 X 期数
        NSString *money = [NSString stringWithFormat:@"￥%@ X%ld期",_order.stagePayment,_order.stageNum];
        
        NSMutableAttributedString *aMoney = [[NSMutableAttributedString alloc] initWithString:money];
        [aMoney addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20.0] range:[money rangeOfString:_order.stagePayment]];
        [aMoney addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#d91e3d"] range:[money rangeOfString:_order.stagePayment]];
        [aMoney addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#d91e3d"] range:[money rangeOfString:@"￥"]];

        _stagePriceLabel.attributedText =  aMoney;
        
        //设置首付显示
        NSString *firstPay = [NSString stringWithFormat:@"首付: ￥%@",_order.firstPayment];
        NSMutableAttributedString *aFirstPay = [[NSMutableAttributedString alloc] initWithString:firstPay];
        [aFirstPay addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#d91e3d"] range:NSMakeRange(3, [firstPay length] - 3)];

        _firstPayLabel.attributedText = aFirstPay;
        
        //设置优惠显示
        NSString *coupon = [NSString stringWithFormat:@"优惠: %@",@"暂无"];
        NSMutableAttributedString *aCoupon = [[NSMutableAttributedString alloc] initWithString:coupon];
        [aCoupon addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#d91e3d"] range:NSMakeRange(3, [coupon length] - 3)];
        _couponLabel.attributedText = aCoupon;

//        _allMonthLabel.text=[NSString stringWithFormat:@" x %ld",self.order.stageNum];
//        
//        _paymentLabel.text=[NSString stringWithFormat:@"￥%@",self.order.firstPayment];
        
        //状态label
//        _statusLabel.frame=CGRectMake(kDeviceWidth-60, 90, 80, 25);
        
        
        //        _schedulePanel.top = _paymentLabel.bottom;
        
        self.schedulePanel.hidden = YES;
//        self.schedulePanel.layer.contents = (id)[UIImage imageNamed:[self imageNameWithState:_model.orderState]].CGImage;
        
        
        
    }
}

*/


/*

- (void)drawRect:(CGRect)rect {
    
    //首先,拿到图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, rgb(225, 225, 225, 1).CGColor);
    CGFloat lengths[]={5,10,5};
    CGContextSetLineDash(context, 10, lengths, 3);
    CGContextMoveToPoint(context, 10.0, 80.0);
    CGContextAddLineToPoint(context, kDeviceWidth, 80.0);
    CGContextStrokePath(context);
    CGContextClosePath(context);
    
    CGContextRef context1 = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context1);
    CGContextSetLineWidth(context1, 2.0);
    CGContextSetStrokeColorWithColor(context1, rgb(225, 225, 225, 1).CGColor);
    CGFloat lengths1[]={5,10,5};
    CGContextSetLineDash(context1, 10, lengths1, 3);
    CGContextMoveToPoint(context1, 10.0, 115.0);
    CGContextAddLineToPoint(context1, kDeviceWidth, 115.0);
    CGContextStrokePath(context1);
    CGContextClosePath(context1);
    
    
}

*/
-(void)addNewSchedulePanelWithFrame:(CGRect)frame
{
    
    UIView *scheduleBgView = [[UIView alloc] initWithFrame:frame];
    scheduleBgView.backgroundColor = [UIColor whiteColor];
//    scheduleBgView.layer.borderColor = rgb(213, 213, 213, 1.0).CGColor;
//    scheduleBgView.layer.borderWidth = 1.0;
    self.scheduleBgView = scheduleBgView;
    
    [self addSubview:scheduleBgView];
    self.schedulePanel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scheduleBgView.width, scheduleBgView.height)];
    _schedulePanel.contentMode = UIViewContentModeCenter;
    _schedulePanel.layer.contentsScale = [[UIScreen mainScreen] scale];
    //    _schedulePanel.layer.contents = (id)[UIImage imageNamed:@""]
    [scheduleBgView addSubview:_schedulePanel];
}

-(NSString *)imageNameWithState:(MyOrderScheduleType)schedule
{
    NSString *imageName = @"";
    /*
    switch (schedule) {
        case MyOrderScheduleTypeQueren:
        {
            imageName = @"borrowsteps01.png";
        }
            break;
        case MyOrderScheduleTypeMianqian:
        {
            imageName = @"borrowsteps02.png";
        }
            break;
        case MyOrderScheduleTypeDaozhang:
        {
            imageName = @"borrowsteps03.png";
        }
            break;
        case MyOrderScheduleTypeHuankuaning:
        {
            imageName = @"borrowsteps04.png";
        }
            break;
        case MyOrderScheduleTypeWancheng:
        {
            imageName = @"borrowsteps05.png";
        }
            break;
            
            
        default:
        {
            imageName = @"borrowsteps01.png";

        }
            break;
    }
    
    */
    
    if (schedule >= 0 && schedule <= 100) {
        imageName = @"borrowsteps01.png";

    }else if (schedule >= 100 && schedule <= MyOrderScheduleTypeQueren){
    
        imageName = @"borrowsteps02.png";
    }else if (schedule >= MyOrderScheduleTypeQueren && schedule <= MyOrderScheduleTypeMianqian){
        
        imageName = @"borrowsteps03.png";
    }else if (schedule >= MyOrderScheduleTypeMianqian && schedule <= MyOrderScheduleTypeDaozhang){
        
        imageName = @"borrowsteps04.png";
    }else if (schedule >= MyOrderScheduleTypeDaozhang && schedule <= MyOrderScheduleTypeHuankuaning){
        
        imageName = @"borrowsteps05.png";
    }else
    {
        imageName = @"borrowsteps01.png";

    }
    
    return imageName;
}

-(void)showSchedulePabel
{
    _schedulePanel.hidden = NO;
}

-(void)isShowItemsBelowLine:(BOOL)isShow
{
    if (isShow) {
        _firstPayLabel.hidden = NO;
        _couponLabel.hidden = NO;
        _line.hidden = NO;
        _scheduleBgView.hidden = NO;
        _devideC.hidden = NO;
    }
    else
    {
        _firstPayLabel.hidden = YES;
        _couponLabel.hidden = YES;
        _line.hidden = YES;
        _scheduleBgView.hidden = YES;
        _devideC.hidden = YES;
    }
}

-(void)setModel:(BaseData *)model
{
    if (_model != model) {
        _model = model;
        CommerceOrder *nModel = [self commerceOrderWithBaseData:model];
        
        NSString *imageUrl = [NSString stringWithFormat:@"%@",nModel.imageUrl];
        [_imgView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"useimg.png"]];
        _titleLabel.text = nModel.descript;
        _subTitle.text = nModel.subDescripe;
        //获取 钱数 X 期数
        NSString *money = [NSString stringWithFormat:@"￥%@ X%ld期",nModel.stagePayment,(long)nModel.stageNum];
        
        NSMutableAttributedString *aMoney = [[NSMutableAttributedString alloc] initWithString:money];
        [aMoney addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16.0] range:[money rangeOfString:nModel.stagePayment]];
        [aMoney addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#d91e3d"] range:[money rangeOfString:nModel.stagePayment]];
        [aMoney addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#d91e3d"] range:[money rangeOfString:@"￥"]];
        [aMoney addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16.0] range:[money rangeOfString:@"￥"]];

        
        _stagePriceLabel.attributedText =  aMoney;
        
        //设置首付显示
        NSString *firstPay = [NSString stringWithFormat:@"首付: ￥%@",nModel.firstPayment];
        NSMutableAttributedString *aFirstPay = [[NSMutableAttributedString alloc] initWithString:firstPay];
        [aFirstPay addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#d91e3d"] range:NSMakeRange(3, [firstPay length] - 3)];
        
        _firstPayLabel.attributedText = aFirstPay;
        
        //设置优惠显示
        NSString *coupon = [NSString stringWithFormat:@"优惠: %@",@"暂无"];
        NSMutableAttributedString *aCoupon = [[NSMutableAttributedString alloc] initWithString:coupon];
        [aCoupon addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#d91e3d"] range:NSMakeRange(3, [coupon length] - 3)];
        _couponLabel.attributedText = aCoupon;

        if ([model isKindOfClass:[CommerceOrderDetail class]]) {
            self.schedulePanel.layer.contents = (id)[UIImage imageNamed:[self imageNameWithState:(((CommerceOrderDetail *)_model).orderState)]].CGImage;

        }
        else
        {
            self.schedulePanel.layer.contents = nil;

        }

        
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
    }else if([baseData isKindOfClass:[GoodsResume class]]){
        GoodsResume *temp = (GoodsResume *)baseData;
        nOrder.imageUrl = temp.imageUrl;
        nOrder.descript = temp.descripe;
        nOrder.subDescripe = temp.subDescripe;
        nOrder.stagePayment = temp.money;
        nOrder.stageNum = temp.stage;
//        nOrder.firstPayment = temp.downPaymentMoney;
        //        nOrder.
        _isNoServiceCharge = temp.isNoServiceCharge;
    }else if([baseData isKindOfClass:[CommerceOrderDetail class]]){
        CommerceOrderDetail *temp = (CommerceOrderDetail *)baseData;
        nOrder.imageUrl = temp.imageUrl;
        nOrder.descript = temp.descript;
//        nOrder.subTitle = temp.subDescripe;
        nOrder.stagePayment = temp.stagesMoney;
        nOrder.stageNum = temp.stagesNum;
        nOrder.firstPayment = temp.downPaymentMoney;
        nOrder.couponStr = @"";
    }
    
    return nOrder;
    
}
@end
