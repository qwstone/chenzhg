//
//  LoanOrRepayWhiteLineCell.m
//  YOUXINBAO
//
//  Created by CH10 on 15/5/4.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanOrRepayWhiteLineCell.h"

@implementation LoanOrRepayWhiteLineCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _userImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 50, 50)];
        _userImg.layer.cornerRadius = 25;
        _userImg.layer.masksToBounds = YES;
        [self.contentView addSubview:_userImg];
        
        _userName = [[UILabel alloc] initWithFrame:CGRectMake(_userImg.right+5, _userImg.top, 200, 20)];
        _userName.backgroundColor = [UIColor clearColor];
        _userName.font = [UIFont systemFontOfSize:15];
        _userName.textColor = [UIColor blackColor];
        [self.contentView addSubview:_userName];
        
        _date = [[UILabel alloc] initWithFrame:CGRectMake(_userImg.right+5, 0, 200, 20)];
        _date.bottom = _userImg.bottom;
        _date.backgroundColor = [UIColor clearColor];
        _date.font = [UIFont systemFontOfSize:13];
        _date.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_date];
        
        _money = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth-200-30, _userImg.top, 200, 20)];
        _money.textAlignment = NSTextAlignmentRight;
        _money.backgroundColor = [UIColor clearColor];
        _money.font = [UIFont systemFontOfSize:16];
        _money.textColor = [UIColor blackColor];
        [self.contentView addSubview:_money];
        
//        _borrower = [[UILabel alloc] initWithFrame:CGRectMake(110, 15, 130, 20)];
//        _borrower.backgroundColor = [UIColor clearColor];
//        _borrower.font = [UIFont systemFontOfSize:13];
//        _borrower.textColor = [UIColor lightGrayColor];
//        [self.contentView addSubview:_borrower];
        

        
        _typelabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth-200-30, 0, 200, 20)];
        _typelabel.bottom = _userImg.bottom;
        _typelabel.backgroundColor = [UIColor clearColor];
        _typelabel.textAlignment = NSTextAlignmentRight;
        _typelabel.font = [UIFont systemFontOfSize:13];
        _typelabel.textColor = rgb(52, 142, 250, 1);
        [self.contentView addSubview:_typelabel];
    }
    
    return self;
}

- (void)setModel:(BlankNoteData *)model {
    if (_model != model) {
        _model = model;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_userImg sd_setImageWithURL:[NSURL URLWithString:self.model.imgurl] placeholderImage:[UIImage imageNamed:@"register_photo.png"]];
    _userName.text = [NSString stringWithFormat:@"%@",self.model.nickName];
    _money.text = [NSString stringWithFormat:@"%@",[self countNumAndChangeformat:self.model.money]];
    
    _date.text = [NSString stringWithFormat:@"%@",self.model.time];
    
    if (self.model.state == 0) {
        _typelabel.text = [NSString stringWithFormat:@"审核中"];
    }else if (self.model.state == 100){
        _typelabel.text = [NSString stringWithFormat:@"审核中"];
    }else if (self.model.state == 200){
        _typelabel.text = [NSString stringWithFormat:@"电话确认"];
    }else if (self.model.state == 300){
        _typelabel.text = [NSString stringWithFormat:@"约见面签"];
    }else if (self.model.state == 400){
        _typelabel.text = [NSString stringWithFormat:@"借款到账"];
    }else if (self.model.state == 500){
        _typelabel.text = [NSString stringWithFormat:@"还款中"];
    }else if (self.model.state == 600){
        _typelabel.text = [NSString stringWithFormat:@"还款完成"];
    }
    
}

-(NSString *)countNumAndChangeformat:(NSString *)num{
    
//    NSRange range = [num rangeOfString:@"."];
//    NSString *str1 = [num substringFromIndex:range.location];
//    NSString *str = [num substringToIndex:range.location];
   
    //防止崩溃，统一转成integerValue类型
    NSMutableString *string = [NSMutableString stringWithString:[NSString stringWithFormat:@"%ld",(long)[num integerValue]]];
    NSMutableString *newstring = [NSMutableString stringWithString:[NSString stringWithFormat:@"%ld",(long)[num integerValue]]];
    int x = ([newstring length] % 3);
    int j = 0;
    for(int i =0; i < [newstring length]; i++)
    {
        if (i != 0) {
            
            if ((x == 0) & (i % 3 == 0)) {
                [string insertString:@"," atIndex:j];
                j++;
            }
            if ((x == 1) & (i % 3 == 1)) {
                [string insertString:@"," atIndex:j];
                j++;
            }
            if ((x == 2) & (i % 3 == 2)) {
                [string insertString:@"," atIndex:j];
                j++;
            }
        }
        j++;
    }
    return [NSString stringWithFormat:@"%@",string];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark -- 绘图
- (void)drawRect:(CGRect)rect {
    //虚线
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 0.6f);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGFloat lengths[] = {3,2};
    CGContextSetLineDash(context, 0, lengths,4);
    CGContextMoveToPoint(context, 0, 99.0);
    CGContextAddLineToPoint(context, kDeviceWidth,99.0);
    CGContextStrokePath(context);
    CGContextClosePath(context);
    
}
@end
