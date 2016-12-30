//
//  ZCTableViewOneCell.m
//  YOUXINBAO
//
//  Created by CH10 on 15/11/12.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "ZCTableViewOneCell.h"
#import "YXBTool.h"
#import "CustomProgressView.h"

@interface ZCTableViewOneCell ()
/**
 众筹状态
 */
@property (nonatomic,weak) UILabel *statusLabel;
/**
 进度条
 */
@property (nonatomic,weak) CustomProgressView *progressView;
/**
 结束时间
 */
@property (nonatomic,weak) UILabel *stopTimeLabel;
/**
 剩余资金
 */
@property (nonatomic,weak) UILabel *remainingMoneyLabel;
/**
 众筹金额
 */
@property (nonatomic,weak) UILabel *zcMoneyLabel;
/**
 收益率
 */
@property (nonatomic,weak) UILabel *earningPercentLabel;

/**
 期限
 */
@property (nonatomic,weak) UILabel *limitTimeLabel;
/**
 还款方式
 */
@property (nonatomic,weak) UILabel *repayTypeLabel;
/**
 还款时间
 */
@property (nonatomic,weak) UILabel *repayTimeLabel;
@end



@implementation ZCTableViewOneCell

-(void)setCrowfundModel:(CrowdfundingData *)crowfundModel{
    if (crowfundModel!=_crowfundModel) {
        _crowfundModel = crowfundModel;
        if (_crowfundModel) {
            
            CGFloat sumMoney = [_crowfundModel.sumMoney floatValue];
            CGFloat finishMoney = [_crowfundModel.finishMoney floatValue];
            CGFloat remainingMoney = sumMoney - finishMoney;
            self.progressView.progress = finishMoney/sumMoney;
            
            
            self.stopTimeLabel.text = self.crowfundModel.endTime;
            
            self.zcMoneyLabel.text = self.crowfundModel.sumMoney;
            
            self.remainingMoneyLabel.text = [NSString stringWithFormat:@"剩余%.0f元",remainingMoney];
            
            self.earningPercentLabel.text = self.crowfundModel.earningsMoney;
            
            self.limitTimeLabel.text = self.crowfundModel.deadline;
            
            self.repayTypeLabel.text = self.crowfundModel.modeOfRepayment;
            
            self.repayTimeLabel.text = self.crowfundModel.timeOfRepayment;
        }
    }
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if ([self.reuseIdentifier isEqualToString:@"FirstCellID"]) {
            [self createFirstCell];
        }else if ([self.reuseIdentifier isEqualToString:@"SecondCellID"]){
            [self createSecondCell];
        }
    }
    return self;
}
-(void)layoutSubviews{
    
    _statusLabel.text = @"进行中";
    _statusLabel.textColor = [UIColor redColor];
    _statusLabel.font = [UIFont systemFontOfSize:18];
    
//    _stopTimeLabel.text = @"2015-10-23 18:23:23结束";
    _stopTimeLabel.textAlignment = NSTextAlignmentRight;
    _stopTimeLabel.textColor = [YXBTool colorWithHexString:@"#919191"];
    _stopTimeLabel.font = [UIFont systemFontOfSize:11];
    
//    _progressView.progress = 0.4;
    
//    _remainingMoneyLabel.text = @"剩余3000元";
    _remainingMoneyLabel.textAlignment = NSTextAlignmentRight;
    _remainingMoneyLabel.font = [UIFont systemFontOfSize:13];
    
    _zcMoneyLabel.textColor = [YXBTool colorWithHexString:@"#EA431C"];
    _zcMoneyLabel.textAlignment = NSTextAlignmentCenter;
//    _zcMoneyLabel.text = @"5000";
    _zcMoneyLabel.font = [UIFont boldSystemFontOfSize:27];
    
    _earningPercentLabel.textColor = [YXBTool colorWithHexString:@"#EA431C"];
//    _earningPercentLabel.text = @"333.45";
    _earningPercentLabel.textAlignment = NSTextAlignmentCenter;
    _earningPercentLabel.font = [UIFont boldSystemFontOfSize:27];
}
-(void)createFirstCell{
    UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(45/2.0, 25/2.0, 60, 18)];
    _statusLabel = statusLabel;
    [self.contentView addSubview:_statusLabel];
    
    UILabel *stopTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth-200-15, 39.0/2, 200, 11)];
    _stopTimeLabel = stopTimeLabel;
    [self.contentView addSubview:_stopTimeLabel];
    
    CustomProgressView *progressView = [[CustomProgressView alloc] initWithFrame:CGRectMake(22.5, _stopTimeLabel.bottom+11, kDeviceWidth-45, 25/2.0)progressTintColor:[YXBTool colorWithHexString:@"#ea431c"] trackTintColor:[YXBTool colorWithHexString:@"#edebeb"]];
    _progressView = progressView;
    [self.contentView addSubview:_progressView];
    
    UILabel *remainingMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _progressView.bottom+(29/4.0), kDeviceWidth-45/2.0, 13)];
    _remainingMoneyLabel = remainingMoneyLabel;
    [self.contentView addSubview:_remainingMoneyLabel];
    
    UILabel *lineH = [[UILabel alloc] initWithFrame:CGRectMake(45/2.0, _progressView.bottom+55/2.0, kDeviceWidth-45, 1)];
    lineH.backgroundColor = [YXBTool colorWithHexString:@"#e1e1e1"];
    [self.contentView addSubview:lineH];
    
    UILabel *lineV = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2-0.5, lineH.bottom+21, 1, 84)];
    lineV.backgroundColor = [YXBTool colorWithHexString:@"#e1e1e1"];
    [self.contentView addSubview:lineV];
    
    UILabel *zcMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, lineH.bottom+55/2.0, kDeviceWidth/2-20, 74/2.0)];
    _zcMoneyLabel = zcMoneyLabel;
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, _zcMoneyLabel.bottom+10, kDeviceWidth/2-20, 20)];
    label1.text = @"众筹金额(元)";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont systemFontOfSize:14];
    label1.textColor = [YXBTool colorWithHexString:@"#282828"];
    [self.contentView addSubview:label1];
    [self.contentView addSubview:_zcMoneyLabel];
    
    UILabel *earningPercentLabel = [[UILabel alloc] initWithFrame:CGRectMake(lineV.right+10, lineH.bottom+55/2.0, kDeviceWidth/2-20, 74/2.0)];
    _earningPercentLabel = earningPercentLabel;
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(lineV.right+10, _zcMoneyLabel.bottom+10, kDeviceWidth/2-20, 20)];
    label2.text = @"预期年化(元)";
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont systemFontOfSize:14];
    label2.textColor = [YXBTool colorWithHexString:@"#282828"];
    [self.contentView addSubview:label2];
    [self.contentView addSubview:_earningPercentLabel];
}
-(void)createSecondCell{
    NSArray *textArray = @[@"期       限:",@"还款方式:",@"还款时间:"];
    for (int i = 0; i < 3; i ++) {
        UILabel *label = [self createLabelWithFrame:CGRectMake(46/2.0, 15+28*i, 80, 14) text:[textArray objectAtIndex:i] font:[UIFont systemFontOfSize:14] textColor:[YXBTool colorWithHexString:@"#909090"] backgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:label];
    }
    UILabel *limitTimeLabel = [self createLabelWithFrame:CGRectMake(100, 15, kDeviceWidth-10-100, 14) text:@"" font:[UIFont systemFontOfSize:14] textColor:[YXBTool colorWithHexString:@"#303030"] backgroundColor:[UIColor clearColor]];
    _limitTimeLabel = limitTimeLabel;
    UILabel *repayTypeLabel = [self createLabelWithFrame:CGRectMake(100, 15+28,kDeviceWidth-10-100, 14) text:@"" font:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backgroundColor:[UIColor clearColor]];
    _repayTypeLabel = repayTypeLabel;
    UILabel *repayTimeLabel = [self createLabelWithFrame:CGRectMake(100, 15+56,kDeviceWidth-10-100, 14) text:@"" font:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backgroundColor:[UIColor clearColor]];
    _repayTimeLabel = repayTimeLabel;
    [self.contentView addSubview:_limitTimeLabel];
    [self.contentView addSubview:_repayTimeLabel];
    [self.contentView addSubview:_repayTypeLabel];
}
-(UILabel *)createLabelWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.backgroundColor = backgroundColor;
    label.textColor = textColor;
    label.font = font;
    return label;
}
- (void)awakeFromNib {
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
