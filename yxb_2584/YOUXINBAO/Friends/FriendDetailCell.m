//
//  FriendDetailCell.m
//  YOUXINBAO
//
//  Created by Feili on 15/5/13.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "FriendDetailCell.h"

@interface FriendDetailCell ()<UITextFieldDelegate>
@property(nonatomic,strong)UILabel     *keyLabel;
@property(nonatomic,strong)UITextField *valueField;
@end
@implementation FriendDetailCell

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
#define FontSize 16
    CGFloat x = 30,y = 0,w = 70,h = FriendDetailCellHeight;
    self.keyLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    _keyLabel.font = [UIFont systemFontOfSize:FontSize];
    _keyLabel.textColor = [UIColor blackColor];
    _keyLabel.backgroundColor = [UIColor clearColor];
    _keyLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_keyLabel];
    
    CGFloat space = 20;
    x = x + w + space;
    w = self.width - x;
    self.valueField = [[UITextField alloc] initWithFrame:CGRectMake(x, y, w, h)];
    _valueField.font = [UIFont systemFontOfSize:FontSize];
    _valueField.textAlignment = NSTextAlignmentLeft;
    _valueField.textColor = [UIColor lightGrayColor];
    _valueField.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_valueField];
}

-(void)setUser:(FriendDetailItemModel *)user
{
    if (_user != user) {
        _user = user;
        _keyLabel.text = _user.itemKey;
        _valueField.text = _user.itemValue;
        _valueField.userInteractionEnabled = _user.isEditable;
    }
}


@end
