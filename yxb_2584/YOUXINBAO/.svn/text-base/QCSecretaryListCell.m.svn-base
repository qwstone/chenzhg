//
//  QCSecretaryListCell.m
//  YOUXINBAO
//
//  Created by Walice on 15/7/7.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCSecretaryListCell.h"

@implementation QCSecretaryListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initViews];
    }
    
    return self;
}

- (void)_initViews{
    
    _usePeopleNum=[[UILabel alloc]initWithFrame:CGRectZero];
    _usePeopleNum.font=[UIFont systemFontOfSize:14];
    [self addSubview:_usePeopleNum];
    
    _descript=[[UILabel alloc]initWithFrame:CGRectZero];
    _descript.font=[UIFont systemFontOfSize:14];
    _descript.numberOfLines=3;
    [self addSubview:_descript];
    
    _imgView=[[UIImageView alloc]initWithFrame:CGRectZero];
    [self addSubview:_imgView];
    
    [self setNeedsLayout];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _usePeopleNum.frame=CGRectMake(kDeviceWidth-100, 5, 90, 15);
    _descript.frame=CGRectMake(10, 5, kDeviceWidth-20, 100);
    
    _usePeopleNum.textColor=rgb(0, 0, 0, 1);
    _usePeopleNum.text=[NSString stringWithFormat:@"%@次使用",self.model.usePeopleNum];
    _usePeopleNum.textAlignment=NSTextAlignmentRight;
    
    NSRange range1=[_usePeopleNum.text rangeOfString:[NSString stringWithFormat:@"%@",self.model.usePeopleNum]];
    NSMutableAttributedString *aText=[[NSMutableAttributedString alloc]initWithString:_usePeopleNum.text];
    [aText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:range1];
    [aText addAttribute:NSForegroundColorAttributeName value:rgb(217, 30, 61, 1) range:range1];
    _usePeopleNum.attributedText=aText;

    
    
    
    
    NSString *str=[NSString stringWithFormat:@"  %@",self.model.descript];
    _descript.numberOfLines=3;
    _descript.textColor=rgb(97, 97, 97, 1);
    NSMutableAttributedString *attribute=[[NSMutableAttributedString alloc]initWithString:str];
    NSMutableParagraphStyle *style=[[NSMutableParagraphStyle alloc]init];
    [style setLineSpacing:10];
    [attribute addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, [str length])];
    [_descript setAttributedText:attribute];
    _descript.numberOfLines=3;
    _descript.font=[UIFont systemFontOfSize:14];
    _descript.textColor=rgb(97, 97, 97, 1);
    
    
    _imgView.frame=CGRectMake(kDeviceWidth-10, self.height/2, 10, 18);
    _imgView.image=[UIImage imageNamed:@"wxck-next.png"];
    [self addSubview:_imgView];
    
    [self.contentView bringSubviewToFront:_usePeopleNum];
    
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
