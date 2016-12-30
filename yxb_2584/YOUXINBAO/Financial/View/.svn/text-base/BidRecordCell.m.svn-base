//
//  BidRecordCell.m
//  YOUXINBAO
//
//  Created by pro on 16/7/28.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "BidRecordCell.h"
#import "YXBTool.h"
@interface BidRecordCell ()

/**
 * 手机号
 */

@property (nonatomic, strong) UILabel* cellNumLabel;

/**
 * 时间
 */

@property (nonatomic, strong) UILabel* timeLabel;

/**
 * 到期收益
 */

@property (nonatomic, strong) UILabel* earningsLabel;

/**
 * 投资金额
 */

@property (nonatomic, strong) UILabel* moneyLabel;

@end

@implementation BidRecordCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView
{
    CGFloat width = (kDeviceWidth - kDeviceWidth/750*30*2)/2;
    //手机号
    self.cellNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/750*30, kDeviceWidth/750*18, width, kDeviceWidth/750*38)];
    _cellNumLabel.textColor = [YXBTool colorWithHexString:@"#4166AC"];
    _cellNumLabel.textAlignment = NSTextAlignmentLeft;
    _cellNumLabel.font = [UIFont systemFontOfSize:kDeviceWidth/750*30];
    [self.contentView addSubview:_cellNumLabel];
    
    //时间
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/750*30, _cellNumLabel.bottom + kDeviceWidth/750*18, width, kDeviceWidth/750*38)];
    _timeLabel.textColor = [YXBTool colorWithHexString:@"#959595"];
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    _timeLabel.font = [UIFont systemFontOfSize:kDeviceWidth/750*25];
    [self.contentView addSubview:_timeLabel];

    //年收益率
//    _shouyiL = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2, kDeviceWidth/750*18, 60, kDeviceWidth/750*38)];
//    _shouyiL.text = @"年收益率";
//    _shouyiL.textColor = [YXBTool colorWithHexString:@"#959595"];
//    _shouyiL.font = [UIFont systemFontOfSize:kDeviceWidth/750*20];
//    [self.contentView addSubview:_shouyiL];
    
//    self.earningsLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2+kDeviceWidth/750*18, kDeviceWidth/750*12, width, kDeviceWidth/750*38)];
//    _earningsLabel.textColor = [YXBTool colorWithHexString:@"#959595"];
//    _earningsLabel.textAlignment = NSTextAlignmentLeft;
//    _earningsLabel.font = [UIFont systemFontOfSize:kDeviceWidth/750*22];
//    [self.contentView addSubview:_earningsLabel];
    self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2+kDeviceWidth/750*18, kDeviceWidth/750*12, width, kDeviceWidth/750*38)];
    _moneyLabel.textColor = [YXBTool colorWithHexString:@"#959595"];
    _moneyLabel.textAlignment = NSTextAlignmentLeft;
    _moneyLabel.font = [UIFont systemFontOfSize:kDeviceWidth/750*22];
    [self.contentView addSubview:_moneyLabel];


    //投资金额
//    self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2+kDeviceWidth/750*18, _earningsLabel.bottom + kDeviceWidth/750*22, width, kDeviceWidth/750*38)];
//    _moneyLabel.textColor = [YXBTool colorWithHexString:@"#959595"];
//    _moneyLabel.textAlignment = NSTextAlignmentLeft;
//    _moneyLabel.font = [UIFont systemFontOfSize:kDeviceWidth/750*22];
//    [self.contentView addSubview:_moneyLabel];
        self.earningsLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2+kDeviceWidth/750*18, _moneyLabel.bottom + kDeviceWidth/750*22, width, kDeviceWidth/750*38)];
        _earningsLabel.textColor = [YXBTool colorWithHexString:@"#959595"];
        _earningsLabel.textAlignment = NSTextAlignmentLeft;
        _earningsLabel.font = [UIFont systemFontOfSize:kDeviceWidth/750*22];
        [self.contentView addSubview:_earningsLabel];


}


-(void)setModel:(AssetParticipation *)model
{
    self.cellNumLabel.text  = model.cellNum;
    self.timeLabel.text     = model.time;
    self.moneyLabel.attributedText = [self SetLabelttributedString:[NSString stringWithFormat:@"投资金额：%@元",model.money] LabelTextSize:kDeviceWidth/750*38 andColor:[YXBTool colorWithHexString:@"#FF3939"]];
    self.earningsLabel.attributedText = [self SetLabelttributedString:[NSString stringWithFormat:@"年收益率：%@元",model.earnings] LabelTextSize:kDeviceWidth/750*25 andColor:[YXBTool colorWithHexString:@"#333333"]];
    
}


- (NSMutableAttributedString *)SetLabelttributedString:(NSString *)Labelstr  LabelTextSize:(float)size andColor:(UIColor *)color
{
    NSMutableString * str = [[NSMutableString alloc] initWithString:Labelstr];
    NSMutableAttributedString* attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSRange rangeEnd  = [str rangeOfString:@"元"];
    NSRange rangeSta  = [str rangeOfString:@"："];
    NSRange range = NSMakeRange(rangeSta.location + rangeSta.length, rangeEnd.location - rangeSta.location - 1);
    
    //设置单位颜色
    [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    //设置单位大小
    [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:size] range:range];

    
    return attributedStr;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
