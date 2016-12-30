//
//  OrderFiveCell.m
//  YOUXINBAO
//
//  Created by Walice on 15/9/17.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "OrderFiveCell.h"
#import "YXBTool.h"

@interface OrderFiveCell ()

@property(nonatomic,strong)UILabel *topLabel;
@property(nonatomic,strong)UILabel *payLabel;



@end

@implementation OrderFiveCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    
    return self;
}

-(void)initViews
{
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"danbxq-money-icon.png"]];
    imageView.frame = CGRectMake(0, 0, 40, 45);
    imageView.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:imageView];
    
    //还款详情
    CGFloat x = 0, y = 0, w = kDeviceWidth, h = 45;
    _topLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    _topLabel.textColor = [YXBTool colorWithHexString:@"#909090"];
    _topLabel.font = [UIFont systemFontOfSize:17];
    _topLabel.text = @"        还款详情";
    _topLabel.textColor=rgb(22, 22, 22, 1);
    _topLabel.textAlignment = NSTextAlignmentLeft;
    _topLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_topLabel];
    
    //添加横线
    y = _topLabel.bottom,h = 1;
    UILabel *firstLine = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    firstLine.backgroundColor = rgb(215, 215, 215, 1.0);
    [self.contentView addSubview:firstLine];
    
    //已还、待还
    x =0 , y = firstLine.bottom, w = kDeviceWidth, h = 45;
    _payLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, y, w, h)];
    _payLabel.textColor = [YXBTool colorWithHexString:@"#909090"];
    _payLabel.font = [UIFont systemFontOfSize:14];
    _payLabel.textAlignment = NSTextAlignmentLeft;
    _payLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_payLabel];
    
    //添加横线
    y = _payLabel.bottom,h = 1;
    UILabel *secondLine = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    secondLine.backgroundColor = rgb(215, 215, 215, 1.0);
    [self.contentView addSubview:secondLine];
 
    
}

- (void)setModel:(CommerceDetailV2 *)model{

    _model=model;
    
    NSString *str1 = [NSString stringWithFormat:@"已还%@期共%@元，待还%@期,共%@元",_model.alreadyPayIssue,_model.alreadyPayMoney,_model.willPayIssue,_model.willPayMoney];
    NSMutableAttributedString *aText=[[NSMutableAttributedString alloc]initWithString:str1];
    [aText addAttribute:NSForegroundColorAttributeName value:rgb(255, 132, 0, 1) range:NSMakeRange(2,self.model.alreadyPayIssue.length)];
    [aText addAttribute:NSForegroundColorAttributeName value:rgb(217, 30, 61, 1) range:NSMakeRange(4+self.model.alreadyPayIssue.length,self.model.alreadyPayMoney.length)];
    [aText addAttribute:NSForegroundColorAttributeName value:rgb(255, 132, 0, 1) range:NSMakeRange(self.model.alreadyPayIssue.length+self.model.alreadyPayMoney.length+8,self.model.willPayIssue.length)];
    [aText addAttribute:NSForegroundColorAttributeName value:rgb(217, 30, 61, 1) range:NSMakeRange(self.model.alreadyPayIssue.length+self.model.alreadyPayMoney.length+self.model.willPayIssue.length+11,self.model.willPayMoney.length)];
    _payLabel.attributedText=aText;
    


}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
