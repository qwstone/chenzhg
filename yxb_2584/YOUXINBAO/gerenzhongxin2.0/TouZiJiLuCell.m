//
//  TouZiJiLuCell.m
//  YOUXINBAO
//
//  Created by 密码是111 on 16/7/26.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "TouZiJiLuCell.h"

@implementation TouZiJiLuCell

//-(void)setFrame:(CGRect)frame
//{
//    frame.origin.x = 0;
//    frame.size.width = kDeviceWidth;
//    [super setFrame:frame];
//    
//}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initViews];
    }
    
    return self;
}
- (void)_initViews{
    
       _TitleLab=[[UILabel alloc]init];
    [self addSubview:_TitleLab];
    ShouYiLab=[[UILabel alloc]init];
    [self addSubview:ShouYiLab];
    JinELab=[[UILabel alloc]init];
    [self addSubview:JinELab];
    BeginLab=[[UILabel alloc]init];
    [self addSubview:BeginLab];
    EndLab=[[UILabel alloc]init];
    [self addSubview:EndLab];
    TimeLab=[[UILabel alloc]init];
    [self addSubview:TimeLab];
    LineView=[[UIView alloc]init];
    [self addSubview:LineView];
    typeImg=[[UIImageView alloc]init];
    [self addSubview:typeImg];
    topView=[[UIView alloc]init];
    [self addSubview:topView];

//    [self setNeedsLayout];
    

}

- (void)layoutSubviews{
     [super layoutSubviews];
   self.backgroundColor=rgb(252, 252, 252, 1);
    
    topView.frame=CGRectMake(0, 0, kDeviceWidth, kDeviceWidth/640*17);
    topView.backgroundColor=kRGB(238, 236, 246);
    
    UIView*Linetop=[[UIView alloc]init];
    Linetop.frame=CGRectMake(0, topView.bottom, kDeviceWidth, 1);
    Linetop.backgroundColor= [YXBTool colorWithHexString:@"#d9d9d9"];
    [self addSubview:Linetop];
    
    _TitleLab.frame=CGRectMake(24*kDeviceWidth/640, topView.bottom, kDeviceWidth-24*kDeviceWidth/640, kDeviceWidth/640*70);
//    _TitleLab.font=[UIFont systemFontOfSize:29*72/96];
    _TitleLab.textColor=[YXBTool colorWithHexString:@"#454545"];
    _TitleLab.text=[NSString stringWithFormat:@"%@",self.model.assetTitle];
//    TitleLab.enabled=NO;
//      _TitleLab.textAlignment = UITextAlignmentLeft;
    
    LineView.frame=CGRectMake(24*kDeviceWidth/640, kDeviceWidth/640*87, kDeviceWidth-24*kDeviceWidth/640*2, 1);
    LineView.backgroundColor= [YXBTool colorWithHexString:@"#d9d9d9"];
   ShouYiLab.text=[NSString stringWithFormat:@"到期收益: %@元",self.model.exceptReturn];
//    [ShouYiLab setAdjustsFontSizeToFitWidth:YES];
    ShouYiLab.frame=CGRectMake(24*kDeviceWidth/640, LineView.bottom, kDeviceWidth-24*kDeviceWidth/640*2, kDeviceWidth/640*116/2);
//    ShouYiLab.font=[UIFont systemFontOfSize:18*72/96];
    ShouYiLab.textColor=[YXBTool colorWithHexString:@"#959595"];
    
    
    JinELab.text=[NSString stringWithFormat:@"投资金额: %@元",self.model.money];
//    [JinELab setAdjustsFontSizeToFitWidth:YES];
    JinELab.frame=CGRectMake(24*kDeviceWidth/640, ShouYiLab.bottom, kDeviceWidth-24*kDeviceWidth/640*2, kDeviceWidth/640*116/2);
    NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:JinELab.text];
    NSRange range1 = [JinELab.text rangeOfString:[NSString stringWithFormat:@"%@",self.model.money]];

    [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#333333"] range:range1];
//    JinELab.font=[UIFont systemFontOfSize:18*72/96];
    JinELab.textColor=[YXBTool colorWithHexString:@"#959595"];
    JinELab.attributedText=mAttStri1;

    UIView*LineView1=[[UIView alloc]init];
    LineView1.frame=CGRectMake(24*kDeviceWidth/640, kDeviceWidth/640*202, kDeviceWidth-24*kDeviceWidth/640*2, 1);
    LineView1.backgroundColor= [YXBTool colorWithHexString:@"#d9d9d9"];
    [self addSubview:LineView1];

    BeginLab.frame=CGRectMake(24*kDeviceWidth/640, LineView1.bottom,(kDeviceWidth- 24*kDeviceWidth/640*2)/2,46*kDeviceWidth/640);
    BeginLab.textColor=[YXBTool colorWithHexString:@"#959595"];
    BeginLab.text=[NSString stringWithFormat:@"起息时间:%@",self.model.startDate];
//    BeginLab.font = [UIFont systemFontOfSize:18*72/96];
    
    EndLab.frame=CGRectMake(BeginLab.right, LineView1.bottom, (kDeviceWidth- 24*kDeviceWidth/640*2)/2, 46*kDeviceWidth/640);
//    EndLab.font=[UIFont systemFontOfSize:18*72/96];
    EndLab.textColor=[YXBTool colorWithHexString:@"#959595"];
    EndLab.text=[NSString stringWithFormat:@"到期时间:%@",self.model.endDate];
    EndLab.textAlignment= NSTextAlignmentRight;
    
    TimeLab.frame=CGRectMake(kDeviceWidth-130,topView.bottom, 100, kDeviceWidth/640*70);
//    TimeLab.font=[UIFont systemFontOfSize:20*72/96];
    TimeLab.textColor=[YXBTool colorWithHexString:@"#5B5B5B"];
    TimeLab.text=[NSString stringWithFormat:@"%@",self.model.buyDate];
    TimeLab.textAlignment=NSTextAlignmentRight;
    if (kDeviceHeight <= 568) {
        _TitleLab.font=[UIFont systemFontOfSize:24*72/96];
        ShouYiLab.font=[UIFont systemFontOfSize:19*72/96];
        JinELab.font=[UIFont systemFontOfSize:19*72/96];
        BeginLab.font = [UIFont systemFontOfSize:19*72/96];
        EndLab.font=[UIFont systemFontOfSize:19*72/96];
        TimeLab.font=[UIFont systemFontOfSize:19*72/96];
        NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:ShouYiLab.text];
       NSRange range = [ShouYiLab.text rangeOfString:[NSString stringWithFormat:@"%@",self.model.exceptReturn]];
               [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25*72/96] range:range];
        [mAttStri addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#FF3939"] range:range];
        ShouYiLab.attributedText=mAttStri;


        
    }
    else{
        _TitleLab.font=[UIFont systemFontOfSize:31*72/96];
        ShouYiLab.font=[UIFont systemFontOfSize:20*72/96];
        JinELab.font=[UIFont systemFontOfSize:20*72/96];
        BeginLab.font = [UIFont systemFontOfSize:20*72/96];
        EndLab.font=[UIFont systemFontOfSize:20*72/96];
        TimeLab.font=[UIFont systemFontOfSize:20*72/96];
        NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:ShouYiLab.text];
        NSRange range = [ShouYiLab.text rangeOfString:[NSString stringWithFormat:@"%@",self.model.exceptReturn]];
        [mAttStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30*72/96] range:range];
        [mAttStri addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#FF3939"] range:range];
        ShouYiLab.attributedText=mAttStri;


        
    }

    UIView*Linefoot=[[UIView alloc]init];
    Linefoot.frame=CGRectMake(0, BeginLab.bottom-1, kDeviceWidth, 1);
    Linefoot.backgroundColor= [YXBTool colorWithHexString:@"#d9d9d9"];
    [self addSubview:Linefoot];
    type=[NSString stringWithFormat:@"%@",self.model.status];
    typeImg.frame=CGRectMake(kDeviceWidth-kDeviceWidth/640*66, topView.bottom, kDeviceWidth/640*66, kDeviceWidth/640*66);
    if([type isEqualToString:@"1"])
    {
    typeImg.image=[UIImage imageNamed:@"LiCaiJinXingZhong.png"];
    }
    else if([type isEqualToString:@"2"])
    {
        typeImg.image=[UIImage imageNamed:@"LiCaiHuanKUanZhong.png"];
    }
    else{
        typeImg.image=[UIImage imageNamed:@"LiCaiYiWanCheng.png"];
        
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
