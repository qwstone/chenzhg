//
//  ConfirmationPaymentCell.m
//  YOUXINBAO
//
//  Created by zjp on 15/6/2.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "ConfirmationPaymentCell.h"

@implementation ConfirmationPaymentCell {
    UILabel         *_userName;
    UILabel         *_phoneNumber;
    UILabel         *_address;
}

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 75, 30)];
        label1.text = @"收  货  人:";
        label1.font = [UIFont systemFontOfSize:15];
        label1.textColor = [YXBTool colorWithHexString:@"#303030"];
        [self.contentView addSubview:label1];
        _userName = [[UILabel alloc] initWithFrame:CGRectMake(label1.right, label1.top, kDeviceWidth-20, 30)];
        _userName.textAlignment = NSTextAlignmentLeft;
        _userName.font = [UIFont systemFontOfSize:15];
        _userName.textColor = [YXBTool colorWithHexString:@"#000000"];
        [self.contentView addSubview:_userName];

        _phoneNumber = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kDeviceWidth-20, 30)];
        _phoneNumber.textAlignment = NSTextAlignmentRight;
        _phoneNumber.font = [UIFont systemFontOfSize:15];
        _phoneNumber.textColor = [YXBTool colorWithHexString:@"#000000"];
        [self.contentView addSubview:_phoneNumber];
        
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 75, 18)];
        label2.text = @"收货地址：";
        label2.font = [UIFont systemFontOfSize:15];
        label2.textColor = [YXBTool colorWithHexString:@"#303030"];
        [self.contentView addSubview:label2];
        _address = [[UILabel alloc] initWithFrame:CGRectZero];
        _address.textAlignment = NSTextAlignmentLeft;
        _address.numberOfLines = 0;
        _address.font = [UIFont systemFontOfSize:15];
        _address.textColor = [YXBTool colorWithHexString:@"#000000"];
        [self.contentView addSubview:_address];
    }
    return self;
}

- (void)createData {

}

- (void)layoutSubviews {
    [super layoutSubviews];
    _userName.text = [NSString stringWithFormat:@"%@",self.model.name];
    _phoneNumber.text = self.model.mobile;
    _address.text = [NSString stringWithFormat:@"%@",self.model.adress];
    _address.frame = CGRectMake(85,40, kDeviceWidth-10-85, [YXBTool countLabelHeightWithText:_address.text font:[UIFont systemFontOfSize:15] labelWidth:kDeviceWidth-10-85]);
}

- (void)setModel:(OrderDownPayment *)model {
    if (_model != model) {
        _model = model;
        [self setNeedsLayout];
    }
}
@end
