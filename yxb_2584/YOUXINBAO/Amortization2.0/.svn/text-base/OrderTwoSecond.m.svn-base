//
//  OrderTwoSecond.m
//  YOUXINBAO
//
//  Created by Walice on 15/9/18.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "OrderTwoSecond.h"
#import "CommerceDetailV2.h"

@interface OrderTwoSecond ()

@property(nonatomic,strong)UILabel *label2;
@property(nonatomic,strong)UILabel *label3;
@property(nonatomic,strong)UILabel *label4;
@end

@implementation OrderTwoSecond

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    
    return self;
}
- (void)initViews{
    
    UIImageView *imgView1=[[UIImageView alloc]initWithFrame:CGRectMake(15, 17, 22, 18)];
    imgView1.image=[UIImage imageNamed:@"形状 5.png"];
    [self.contentView addSubview:imgView1];
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(imgView1.right+12,18, 100, 16)];
    label1.font=[UIFont systemFontOfSize:16];
    label1.text=@"银行信息";
    label1.textColor=rgb(40, 40,40, 1);
    [self.contentView addSubview:label1];
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, label1.bottom+10, kDeviceWidth, 1)];
    line.backgroundColor=rgb(228, 228, 228, 1);
    [self.contentView addSubview:line];
    
    UIImageView *imgView2=[[UIImageView alloc]initWithFrame:CGRectMake(15, line.bottom+13, 18, 19)];
    imgView2.image=[UIImage imageNamed:@"bankdz-icon.png"];
    [self.contentView addSubview:imgView2];
    _label2=[[UILabel alloc]initWithFrame:CGRectMake(imgView2.right+12, line.bottom+13, kDeviceWidth-imgView2.right, 15)];
    _label2.font=[UIFont systemFontOfSize:15];
    _label2.textColor=rgb(48, 48, 48, 1);
    [self.contentView addSubview:_label2];
    
    
    UIImageView *imgView3=[[UIImageView alloc]initWithFrame:CGRectMake(imgView2.origin.x, imgView2.bottom+16, 17, 14)];
    imgView3.image=[UIImage imageNamed:@"bankcard-icon.png"];
    [self.contentView addSubview:imgView3];
    _label3=[[UILabel alloc]initWithFrame:CGRectMake(imgView3.right+12, imgView2.bottom+16, kDeviceWidth-imgView2.right, 15)];
    _label3.font=[UIFont systemFontOfSize:13];
    _label3.textColor=rgb(48, 48, 48, 1);
    [self.contentView addSubview:_label3];
    
}

- (void)setModel:(CommerceDetailV2 *)model{
    _model=model;
 
    _label2.text=self.model.name;
    _label3.text=self.model.phone;
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
