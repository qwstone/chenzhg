//
//  OrderOneCell.m
//  YOUXINBAO
//
//  Created by Walice on 15/9/16.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "OrderOneCell.h"
#import "UIImageView+WebCache.h"

@interface OrderOneCell ()

@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)UILabel *closeLabel;
@property(nonatomic,strong)UILabel *label;


@end

@implementation OrderOneCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    
    return self;
}
- (void)initViews{

    _imgView=[[UIImageView alloc]initWithFrame:CGRectMake((kDeviceWidth-280)/2,23,280, 40)];
    [self.contentView addSubview:_imgView];
    
    _closeLabel=[[UILabel alloc]initWithFrame:CGRectMake((kDeviceWidth-80)/2, 33, 80, 16)];
     _closeLabel.text=@"已关闭";
    _closeLabel.font=[UIFont systemFontOfSize:16];
    _closeLabel.textColor=rgb(255, 132, 0, 1);
    _closeLabel.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:_closeLabel];
    
    _label=[[UILabel alloc]initWithFrame:CGRectMake(20, _imgView.bottom+17, kDeviceWidth-40, 15)];
    _label.font=[UIFont systemFontOfSize:11];
    _label.textAlignment=NSTextAlignmentCenter;
    _label.textColor=rgb(145, 145, 145, 1);
    [self.contentView addSubview:_label];
    

}

- (void)setModel:(CommerceDetailV2 *)model{

    _model=model;
    if (model.isClosed.integerValue==1) {
        _imgView.hidden=YES;
        _closeLabel.hidden=NO;
        _label.text=self.model.remark;
        
    }
    else{
        _imgView.hidden=NO;
        [_imgView sd_setImageWithURL:[NSURL URLWithString:self.model.statusImageUrl]];
        _closeLabel.hidden=YES;
        _label.text=self.model.remark;
       
    
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
