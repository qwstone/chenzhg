//
//  LoanBottomCell.m
//  YOUXINBAO
//
//  Created by zjp on 15/6/23.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanBottomCell.h"
#import "UIImageView+WebCache.h"
#import "YXBTool.h"

#define selfKsWidth kDeviceWidth-20
#define selfKshight 33
@implementation LoanBottomCell{
    UIImageView         *_lvImg;
    UILabel             *_label;
    NSMutableAttributedString   *strLabel;

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _lvImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 18, 8.5, 10.5)];
        [self.contentView addSubview:_lvImg];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(38, 0,selfKsWidth-35 ,140/3)];
        _label.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_label];
    }
    
    
    return self;
}



- (void)setModel:(TLoanIndexPersonRank *)model {
    if (_model != model) {
        _model = model;
        [self setdata];
    }
}

- (void)setdata {
    if (self.model.state == 1) {
        _lvImg.image = [UIImage imageNamed:@"yjyh-upicon"];
    }else if (self.model.state == 2) {
        _lvImg.image = [UIImage imageNamed:@"yjyh-diamondicon"];
    }else if (self.model.state == 3) {
        _lvImg.image = [UIImage imageNamed:@"yjyh-jbicon"];
    }

    NSString *string = [NSString stringWithFormat:@"%@ %@",_model.name,_model.descrString];
    strLabel = [[NSMutableAttributedString alloc] initWithString:string];
    [strLabel addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#2ab3f3"]
                     range:[string rangeOfString:_model.name]];
    [strLabel addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#666565"]
                     range:[string rangeOfString:_model.descrString]];
    _label.attributedText = strLabel;
}
@end
