//
//  BaoDynamicCell.m
//  YOUXINBAO
//
//  Created by zjp on 15/6/30.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "BaoDynamicCell.h"
#import "YXBTool.h"
#import "LineView.h"
@implementation BaoDynamicCell{
    UILabel             *_labelName;
    UILabel             *_labelMassage;
    NSMutableAttributedString   *strLabel;
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        LineView *line = [[LineView alloc] initWithFrame:CGRectMake(12.5, 0, kDeviceWidth-50.0f, 1)];
        line.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:line];
        
        _labelName = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 80, 35)];
        _labelName.text = @"风一样的**";
        _labelMassage.font = [UIFont systemFontOfSize:14];
        _labelName.textColor = [YXBTool colorWithHexString:@"0ba7f2"];
        [self.contentView addSubview:_labelName];
        
        _labelMassage = [[UILabel alloc] initWithFrame:CGRectMake(_labelName.right, 0,kDeviceWidth-_labelName.right-30 , 35)];
        _labelMassage.text = @"收到红包999999999元";
        _labelMassage.textColor = [YXBTool colorWithHexString:@"a0a0a0"];
        _labelMassage.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_labelMassage];
    }
    return self;
}


- (void)setModel:(ProfitBannerData *)model {
    if (_model != model) {
        _model = model;
        [self setData];
    }
}



- (void)setData {
    _labelName.text = self.model.name;

    
    NSString *string = [NSString stringWithFormat:@"%@%@%@",_model.str1,_model.money,_model.metric];
    strLabel = [[NSMutableAttributedString alloc] initWithString:string];
    [strLabel addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#a0a0a0"]
                     range:[string rangeOfString:_model.str1]];
    [strLabel addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#fd6138"]
                     range:[string rangeOfString:_model.money]];
    [strLabel addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#a0a0a0"]
                     range:[string rangeOfString:_model.metric]];
    _labelMassage.attributedText = strLabel;
}

@end
