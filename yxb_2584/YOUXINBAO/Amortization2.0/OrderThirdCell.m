//
//  OrderThirdCell.m
//  YOUXINBAO
//
//  Created by Walice on 15/9/16.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "OrderThirdCell.h"
#import "UIImageView+WebCache.h"

@interface OrderThirdCell ()

@property(nonatomic,strong)UIImageView *imgView2;
@property(nonatomic,strong)UILabel *label2;
@property(nonatomic,strong)UILabel *label3;


@end

@implementation OrderThirdCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    
    return self;
}
- (void)initViews{
    
    UIImageView *imgView1=[[UIImageView alloc]initWithFrame:CGRectMake(13, 15, 18, 16)];
     imgView1.image=[UIImage imageNamed:@"orderxq-yf.png"];
    [self.contentView addSubview:imgView1];
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(imgView1.right+9,15, 200, 17)];
    label1.text=@"商品信息";
    label1.font=[UIFont systemFontOfSize:17];
    label1.textColor=rgb(22, 22,22, 1);
    [self.contentView addSubview:label1];
    
    
    _imgView2=[[UIImageView alloc]initWithFrame:CGRectMake(13, imgView1.bottom+15, 94, 94)];
    [self.contentView addSubview:_imgView2];
    _label2=[[UILabel alloc]initWithFrame:CGRectMake(_imgView2.right+10, _imgView2.origin.y, kDeviceWidth-_imgView2.right-20, 60)];
    _label2.font=[UIFont systemFontOfSize:14];
    _label2.textColor=rgb(48, 48, 48, 1);
    _label2.numberOfLines=0;
    [self.contentView addSubview:_label2];
    
    
    _label3=[[UILabel alloc]initWithFrame:CGRectMake(_imgView2.right+10, _label2.bottom+19, kDeviceWidth-_imgView2.right-10, 21)];
    _label3.font=[UIFont systemFontOfSize:21];
    _label3.textColor=rgb(217, 30, 61, 1);
    [self.contentView addSubview:_label3];
    
    
}

- (void)setModel:(CommerceDetailV2 *)model{

    _model=model;
    [_imgView2 sd_setImageWithURL:[NSURL URLWithString:self.model.goodImageUrl]];
    _label2.text=self.model.goodDes;
    _label3.text=self.model.goodMoney;
    
    
//    NSString *str1=[NSString stringWithFormat:@"%@",self.model.goodMoney];
//    NSMutableAttributedString *aText=[[NSMutableAttributedString alloc]initWithString:str1];
//    [aText addAttribute:NSForegroundColorAttributeName value:rgb(208, 30, 61, 1) range:NSMakeRange(0,self.model.goodMoney.length)];
//    [aText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:21] range:NSMakeRange(0,self.model.goodMoney.length)];
//    _label3.attributedText=aText;
    

}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
