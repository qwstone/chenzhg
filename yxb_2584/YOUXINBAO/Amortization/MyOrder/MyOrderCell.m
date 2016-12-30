//
//  MyOrderCell.m
//  YOUXINBAO
//
//  Created by Walice on 15/9/15.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "MyOrderCell.h"
#import "UIImageView+WebCache.h"

@implementation MyOrderCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)initViews{

    _numberLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    [self addSubview:_numberLabel];
    _imgView=[[UIImageView alloc]initWithFrame:CGRectZero];
    [self addSubview:_imgView];
    _titleLable=[[UILabel alloc]initWithFrame:CGRectZero];
    [self addSubview:_titleLable];
    _priceLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    [self addSubview:_priceLabel];
    _status=[[UIImageView alloc]initWithFrame:CGRectZero];
    [self addSubview:_status];
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 3*15, kDeviceWidth, 1)];
    line.backgroundColor=rgb(220, 220, 220, 1);
    [self addSubview:line];
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 150, kDeviceWidth, 10)];
    view.backgroundColor=rgb(244, 244, 244, 1);
    [self addSubview:view];
    [self setNeedsLayout];

}
- (void)layoutSubviews{

    [super layoutSubviews];
    CGFloat left=15;
    _numberLabel.frame=CGRectMake(left, left, kDeviceWidth, left);
    _numberLabel.text=[NSString stringWithFormat:@"订单编号 : %@",self.model.displayOrderID];
    _numberLabel.textColor=rgb(145, 145, 145, 1);
    _numberLabel.font=[UIFont systemFontOfSize:14];
    _imgView.frame=CGRectMake(left, left*4, 80, 80);
    [_imgView sd_setImageWithURL:[NSURL URLWithString:self.model.imageUrl]];
    _titleLable.frame=CGRectMake(_imgView.right+17, 3*left, kDeviceWidth-120, 4*left);
    _titleLable.font=[UIFont systemFontOfSize:14];
    _titleLable.textColor=rgb(28, 28, 28, 1);
    _titleLable.text=self.model.descript;
    _titleLable.numberOfLines=0;
    _priceLabel.frame=CGRectMake(_imgView.right+17, _titleLable.bottom+15, kDeviceWidth, 2*left);
    _priceLabel.font=[UIFont systemFontOfSize:20];
    _priceLabel.textColor=rgb(217, 30, 61, 1);
    _priceLabel.text=self.model.priceWhenBuying;
    _status.frame=CGRectMake(kDeviceWidth-120, _titleLable.bottom-5,100, 50);
    
    if (self.model.orderState==ORDERSTATE_CLOSED) {
        _status.image=[UIImage imageNamed:@"order-closed-stamp.png"];
       
    }
    else if (self.model.orderState==ORDERSTATE_COMPLETE){
        _status.image=[UIImage imageNamed:@"order-completed-stamp.png"];
        
    }
    else if (self.model.orderState==ORDERSTATE_WAIT_FOR_REPAYMENT2){
        
        _status.image=[UIImage imageNamed:@"order-ddak-stamp.png"];
        
    }
    else if (self.model.orderState==ORDERSTATE_GUARANTEE ){
        _status.image=[UIImage imageNamed:@"order-ddanb-stamp.png"];
       
        
    }
    else if (self.model.orderState==ORDERSTATE_DELIVER_GOODS){
        
        _status.image=[UIImage imageNamed:@"order-dfah-stamp.png"];
      
    }
    else if (self.model.orderState==ORDERSTATE_SUBSCRIBE_FAILUREEE){
        
        _status.image=[UIImage imageNamed:@"order-dfuk-stamp.png"];
       
    }
    else if (self.model.orderState==ORDERSTATE_WAIT_FOR_REPAYMENT){
        _status.image=[UIImage imageNamed:@"order-dhuank-stamp.png"];
      
        
    }
    else if (self.model.orderState==ORDERSTATE_RECEIVE_GOODS){
        
        _status.image=[UIImage imageNamed:@"order-dshou-stamp.png"];
       
    }
    else if (self.model.orderState==ORDERSTATE_WAIT_FOR_PAY){
        _status.image=[UIImage imageNamed:@""];
    
    }
    
    else if (self.model.orderState==ORDERSTATE_CHECK_PENDINGGG){
        _status.image=[UIImage imageNamed:@"order-dshen-stamp.png"];
        
        
    }

}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
