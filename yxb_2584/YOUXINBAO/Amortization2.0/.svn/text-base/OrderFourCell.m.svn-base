//
//  OrderFourCell.m
//  YOUXINBAO
//
//  Created by Walice on 15/9/17.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "OrderFourCell.h"
#import "YXBTool.h"

@interface OrderFourCell ()

@property(nonatomic,strong)UILabel *label4;
@property(nonatomic,strong)UILabel *label5;
@property(nonatomic,strong)UILabel *label6;
@property (nonatomic,strong)UILabel *label;


@end


@implementation OrderFourCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self initViews];
        [self loadLabels];
    }
    
    return self;
}
- (void)initViews{
    CGFloat left=20;
    
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(left,10, 80, 15)];
    label1.text=@"下单时间 :";
    label1.textColor=rgb(193, 193, 193, 1);
    [self.contentView addSubview:label1];
    
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(left,label1.bottom+5, 80, 15)];
    label2.text=@"担保时间 :";
    label2.textColor=rgb(193, 193, 193, 1);
    [self.contentView addSubview:label2];
    
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(left,label2.bottom+5, 80, 15)];
    label3.text=@"发货时间 :";
    label3.textColor=rgb(193, 193, 193, 1);
    [self.contentView addSubview:label3];
    
    
    _label4=[[UILabel alloc]initWithFrame:CGRectMake(label1.right,10, kDeviceWidth-150, 15)];
    _label4.textColor=rgb(193, 193, 193, 1);
    _label4.text=@"2016-08-30 19:00:00";
    [self.contentView addSubview:_label4];
    _label5=[[UILabel alloc]initWithFrame:CGRectMake(label1.right,_label4.bottom+5, kDeviceWidth-150, 15)];
    _label5.text=@"2016-08-30 19:00:00";
    _label5.textColor=rgb(193, 193, 193, 1);
    [self.contentView addSubview:_label5];
    _label6=[[UILabel alloc]initWithFrame:CGRectMake(label1.right,_label5.bottom+5, kDeviceWidth-150, 15)];
    _label6.text=@"2016-08-30 19:00:00";
    _label6.textColor=rgb(193, 193, 193, 1);
    [self.contentView addSubview:_label6];
    
    
    
}

-(void)loadLabels
{
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(20,0, kDeviceWidth-40, 0)];
    _label.text=@"下单时间 :";
    _label.textColor=rgb(193, 193, 193, 1);
    _label.numberOfLines = 0;
    _label.lineBreakMode = 0;
    _label.font = [UIFont systemFontOfSize:14.0];
    _label.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_label];
}

- (void)setModel:(CommerceDetailV2 *)model{
    if (_model != model) {
        _model = model;
        CGSize size = [YXBTool getFontSizeWithString:_model.timeDes font:_label.font constrainSize:CGSizeMake(kDeviceWidth, kDeviceHeight)];
        
        _label.height = size.height + OrderFourCellLabelSpaceTopBottom;
        
        _label.text = model.timeDes;

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
