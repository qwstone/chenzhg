//
//  paydetailView.m
//  YOUXINBAO
//
//  Created by Feili on 15/9/15.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "PaydetailView.h"
#import "YXBTool.h"

@interface PaydetailView ()
{
    UILabel     *_timeLabelTop;//顶部还款时间
    UIButton    *_statusImageTop;//顶部标记状态的图片
    UIButton    *_detailBtn;// 小框图片
    UIImageView *_yuImageView;//逾期图片
    UIImageView *_daifuImageView;//代付图片
    UILabel     *_timeLabel;//逾期时间label
    UILabel     *_moneyLabel;//还款金额label
}
@end

@implementation PaydetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    
    return self;
}

-(void)initViews
{
    //添加顶部时间
    CGFloat x = 0, y = 10, w = self.width,h = 20;
    _timeLabelTop = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    _timeLabelTop.textColor = [YXBTool colorWithHexString:@"#909090"];
    _timeLabelTop.font = [UIFont systemFontOfSize:13];
    _timeLabelTop.text = @"";
    _timeLabelTop.adjustsFontSizeToFitWidth = YES;
    _timeLabelTop.minimumScaleFactor = 8.0/_timeLabelTop.font.pointSize;
    _timeLabelTop.textAlignment = NSTextAlignmentCenter;
    _timeLabelTop.backgroundColor = [UIColor clearColor];
    [self addSubview:_timeLabelTop];
        
    //添加顶部状态图片
    UIImage *statusImage = [UIImage imageNamed:@"danbxq-checked-icon.png"];
    y = _timeLabelTop.bottom + 6, w = statusImage.size.width,h = statusImage.size.height;
    x = (self.width - w)/2.0;
    _statusImageTop = [UIButton buttonWithType:UIButtonTypeCustom];
    _statusImageTop.frame = CGRectMake(x, y, w, h);
    _statusImageTop.userInteractionEnabled = NO;
    _statusImageTop.backgroundColor = [UIColor whiteColor];
    _statusImageTop.layer.cornerRadius = _statusImageTop.height/2.0;
    _statusImageTop.layer.borderWidth = 1.0;
    _statusImageTop.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _statusImageTop.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_statusImageTop setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    [_statusImageTop setTitle:@"ddddd" forState:UIControlStateNormal];
    [_statusImageTop setImage:statusImage forState:UIControlStateNormal];
    [self addSubview:_statusImageTop];
    
    //添加整个小框
    x = 0;
    y = _statusImageTop.bottom - 5;
    w = self.width;
    h = self.height - y;
    _detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _detailBtn.backgroundColor = [UIColor clearColor];
    _detailBtn.frame = CGRectMake(x, y, w, h);
    _detailBtn.userInteractionEnabled = NO;
   // [_detailBtn setImage:[UIImage imageNamed:@"timeboxbg.png"] forState:UIControlStateNormal];
//    _detailBtn.contentMode = UIViewContentModeTop;
    [_detailBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 40, 0)];
    [self addSubview:_detailBtn];
    
    //添加小框上面的控件
        //添加逾期按钮
//    UIImage *yuImage = [UIImage imageNamed:@"danbxq-yuq-icon2.png"];
//    y = 18,w = yuImage.size.width, h = yuImage.size.height;
//    _yuImageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
//    _yuImageView.image = yuImage;
//    [_detailBtn addSubview:_yuImageView];
    
        //添加代付图片
    UIImage *daifuImage = [UIImage imageNamed:@"danbxq-dai-icon.png"];
    x = self.width - daifuImage.size.width,w = daifuImage.size.width, h = daifuImage.size.height;
    
    _daifuImageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y + 10, w, h)];
    _daifuImageView.image = daifuImage;
    _daifuImageView.center = CGPointMake(_detailBtn.center.x, _daifuImageView.center.y);
    [_detailBtn addSubview:_daifuImageView];
    
        //添加逾期还款时间label
//    x = 0, y = _yuImageView.top, w = self.width,h = 20;
//    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
//    _timeLabel.textColor = [YXBTool colorWithHexString:@"#909090"];
//    _timeLabel.font = [UIFont systemFontOfSize:13];
//    _timeLabel.text = @"05.20";
//    _timeLabel.textAlignment = NSTextAlignmentCenter;
//    _timeLabel.backgroundColor = [UIColor clearColor];
//    [_detailBtn addSubview:_timeLabel];
    
        //添加虚线
//    x = 0, y = _timeLabel.bottom + 4, w = self.width,h = 1;
//    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
//    line.backgroundColor = [UIColor blackColor];
//    [_detailBtn addSubview:line];

    
    
        //添加还款金额label
    x = 0, y = 15, w = self.width,h = 30;
    _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
//    _moneyLabel.textColor = [YXBTool colorWithHexString:@"#909090"];
    _moneyLabel.textColor = [UIColor redColor];
    _moneyLabel.font = [UIFont systemFontOfSize:17];
    _moneyLabel.adjustsFontSizeToFitWidth = YES;
    _moneyLabel.minimumScaleFactor = 10.0/_moneyLabel.font.pointSize;
    _moneyLabel.text = @" 元";
    _moneyLabel.textAlignment = NSTextAlignmentCenter;
    _moneyLabel.backgroundColor = [UIColor clearColor];
    [_detailBtn addSubview:_moneyLabel];


    [self bringSubviewToFront:_statusImageTop];

}

-(void)setModel:(GuaranteeStages *)model
{
    if (_model != model) {
        
        _model = model;
        _timeLabelTop.text = _model.shouldPayTime;
        _timeLabel.text = _model.actualPayTime;
        NSString *str = [NSString stringWithFormat:@"%@",_model.payMoney];
//        NSMutableAttributedString *moneyStr = [[NSMutableAttributedString alloc] initWithString:str];
//        [moneyStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[str rangeOfString:_model.payMoney]];
//        [moneyStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0] range:NSMakeRange(str.length - 1, 1)];
        _moneyLabel.text = str;
        
        //逾期
        if ([_model.hasOverdue integerValue] == 0) {
            //_yuImageView.hidden = YES;
            [_detailBtn setImage:[UIImage imageNamed:@"timeboxbg-1.png"] forState:UIControlStateNormal];
            
        }
        else
        {
            //_yuImageView.hidden = NO;
            [_detailBtn setImage:[UIImage imageNamed:@"timeboxbg-yu.png"] forState:UIControlStateNormal];
        }
        
        //代付
        if ([_model.hasHelpPay integerValue] == 0) {
            _daifuImageView.hidden = YES;
        }
        else
        {
            _daifuImageView.hidden = NO;
        }
        
        if (_yuImageView.hidden && _daifuImageView.hidden) {
//            _moneyLabel.top = 18;
//            _moneyLabel.height = _detailBtn.height - _moneyLabel.top;
        }
        else
        {
//            _moneyLabel.top = 18 + _daifuImageView.height;
//            _moneyLabel.height = _detailBtn.height - _moneyLabel.top;
        }

        
    }
}

-(void)setIndex:(NSInteger)index
{
    _index = index;
    if ([_model.hasPayCompleted integerValue] == 0) {
        [_statusImageTop setImage:nil forState:UIControlStateNormal];
        [_statusImageTop setTitle:[NSString stringWithFormat:@"%ld",(long)index] forState:UIControlStateNormal];
    }
}

@end
