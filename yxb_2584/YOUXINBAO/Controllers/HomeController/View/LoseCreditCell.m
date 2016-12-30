//
//  LoseCreditCell.m
//  YOUXINBAO
//
//  Created by pro on 16/9/23.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoseCreditCell.h"
#import <QuartzCore/QuartzCore.h>

@interface LoseCreditCell()

@property (strong, nonatomic) UIImageView   * headIcon;
@property (strong, nonatomic) UILabel       * nameLabel;
@property (strong, nonatomic) UILabel       * mobileLabel;
@property (strong, nonatomic) UILabel       * idcardLabel;
@property (strong, nonatomic) UILabel       * stateLabel;
@property (strong, nonatomic) UIImageView   * lineView;
@end




@implementation LoseCreditCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [YXBTool colorWithHexString:@"f5f5f5"];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initViews];
    }
    return self;
}

//29

-(void) setModel:(DishonestUser *)model
{
    _nameLabel.text   =  model.name;
    _mobileLabel.text =  model.mobile;
    _idcardLabel.text =  model.idcard;
    _stateLabel.text  =  model.stateStr;
    if ([model.gender isEqualToString:@"1"]) {
        _headIcon.image = [UIImage imageNamed:@"user1.png"];
    }else{
        _headIcon.image = [UIImage imageNamed:@"user2.png"];
    }
    if (model.isShow) {
        [self.lineView setHidden:NO];
    }else{
        [self.lineView setHidden:YES];
    }

}





-(void)initViews
{
    self.headIcon = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/750*11, (30 - kDeviceWidth/750*24)/2, kDeviceWidth/750*24, kDeviceWidth/750*24)];
    [self.contentView addSubview:_headIcon];
    //姓名
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_headIcon.right + kDeviceWidth/750*6, 1, kDeviceWidth/750*82, 28)];
    [_nameLabel setAdjustsFontSizeToFitWidth:YES];
    _nameLabel.textColor = [YXBTool colorWithHexString:@"#555555"];
    _nameLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_nameLabel];
    
    //电话
    self.mobileLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.right + kDeviceWidth/750*16, 1, kDeviceWidth/750*160, 28)];
    _mobileLabel.textColor = [YXBTool colorWithHexString:@"#5F5F5F"];
    [_mobileLabel setAdjustsFontSizeToFitWidth:YES];
    _mobileLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_mobileLabel];
    
    //身份证号308 256
    self.idcardLabel = [[UILabel alloc] initWithFrame:CGRectMake(_mobileLabel.right + kDeviceWidth/750*16, 1, kDeviceWidth/750*240, 28)];
    _idcardLabel.textColor = [YXBTool colorWithHexString:@"#606060"];
    [_idcardLabel setAdjustsFontSizeToFitWidth:YES];
    _idcardLabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:_idcardLabel];
    
    //状态564 184 748 2
    self.stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(_idcardLabel.right + kDeviceWidth/750*16, 1, kDeviceWidth/750*168, 28)];
    _stateLabel.textColor = [YXBTool colorWithHexString:@"#606060"];
    [_stateLabel setAdjustsFontSizeToFitWidth:YES];
    _stateLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_stateLabel];
    
    //分割线
  //  UIImageView * line = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/750*20, 29, kDeviceWidth - kDeviceWidth/750*20*2, 1)];
    //line.backgroundColor = [UIColor colorWithRed:217.0/255 green:217.0/255 blue:217.0/255 alpha:0.15];
   // [self.contentView addSubview:line];
    /*
    UILabel * line = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/750*20, 29, kDeviceWidth - kDeviceWidth/750*20*2, 1)];
    line.text = @"- - - - - - - - - - - - - - - - - - - -";
    line.textColor = [UIColor colorWithRed:217.0/255 green:217.0/255 blue:217.0/255 alpha:0.15];
    [self.contentView addSubview:line];*/
    
    [self addDashed];
    
}


-(void)addDashed
{
    self.lineView = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/750*20, 29, kDeviceWidth - kDeviceWidth/750*20*2, 1)];
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
