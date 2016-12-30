//
//  InvestDetailUpView.m
//  YOUXINBAO
//
//  Created by pro on 16/7/27.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#define pi 3.14159265359
#define   DEGREES_TO_RADIANS(degrees)  ((pi * degrees)/ 180)

#define START_ANGLE     40
#define END_ANGLE       140

#import "InvestDetailUpView.h"
#import "ZFProgressView.h"
@interface InvestDetailUpView ()

@property (assign, nonatomic) CGPoint origin;//圆环的原点
@property (assign, nonatomic) CGFloat Line_Y;//下边直线的y坐标

@property (nonatomic, strong)UIImageView *noteBgImgV;
@property (nonatomic, strong) UILabel* Note;//右上角注释
@property (nonatomic, strong) UILabel* annualizedReturn;//年收益率
@property (nonatomic, strong) UILabel* minimumMoney;//起投金额
@property (nonatomic, strong) UILabel* surplusMoney;//剩余可投金额

@end

@implementation InvestDetailUpView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self initView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


//绘制圆弧和直线
-(void)drawRect:(CGRect)rect
{
    //圆环
    [self initView];
    
    //绘制圆弧和直线
    UIColor *color = [YXBTool colorWithHexString:@"#aaaaaa"];
    [color set]; //设置线条颜色
    UIBezierPath * aPath = [[UIBezierPath alloc] init];

    //计算出圆弧的起始坐标
    double a = kDeviceWidth/750*130*sin(DEGREES_TO_RADIANS(START_ANGLE));
    double b = kDeviceWidth/750*130*cos(DEGREES_TO_RADIANS(START_ANGLE));
    
    //下方直线的Y坐标
    _Line_Y = _origin.y + a +kDeviceWidth/750*12;
    
    //绘制直线
    [aPath moveToPoint:CGPointMake(kDeviceWidth, _Line_Y)];
    [aPath addLineToPoint:CGPointMake(_origin.x + b + kDeviceWidth/750*20, _Line_Y)];
    //绘制圆弧
    [aPath addArcWithCenter:CGPointMake(_origin.x, _origin.y)
                     radius:kDeviceWidth/750*150
                 startAngle:DEGREES_TO_RADIANS(START_ANGLE)
                   endAngle:DEGREES_TO_RADIANS(END_ANGLE)
                  clockwise:YES];
    //绘制直线
    [aPath addLineToPoint:CGPointMake(0, _Line_Y)];
    
    aPath.lineWidth = 1.0;
    aPath.lineCapStyle = kCGLineCapRound; //线条拐角
    aPath.lineJoinStyle = kCGLineCapRound; //终点处理
    [aPath stroke];
    
    //加载底部Lable
    [self initLabel];
}




-(void)initView
{
    //环形图
    ZFProgressView * probabilityView = [[ZFProgressView alloc] initWithFrame:CGRectMake((kDeviceWidth-kDeviceWidth/750*260)/2, kDeviceWidth/750*40, kDeviceWidth/750*260, kDeviceWidth/750*260)];
    //取出原点坐标
    _origin = probabilityView.center;
    probabilityView.progressLineWidth = 9;
    probabilityView.backgourndLineWidth = 9;
    probabilityView.progressStrokeColor = [YXBTool colorWithHexString:@"#fd6138"];
    probabilityView.backgroundStrokeColor = [YXBTool colorWithHexString:@"#d4d4d4"];
    probabilityView.digitTintColor  = [YXBTool colorWithHexString:@"#323232"];
    __weak ZFProgressView *weakProbabilityView = probabilityView;
    
    [probabilityView setAnimateCompletationBlock:^{
        [weakProbabilityView setProgressLabelText:[NSString stringWithFormat:@"融资%@万",_model.sumMoney]];
    }];
    
    [probabilityView setProgress:[_model.percentage floatValue]/100.0 Animated:YES];
    
    
    [self addSubview:probabilityView];
    
    //右上角注释
    UIImage *noteImg = [UIImage imageNamed:@"yiTou"];
    
    self.noteBgImgV = [[UIImageView alloc] initWithFrame:CGRectMake(_origin.x + kDeviceWidth/750*100+3, kDeviceWidth/750*70, kDeviceWidth/750*150, kDeviceWidth/750*54)];
    self.noteBgImgV.image = noteImg;
    [self addSubview:_noteBgImgV];
    
    self.Note = [[UILabel alloc] initWithFrame:CGRectMake(3, 0, kDeviceWidth/750*150, kDeviceWidth/750*54)];
    NSString * NoteStr = [NSString stringWithFormat:@"已投:%.0f%%",[_model.percentage floatValue]];
    _Note.text = NoteStr;
    _Note.font = [UIFont boldSystemFontOfSize:kDeviceWidth/750*23];
    _Note.textAlignment = NSTextAlignmentCenter;
    _Note.textColor = [UIColor whiteColor];
    [self.noteBgImgV addSubview:_Note];
}



-(void)initLabel
{
    //年化益率
    self.annualizedReturn = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/750*30, _Line_Y+kDeviceWidth/750*15, kDeviceWidth/750*200, kDeviceWidth/750*50)];
    _annualizedReturn.textColor = [YXBTool colorWithHexString:@"#FF6600"];
//    _annualizedReturn.backgroundColor = [UIColor greenColor];
    _annualizedReturn.font = [UIFont fontWithName:@"ArialMT" size:kDeviceWidth/750*42];
    _annualizedReturn.textAlignment = NSTextAlignmentCenter;
    _annualizedReturn.attributedText = [self SetLabelttributedString:_model.annualizedReturn andUnit:@"%"];
    [self addSubview:_annualizedReturn];
    
    UILabel * nianhuayilv = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/750*30, _annualizedReturn.bottom + 3, kDeviceWidth/750*200, kDeviceWidth/750*32)];
//    nianhuayilv.backgroundColor = [UIColor orangeColor];
    nianhuayilv.textAlignment = NSTextAlignmentCenter;
    nianhuayilv.textColor = [YXBTool colorWithHexString:@"#787878"];
    nianhuayilv.text = @"预期年化";
    nianhuayilv.font = [UIFont systemFontOfSize:kDeviceWidth/750*22];
    [self addSubview:nianhuayilv];
    
    //起投金额
    self.minimumMoney = [[UILabel alloc] initWithFrame:CGRectMake(_origin.x - kDeviceWidth/750*100, _origin.y + kDeviceWidth/750*150 + kDeviceWidth/750*15, kDeviceWidth/750*200, kDeviceWidth/750*50)];
    _minimumMoney.textColor = [YXBTool colorWithHexString:@"#333333"];
    _minimumMoney.font = [UIFont fontWithName:@"ArialMT" size:kDeviceWidth/750*36];
    _minimumMoney.textAlignment = NSTextAlignmentCenter;
    _minimumMoney.attributedText = [self SetLabelttributedString:_model.minimumMoney andUnit:@"元"];
    [self addSubview:_minimumMoney];
    
    UILabel * minimumTitle = [[UILabel alloc] initWithFrame:CGRectMake(_origin.x - kDeviceWidth/750*110, _minimumMoney.bottom + 3, kDeviceWidth/750*220, kDeviceWidth/750*32)];
    minimumTitle.textAlignment = NSTextAlignmentCenter;
    minimumTitle.textColor = [YXBTool colorWithHexString:@"#787878"];
    minimumTitle.text = @"起投金额";
    minimumTitle.font = [UIFont systemFontOfSize:kDeviceWidth/750*22];
    [self addSubview:minimumTitle];

    //剩余可投
    self.surplusMoney = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth - kDeviceWidth/750*30 - kDeviceWidth/750*200, _Line_Y+kDeviceWidth/750*15, kDeviceWidth/750*200, kDeviceWidth/750*50)];
    _surplusMoney.textColor = [YXBTool colorWithHexString:@"#333333"];
    _surplusMoney.font = [UIFont fontWithName:@"ArialMT" size:kDeviceWidth/750*42];
    _surplusMoney.textAlignment = NSTextAlignmentCenter;
    _surplusMoney.attributedText = [self SetLabelttributedString:_model.surplusMoney andUnit:@"万"];
    [self addSubview:_surplusMoney];
    
    UILabel * surplusTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth - kDeviceWidth/750*30 - kDeviceWidth/750*200, _annualizedReturn.bottom + 3, kDeviceWidth/750*200, kDeviceWidth/750*32)];
    surplusTitle.textAlignment = NSTextAlignmentCenter;
    surplusTitle.textColor = [YXBTool colorWithHexString:@"#787878"];
    surplusTitle.text = @"剩余可投";

    surplusTitle.font = [UIFont systemFontOfSize:kDeviceWidth/750*22];
    [self addSubview:surplusTitle];
}





//设置单位
- (NSMutableAttributedString *)SetLabelttributedString:(NSString *)Labelstr andUnit:(NSString *)unit
{
    NSMutableString * str = [[NSMutableString alloc] initWithString:Labelstr];
    [str appendString:unit];
    
    
    NSMutableAttributedString* attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
    //设置单位颜色
    NSRange  range = NSMakeRange(str.length-1, 1);
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:range];
    //设置单位大小
    [attributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"ArialMT" size:12] range:range];
    
    return attributedStr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
