//
//  PayForanotherTableViewCell.m
//  YOUXINBAO
//
//  Created by zjp on 15/9/11.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "PayForanotherTableViewCell.h"
#import "YXBTool.h"
@implementation PayForanotherTableViewCell {
    UIImageView     *_img;
    UILabel         *_name;
    UILabel         *_money;
     UILabel         *_detail;
     UILabel         *_faqitime;
    UILabel         *_fukuantime;
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = rgb(242, 239, 248, 1);
        UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kDeviceWidth-20, 350)];
        bgview.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bgview];
        
        _img = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 90, 30)];
        _img.image = [UIImage imageNamed:@"fuked-icon"];
        _img.contentMode = UIViewContentModeScaleAspectFit;
        [bgview addSubview:_img];
        
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(15, 62, kDeviceWidth-30, 0.5)];
         view.backgroundColor = [YXBTool colorWithHexString:@"#d6d6d6"];
        [self.contentView addSubview:view];
        
        UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(15, 175, kDeviceWidth-30, 0.5)];
         view2.backgroundColor = [YXBTool colorWithHexString:@"#d6d6d6"];
        [self.contentView addSubview:view2];
        
        UILabel *money = [[UILabel alloc] initWithFrame:CGRectMake(15, 82, 150, 16)];
        money.textAlignment = NSTextAlignmentLeft;
        money.font = [UIFont systemFontOfSize:16];
        money.textColor = rgb(129, 129, 129, 1);
        money.text = @"代付金额:";
        [bgview addSubview:money];
        _money = [[UILabel alloc] initWithFrame:CGRectMake(15, 100, kDeviceWidth-30, 59)];
        _money.textAlignment = NSTextAlignmentRight;
        _money.textColor = [UIColor blackColor];
        _money.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:59];
        _money.text = @"==";
        [_money setAdjustsFontSizeToFitWidth:YES];
        [bgview addSubview:_money];

        UIImageView *next = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth-30, 195, 9, 18)];
        next.image = [UIImage imageNamed:@"next"];
        [bgview addSubview:next];
        
        _name = [[UILabel alloc] initWithFrame:CGRectMake(15, 195, kDeviceWidth-30, 16)];
        _name.textAlignment = NSTextAlignmentLeft;
        _name.font = [UIFont systemFontOfSize:16];
        _name.textColor = [UIColor blackColor];
        _name.text = @"===";
        _name.userInteractionEnabled = YES;
        [bgview addSubview:_name];
        
        //添加头像点击事件，下面区域不可点击
        UIControl *control = [[UIControl alloc] initWithFrame:_name.bounds];
        [control addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [_name addSubview:control];

        
        
        UILabel *_detailss = [[UILabel alloc] initWithFrame:CGRectMake(15, 230, 80, 16)];
        _detailss.textAlignment = NSTextAlignmentLeft;
        _detailss.numberOfLines = 1;
        _detailss.font = [UIFont systemFontOfSize:16];
        _detailss.textColor = rgb(129, 129, 129, 1);
        _detailss.text = @"代付说明:";
        [bgview addSubview:_detailss];
        _detail = [[UILabel alloc] initWithFrame:CGRectMake(90, 229, kDeviceWidth-120, 40)];
        _detail.textAlignment = NSTextAlignmentLeft;
        _detail.userInteractionEnabled = NO;
        _detail.numberOfLines = 0;
        _detail.font = [UIFont systemFontOfSize:16];
        _detail.textColor = [UIColor blackColor];
        [bgview addSubview:_detail];
        
        _faqitime = [[UILabel alloc] initWithFrame:CGRectMake(15, 280, kDeviceWidth-30, 16)];
        _faqitime.textAlignment = NSTextAlignmentLeft;
        _faqitime.font = [UIFont systemFontOfSize:16];
        _faqitime.textColor = [UIColor blackColor];
        _faqitime.text = @"----";
        [bgview addSubview:_faqitime];
        
        _fukuantime = [[UILabel alloc] initWithFrame:CGRectMake(15, 315, kDeviceWidth-30, 16)];
        _fukuantime.textAlignment = NSTextAlignmentLeft;
        _fukuantime.font = [UIFont systemFontOfSize:16];
        _fukuantime.textColor = [UIColor blackColor];
        _fukuantime.text = @"----";
        [bgview addSubview:_fukuantime];
        

    }
    return self;
}


- (void)setModel:(HelpPayment *)model {
    _model = model;
    [self createData];
}

- (void)createData {
    if (_model.helpPaymentStatus == 100) {
        _img.image = [UIImage imageNamed:@"fukwait-icon"];
    }else if (_model.helpPaymentStatus == 200){
        _img.image = [UIImage imageNamed:@"fuked-icon"];
    }else if (_model.helpPaymentStatus == 300 || _model.helpPaymentStatus == 400
              ||_model.helpPaymentStatus == 500){
        _img.image = [UIImage imageNamed:@"fukclosed-icon"];
    }

    NSString *interviewTime = [NSString stringWithFormat:@"￥%@",self.model.helpPayMoney];
    NSMutableAttributedString *strLabel4 = [[NSMutableAttributedString alloc] initWithString:interviewTime];
    [strLabel4 addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:30] range:[interviewTime rangeOfString:@"￥"]];
    _money.attributedText = strLabel4;
    
    

    NSString *names = [NSString stringWithFormat:@"申  请 人:  %@",_model.helpPayUser];
    NSMutableAttributedString *strLabel5 = [[NSMutableAttributedString alloc] initWithString:names];
    [strLabel5 addAttribute:NSForegroundColorAttributeName value:rgb(129, 129, 129, 1) range:[names rangeOfString:@"申  请 人:"]];
    _name.attributedText = strLabel5;
    
//    NSString *details = [NSString stringWithFormat:@"代付说明: %@",_model.helpPayDeclare];
//    NSMutableAttributedString *strLabel6 = [[NSMutableAttributedString alloc] initWithString:details];
//    [strLabel6 addAttribute:NSForegroundColorAttributeName value:rgb(129, 129, 129, 1) range:[details rangeOfString:@"代付说明:"]];
    _detail.size = [YXBTool getFontSizeWithString:_model.helpPayDeclare font:[UIFont systemFontOfSize:16] constrainSize:CGSizeMake(kDeviceWidth-120, CGFLOAT_MAX)];
    _detail.text = _model.helpPayDeclare;
    
    _faqitime.top = _detail.bottom+15;
    NSString *faqitimes = [NSString stringWithFormat:@"发起时间:  %@",_model.createTime];
    NSMutableAttributedString *strLabel7 = [[NSMutableAttributedString alloc] initWithString:faqitimes];
    [strLabel7 addAttribute:NSForegroundColorAttributeName value:rgb(129, 129, 129, 1) range:[faqitimes rangeOfString:@"发起时间:"]];
    _faqitime.attributedText = strLabel7;
    
    _fukuantime.top = _faqitime.bottom+15;
    
    NSString *title = [self titleLabelWithState:_model.helpPaymentStatus];
    if (![title isEqualToString:@""]) {
        NSString *fukuantimes = [NSString stringWithFormat:@"%@  %@",title,_model.payTime];
        NSMutableAttributedString *strLabel8 = [[NSMutableAttributedString alloc] initWithString:fukuantimes];
        [strLabel8 addAttribute:NSForegroundColorAttributeName value:rgb(129, 129, 129, 1) range:[fukuantimes rangeOfString:title]];
        _fukuantime.attributedText = strLabel8;
        _fukuantime.hidden = NO;
    }
    else
    {
        _fukuantime.hidden = YES;
    }
    
}

-(NSString *)titleLabelWithState:(NSInteger)state
{
    NSString *title = @"";
    if (state == 200) {
        title = @"付款时间:";
    }else if (state == 300 || state == 500)
    {
        title = @"关闭时间:";
    }else if (state == 400)
    {
        title = @"拒绝时间:";
    }
    
    return title;
    
}


-(void)buttonAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(toMyFriend)]) {
        [_delegate toMyFriend];
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
