//
//  OrderDetailPayCell.m
//  YOUXINBAO
//
//  Created by Feili on 15/9/16.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "OrderDetailPayCell.h"
#import "YXBTool.h"
#import "PayScrollView.h"

@interface OrderDetailPayCell ()
{
   // UILabel *payLabel;//还款详情字符串
    PayScrollView *detailView;//还款详情 框
}
@end

@implementation OrderDetailPayCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

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
    
    //还款详情
    CGFloat x = 0, y = 0, w = kDeviceWidth;
   // CGFloat h = 45;
    
    /*
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
//    topLabel.textColor = [YXBTool colorWithHexString:@"#909090"];
    topLabel.font = [UIFont systemFontOfSize:17];
    topLabel.text = @"    还款详情";
    topLabel.textColor=rgb(22, 22, 22, 1);
    topLabel.textAlignment = NSTextAlignmentLeft;
    topLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:topLabel];
    
    //添加横线
    y = topLabel.bottom,h = 1;
    UILabel *firstLine = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    firstLine.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:firstLine];
    
    //已还、待还
    x = 0, y = firstLine.bottom, w = kDeviceWidth, h = 45;
    payLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    payLabel.textColor = [YXBTool colorWithHexString:@"#909090"];
    payLabel.font = [UIFont systemFontOfSize:14];
    payLabel.text = @"已还3期，共510元、待还三期共510元";
    payLabel.textAlignment = NSTextAlignmentCenter;
    payLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:payLabel];
    
    //添加横线
    y = payLabel.bottom,h = 1;
    UILabel *secondLine = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    secondLine.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:secondLine];
    */
    
    //添加还款详情
  //  x = 0,y = secondLine.bottom, w = kDeviceWidth, h = 140;

    detailView = [[PayScrollView alloc] initWithFrame:CGRectMake(x, y, w, 140)];
    [self.contentView addSubview:detailView];
    

}

-(void)setModel:(CommerceDetailV2 *)model
{
    if (_model != model) {
        _model = model;
        /*
        NSString *str1 = [NSString stringWithFormat:@"已还%@期共%@元，待还%@期,共%@元",_model.alreadyPayIssue,_model.alreadyPayMoney,_model.willPayIssue,_model.willPayMoney];
        NSMutableAttributedString *aText=[[NSMutableAttributedString alloc]initWithString:str1];
        [aText addAttribute:NSForegroundColorAttributeName value:rgb(255, 132, 0, 1) range:NSMakeRange(2,self.model.alreadyPayIssue.length)];
        [aText addAttribute:NSForegroundColorAttributeName value:rgb(217, 30, 61, 1) range:NSMakeRange(4+self.model.alreadyPayIssue.length,self.model.alreadyPayMoney.length)];
        [aText addAttribute:NSForegroundColorAttributeName value:rgb(255, 132, 0, 1) range:NSMakeRange(self.model.alreadyPayIssue.length+self.model.alreadyPayMoney.length+8,self.model.willPayIssue.length)];
        [aText addAttribute:NSForegroundColorAttributeName value:rgb(217, 30, 61, 1) range:NSMakeRange(self.model.alreadyPayIssue.length+self.model.alreadyPayMoney.length+self.model.willPayIssue.length+11,self.model.willPayMoney.length)];
        payLabel.attributedText=aText;
         */
        
        detailView.modelArray = _model.guaranteeStages;
        detailView.startYear = _model.startYear;
    }
}

@end
