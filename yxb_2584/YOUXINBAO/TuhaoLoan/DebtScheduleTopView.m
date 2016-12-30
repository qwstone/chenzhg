//
//  DebtScheduleTopView.m
//  YOUXINBAO
//
//  Created by Feili on 15/4/30.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "DebtScheduleTopView.h"
#import "AttributeStringModel.h"

#define DebtScheduleTopViewLabelTagStart 2000
#define DebtScheduleTopViewLabelFontSize 12.0

@interface DebtScheduleTopView ()
@property(nonatomic,strong)NSMutableArray *elementArray;
@property(nonatomic,strong)UIView *schedulePanel;//进度板
@property(nonatomic,strong)UIView *topBgView;//顶部
@property(nonatomic,strong)UIView *scheduleView;//进度条view

@end

@implementation DebtScheduleTopView

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
        self.elementArray = [NSMutableArray array];
        [self initView];
    }
    return self;
}


-(void)initView
{
    
    self.topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 110)];
    _topBgView.layer.borderColor = rgb(213, 213, 213, 1.0).CGColor;
    _topBgView.layer.borderWidth = 1.0;

    _topBgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_topBgView];
    CGFloat x = 10;
    CGFloat y = 20;
    CGFloat w = (kDeviceWidth - 2*x)/2.0;
    CGFloat h = 15;
    CGFloat x1 = x;
    CGFloat y1 = y;
    CGFloat w1 = w;
    CGFloat h1 = h;
    
    CGFloat labelYSpace = 15;
    for (int i = 0; i < 6; i ++) {
        if(i % 2 == 0)
        {
            x1 = x;
        }
        else
        {
            x1 = x + w;
        }
        y1 = y + (h+labelYSpace)*(i/2);
        
        UILabel *label = [self labelWithFrame:CGRectMake(x1, y1, w1, h1)];
        label.font = [UIFont systemFontOfSize:15.0];
//        label.minimumScaleFactor = 8.0/label.font.pointSize;
//        label.adjustsFontSizeToFitWidth = YES;
        label.textColor = [UIColor grayColor];
        label.tag = DebtScheduleTopViewLabelTagStart + i;
        [_topBgView addSubview:label];
    }
    
    //添加进度板
    x = 10;
    w = kDeviceWidth-2*x;
//    [self addDebtSchedulePanelWithFrame:CGRectMake(x, y1+h+20, w, 150+40)];
//    [self addDebtSchedulePanelWithFrame:CGRectMake(x, y1+h+20, w, 150+40)];
    [self addNewSchedulePanelWithFrame:CGRectMake(0, _topBgView.bottom+20, self.width, 90)];

    
}


/**
 *  @author chenglibin
 *
 *  添加新的进度板显示
 *
 *  @param frame <#frame description#>
 */

-(void)addNewSchedulePanelWithFrame:(CGRect)frame
{
    
    UIView *scheduleBgView = [[UIView alloc] initWithFrame:frame];
    scheduleBgView.backgroundColor = [UIColor whiteColor];
    scheduleBgView.layer.borderColor = rgb(213, 213, 213, 1.0).CGColor;
    scheduleBgView.layer.borderWidth = 1.0;

    [self addSubview:scheduleBgView];
    self.schedulePanel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scheduleBgView.width, scheduleBgView.height)];
    _schedulePanel.contentMode = UIViewContentModeCenter;
    _schedulePanel.layer.contentsScale = [[UIScreen mainScreen] scale];
    //    _schedulePanel.layer.contents = (id)[UIImage imageNamed:@""]
    [scheduleBgView addSubview:_schedulePanel];
}

-(NSString *)imageNameWithState:(TuhaoScheduleType)schedule
{
    NSString *imageName = @"";
    switch (schedule) {
        case TuhaoScheduleTypeQueren:
        {
            imageName = @"borrowsteps01.png";
        }
            break;
        case TuhaoScheduleTypeMianqian:
        {
            imageName = @"borrowsteps02.png";
        }
            break;
        case TuhaoScheduleTypeDaozhang:
        {
            imageName = @"borrowsteps03.png";
        }
            break;
        case TuhaoScheduleTypeHuankuaning:
        {
            imageName = @"borrowsteps04.png";
        }
            break;
        case TuhaoScheduleTypeWancheng:
        {
            imageName = @"borrowsteps05.png";
        }
            break;

            
        default:
            break;
    }
    
    return imageName;
}

-(void)showSchedulePabel
{
    _schedulePanel.hidden = NO;
}

-(void)setModel:(RepaymentNoteData *)model
{
    if (_model != model) {
        _model = model;
        self.elementArray = [NSMutableArray arrayWithObjects:
                             [NSString stringWithFormat:@"借款人：%@",_model.debtorName],
                             [NSString stringWithFormat:@"义气土豪：%@",_model.creditorName],
                             [NSString stringWithFormat:@"借款金额：%@",[_model money]],
                             [NSString stringWithFormat:@"还款方式：%@",_model.repaymentMode],
                             [NSString stringWithFormat:@"利    息：%@",_model.moneyPerMonth],
                             [NSString stringWithFormat:@"年利率：%@%%",_model.yearRate], nil];
        
        for (int i = 0; i < [_elementArray count]; i ++) {
            NSInteger tag = DebtScheduleTopViewLabelTagStart + i;
            UILabel *label = (UILabel *)[_topBgView viewWithTag:tag];
            label.text = _elementArray[i];
        }
        
        //设置进度板数据
        [self.elementArray removeAllObjects];
        self.elementArray = [NSMutableArray arrayWithObjects:
                             [NSString stringWithFormat:@"申请借款"],
                             [NSString stringWithFormat:@"审核中"],
                             [NSString stringWithFormat:@"约见面签"],
                             [NSString stringWithFormat:@"借款到账"],
                             [NSString stringWithFormat:@"还款中"],
                             [NSString stringWithFormat:@"还款完成"], nil];
        
        for (int i = 0; i < [_elementArray count]; i ++) {
            NSInteger tag = DebtScheduleTopViewLabelTagStart + 10 + i*100;
            UILabel *label = (UILabel *)[_schedulePanel viewWithTag:tag];
            label.text = _elementArray[i];
        }
        
//        self.schedule = _model.state;
        if (_model.state <= TuhaoScheduleTypeQueren) {
            _model.state = TuhaoScheduleTypeQueren;
        }else if (_model.state <= TuhaoScheduleTypeMianqian)
        {
            _model.state = TuhaoScheduleTypeMianqian;

        }else if (_model.state <= TuhaoScheduleTypeDaozhang)
        {
            _model.state = TuhaoScheduleTypeDaozhang;
            
        }else if (_model.state <= TuhaoScheduleTypeHuankuaning)
        {
            _model.state = TuhaoScheduleTypeHuankuaning;
            
        }else if (_model.state <= TuhaoScheduleTypeWancheng)
        {
            _model.state = TuhaoScheduleTypeWancheng;
            
        }
        self.schedulePanel.layer.contents = (id)[UIImage imageNamed:[self imageNameWithState:_model.state]].CGImage;
        
        
    }

}



-(NSMutableArray *)attributeArrayWithSourceStrArray:(NSArray *)sourceStrArray
{
    NSMutableArray *attributeArray = [NSMutableArray array];
    
    //第一个
    for (int i = 0; i < [sourceStrArray count]; i ++) {
        NSMutableArray *aArray = [NSMutableArray array];
        for (int j = 0; j < 3; j ++) {
            if (i < 2) {
                //[0][0] [0][1]位置的属性 三部分
                
                if (j == 0) {
                    AttributeStringModel *model1 = [[AttributeStringModel alloc] init];
                    model1.attributeName = NSFontAttributeName;
                    model1.attributeValue = [UIFont boldSystemFontOfSize:16.0];
                    model1.attributeRange = NSMakeRange(0, [sourceStrArray[i] length]);
                    [aArray addObject:model1];
                }
                else if(j == 1)
                {
                    AttributeStringModel *model2 = [[AttributeStringModel alloc] init];
                    model2.attributeName = NSForegroundColorAttributeName;
                    model2.attributeValue = rgb(12, 12, 12, 1.0);
                    model2.attributeRange = NSMakeRange(0, [sourceStrArray[i] length]);
                    [aArray addObject:model2];
                    
                }
                else if(j == 2)
                {
                    AttributeStringModel *model3 = [[AttributeStringModel alloc] init];
                    model3.attributeName = NSForegroundColorAttributeName;
                    model3.attributeValue = rgb(231, 99, 40, 1.0);
                    model3.attributeRange = NSMakeRange(5, [sourceStrArray[i] length] - 5 - 1);
                    [aArray addObject:model3];
                    
                }
                
                
            }
            else if (i >= 2)
            {
                AttributeStringModel *model1 = [[AttributeStringModel alloc] init];
                model1.attributeName = NSFontAttributeName;
                model1.attributeValue = [UIFont systemFontOfSize:14.0];
                model1.attributeRange = NSMakeRange(0, [sourceStrArray[i] length]);
                [aArray addObject:model1];
                
            }
            
        }
        [attributeArray addObject:aArray];
        
    }
    
    return attributeArray;
}




-(UILabel *)labelWithFrame:(CGRect)frame
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [self generateRandomColor];
//    label.font = [UIFont systemFontOfSize:DebtScheduleTopViewLabelFontSize];
    return label;
}

-(UIColor *)generateRandomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    color = [UIColor clearColor];

    return color;
    
}


/*
 -(void)setSchedule:(NSInteger)schedule
 {
 _schedule = schedule;
 for (int i = 0; i < 6; i ++) {
 NSInteger tag = DebtScheduleTopViewLabelTagStart + 10 + i*100;
 UILabel *label = (UILabel *)[_schedulePanel viewWithTag:tag];
 
 label.textColor = [UIColor lightGrayColor];
 if (tag < DebtScheduleTopViewLabelTagStart + 10 + _schedule) {
 label.textColor = [UIColor greenColor];
 }
 if (tag == DebtScheduleTopViewLabelTagStart + 10 + _schedule) {
 label.textColor = [UIColor redColor];
 }
 
 }
 }
 */

/*
 -(void)addDebtSchedulePanelWithFrame:(CGRect)frame
 {
 self.schedulePanel = [[UIView alloc] initWithFrame:frame];
 _schedulePanel.layer.borderWidth = 1.0;
 _schedulePanel.layer.borderColor = [UIColor lightGrayColor].CGColor;
 [self addSubview:_schedulePanel];
 
 UILabel *panelTitle = [self labelWithFrame:CGRectMake(0, 10, frame.size.width, 20)];
 panelTitle.text = @"借款进度板";
 panelTitle.font = [UIFont systemFontOfSize:16.0];
 panelTitle.textAlignment = NSTextAlignmentCenter;
 [_schedulePanel addSubview:panelTitle];
 
 
 static NSInteger leftAlign = 10;
 static NSInteger topAlign = 60;
 static NSInteger spaceBetweenX = 50;
 static NSInteger spaceBetweenY = 50;
 
 
 CGFloat x = leftAlign;
 CGFloat y = topAlign;
 CGFloat w = (_schedulePanel.width - 2*x - 2*spaceBetweenX)/3.0;
 CGFloat h = 15;
 CGFloat x1 = x;
 CGFloat y1 = y;
 CGFloat w1 = w;
 CGFloat h1 = h;
 
 for (int i = 0; i < 6; i ++) {
 
 x1 = x + (w + spaceBetweenX)*(i%3);
 y1 = y + (h+spaceBetweenY)*(i/3);
 
 UILabel *label = [self labelWithFrame:CGRectMake(x1, y1, w1, h1)];
 label.tag = DebtScheduleTopViewLabelTagStart + 10 + i*100;
 //交换4和6的tag
 if (i == 3) {
 label.tag = DebtScheduleTopViewLabelTagStart + 10 + 5*100;
 }
 if (i == 5) {
 label.tag = DebtScheduleTopViewLabelTagStart + 10 + 3*100;
 
 }
 label.textAlignment = NSTextAlignmentCenter;
 [_schedulePanel addSubview:label];
 }
 
 //    //交换4——6的tag值
 //    NSInteger tempTag = DebtScheduleTopViewLabelTagStart + 10 + 3;
 //    UILabel *label4 = (UILabel *)[_schedulePanel viewWithTag:tempTag];
 //    label4.tag = DebtScheduleTopViewLabelTagStart + 10 + 5;
 //    tempTag = DebtScheduleTopViewLabelTagStart + 10 + 5;
 //    UILabel *label6 = (UILabel *)[_schedulePanel viewWithTag:tempTag];
 //    label6.tag = DebtScheduleTopViewLabelTagStart + 10 + 3;
 
 
 _schedulePanel.frame = CGRectMake(_schedulePanel.frame.origin.x, _schedulePanel.frame.origin.y, _schedulePanel.width, 10+topAlign+2*h+spaceBetweenY);
 
 
 CGFloat labelWidth = w;
 x = leftAlign;
 y = y;
 w = spaceBetweenX;
 h = h;
 
 x1 = x;
 y1 = y;
 w1 = w;
 h1 = h;
 for (int i = 0; i < 4; i ++) {
 if (i < 2) {
 x1 = x + labelWidth*(i+1) + spaceBetweenX*i;
 
 }
 else
 {
 x1 = x + labelWidth*(i%2+1) + spaceBetweenX*(i%2);
 
 }
 y1 = y + (h+spaceBetweenY)*(i/2);
 
 UILabel *label = [self labelWithFrame:CGRectMake(x1, y1, w1, h1)];
 label.tag = DebtScheduleTopViewLabelTagStart + 20 + i;
 label.textAlignment = NSTextAlignmentCenter;
 if (i < 2) {
 label.text = @">>";
 }
 else
 {
 label.text = @"<<";
 }
 [_schedulePanel addSubview:label];
 }
 
 x = _schedulePanel.width - leftAlign - labelWidth;
 y = topAlign + h;
 w = labelWidth;
 h = spaceBetweenY;
 UILabel *label = [self labelWithFrame:CGRectMake(x, y, w, h)];
 label.textAlignment = NSTextAlignmentCenter;
 label.text = @">>";
 label.transform = CGAffineTransformMakeRotation(M_PI/2);
 [_schedulePanel addSubview:label];
 _schedulePanel.hidden = YES;
 
 
 }
 
 */

@end
