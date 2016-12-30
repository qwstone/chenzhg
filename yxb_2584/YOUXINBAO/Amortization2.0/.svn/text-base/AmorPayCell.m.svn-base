//
//  AmorPayCell.m
//  YOUXINBAO
//
//  Created by Feili on 15/9/18.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AmorPayCell.h"

@implementation AmorPayCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

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
//    NSMutableArray *array = [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"%ld",(long)100],[NSString stringWithFormat:@"%ld",(long)200],[NSString stringWithFormat:@"%ld",(long)300], nil];
    CGFloat x = 0, y = 0, w = kDeviceWidth, h = 44;
    self.payView = [[AmorPayView alloc] initWithFrame:CGRectMake(x, y, w, h)];
//    _payView.payTypeArray = array;
    _payView.backgroundColor = [UIColor whiteColor];
    _payView.userInteractionEnabled = YES;
    [self.contentView addSubview:_payView];
}

-(void)setButtonType:(NSInteger)buttonType
{
    _buttonType = buttonType;
    _payView.buttonType = _buttonType;

}


@end
