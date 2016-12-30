//
//  OrderTwoCell.m
//  YOUXINBAO
//
//  Created by Walice on 15/9/16.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "OrderTwoCell.h"
#import "YXBTool.h"

@interface OrderTwoCell ()

@property(nonatomic,strong)UILabel *label2;
@property(nonatomic,strong)UILabel *label3;
@property(nonatomic,strong)UILabel *label4;
@end

@implementation OrderTwoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    
    return self;
}
- (void)initViews{
    
    UIImageView *imgView1=[[UIImageView alloc]initWithFrame:CGRectMake(15, 13, 15, 18)];
    imgView1.image=[UIImage imageNamed:@"orderxq-dw.png"];
    [self.contentView addSubview:imgView1];
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(imgView1.right+12,16, 50, 16)];
    label1.font=[UIFont systemFontOfSize:16];
    label1.text=@"地址";
    label1.textColor=rgb(40, 40,40, 1);
    [self.contentView addSubview:label1];
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, label1.bottom+10, kDeviceWidth, 1)];
    line.backgroundColor=rgb(228, 228, 228, 1);
    [self.contentView addSubview:line];
    
    UIImageView *imgView2=[[UIImageView alloc]initWithFrame:CGRectMake(23, line.bottom+14, 18, 18)];
    imgView2.image=[UIImage imageNamed:@"orderxq-user.png"];
    [self.contentView addSubview:imgView2];
    _label2=[[UILabel alloc]initWithFrame:CGRectMake(imgView2.right+18, line.bottom+16, 60, 20)];
    _label2.font=[UIFont systemFontOfSize:15];
    _label2.textColor=rgb(48, 48, 48, 1);
    [self.contentView addSubview:_label2];
    
    UIImageView *imgView3=[[UIImageView alloc]initWithFrame:CGRectMake(_label2.right+30, line.bottom+14, 13, 18)];
    imgView3.image=[UIImage imageNamed:@"orderxq-phone.png"];
    [self.contentView addSubview:imgView3];
    _label3=[[UILabel alloc]initWithFrame:CGRectMake(imgView3.right+15, line.bottom+16, 150, 20)];
    _label3.textColor=rgb(47, 47, 47, 1);
    [self.contentView addSubview:_label3];
    
    
    UIImageView *imgView4=[[UIImageView alloc]initWithFrame:CGRectMake(imgView2.origin.x, imgView2.bottom+18, 18, 23)];
    imgView4.image=[UIImage imageNamed:@"orderxq-dz.png"];
    [self.contentView addSubview:imgView4];
    _label4=[[UILabel alloc]initWithFrame:CGRectMake(imgView4.right+18, imgView4.origin.y+2, kDeviceWidth-imgView4.right-20, [self getHeight].height)];
    _label4.font=[UIFont systemFontOfSize:13];
    _label4.textColor=rgb(48, 48, 48, 1);
    _label4.numberOfLines=0;
    [self.contentView addSubview:_label4];
    
}

- (void)setModel:(CommerceDetailV2 *)model{
    _model=model;
    _label2.text=self.model.name;
    _label3.text=self.model.phone;
    _label4.text=self.model.adress;


}

- (CGSize)getHeight{
    
    CGSize size=[YXBTool getFontSizeWithString:[NSString stringWithFormat:@"%@",self.model.adress] font:[UIFont systemFontOfSize:13] constrainSize:CGSizeMake(kDeviceWidth-50, CGFLOAT_MAX)];
    return size;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
