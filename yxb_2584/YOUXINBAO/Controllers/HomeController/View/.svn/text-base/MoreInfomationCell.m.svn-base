//
//  MoreInfomationFootCell.m
//  YOUXINBAO
//
//  Created by Feili on 16/12/21.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "MoreInfomationCell.h"

@interface MoreInfomationCell()

@property (nonatomic, weak) UILabel   * cellNum;
@property (nonatomic, weak) UILabel   * fundName;
@property (nonatomic, weak) UILabel   * moneyStr;
@property (nonatomic, weak) UILabel   * date;
@property (nonatomic, strong) UIView  * lineView;


@end


@implementation MoreInfomationCell




-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self initFootView];
    }
    return self;
}

-(void)setModel:(LoanFundDetail *)model{
    _fundName.text = model.fundName;
    _moneyStr.text = model.moneyStr;
    _date.text = model.date;
}

-(void)setIndex:(NSInteger )index{
    _cellNum.text = [NSString stringWithFormat:@"%ld",(long)index];
}


-(void)initFootView{
    
    UIFont * font = [UIFont systemFontOfSize:12];
    
    //编号
    UILabel * tcellNum = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/750*30, 0, kDeviceWidth/750*50, kDeviceWidth/640*85)];
    tcellNum.font = font;
    tcellNum.textAlignment = NSTextAlignmentCenter;
    tcellNum.textColor = [YXBTool colorWithHexString:@"#b3b3b3"];
    [self.contentView addSubview:tcellNum];
    self.cellNum = tcellNum;
    
    //资金名称
    UILabel * tfundName = [[UILabel alloc] initWithFrame:CGRectMake(tcellNum.right+5, 0, kDeviceWidth/750*140, kDeviceWidth/640*85)];
    tfundName.font = font;
    tfundName.textColor = [YXBTool colorWithHexString:@"#4d4d4d"];
    [self.contentView addSubview:tfundName];
    self.fundName = tfundName;
    
    //金额
    UILabel * tmoneyStr = [[UILabel alloc] initWithFrame:CGRectMake(tfundName.right+5, 0, kDeviceWidth-30 - tfundName.right - kDeviceWidth/750*180 - kDeviceWidth/750*30 - 5, kDeviceWidth/640*85)];
    tmoneyStr.font = font;
    tmoneyStr.textAlignment = NSTextAlignmentCenter;
    tmoneyStr.textColor = [YXBTool colorWithHexString:@"#ec2d2f"];
    [self.contentView addSubview:tmoneyStr];
    self.moneyStr = tmoneyStr;
    
    
    //日期
    UILabel * tdate = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth-30 - kDeviceWidth/750*180 - kDeviceWidth/750*30, 0, kDeviceWidth/750*180, kDeviceWidth/640*85)];
    tdate.font = font;
    tdate.textColor = [YXBTool colorWithHexString:@"#ec2d2f"];
    [self.contentView addSubview:tdate];
    self.date = tdate;
    
    
    [self addDashed];
}



-(void)addDashed
{
    self.lineView = [[UIImageView alloc] initWithFrame:CGRectMake(15, kDeviceWidth/640*85-1, kDeviceWidth - 60, 1)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:_lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(_lineView.frame) / 2, CGRectGetHeight(_lineView.frame))];
    [shapeLayer setFillColor:[UIColor colorWithRed:217.0/255 green:217.0/255 blue:217.0/255 alpha:1].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:[UIColor colorWithRed:217.0/255 green:217.0/255 blue:217.0/255 alpha:1].CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(_lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:3], [NSNumber numberWithInt:2], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(_lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [_lineView.layer addSublayer:shapeLayer];
    [self.contentView addSubview:_lineView];
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
