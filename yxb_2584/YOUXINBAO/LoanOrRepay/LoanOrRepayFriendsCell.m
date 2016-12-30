//
//  LoanOrRepayFriendsCell.m
//  YOUXINBAO
//
//  Created by CH10 on 15/7/21.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanOrRepayFriendsCell.h"
#import "YXBTool.h"
#import "UIImageView+WebCache.h"

@implementation LoanOrRepayFriendsCell {
    UILabel *_rightLabel;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth-85.0, (kLinkManCellHeight-29.5)/2, 70.0, 29.5)];
        _rightLabel.backgroundColor = [UIColor clearColor];
        _rightLabel.textAlignment = NSTextAlignmentCenter;
        _rightLabel.textColor = [YXBTool colorWithHexString:@"#D61212"];
        _rightLabel.text = @"向ta借钱";
        _rightLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_rightLabel];
    }
    
    return self;
}

- (void)setIsBorrow:(BOOL)isBorrow {
    if (isBorrow) {
        _rightLabel.text = @"向ta借钱";
    }else {
        _rightLabel.text = @"借钱给ta";
    }
}

-(void)setCellType:(LoanFriendCellType)cellType
{
    switch (cellType) {
        case LoanFriendCellTypeBorrow:
        {
            _rightLabel.text = @"向ta借钱";

        }
            break;
        case LoanFriendCellTypeLend:
        {
            _rightLabel.text = @"借钱给ta";
            
        }
            break;

            
        default:
        {
            _rightLabel.text = @"";

        }
            break;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.nameLabel.text = _friendUser.nickname;
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:_friendUser.iconAddr] placeholderImage:[UIImage imageNamed:@"useimg"]];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
