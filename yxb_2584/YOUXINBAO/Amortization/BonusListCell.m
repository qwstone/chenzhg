//
//  BonusListCell.m
//  YOUXINBAO
//
//  Created by Walice on 15/6/1.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "BonusListCell.h"

@implementation BonusListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initViews];
    }
    
    return self;
}

- (void)_initViews{
    
    _nameLabel=[[UILabel alloc]init];
    [self addSubview:_nameLabel];
    
    _timeLabel=[[UILabel alloc]init];
    [self addSubview:_timeLabel];
    
    _imgView=[[UIImageView alloc]init];
    [self addSubview:_imgView];

    _moneyLabel=[[UILabel alloc]init];
    [self addSubview:_moneyLabel];
    
    _remarkLabel=[[UILabel alloc]init];
    [self addSubview:_remarkLabel];
   
        
    _yuanLabel=[[UILabel alloc]init];
    [self addSubview:_yuanLabel];
        
    _perLabel=[[UILabel alloc]init];
    [self addSubview:_perLabel];
  
    
    [self setNeedsLayout];
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    _nameLabel.frame=CGRectMake(10, 13, (kDeviceWidth)/2, 15);
    _nameLabel.textColor=rgb(50, 50, 50, 1);
    _nameLabel.font=[UIFont systemFontOfSize:15];
  
    _timeLabel.frame=CGRectMake(10, 40, 100, 15);
    _timeLabel.textColor=rgb(140, 138, 138, 1);
    _timeLabel.font=[UIFont systemFontOfSize:12];
    
    _moneyLabel.frame=CGRectMake(_nameLabel.right, 13, (kDeviceWidth-20)/2-10, 18);
    _moneyLabel.textAlignment=NSTextAlignmentRight;
    _moneyLabel.textColor=rgb(250, 114, 81, 1);
    _moneyLabel.font=[UIFont boldSystemFontOfSize:18];
    
    _remarkLabel.frame=CGRectMake(_timeLabel.right, 40, kDeviceWidth-_timeLabel.right-10, 15);
    _remarkLabel.textColor=rgb(179, 179, 179,1);
    _remarkLabel.font=[UIFont systemFontOfSize:11];
    _remarkLabel.textAlignment=NSTextAlignmentRight;
    
    _nameLabel.text=self.model.name;
    _timeLabel.text=self.model.time;
    _moneyLabel.text=self.model.money;
    _remarkLabel.text=self.model.remark;
    
    if (self.isCollectMoney) {
        
        _nameLabel.frame=CGRectMake(10, 15, 177, 15);
        _nameLabel.textColor=rgb(50, 50, 50, 1);
        _nameLabel.font=[UIFont systemFontOfSize:14];
        
        _timeLabel.frame=CGRectMake(10, 35, 130, 15);
        _timeLabel.textColor=rgb(179, 179, 179, 1);
        _timeLabel.font=[UIFont systemFontOfSize:12];
        
        _imgView.frame=CGRectMake(_timeLabel.right, _timeLabel.origin.y, 39, 13);
        
        _moneyLabel.frame=CGRectMake(_nameLabel.right, 15, kDeviceWidth-50-_nameLabel.width, 18 );
        _moneyLabel.textColor=rgb(1, 1, 1, 1);
        _moneyLabel.font=[UIFont systemFontOfSize:14];
        
        _yuanLabel.frame=CGRectMake(kDeviceWidth-40, 15, 40, 18);
        _yuanLabel.textAlignment=NSTextAlignmentLeft;
        _yuanLabel.font=[UIFont systemFontOfSize:12];
        _yuanLabel.textColor=rgb(179, 179, 179, 1);
    
        _remarkLabel.frame=CGRectZero;

        _perLabel.frame=CGRectMake(kDeviceWidth-40, 35, 40, 15);
        _perLabel.font=[UIFont systemFontOfSize:12];
    

        _abcText=[NSString stringWithFormat:@"(%ld/%ld)",(long)self.collectModel.peopleComplete,(long)self.collectModel.peopleSum];
    
    NSRange range1=[_abcText rangeOfString:[NSString stringWithFormat:@"%ld",(long)self.collectModel.peopleComplete]];
    NSRange range2=[_abcText rangeOfString:[NSString stringWithFormat:@"%ld",(long)self.collectModel.peopleSum]];
    NSMutableAttributedString *aText=[[NSMutableAttributedString alloc]initWithString:_abcText];
    [aText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:range1];
    [aText addAttribute:NSForegroundColorAttributeName value:rgb(217, 30,61, 1) range:range1];
    [aText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:range2];
    [aText addAttribute:NSForegroundColorAttributeName value:rgb(104, 100, 100, 1) range:range2];
    _perLabel.attributedText=aText;

        
        

        _nameLabel.text=self.collectModel.title;
        _timeLabel.text=self.collectModel.time;
        if (self.collectModel.mode==1) {
            _moneyLabel.text=[NSString stringWithFormat:@"+%@",self.collectModel.money];
            if (self.collectModel.collectType==100) {
                _imgView.image=[UIImage imageNamed:@"AA-dsk.png"];
                
            }
            if (self.collectModel.collectType==200) {
                _imgView.image=[UIImage imageNamed:@"AA-ygb.png"];
            }
            if (self.collectModel.collectType==300) {
                _imgView.image=[UIImage imageNamed:@"AA-ytk.png"];
            }
            if (self.collectModel.collectType==400) {
                _imgView.image=[UIImage imageNamed:@"AA-ysq.png"];
            }
        }
        else if (self.collectModel.mode==2){
            _moneyLabel.text=[NSString stringWithFormat:@"-%@",self.collectModel.money];
            {
            
                if (self.collectModel.collectType==200) {
                      _imgView.image=[UIImage imageNamed:@"AA-ygb.png"];
                }
                if (self.collectModel.collectType==800) {
                      _imgView.image=[UIImage imageNamed:@"AA-yfk.png"];
                }
                if (self.collectModel.collectType==900) {
                     _imgView.image=[UIImage imageNamed:@"AA-wfk.png"];
                }
                if (self.collectModel.collectType==300) {
                    _imgView.image=[UIImage imageNamed:@"AA-ytk.png"];
                }
            
            }
        
        }

        
        _yuanLabel.text=@"元/人";

        

    }
    

}


@end
