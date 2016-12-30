//
//  TuhaoLoanSetTableViewCell.m
//  YOUXINBAO
//
//  Created by zjp on 15/4/30.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "TuhaoLoanSetTableViewCell.h"

@implementation TuhaoLoanSetTableViewCell {
    
    UILabel *time;
    UILabel *nickName;
//    UILabel *wayAndTime;
    UIImageView *state;
}

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
        time = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth/3.5, kDeviceWidth/640*75)];
        time.textAlignment = NSTextAlignmentCenter;
        time.font = [UIFont systemFontOfSize:12];
        time.textColor = [UIColor lightGrayColor];
        time.text = @"2015.6.6";
        [self.contentView addSubview:time];
        nickName = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/3.5, 0, kDeviceWidth/3.5*1.5, kDeviceWidth/640*75)];
        nickName.textAlignment = NSTextAlignmentCenter;
        nickName.font = [UIFont systemFontOfSize:13];
        nickName.textColor = [UIColor blackColor];
        nickName.text = @"情峰";
        [nickName setAdjustsFontSizeToFitWidth:YES];
        [self.contentView addSubview:nickName];

        state = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/3.5*2.5+(kDeviceWidth/3.5-kDeviceWidth/5)/2,kDeviceWidth/640*75/4, kDeviceWidth/5, kDeviceWidth/640*75/2)];
        [self.contentView addSubview:state];
    }
    
    return self;
}

- (void)setModel:(NoteSummary *)Model {
    if (_Model != Model) {
        _Model = Model;
        [self createData];
    }
}

//- (void)setRepaymentMonth:(NSInteger)repaymentMonth {
//    if (_repaymentMonth != repaymentMonth) {
//        _repaymentMonth = repaymentMonth;
//        [self createData];
//    }
//}
//- (void)setRepaymentType:(NSInteger)repaymentType {
//    if (_repaymentType != repaymentType) {
//        _repaymentType = repaymentType;
//        [self createData];
//    }
//}

- (void)createData {
    time.text = self.Model.time;
    nickName.text = self.Model.debtorName;
    NSString *str = nil;
    if (self.repaymentType == 0) {
        str = @"全额";
    }else if (self.repaymentType == 1){
        str = @"分期";
    }
    
//    wayAndTime.text = [NSString stringWithFormat:@"%@%ld个月",str,(long)self.repaymentMonth];
    
    if (self.Model.state <= 300){
        state.image = [UIImage imageNamed:@"shenheing-icon"];
    }else if (self.Model.state <= 400 && self.Model.state > 300){
        state.image = [UIImage imageNamed:@"dakuaning-icon"];
    }else if (self.Model.state <= 500 && self.Model.state > 400){
        state.image = [UIImage imageNamed:@"huankuaning-icon"];
    }else if (self.Model.state <= 600 && self.Model.state > 500){
        state.image = [UIImage imageNamed:@"huankuaned-icon"];
    }
}
@end
