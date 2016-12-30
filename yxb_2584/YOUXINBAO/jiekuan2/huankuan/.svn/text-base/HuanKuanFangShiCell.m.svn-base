//
//  HuanKuanFangShiCell.m
//  YOUXINBAO
//
//  Created by Feili on 16/1/28.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "HuanKuanFangShiCell.h"
#import "YXBTool.h"

@interface HuanKuanFangShiCell ()
@property (nonatomic,strong)UISegmentedControl *segmentControl;
@property (nonatomic,strong)UILabel *fenqishuLabel;//分期数label
@end

@implementation HuanKuanFangShiCell

-(void)initViews
{
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    leftLabel.text = @"    还款方式";
//    leftLabel.backgroundColor = [UIColor brownColor];
    leftLabel.font = [UIFont systemFontOfSize:JieKuanBaseFontSize];
    CGSize size = [YXBTool getFontSizeWithString:leftLabel.text font:leftLabel.font constrainSize:CGSizeMake(NSIntegerMax, NSIntegerMax)];
    leftLabel.width = size.width;
//    leftLabel.textColor = kRGB(91, 91, 91);
    [self.contentView addSubview:leftLabel];
    
    UILabel *quaneLabel = [[UILabel alloc] initWithFrame:ccr(kDeviceWidth - 150,7,100,30)];
    quaneLabel.backgroundColor = [UIColor clearColor];
    quaneLabel.text = @"全额";
    quaneLabel.textAlignment = NSTextAlignmentRight;
    quaneLabel.font = [UIFont systemFontOfSize:14.0];
    quaneLabel.textColor = kRGB(91, 91, 91);
    [self.contentView addSubview:quaneLabel];
    [self initSegmentControl];
    
}

-(void)initSegmentControl
{
    self.segmentControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"全额",@"分期", nil]];
    _segmentControl.frame = CGRectMake(kDeviceWidth - 150,7,100,30);
    _segmentControl.selectedSegmentIndex = 0;
    _segmentControl.layer.cornerRadius = 5.0;
    _segmentControl.backgroundColor = [UIColor whiteColor];
    _segmentControl.tintColor = rgb(221, 39, 39, 1.0);
    _segmentControl.hidden = YES;
    [_segmentControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize: 14],NSFontAttributeName ,nil];
    
    [_segmentControl setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    [self.contentView addSubview:_segmentControl];
    //    [self.view sendSubviewToBack:_segmentControl];
    
    //    [self.view addSubview:_segmentControl];
    

    self.fenqishuLabel = [[UILabel alloc] initWithFrame:ccr(0,_segmentControl.bottom + 5, 0, 20)];
    _fenqishuLabel.font = [UIFont systemFontOfSize:14.0];
    //    _durationLabel.backgroundColor = [UIColor brownColor];
    _fenqishuLabel.text = @"借款到期全额还款";
//    _fenqishuLabel.hidden = YES;
    _fenqishuLabel.adjustsFontSizeToFitWidth = YES;
    _fenqishuLabel.minimumScaleFactor = 8.0/_fenqishuLabel.font.pointSize;
    _fenqishuLabel.textColor = kRGB(225, 39, 39);

    CGSize size = [YXBTool getFontSizeWithString:_fenqishuLabel.text font:_fenqishuLabel.font constrainSize:CGSizeMake(kDeviceWidth, kDeviceHeight)];
    _fenqishuLabel.width = size.width;
    _fenqishuLabel.right = kDeviceWidth - 50;
    [self.contentView addSubview:_fenqishuLabel];

}


//事件
-(void)segmentAction:(UISegmentedControl *)Seg
{
    NSInteger index = Seg.selectedSegmentIndex;
    YXBLoan *loan = [JieKuanInstance shareInstance].yxbLoan;
    NSInteger periods = [YXBTool getAmortizationNumWithEndDate:loan.backTime];

    if (periods <= 1) {
        self.fenqishuLabel.text = [NSString stringWithFormat:@"借款时长小于等于一个月,到期全额还款"];
        _segmentControl.selectedSegmentIndex = 0;
//        [ProgressHUD showErrorWithStatus:@"借款时长小于等于一个月,不支持分期"];
//        [self segmentAction:_segmentControl];

    }
    else
    {
        [self updateFenqishuLabel];
        
        if (index < 2) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(updateHuanKuanFangShi:)]) {
                [self.delegate updateHuanKuanFangShi:index];
            }
        }

    }
    
    
}

-(void)setLoan:(YXBLoan *)loan
{
    YXBRepayType repayType = [JieKuanInstance shareInstance].yxbLoan.repayType;
    NSInteger fenqishu = [YXBTool getAmortizationNumWithEndDate:loan.backTime];
    
    if (fenqishu > 1) {
        _segmentControl.hidden = NO;
        
    }
    else
    {
        _segmentControl.hidden = YES;
    }
    if (repayType == YXBRepayTypeFenQi) {
        _segmentControl.selectedSegmentIndex = 1;
        
    }else
    {
        _segmentControl.selectedSegmentIndex = 0;

    }
    
    [self updateFenqishuLabel];
    
}

-(void)updateFenqishuLabel
{
    YXBLoan *loan = [JieKuanInstance shareInstance].yxbLoan;
    NSInteger periods = [YXBTool getAmortizationNumWithEndDate:loan.backTime];

    if (loan.repayType == YXBRepayTypeQuanE) {
        
        if (periods <= 1) {
            self.fenqishuLabel.text = [NSString stringWithFormat:@"借款时长小于等于一个月,到期全额还款"];
            _segmentControl.selectedSegmentIndex = 0;
//            [ProgressHUD showErrorWithStatus:@"借款时长小于等于一个月,不支持分期"];
            [self segmentAction:_segmentControl];
            
        }
        else
        {
            _fenqishuLabel.text = @"借款到期全额还款";

        }
        


    }
    else
    {
//        self.fenqishuLabel.hidden = NO;
            self.fenqishuLabel.text = [NSString stringWithFormat:@"借款时长支持分%ld期",(long)periods];

    }
    
    CGSize size = [YXBTool getFontSizeWithString:_fenqishuLabel.text font:_fenqishuLabel.font constrainSize:CGSizeMake(kDeviceWidth, kDeviceHeight)];
    _fenqishuLabel.width = size.width;
    _fenqishuLabel.right = kDeviceWidth - 50;

    
}

-(void)layoutSubviews
{
//    [self updateFenqishuLabel];

    [super layoutSubviews];
}

@end
