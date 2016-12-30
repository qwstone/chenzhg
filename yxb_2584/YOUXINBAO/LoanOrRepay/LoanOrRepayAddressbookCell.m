//
//  LoanOrRepayAddressbookCell.m
//  YOUXINBAO
//
//  Created by CH10 on 15/7/21.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanOrRepayAddressbookCell.h"
#import "YXBTool.h"

@implementation LoanOrRepayAddressbookCell {
    UIImageView *_imageview;
    UILabel *_nameLabel;
    UILabel *_rightLabel;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        jjzx-txl-icon
        _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(15, (kAddressbookCellHeight-41)/2, 41.5, 41)];
        _imageview.layer.cornerRadius = _imageview.height/2;
        _imageview.layer.masksToBounds = YES;
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, (kAddressbookCellHeight-20)/2, kDeviceWidth -80, 20)];
        //        _nameLabel.text = @"阿信";
        _nameLabel.font = [UIFont systemFontOfSize:16];
        //_nameLabel.backgroundColor = [UIColor purpleColor];
        
        [self.contentView addSubview:_imageview];
        [self.contentView addSubview:_nameLabel];

        
//        _rightLabel = [UIButton buttonWithType:UIButtonTypeCustom];
//        _rightLabel.titleLabel.font = [UIFont systemFontOfSize:14];
//        [_rightLabel setFrame:CGRectMake(kDeviceWidth-85.0, (self.contentView.height-29.5)/2, 70.0, 29.5)];
//        [_rightLabel addTarget:self action:@selector(checkButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:_rightLabel];
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth-85.0, (kAddressbookCellHeight-29.5)/2, 70.0, 29.5)];
        _rightLabel.backgroundColor = [UIColor clearColor];
        _rightLabel.textAlignment = NSTextAlignmentCenter;
        _rightLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_rightLabel];
        
    }
    return self;
}

//- (void)checkButtonTapped:(UIButton *)button {
//    
//}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _nameLabel.text = _user.nickname;
    
    if (self.friendStyle == LoanOrRepayAddressbookCellStyleAddressFriend) {
        _rightLabel.text = @"直接借款";
        _rightLabel.textColor = [YXBTool colorWithHexString:@"#2E962E"];
        _nameLabel.left = _imageview.left;
        _imageview.image = nil;
//        [_rightButton setTitle:@"直接借款" forState:UIControlStateNormal];
//        [_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else if (self.friendStyle == LoanOrRepayAddressbookCellStyleAddressNotFriend) {
        _rightLabel.text = @"短信借款";
        _rightLabel.textColor = [YXBTool colorWithHexString:@"#D61212"];
        _nameLabel.left = _imageview.left;
        _imageview.image = nil;
//        [_rightButton setTitle:@"短信借款" forState:UIControlStateNormal];
//        [_rightButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }else if (self.friendStyle == LoanOrRepayAddressbookCellStyleYXBFriend) {
        _rightLabel.text = @"向他借钱";
        _rightLabel.textColor = [YXBTool colorWithHexString:@"#2E962E"];
        _imageview.image = [UIImage imageNamed:@"jjzx-txl-icon"];
        _nameLabel.left = 70;
//        [_rightButton setTitle:@"向他借款" forState:UIControlStateNormal];
//        [_rightButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    }else if (self.friendStyle == LoanOrRepayAddressbookCellStyleAddressBlank) {
        _rightLabel.text = @"";
        _rightLabel.textColor = [YXBTool colorWithHexString:@"#2E962E"];
        _imageview.image = [UIImage imageNamed:@"jjzx-txl-icon"];
        _nameLabel.left = 70;
        //        [_rightButton setTitle:@"向他借款" forState:UIControlStateNormal];
        //        [_rightButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
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
