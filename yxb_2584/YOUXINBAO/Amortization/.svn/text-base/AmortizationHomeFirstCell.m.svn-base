//
//  AmortizationHomeFirstCell.m
//  YOUXINBAO
//
//  Created by CH10 on 15/7/13.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AmortizationHomeFirstCell.h"

#define kButtonTag 30030

@implementation AmortizationHomeFirstCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //            xfqnav1  102*138
        CGFloat buttonW = getScreenFitSize(102/2);
        CGFloat buttonH = getScreenFitSize(138/2);
        CGFloat gap = (kDeviceWidth-buttonW*4)/5;
        for (int i = 0; i<4; i++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*(buttonW+gap)+gap, (kAmortizationHomeFirstCellHeight-buttonH)/2, buttonW, buttonH)];
            button.tag = kButtonTag+i;
            NSString *imageStr = [NSString stringWithFormat:@"xfqnav%ld",(long)(i+1)];
            [button setBackgroundImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:button];
        }
    }
    
    return self;
}

- (void)buttonAction:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(amortizationHomeFirstCell:buttonDidClickedAtIndex:)]) {
        [self.delegate amortizationHomeFirstCell:self buttonDidClickedAtIndex:(button.tag-kButtonTag)];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
