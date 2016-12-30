//
//  QCLoanCell.m
//  YOUXINBAO
//
//  Created by CH10 on 15/4/11.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCLoanCell.h"
#import "UIImageView+WebCache.h"

@implementation QCLoanCell {
    UIImageView *_portrait;
    UILabel *_name;
    UILabel *_money;
    UILabel *_date;
    
    UILabel *_type;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        _portrait = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 40, 40)];
        _portrait.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_portrait];
        
        _name = [[UILabel alloc] initWithFrame:CGRectMake(30, 53, 70, 17)];
        _name.font = [UIFont systemFontOfSize:13];
        _name.text = @"阿拉蕾";
        _name.textAlignment = NSTextAlignmentCenter;
        _name.backgroundColor = [UIColor clearColor];
        _name.textColor = [UIColor blackColor];
        [self.contentView addSubview:_name];
        
        _money = [[UILabel alloc] initWithFrame:CGRectMake(125, 10, 125, 30)];
        _money.font = [UIFont systemFontOfSize:20];
        _money.text = @"￥5000";
        _money.backgroundColor = [UIColor clearColor];
        _money.textColor = [UIColor blackColor];
        [self.contentView addSubview:_money];

        _date = [[UILabel alloc] initWithFrame:CGRectMake(125, 45, 125, 20)];
        _date.font = [UIFont systemFontOfSize:13];
        _date.text = @"2015-03-04";
        _date.backgroundColor = [UIColor clearColor];
        _date.textColor = [UIColor blackColor];
        [self.contentView addSubview:_date];
        
        _type = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth-70, 25, 70, 25)];
        _type.font = [UIFont systemFontOfSize:17];
        _type.text = @"生效";
        _type.backgroundColor = [UIColor clearColor];
        _type.textColor = [UIColor redColor];
        [self.contentView addSubview:_type];
    }
    
    return self;
}

- (void)setLoanBrief:(TLoanCenterBrief *)loanBrief {
    _loanBrief = loanBrief;
    
    [_portrait setImageWithURL:[NSURL URLWithString:loanBrief.friendIconAddr]];
    _name.text = loanBrief.friendRealname;
    _money.text = [NSString stringWithFormat:@"￥%@",loanBrief.money];
    _date.text = loanBrief.realBorrowDate;
    if (loanBrief.status == 0) {
        _type.text = @"失效";
        _type.textColor = [UIColor redColor];
    }else {
        _type.text = @"生效";
        _type.textColor = [UIColor greenColor];
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
