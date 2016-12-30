//
//  MingxiNewCell.m
//  YOUXINBAO
//
//  Created by zjp on 15/9/23.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "MingxiNewCell.h"
#import "YXBTool.h"
@implementation MingxiNewCell {
    UILabel *_riqi;
    UILabel *_money;
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _riqi = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth/2, 50)];
        _riqi.text = @"10.25";
        _riqi.textAlignment = NSTextAlignmentCenter;
        _riqi.font = [UIFont systemFontOfSize:17];
        _riqi.textColor = [YXBTool colorWithHexString:@"#808080"];
        [self.contentView addSubview:_riqi];
        
       _money = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2, 0, kDeviceWidth/2, 50)];
        _money.text = @"10.25";
         _money.textColor = [YXBTool colorWithHexString:@"#808080"];
        _money.textAlignment = NSTextAlignmentCenter;
        _money.font = [UIFont systemFontOfSize:17];
        [_money setAdjustsFontSizeToFitWidth:YES];
        [self.contentView addSubview:_money];

        
    }
    return self;
}

- (void)setModel:(ProfitListItemV2 *)model {
    if (_model != model) {
        _model = model;
        
        _riqi.text = _model.time;
        _money.text=[NSString stringWithFormat:@"%@元",self.model.money];
        NSRange range=[_money.text rangeOfString:[NSString stringWithFormat:@"%@",self.model.money]];
        NSMutableAttributedString *aText=[[NSMutableAttributedString alloc]initWithString:_money.text];
        [aText addAttribute:NSForegroundColorAttributeName value:rgb(237, 46, 36, 1) range:range];
        _money.attributedText=aText;
        
    
    }
}

@end
