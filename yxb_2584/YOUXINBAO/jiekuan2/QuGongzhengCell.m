//
//  QuGongzhengCell.m
//  YOUXINBAO
//
//  Created by Walice on 16/3/23.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QuGongzhengCell.h"



#define sWidth self.frame.size.width
#define sHeight self.frame.size.height

@implementation QuGongzhengCell
{
    
    UILabel *_baoquanbianhao;
    UILabel *_baoquanshijian;

    UILabel *_jiaoyileixing;
    UILabel *_baoquanzhuangtai;
    UIImageView *img1;
    UIImageView *img2;
    UIImageView *img3;
    UIImageView *img4;
    UIImageView *img5;
   
    UIButton *moreInfo;

}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    
    return self;
}
- (void)initViews{
    img1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth-20, 9)];
    [self addSubview:img1];
    //以圈为分隔的上半部分的高度是100
    img3=[[UIImageView alloc]initWithFrame:CGRectMake(0, 70, kDeviceWidth-20, 19)];
    [self addSubview:img3];
    
    img2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 9, kDeviceWidth-20, img3.top-9)];
    [self addSubview:img2];

    _baoquanbianhao=[[UILabel alloc]initWithFrame:CGRectMake(12, 13, kDeviceWidth-24, 12)];
    _baoquanbianhao.font=[UIFont systemFontOfSize:15];
    [img2 addSubview:_baoquanbianhao];

    
    _baoquanshijian=[[UILabel alloc]initWithFrame:CGRectMake(12, _baoquanbianhao.bottom+13, kDeviceWidth-24, 12)];
    _baoquanshijian.font=[UIFont systemFontOfSize:15];
    [img2 addSubview:_baoquanshijian];
   
    //下部分背景图
    
    img4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, img3.bottom, kDeviceWidth-20, 50)];
    img4.userInteractionEnabled=YES;
    img4.image = [UIImage imageNamed:@"qrbgcon"];
    [self addSubview:img4];
    
    img5 = [[UIImageView alloc] initWithFrame:CGRectMake(0, img4.bottom, kDeviceWidth-20, 9)];
    img5.image = [UIImage imageNamed:@"qrbgtop2"];
    [self addSubview:img5];
    
    _jiaoyileixing=[[UILabel alloc]initWithFrame:CGRectMake(12, 0, kDeviceWidth-30-100, 12)];
    [img4 addSubview:_jiaoyileixing];
    
    _baoquanzhuangtai=[[UILabel alloc]initWithFrame:CGRectMake(12, _jiaoyileixing.bottom+13, kDeviceWidth-30-100, 12)];
    [img4 addSubview:_baoquanzhuangtai];
    
    moreInfo=[[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth-120, _jiaoyileixing.bottom, 77, 26)];
    [moreInfo addTarget:self action:@selector(moreInfoAction) forControlEvents:UIControlEventTouchUpInside];
    [img4 addSubview:moreInfo];

}
- (void)moreInfoAction{

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_model.webviewUrl]];
}
- (void)setModel:(PreserveCer *)model{

    if (_model != model) {
        _model = model;
    }
    
    [self setdata];
}

- (void)setdata {

    _baoquanbianhao.attributedText = [self manageStr:[NSString stringWithFormat:@"保全编号  %@",_model.cerID] WithFirstColor:rgb(178, 178, 178, 1) andSecondColor:[UIColor blackColor]andSeparateIndex:4];
     _baoquanshijian.attributedText = [self manageStr:[NSString stringWithFormat:@"保全时间  %@",_model.time] WithFirstColor:rgb(178, 178, 178, 1) andSecondColor:[UIColor blackColor]andSeparateIndex:4];
     _jiaoyileixing.attributedText = [self manageStr:[NSString stringWithFormat:@"交易类型  %@",_model.mode] WithFirstColor:rgb(178, 178, 178, 1) andSecondColor:[UIColor blackColor]andSeparateIndex:4];
     _baoquanzhuangtai.attributedText = [self manageStr:[NSString stringWithFormat:@"保全状态  %@",_model.state] WithFirstColor:rgb(178, 178, 178, 1) andSecondColor:[UIColor blackColor]andSeparateIndex:4];
    
}

//处理str红+黑
-(NSAttributedString*)manageStr:(NSString*)str WithFirstColor:(UIColor*)firstColor andSecondColor:(UIColor *)secondColor andSeparateIndex:(NSInteger)index{
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange firstRange = {0,index};
    NSRange secondRange = {index,attString.length-index};
    [attString addAttribute:NSForegroundColorAttributeName value:firstColor range:firstRange];
    [attString addAttribute:NSForegroundColorAttributeName value:secondColor range:secondRange];
    return attString;
}

- (void)layoutSubviews{

     img1.image = [UIImage imageNamed:@"qrbgtop"];
     img3.image=[UIImage imageNamed:@"YXBjiejxx-con.jpg"];
     img2.image = [UIImage imageNamed:@"qrbgcon"];
        [moreInfo setImage:[UIImage imageNamed:@"YXBMoreMess"] forState:UIControlStateNormal];
    _baoquanbianhao.font=[UIFont systemFontOfSize:15];
    _baoquanshijian.font=[UIFont systemFontOfSize:15];
    _jiaoyileixing.font=[UIFont systemFontOfSize:15];
    [_jiaoyileixing setAdjustsFontSizeToFitWidth:YES];
    _baoquanzhuangtai.font=[UIFont systemFontOfSize:15];


}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
