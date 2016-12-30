//
//  AADetailHeaderView.m
//  YOUXINBAO
//
//  Created by CH10 on 15/7/3.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AADetailHeaderView.h"
#import "QCConst.h"
#import "UIImageView+WebCache.h"

#define KFONT getScreenFitSize(12)



@interface AADetailHeaderView() {
    UIButton *_lodgeButton;
}

@property (nonatomic,retain)UILabel * topicLabel;   //标题

@property (nonatomic,retain)UILabel * timeLable;    //时间

@property (nonatomic,retain)UILabel * initiatorLable;   //昵称

@property (nonatomic,retain)UILabel * placeLable;   //地点

@property (nonatomic,retain)UILabel * joinPeopleLable;  //参与人数

@property (nonatomic,retain)UILabel * wayOfPayingLable; //付费方式

@property (nonatomic,strong)UIImageView * portrait; //头像

@property (nonatomic,strong)UILabel *readers;   //阅读次数

@property (nonatomic,strong)UILabel *sharers;    //分享次数

@property (nonatomic,strong)UIButton *call; //电话按钮

@property (nonatomic,strong)UIImageView *gender;    //性别

@end
@implementation AADetailHeaderView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        float leftOrigin = 15;
        
        _topicLabel = [[UILabel alloc]initWithFrame:CGRectMake(getScreenFitSize(leftOrigin), getScreenFitSize(10), getScreenFitSize(kDeviceWidth-100), getScreenFitSize(20))];
        _topicLabel.font = [UIFont systemFontOfSize:getScreenFitSize(15)];
        
        [self addSubview:_topicLabel];
        
        _portrait = [[UIImageView alloc] initWithFrame:CGRectMake(getScreenFitSize(leftOrigin), getScreenFitSize(37.5), getScreenFitSize(20), getScreenFitSize(20))];
        //        _portrait.backgroundColor = [UIColor blackColor];
        _portrait.layer.cornerRadius = _portrait.width/2;
        _portrait.layer.masksToBounds = YES;
//        QCUserModel *model = [[QCUserManager sharedInstance] getLoginUser];
//        [_portrait setImageWithURL:[NSURL URLWithString:model.user.iconAddr]];
        [self addSubview:_portrait];
        
        _initiatorLable = [[UILabel alloc]initWithFrame:CGRectMake(_portrait.right+getScreenFitSize(5), _portrait.top+getScreenFitSize(3.5), getScreenFitSize(80), getScreenFitSize(15))];
        _initiatorLable.font = [UIFont systemFontOfSize:KFONT];
        
        _initiatorLable.textColor = rgb(11, 167, 242, 1);
        [self addSubview:_initiatorLable];
        
        _gender = [[UIImageView alloc] initWithFrame:CGRectMake(_initiatorLable.right, _initiatorLable.top+getScreenFitSize(2), 13, 13)];
        [self addSubview:_gender];
        
        
        _call = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth/2-getScreenFitSize(20), _portrait.top, getScreenFitSize(20), getScreenFitSize(20))];
        //        call.backgroundColor = [UIColor blueColor];
        [_call setImage:[UIImage imageNamed:@"AA_tel-icon"] forState:UIControlStateNormal];
        [_call addTarget:self action:@selector(callAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_call];
        
        //        取消活动&投诉列表
        _lodgeButton = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth-getScreenFitSize(66+leftOrigin), _portrait.top-getScreenFitSize(2), getScreenFitSize(66), getScreenFitSize(23))];
        //        [_imageButton setImage:[UIImage imageNamed:@"picwall-icon"] forState:UIControlStateNormal];
        [_lodgeButton setTitleColor:rgb(11, 167, 242, 1) forState:UIControlStateNormal];
        [_lodgeButton setTitle:@"取消活动" forState:UIControlStateNormal];
        _lodgeButton.titleLabel.font = [UIFont systemFontOfSize:getScreenFitSize(12)];
        self.buttonStyle = AADetailHeaderViewButtonStyleCancle;
        [_lodgeButton addTarget:self action:@selector(imageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_lodgeButton];
        
        [self dashLineWithY:70];
        
        float gap = 26.0;
        float imageBasicY = 85;
        float labelBasicY = 84.5;
        
        UIImageView *placeImage = [[UIImageView alloc] initWithFrame:CGRectMake(getScreenFitSize(leftOrigin), getScreenFitSize(imageBasicY), getScreenFitSize(15), getScreenFitSize(15))];
        placeImage.image = [UIImage imageNamed:@"loaction"];
        [self addSubview:placeImage];
        
        _placeLable = [[UILabel alloc]initWithFrame:CGRectMake(placeImage.right+getScreenFitSize(5), getScreenFitSize(labelBasicY), getScreenFitSize(kDeviceWidth-(placeImage.right+5)), getScreenFitSize(15))];
        _placeLable.font = [UIFont systemFontOfSize:getScreenFitSize(15)];
        
        _placeLable.textColor = rgb(144, 144, 144, 1);
        [self addSubview:_placeLable];
        
        UIButton *mapButton = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth-getScreenFitSize(leftOrigin+21), getScreenFitSize(imageBasicY-4.5), getScreenFitSize(21), getScreenFitSize(24))];
        [mapButton setBackgroundImage:[UIImage imageNamed:@"map"] forState:UIControlStateNormal];
        [mapButton addTarget:self action:@selector(mapAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:mapButton];
        
        UIImageView *timeImage = [[UIImageView alloc] initWithFrame:CGRectMake(getScreenFitSize(leftOrigin), getScreenFitSize(imageBasicY+gap), getScreenFitSize(15), getScreenFitSize(15))];
        //        timeImage.backgroundColor = [UIColor orangeColor];
        timeImage.image = [UIImage imageNamed:@"AA_time-icon-blue"];
        [self addSubview:timeImage];
        
        _timeLable = [[UILabel alloc]initWithFrame:CGRectMake(timeImage.right+getScreenFitSize(5), getScreenFitSize(labelBasicY+gap), getScreenFitSize(kDeviceWidth-(timeImage.right+5)), getScreenFitSize(15))];
        _timeLable.font = [UIFont systemFontOfSize:getScreenFitSize(15)];
        _timeLable.textColor = rgb(144, 144, 144, 1);
        [self addSubview:_timeLable];
        
        UIImageView *peopleImage = [[UIImageView alloc] initWithFrame:CGRectMake(getScreenFitSize(leftOrigin), getScreenFitSize(imageBasicY+gap*2), getScreenFitSize(15), getScreenFitSize(15))];
        //        priceImage.backgroundColor = [UIColor orangeColor];
        peopleImage.image = [UIImage imageNamed:@"AA_user-icon-yellow"];
        [self addSubview:peopleImage];
        
        _joinPeopleLable = [[UILabel alloc]initWithFrame:CGRectMake(peopleImage.right+getScreenFitSize(5), getScreenFitSize(labelBasicY+gap*2), kDeviceWidth/2-(peopleImage.right+getScreenFitSize(5)), getScreenFitSize(15))];
        _joinPeopleLable.font = [UIFont systemFontOfSize:KFONT];
        _joinPeopleLable.textColor = rgb(144, 144, 144, 1);
        
        [self addSubview:_joinPeopleLable];
        
        UIImageView *payTypeImage = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/2, getScreenFitSize(imageBasicY+2*gap), getScreenFitSize(15), getScreenFitSize(15))];
        //        payTypeImage.backgroundColor = [UIColor orangeColor];
        payTypeImage.image = [UIImage imageNamed:@"AA_money-icon-green"];
        [self addSubview:payTypeImage];
        
        _wayOfPayingLable = [[UILabel alloc]initWithFrame:CGRectMake(payTypeImage.right+getScreenFitSize(5), getScreenFitSize(labelBasicY+2*gap), getScreenFitSize(kDeviceWidth/2), getScreenFitSize(15))];
        _wayOfPayingLable.font = [UIFont systemFontOfSize:KFONT];
        _wayOfPayingLable.textColor = rgb(144, 144, 144, 1);
        //        _wayOfPayingLable.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:_wayOfPayingLable];
        
    }
    return self;
}

- (void)setLodgeButtonStyle:(AADetailHeaderViewButtonStyle)style {
    if (style == AADetailHeaderViewButtonStyleLodge) {
        self.buttonStyle = AADetailHeaderViewButtonStyleLodge;
        [_lodgeButton setTitle:@"投诉列表" forState:UIControlStateNormal];
    }else if (style == AADetailHeaderViewButtonStyleCancle) {
        self.buttonStyle = AADetailHeaderViewButtonStyleCancle;
        [_lodgeButton setTitle:@"取消活动" forState:UIControlStateNormal];
    }
}

- (void)setActivityModel:(AAActivity *)activityModel
{
    _activityModel = activityModel;
    
    if (activityModel != nil) {

        if ((activityModel.status == A_CHECKING || activityModel.status == A_PASSED) &&activityModel.type == M_CREATED) {
            //取消活动
            [self setLodgeButtonStyle:AADetailHeaderViewButtonStyleCancle];
        }else {
            [self setLodgeButtonStyle:AADetailHeaderViewButtonStyleLodge];
            if (activityModel.ctFlag == 1) {
                _lodgeButton.hidden = NO;
            }else {
                _lodgeButton.hidden = YES;
            }
        }
        
        [_portrait sd_setImageWithURL:[NSURL URLWithString:activityModel.iconAddr] placeholderImage:[UIImage imageNamed:@"useimg"]];
        _placeLable.text = _activityModel.destName;
        _timeLable.text = [NSString stringWithFormat:@"%@   %@   %@",[activityModel.activityDate substringWithRange:NSMakeRange(5, 5)],[activityModel.activityDate substringWithRange:NSMakeRange(11, 5)],[AADetailHeaderView getWeekdayWithNum:_activityModel.weekday]];
        _initiatorLable.text = [NSString stringWithFormat:@"%@",activityModel.creator];
        _topicLabel.text = [NSString stringWithFormat:@"%@",activityModel.topic];
        _joinPeopleLable.text = [NSString stringWithFormat:@"已参加%ld人(上限%ld人)",(long)activityModel.participantsCount,(long)activityModel.capacity];

        if (activityModel.showMobile) {
            _call.hidden = NO;
        }else {
            _call.hidden = YES;
        }
        
        if (_activityModel.gender == 1) {
            _gender.image = [UIImage imageNamed:@"AA_man-icon"];
        }else {
            _gender.image = [UIImage imageNamed:@"AA_woman-icon"];
        }
        
        //调整frame
        [_initiatorLable sizeToFit];
        _gender.left = _initiatorLable.right+15;
        _call.left = _gender.right+15;
        
        NSString *payCost = [self getPayTypeWithCost];
        if (_activityModel.payType > 0) {
            NSMutableAttributedString * strLabel = [[NSMutableAttributedString alloc] initWithString:payCost];
            NSRange range = [payCost rangeOfString:_activityModel.avgCost];
            [strLabel addAttribute:NSForegroundColorAttributeName value:rgb(223, 70, 85, 1) range:range];
            _wayOfPayingLable.attributedText = strLabel;
        }else {
            _wayOfPayingLable.text = payCost;
        }
    }
    
    
}

- (void)mapAction:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(mapButtonAction)]) {
        [self.delegate mapButtonAction];
    }
}

- (void)imageButtonAction:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(lodgeButtonActionWithStyle:)]) {
        [self.delegate lodgeButtonActionWithStyle:self.buttonStyle];
    }
}

- (void)callAction:(UIButton *)button {
    [QCUtils callTelphoneWithNum:self.activityModel.mobile];
}

//- (NSString *)getPayType:(NSInteger)money {
//    NSString *typeStr = nil;
//    if (money == 0) {
//        typeStr = @"免费";
//    }else if (money > 0) {
//        typeStr = @"预付费";
//    }else {
//        typeStr = @"";
//    }
//    
//    return typeStr;
//}

-(void)dashLineWithY:(CGFloat)y
{
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(getScreenFitSize(10), getScreenFitSize(y), getScreenFitSize(kDeviceWidth-20), getScreenFitSize(0.5))];
    [self addSubview:imageView1];
    
    
    UIGraphicsBeginImageContext(imageView1.frame.size);   //开始画线
    [imageView1.image drawInRect:CGRectMake(0, 0, imageView1.frame.size.width, imageView1.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
    
    
    CGFloat lengths[] = {2,2};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, [UIColor lightGrayColor].CGColor);
    
    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
    CGContextMoveToPoint(line, 0.0, 0.0);    //开始画线
    CGContextAddLineToPoint(line, kDeviceWidth-20, 0.0);
    CGContextStrokePath(line);
    
    imageView1.image = UIGraphicsGetImageFromCurrentImageContext();
}

+ (NSString *)getWeekdayWithNum:(NSInteger)num {
    NSString *str;
    if (num == 1) {
        str = @"星期一";
    }else if (num == 2) {
        str = @"星期二";
    }else if (num == 3) {
        str = @"星期三";
    }else if (num == 4) {
        str = @"星期四";
    }else if (num == 5) {
        str = @"星期五";
    }else if (num == 6) {
        str = @"星期六";
    }else if (num == 7) {
        str = @"星期天";
    }
    return str;
}



-(NSString *)getPayTypeWithCost
{
    NSString *typeStr = @"免费";
    //        支付方式  1 免费; 2 预付费; 3 后付费
    if (_activityModel.payType == 2) {
//        typeStr = [NSString stringWithFormat:@"预付费（¥:%@）",_activityModel.avgCost];
        typeStr = [NSString stringWithFormat:@"付费（¥:%@）",_activityModel.avgCost];
    }else if (_activityModel.payType == 3) {
//        typeStr = [NSString stringWithFormat:@"后付费（¥:%@）",_activityModel.avgCost];
        typeStr = [NSString stringWithFormat:@"付费（¥:%@）",_activityModel.avgCost];
    }
    
    return typeStr;
}
@end

