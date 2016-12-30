//
//  ZFProgressView.m
//  ZFProgressView
//
//  Created by macOne on 15/9/23.
//  Copyright © 2015年 WZF. All rights reserved.
//

#import "ZFProgressView.h"
#define degressToRadius(ang) (M_PI*(ang)/180.0f) //把角度转换成PI的方式
#define PROGRESS_WIDTH 80 // 圆直径
#define PROGRESS_LINE_WIDTH 4 //弧线的宽度
#define RYUIColorWithRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define DefaultLineWidth 3

@interface ZFProgressView ()

@property (nonatomic,strong) CAShapeLayer *backgroundLayer;
@property (nonatomic,strong) CAShapeLayer *progressLayer;
@property (nonatomic,strong) CALayer *imageLayer;
@property (nonatomic,strong) UILabel *progressLabel;
//@property (nonatomic, strong) UILabel *gaiLvTextLb;
@property (nonatomic,assign) CGFloat sumSteps;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) ZFProgressViewStyle style;


@end

@implementation ZFProgressView
//默认样式 none
-(instancetype) initWithFrame:(CGRect)frame
{
   return [self initWithFrame:frame style:ZFProgressViewStyleNone];
    
}
- (instancetype) initWithFrame:(CGRect)frame style:(ZFProgressViewStyle)style
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.style = style;
        [self layoutViews:style];

        //init default variable
        self.GapWidth = 10.0;
        if (ZFProgressViewStyleImageSegment == style) {
            self.backgourndLineWidth = 3;
            self.progressLineWidth = 3;
        }
        else{
            self.backgourndLineWidth = DefaultLineWidth;
            self.progressLineWidth = DefaultLineWidth;
        }

        self.Percentage = 0;
        self.offset = 2;
        self.sumSteps = 0;
        self.step = 0.1;
        self.timeDuration = 2.0;
        self.displayHasFinished = NO;
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame style:(ZFProgressViewStyle)style withImage:(UIImage *)image
{
    self.image = (style == ZFProgressViewStyleImageSegment) ? image :nil;
    return [self initWithFrame:frame style:style];
}

-(void) layoutViews:(ZFProgressViewStyle)style
{
    [self.progressLabel setTextColor:[UIColor whiteColor]];
    self.progressLabel.text = @"0%";
    self.progressLabel.textAlignment = NSTextAlignmentCenter;
    self.progressLabel.font = [UIFont systemFontOfSize:self.bounds.size.height/4];
    [self addSubview:self.progressLabel];
    self.progressLabel.adjustsFontSizeToFitWidth = YES;
    if (!_backgroundLayer) {
        _backgroundLayer = [CAShapeLayer layer];
        _backgroundLayer.frame = self.bounds;
        _backgroundLayer.fillColor = nil;
        _backgroundLayer.strokeColor = [UIColor brownColor].CGColor;
    }

    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.frame = self.bounds;
        _progressLayer.fillColor = nil;
        _progressLayer.strokeColor = [UIColor whiteColor].CGColor;
    }

    
//    switch (style) {
//        case ZFProgressViewStyleNone:
//        case ZFProgressViewStyleSquareSegment:
//            _backgroundLayer.lineCap = kCALineCapSquare;
//            _backgroundLayer.lineJoin = kCALineCapSquare;
//            
//            _progressLayer.lineCap = kCALineCapSquare;
//            _progressLayer.lineJoin = kCALineCapSquare;
//            
//            [_imageLayer removeFromSuperlayer];
//            _imageLayer = nil;
//            break;
            
//        case ZFProgressViewStyleRoundSegment:
//            _backgroundLayer.lineCap = kCALineCapRound;
//            _backgroundLayer.lineJoin = kCALineCapRound;
//            
//            _progressLayer.lineCap = kCALineCapRound;
//            _progressLayer.lineJoin = kCALineCapRound;
//            [_imageLayer removeFromSuperlayer];
//            _imageLayer = nil;
//            break;
//         case ZFProgressViewStyleImageSegment:
//            
//            [_progressLabel removeFromSuperview];
//            _progressLabel = nil;
//            
//            _imageLayer = [CALayer layer];
//            _imageLayer.contents = (__bridge id)self.image.CGImage;
//            _imageLayer.frame = self.bounds;
//            _imageLayer.cornerRadius = self.bounds.size.height/2;
//            _imageLayer.masksToBounds = YES;
//            [self.layer addSublayer:_imageLayer];
//            
//            _backgroundLayer.lineCap = kCALineCapSquare;
//            _backgroundLayer.lineJoin = kCALineCapSquare;
//            
//            _progressLayer.lineCap = kCALineCapSquare;
//            _progressLayer.lineJoin = kCALineCapSquare;
//            
//            break;
//        default:
//            break;
//    }
    
    [self.layer addSublayer:_backgroundLayer];
    [self.layer addSublayer:_progressLayer];
    

}
#pragma mark - draw circleLine
-(void) setBackgroundCircleLine:(ZFProgressViewStyle)style
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    if (style == ZFProgressViewStyleNone ||  style == ZFProgressViewStyleImageSegment) {
        path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.center.x - self.frame.origin.x,
                                                                               self.center.y - self.frame.origin.y)
                                                            radius:(self.bounds.size.width - _backgourndLineWidth)/ 2 - _offset
                                                        startAngle:0
                                                          endAngle:M_PI*2
                                                         clockwise:YES];
    }
    
    _backgroundLayer.path = path.CGPath;

}

-(void)setProgressCircleLine:(ZFProgressViewStyle)style
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    if (style == ZFProgressViewStyleNone || style == ZFProgressViewStyleImageSegment) {
        path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.center.x - self.frame.origin.x,
                                                                            self.center.y - self.frame.origin.y)
                                                         radius:(self.bounds.size.width - _progressLineWidth)/ 2 - _offset
                                                     startAngle:-M_PI_2
                                                       endAngle:-M_PI_2 + M_PI *2
                                                      clockwise:YES];
    }
    else
    {
        static float minAngle = 0.0081;
        for (int i = 0; i < ceil(360 / _GapWidth *_Percentage)+1; i++) {
            CGFloat angle = (i * (_GapWidth + minAngle) * M_PI / 180.0);
            
            if (i == 0) {
                angle = minAngle * M_PI/180.0;
            }
            
            if (angle >= M_PI *2) {
                angle = M_PI *2;
            }
            UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.center.x - self.frame.origin.x,
                                                                                    self.center.y - self.frame.origin.y)
                                                                 radius:(self.bounds.size.width - _progressLineWidth)/ 2 - _offset
                                                             startAngle:-M_PI_2 +(i *_GapWidth * M_PI / 180.0)
                                                               endAngle:-M_PI_2 + angle
                                                              clockwise:YES];
            
            [path appendPath:path1];
            
        }

    }
    _progressLayer.path = path.CGPath;
}


#pragma mark - setter and getter methond

-(UILabel *)progressLabel
{
    if(!_progressLabel)
    {
//        _progressLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.bounds.size.width - SCREEN_FIT(50))/2, SCREEN_FIT(15), SCREEN_FIT(50), SCREEN_FIT(17))];
        _progressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height/3, self.bounds.size.width, self.bounds.size.height/3)];
    }
    return _progressLabel;
}

//- (UILabel *)gaiLvTextLb
//{
//    if (!_gaiLvTextLb) {
//        _gaiLvTextLb = [[UILabel alloc] initWithFrame:CGRectMake(6.0f, _progressLabel.frame.origin.y + _progressLabel.frame.size.height + 5.0, self.frame.size.width - 2*6.0f, 10.0)];
//        _gaiLvTextLb.text = @"已完成";
//    }
//    return _gaiLvTextLb;
//}
//
//- (void)setGaiLvTextLbText:(NSString *)text
//{
//    _gaiLvTextLb.text = text;
//}

-(void)setProgressLabelText:(NSString *)text
{
    _progressLabel.text = text;
//    _progressLabel.font = [UIFont systemFontOfSize:self.bounds.size.height/7 weight:0.4];
    
    _progressLabel.font = [UIFont systemFontOfSize:self.bounds.size.height/7];

}


-(void)setBackgourndLineWidth:(CGFloat)backgourndLineWidth
{
    _backgourndLineWidth = backgourndLineWidth;
    _backgroundLayer.lineWidth = backgourndLineWidth;
    CGRect newRect = self.progressLabel.frame;
    newRect.origin.x = _backgourndLineWidth;
    newRect.size.width = self.bounds.size.width-2*_backgourndLineWidth;
    self.progressLabel.frame = newRect;
}

-(void)setProgressLineWidth:(CGFloat)progressLineWidth
{
    _progressLineWidth = progressLineWidth;
    _progressLayer.lineWidth = progressLineWidth;
    [self setBackgroundCircleLine:self.style];
    [self setProgressCircleLine:self.style];
}

-(void)setPercentage:(CGFloat)Percentage
{
    _Percentage = Percentage;
    [self setProgressCircleLine:self.style];
    [self setBackgroundCircleLine:self.style];
;
}

-(void)setBackgroundStrokeColor:(UIColor *)backgroundStrokeColor
{
    _backgroundStrokeColor = backgroundStrokeColor;
    _backgroundLayer.strokeColor = backgroundStrokeColor.CGColor;
}

-(void)setProgressStrokeColor:(UIColor *)progressStrokeColor
{
    _progressStrokeColor = progressStrokeColor;
    _progressLayer.strokeColor = progressStrokeColor.CGColor;
    [self setupColorLayer];
}

- (void)setupColorLayer {
//    //渐变图层
//    CALayer * grain = [CALayer layer];
//    //        我们是两种渐变色，所以我么要用一个grain 对象将两个渐变图层放到一起，
//    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
//    
//    gradientLayer.frame = CGRectMake(0, 0, self.bounds.size.width/2, self.bounds.size.height);
//    
//    [gradientLayer setColors:[NSArray arrayWithObjects:(id)[[UIColor purpleColor] CGColor],(id)[RYUIColorWithRGB(193, 44, 113) CGColor], nil]];
//    
//    [gradientLayer setLocations:@[@0.1,@0.9]];
//    
//    [gradientLayer setStartPoint:CGPointMake(0.5, 0)];
//    
//    [gradientLayer setEndPoint:CGPointMake(0.5, 1)];
//    [grain addSublayer:gradientLayer];
    
//    CAGradientLayer * gradientLayer1 = [CAGradientLayer layer];
//    gradientLayer1.frame = CGRectMake(self.bounds.size.width/2-1.5, 0, self.bounds.size.width/2+1.5, self.bounds.size.height);
//    
//    [gradientLayer1 setColors:[NSArray arrayWithObjects:(id)[[UIColor redColor] CGColor],(id)[RYUIColorWithRGB(193, 44, 113) CGColor], nil]];
//    [gradientLayer1 setLocations:@[@0.1,@0.9]];
//    
//    [gradientLayer1 setStartPoint:CGPointMake(0.9, 0)];
//    
//    [gradientLayer1 setEndPoint:CGPointMake(0.05, 1)];
//    [grain addSublayer:gradientLayer1];
    //用progressLayer来截取渐变层 遮罩
//    [grain setMask:_progressLayer];
    [self.layer addSublayer:_progressLayer];
}

-(void)setDigitTintColor:(UIColor *)digitTintColor
{
    _digitTintColor = digitTintColor;
    _progressLabel.textColor = digitTintColor;
//    _gaiLvTextLb.textColor = digitTintColor;
}

-(void)setGapWidth:(CGFloat)GapWidth
{
    _GapWidth = GapWidth;
    [self setBackgroundCircleLine:self.style];
    [self setProgressCircleLine:self.style];
    
}

-(void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
    
    _progressLineWidth = lineWidth;
    _progressLayer.lineWidth = lineWidth;
    
    _backgourndLineWidth = lineWidth;
    _backgroundLayer.lineWidth = lineWidth;
}


-(void)setImage:(UIImage *)image
{
    _image = image;
    [self layoutViews:ZFProgressViewStyleImageSegment];
}

-(void)setTimeDuration:(CGFloat)timeDuration
{
    _timeDuration = timeDuration;
//    [self setProgress:1.0 Animated:YES];
}
#pragma mark - progress animated YES or NO
-(void)setProgress:(CGFloat)Percentage Animated:(BOOL)animated
{
    self.Percentage = Percentage;
    if (animated) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.fromValue = [NSNumber numberWithFloat:0.0];
        if (self.style ==  ZFProgressViewStyleNone || self.style == ZFProgressViewStyleImageSegment) {
            animation.toValue = [NSNumber numberWithFloat:_Percentage];
            _progressLayer.strokeEnd = _Percentage;
        }
        else
        {
            animation.toValue = [NSNumber numberWithFloat:1.0];
        }

        animation.duration = self.timeDuration;

        //start timer
        [_timer invalidate];
        _timer = nil;
        _timer = [NSTimer scheduledTimerWithTimeInterval:_step
                                                  target:self
                                                selector:@selector(numberAnimation)
                                                userInfo:nil
                                                 repeats:YES];
        [_progressLayer addAnimation:animation forKey:@"strokeEndAnimation"];

    } else {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        _progressLayer.strokeEnd = _Percentage;
        _progressLabel.attributedText = [self getProgressLabelttributedString:[NSString stringWithFormat:@"%.0f％",_Percentage*100]];
        __weak ZFProgressView *weakThis = self;
        
        [CATransaction setCompletionBlock:^{
            [weakThis animationComeplete];
        }];
        [CATransaction commit];
        
    }
}


-(void)numberAnimation
{
    //Duration 动画持续时长
    _sumSteps += _step;
    float sumSteps =  _Percentage /self.timeDuration *_sumSteps;
    if (_sumSteps >= self.timeDuration) {
        NSString *percentageStr = [NSString stringWithFormat:@"%.0f％",_Percentage * 100];
        NSMutableAttributedString *percentAttributedStr = [self getProgressLabelttributedString:percentageStr];
        if (![_progressLabel.attributedText isEqualToAttributedString:percentAttributedStr]) {
            _progressLabel.attributedText = percentAttributedStr;
        }
        [_timer invalidate];
        _timer = nil;
        [self animationComeplete];
        return;
    }
      _progressLabel.attributedText = [self getProgressLabelttributedString:[NSString stringWithFormat:@"%.0f％",sumSteps *100]];
//    _progressLabel.textColor = [YXBTool colorWithHexString:@"#FF6600"];
}
//动画完成时调用
-(void)animationComeplete{

    if (self.animateCompletationBlock!=nil) {

        self.animateCompletationBlock();
    }
}
- (NSMutableAttributedString *)getProgressLabelttributedString:(NSString *)str
{
    NSMutableAttributedString* attributedStr = nil;
    
    
    if ([str integerValue] <= 100) {
        attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
        NSRange  range0 = NSMakeRange(0, str.length-1);
        [attributedStr addAttribute:NSForegroundColorAttributeName value:self.progressStrokeColor range:range0];
        [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kDeviceWidth/750*35.01] range:range0];
        
        NSRange  range1 = NSMakeRange(str.length-1, 1);
        [attributedStr addAttribute:NSForegroundColorAttributeName value:self.progressStrokeColor range:range1];
        [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kDeviceWidth/750*25.01] range:range1];
        self.progressLayer.strokeColor = self.progressStrokeColor.CGColor;
    }
    if([str integerValue]==100){
        if (self.displayHasFinished) {
            attributedStr = [[NSMutableAttributedString alloc] initWithString:@"已完成"];
            NSRange  range1 = NSMakeRange(0, 3);
            [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:range1];
            self.progressLayer.strokeColor = self.backgroundStrokeColor.CGColor;
        }else{
            
        }
        
    }
    
   
    
    return attributedStr;
}


@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com