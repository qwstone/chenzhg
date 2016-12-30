//
//  MyOrderLisetCell.m
//  YOUXINBAO
//
//  Created by 冰冰 on 15/5/23.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "MyOrderLisetCell.h"
#import "UIImageView+WebCache.h"
#import "MyOrderScheduleTopView.h"
#import "MyOrderNewScheduleTopView.h"
#import "YXBTool.h"

@implementation MyOrderLisetCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initViews];
    }
    return self;
}

- (void)_initViews{

    _label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 40)];
    _label.backgroundColor=[YXBTool colorWithHexString:@"#f4f4f4"];
    _label.font = [UIFont systemFontOfSize:16];
    _label.textColor = [YXBTool colorWithHexString:@"#303030"];
    [self addSubview:_label];


    _topView=[[MyOrderNewScheduleTopView alloc]initWithFrame:CGRectMake(0, 40, kDeviceWidth, 220)];

    [self addSubview:_topView];

    
    //针对状态的描述
    _remarkLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    [self addSubview:_remarkLabel];

     
    //状态的(待审核)
    _statusLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    [self addSubview:_statusLabel];
    
    _button1=[[UIButton alloc]initWithFrame:CGRectZero];
    _button1.tag=1001;
    [_button1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_button1];
    
    _button2=[[UIButton alloc]initWithFrame:CGRectZero];
    _button2.tag=1002;
    [_button2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_button2];
    
    _button3=[[UIButton alloc]initWithFrame:CGRectZero];
    _button3.tag=1003;
    [_button3 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_button3];

    
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    _topView.model = _model;
    
//    _label.text=[NSString stringWithFormat:@"  订单编号: %@",_model.displayOrderID];
    //设置优惠显示
    NSString *coupon = [NSString stringWithFormat:@"  订单编号: %@",_model.displayOrderID];
    NSMutableAttributedString *aCoupon = [[NSMutableAttributedString alloc] initWithString:coupon];
    [aCoupon addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#4e4e4e"] range:[coupon rangeOfString:[NSString stringWithFormat:@"%@",_model.displayOrderID]]];
    [aCoupon addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:[coupon rangeOfString:[NSString stringWithFormat:@"%@",_model.displayOrderID]]];
    _label.attributedText = aCoupon;
    /*
    //上框线
    CALayer *border = [CALayer layer];
    float width = kDeviceWidth;
    border.frame = CGRectMake(0.0f, -1, width, 1.0f);
    border.backgroundColor = [YXBTool colorWithHexString:@"#dcdcdc"].CGColor;
    [self.layer addSublayer:border];
     */
    //下框线
    /*
    CALayer *border1 = [CALayer layer];
    float width1 = kDeviceWidth;
    border1.frame = CGRectMake(0.0f, 281, width1, 1.0f);
    border1.backgroundColor = [YXBTool colorWithHexString:@"#dcdcdc"].CGColor;
    [self.layer addSublayer:border1];
     */

    
    _button1.frame=CGRectMake(kDeviceWidth-255,_topView.bottom+10, 80, 25);
    _button2.frame=CGRectMake(kDeviceWidth-170,_topView.bottom+10, 80, 25);
    _button3.frame=CGRectMake(kDeviceWidth-85, _topView.bottom+10, 80, 25);
    //状态
    _statusLabel.frame=CGRectMake(kDeviceWidth-120, _topView.bottom+10, 110, 25);
    _statusLabel.font=[UIFont systemFontOfSize:15.0];
    _statusLabel.textAlignment=NSTextAlignmentRight;
    _statusLabel.textColor=rgb(62, 163, 255, 1);
    //状态的详细描述
    _remarkLabel.frame=CGRectMake(10, _statusLabel.bottom, kDeviceWidth, 25);
    _remarkLabel.font=[UIFont systemFontOfSize:12.0];
    _remarkLabel.textColor=rgb(255, 0, 0, 1);

    if (self.model.orderState==ORDERSTATE_CHECK_PENDING ||
        self.model.orderState==ORDERSTATE_CANCEL ||
        self.model.orderState==ORDERSTATE_FINISH) {
        _statusLabel.text=self.model.orderStateStr;
        _remarkLabel.text=self.model.remark;
        _button1.hidden=YES;
        _button2.hidden=YES;
        _button3.hidden=YES;
        _statusLabel.hidden = NO;
        _remarkLabel.hidden = NO;
    }
    if (self.model.orderState==ORDERSTATE_CHECK_PASS) {
        _statusLabel.text=self.model.orderStateStr;
         _remarkLabel.text=self.model.remark;
        _button1.hidden=YES;
        _button2.hidden=YES;
        _button3.hidden=YES;
        _statusLabel.hidden = NO;
        _remarkLabel.hidden = NO;
    }
    if (self.model.orderState==ORDERSTATE_CHECK_FAILURE||self.model.orderState==ORDERSTATE_SUBSCRIBE_FAILURE) {
        _statusLabel.text=self.model.orderStateStr;
        _remarkLabel.text=self.model.remark;
        _button1.hidden=YES;
        _button2.hidden=YES;
        _button3.hidden=YES;
        _statusLabel.hidden = NO;
        _remarkLabel.hidden = NO;
    }
    if (self.model.orderState==ORDERSTATE_SUBSCRIBE_PASS||self.model.orderState==ORDERSTATE_NON_PAYMENT) {
        _statusLabel.hidden=YES;
        _remarkLabel.hidden = NO;
        _button1.hidden=YES;
        _button2.hidden=YES;
        _button3.hidden=NO;
        [_button3 setImage:[UIImage imageNamed:@"gopay-but.png"] forState:UIControlStateNormal];
        [_button3 setImage:[UIImage imageNamed:@"gopay-but-on.png"] forState:UIControlStateHighlighted];
    }
    if (self.model.orderState==ORDERSTATE_PAY||self.model.orderState==ORDERSTATE_UNRECEIVED) {
        _statusLabel.text=self.model.orderStateStr;
        _remarkLabel.text=self.model.remark;
        _button1.hidden=YES;
        _button2.hidden=YES;
        _button3.hidden = YES;
        _statusLabel.hidden=NO;
        _remarkLabel.hidden=NO;
    }

    if (self.model.orderState==ORDERSTATE_RECEIVE) {
        _statusLabel.hidden=YES;
        _remarkLabel.hidden = NO;
        _button3.hidden = NO;
        _button1.hidden=YES;
        _button2.hidden = NO;
        [_button2 setImage:[UIImage imageNamed:@"quanehk-but.png"] forState:UIControlStateNormal];
        [_button2 setImage:[UIImage imageNamed:@"quanehk-but-on.png"] forState:UIControlStateHighlighted];
        [_button3 setImage:[UIImage imageNamed:@"gohk-but.png"] forState:UIControlStateNormal];
        [_button3 setImage:[UIImage imageNamed:@"gopay-but-on.png"] forState:UIControlStateHighlighted];
        
    }
    
    if (self.model.orderState==ORDERSTATE_ONTHEDAYOFPAYMENT) {
        _statusLabel.hidden=YES;
        _remarkLabel.hidden = NO;
        _button1.hidden = NO;
        _button2.hidden = NO;
        _button3.hidden = NO;
        [_button1 setImage:[UIImage imageNamed:@"yanqihk-but.png"] forState:UIControlStateNormal];
        [_button1 setImage:[UIImage imageNamed:@"yanqihk-but-on.png"] forState:UIControlStateHighlighted];
        [_button2 setImage:[UIImage imageNamed:@"quanehk-but.png"] forState:UIControlStateNormal];
        [_button2 setImage:[UIImage imageNamed:@"quanehk-but-on.png"] forState:UIControlStateHighlighted];
        [_button3 setImage:[UIImage imageNamed:@"gohk-but.png"] forState:UIControlStateNormal];
        [_button3 setImage:[UIImage imageNamed:@"gohk-but-on.png"] forState:UIControlStateHighlighted];
    }
    if (self.model.orderState==ORDERSTATE_POSTPONE||self.model.orderState==ORDERSTATE_OVERDUE_PAYMENT) {
        _statusLabel.hidden=YES;
        _remarkLabel.hidden = NO;
        _button2.hidden = NO;
        _button3.hidden = NO;
        _button1.hidden=YES;
        [_button2 setImage:[UIImage imageNamed:@"quanehk-but.png"] forState:UIControlStateNormal];
         [_button2 setImage:[UIImage imageNamed:@"quanehk-but-on.png"] forState:UIControlStateHighlighted];
        [_button3 setImage:[UIImage imageNamed:@"gohk-but.png"] forState:UIControlStateNormal];
        [_button3 setImage:[UIImage imageNamed:@"gohk-but-on.png"] forState:UIControlStateHighlighted];
    }
    if (self.model.orderState==ORDERSTATE_EXPRESS_INFO) {
        _statusLabel.hidden=YES;
        _remarkLabel.hidden = NO;
        _button2.hidden = YES;
        _button3.hidden = NO;
        _button1.hidden=YES;
        [_button3 setImage:[UIImage imageNamed:@"seewl-but.png"] forState:UIControlStateNormal];
        [_button3 setImage:[UIImage imageNamed:@"seewl-but-on.png"] forState:UIControlStateHighlighted];
        
    }
    if (self.model.orderState==ORDERSTATE_TO_REPAYMENT) {
        _statusLabel.hidden=YES;
        _remarkLabel.hidden = NO;
        _button2.hidden = YES;
        _button3.hidden = NO;
        _button1.hidden=YES;
        [_button3 setImage:[UIImage imageNamed:@"gohk-but.png"] forState:UIControlStateNormal];
        [_button3 setImage:[UIImage imageNamed:@"gohk-but-on.png"] forState:UIControlStateHighlighted];
        
    }

    

}

- (void)buttonAction:(UIButton *)button{
    if([self.delegate respondsToSelector:@selector(MyOrderLisetPushAction:butTag:)]){
        [self.delegate MyOrderLisetPushAction:self.model butTag:button.tag];
    };
}



@end
