//
//  DebtDetailCell.m
//  YOUXINBAO
//
//  Created by Feili on 15/5/20.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "DebtDetailCell.h"
#import "YXBTool.h"

#define DebtDetailCellFont 17
#define DebtDetailCellLedtAlign 15


@interface DebtDetailCell ()
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)UILabel *valueLabel;
@property(nonatomic,strong)UILabel *lineLabel;
@property(nonatomic,strong)UIImageView *mianxiImage;
@end

@implementation DebtDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
//        self.elementArray = [NSMutableArray array];
        [self initViews];
        
    }
    
    return self;
}

-(void)initViews
{
    CGFloat x = DebtDetailCellLedtAlign, y = 0;
    CGFloat w = 0,h = 0;
    self.detailLabel = [self labelWithFrame:CGRectMake(x, y, w, h)];
    _detailLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_detailLabel];
    
    self.valueLabel = [self labelWithFrame:CGRectMake(x, y, w, h)];
    _valueLabel.textAlignment = NSTextAlignmentRight;
    _valueLabel.adjustsFontSizeToFitWidth = YES;
    _valueLabel.minimumScaleFactor = 8.0/_detailLabel.font.pointSize;
    [self.contentView addSubview:_valueLabel];
    
    //添加首借免息
    /*
    self.mianxiImage = [[UIImageView alloc] initWithFrame:CGRectMake(60, 2, 53, 15)];
    _mianxiImage.image = [UIImage imageNamed:@"firstmianxi-icon.png"];
    _mianxiImage.hidden = YES;
    [self.contentView addSubview:_mianxiImage];
     */
     
    
    self.lineLabel  = [[UILabel alloc] initWithFrame:CGRectZero];
    _lineLabel.backgroundColor = [UIColor lightGrayColor];
//    [self.contentView addSubview:_lineLabel];
    
}

-(void)reSetFrameIfNeed
{
    _detailLabel.width = (self.width-2*DebtDetailCellLedtAlign)/2;
    _detailLabel.height = self.height;

    _valueLabel.left = _detailLabel.left + _detailLabel.width;
    _valueLabel.top = _detailLabel.top;
    _valueLabel.width = _detailLabel.width;
    _valueLabel.height = _detailLabel.height;
    
    CGRect lineFrame = CGRectMake(0, self.height-1, self.width, 1);
    _lineLabel.frame = lineFrame;
}

-(void)setModel:(DebtItemModel *)model
{
    if (_model != model) {
        _model = model;
        _detailLabel.text = _model.debtName;
        _valueLabel.text = _model.debtValue;
    }
}

-(void)isFirstMianxi:(BOOL)isMianxi
{
    _mianxiImage.hidden = !isMianxi;
}


-(UILabel *)labelWithFrame:(CGRect)frame
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
//    label.backgroundColor = [YXBTool generateRandomColor];
    label.font = [UIFont systemFontOfSize:DebtDetailCellFont];
    return label;
}

@end
