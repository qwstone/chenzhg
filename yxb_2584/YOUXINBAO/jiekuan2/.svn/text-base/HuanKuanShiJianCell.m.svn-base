//
//  HuanKuanShiJianCell.m
//  YOUXINBAO
//
//  Created by Feili on 16/1/26.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "HuanKuanShiJianCell.h"
#import "AATimePickerView.h"
#import "JieKuanSquareView.h"
#import "YXBTool.h"

@interface HuanKuanShiJianCell ()<JieKuanSquareViewDelegate>
@property (nonatomic,strong)AATimePickerView *timePicker;
@property (nonatomic,strong)UIButton *btn;
@property (nonatomic,strong)JieKuanSquareView *squareView;
@property (nonatomic,strong)UILabel *durationLabel;//借款时长label
@property (nonatomic,strong)UIButton *riliBtn;
@end

@implementation HuanKuanShiJianCell

-(void)initViews
{
    self.backgroundColor = [UIColor clearColor];
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 80, 34)];
    timeLabel.text = @"还款时间";
    timeLabel.font = [UIFont systemFontOfSize:JieKuanBaseFontSize];
//    timeLabel.textColor = kRGB(91, 91, 91);
    [self.contentView addSubview:timeLabel];
    

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = ccr(kDeviceWidth - 200, 0, 120, 34);
    btn.titleLabel.font = [UIFont systemFontOfSize:JieKuanBaseFontSize];
//  btn.backgroundColor = [UIColor brownColor];
    [btn setTitle:@"请选择时间 " forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [btn setImage:[UIImage imageNamed:@"data-blue.png"] forState:UIControlStateNormal];
//    btn.transform = CGAffineTransformMakeScale(-1.0, 1.0);
//    btn.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
//    btn.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    self.btn = btn;
    [self.contentView addSubview:btn];
    
    UIButton *riliBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    riliBtn.frame = ccr(btn.right, btn.top, 40, btn.height);
    [riliBtn setImage:[UIImage imageNamed:@"data-gray.png"] forState:UIControlStateNormal];
    [riliBtn setImage:[UIImage imageNamed:@"data-blue.png"] forState:UIControlStateSelected];
    [riliBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:riliBtn];
    self.riliBtn = riliBtn;
    //时长
    
    self.durationLabel = [[UILabel alloc] initWithFrame:ccr(0, btn.bottom, 0, 12)];
    _durationLabel.font = [UIFont systemFontOfSize:12.0];
//    _durationLabel.backgroundColor = [UIColor brownColor];
    _durationLabel.text = @"借款时长--天";
    _durationLabel.hidden = YES;
    CGSize size = [YXBTool getFontSizeWithString:_durationLabel.text font:_durationLabel.font constrainSize:CGSizeMake(kDeviceWidth, kDeviceHeight)];
    _durationLabel.width = size.width;
    _durationLabel.right = kDeviceWidth - 50;
    _durationLabel.height = 0;
    [self.contentView addSubview:_durationLabel];
    
    [self createTimerPickerView];
    
    
    //添加时间快速选择框
    
//    NSString *stringNameSelected = @"timesquareS";
//    UIImage *sizeImage =[UIImage imageNamed:stringNameSelected];
//    NSInteger space = 30;
//    CGFloat imageWidth = ((kDeviceWidth - 60) - (2 * space))/3.0;
//    CGFloat h = [YXBTool heightWithSize:sizeImage.size width:imageWidth];
//    CGFloat squareViewHeight = 2 * 10 + 2 * h + 15;
    
    self.squareView = [[JieKuanSquareView alloc] initWithFrame:ccr(20, _durationLabel.bottom, kDeviceWidth - 30 - 40, [YXBTool getSquareHeight])];
    _squareView.backgroundColor = [UIColor clearColor];
    _squareView.delegate = self;
    [self.contentView addSubview:_squareView];

}

-(void)btnAction:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(jiekuanEndEdit)]) {
        [self.delegate jiekuanEndEdit];

    }
    if (![self.delegate isMoneyCellEdit]) {
        [self.squareView setAllUnSelected];
        [self createTimerPickerView];
        [_timePicker showPickerView];

    }
    
}

-(void)createTimerPickerView
{
    if (_timePicker == nil || _timePicker.superview == nil) {
        self.timePicker = [[AATimePickerView alloc] initWithFrame:CGRectMake(0, kDeviceHeight, kDeviceWidth, kTimeCustomHeight+20)withHour:NO];
        
        UIWindow *mWindow = [[[UIApplication sharedApplication] delegate] window];
        if (!mWindow.isKeyWindow) {
            [mWindow makeKeyAndVisible];
            
        }
        
        __weak typeof(self) weakSelf = self;
        _timePicker.selectedBlock= ^ (NSInteger year, NSInteger month, NSInteger day, NSInteger hour, NSInteger minIndex, AATimePickerView *timePickerView) {
            
            NSString *date = [NSString stringWithFormat:@"%ld-%02ld-%02ld",(long)year,(long)month,(long)day];

            NSInteger days = [YXBTool daysBetweenTwoDaysWithEndDayStr:date];
            NSInteger yearD = [YXBTool yearBetweenTwoDateFromNowTo:date];
            
            
            if (days > 1 && yearD <= [YXBJieKuanMaxYear integerValue])
            {
                [weakSelf.riliBtn setSelected:YES];
                [weakSelf showDurationLabel:YES];
                [weakSelf.btn setTitle:date forState:UIControlStateNormal];
                //            weakSelf.durationLabel.text = [@([YXBTool daysBetweenTwoDaysWithEndDayStr:date]) stringValue];
                [weakSelf updateDurationLabelWithDate:date];
                if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(updateHuanKuanShiJian:)]) {
                    [weakSelf.delegate updateHuanKuanShiJian:date];
                }

            }
            else
            {

                if (days <= 1) {
                    [ProgressHUD showSuccessWithStatus:@"请选择大于当前日的日期"];

                }else if(yearD > [YXBJieKuanMaxYear integerValue])
                {
                    [ProgressHUD showSuccessWithStatus:@"请选择两年以内的日期"];

                }
                else
                {
                    [ProgressHUD showSuccessWithStatus:@"借款时长有误，请重新选择"];

                }
            }
            
        };
        
        [mWindow addSubview:_timePicker];
        

    }
}


-(void)squareViewSelectedDate:(NSString *)date
{
//    [self showDurationLabel:YES];
    [self.riliBtn setSelected:YES];

    [self.btn setTitle:[NSString stringWithFormat:@"%@",date] forState:UIControlStateNormal];
    [self updateDurationLabelWithDate:date];

    if (self.delegate && [self.delegate respondsToSelector:@selector(updateHuanKuanShiJian:)]) {
        [self.delegate updateHuanKuanShiJian:date];
    }

}

-(void)updateDurationLabelWithDate:(NSString *)date
{
    NSInteger days = [YXBTool daysBetweenTwoDaysWithEndDayStr:date];
    self.durationLabel.text = [NSString stringWithFormat:@"借款时长%ld天",(long)days];
    CGSize size = [YXBTool getFontSizeWithString:_durationLabel.text font:_durationLabel.font constrainSize:CGSizeMake(kDeviceWidth, kDeviceHeight)];
    _durationLabel.width = size.width;
    _durationLabel.right = kDeviceWidth - 50;

}

-(void)showDurationLabel:(BOOL)isShow
{
    if (isShow) {
    }
}

-(void)dealloc
{
    if (_timePicker != nil) {
        [_timePicker removeFromSuperview];

    }
}

-(void)setLoan:(YXBLoan *)loan
{
    if (loan != nil && loan.backTime != nil) {
        [self.btn setTitle:loan.backTime forState:UIControlStateNormal];
        [self updateDurationLabelWithDate:loan.backTime];

        [UIView animateWithDuration:0.2 animations:^{
            
            NSInteger durationHeight = 0;
            if ([loan.duration integerValue] > 0) {
                _durationLabel.hidden = NO;
                durationHeight = 12;
            }
            else
            {
                _durationLabel.hidden = YES;
                
            }
            
            _durationLabel.height = durationHeight;
            _squareView.top = _durationLabel.bottom;

        }];
        

        

    }

    
}


@end
