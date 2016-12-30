//
//  DetailsHeaderView.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/3/17.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "DetailsHeaderView.h"
#import "QCConst.h"
#import "UIImageView+WebCache.h"

#define KFONT 12
@interface DetailsHeaderView() {
    UIButton *_imageButton;
}

@property (nonatomic,retain)UILabel * timeLable;

@property (nonatomic,retain)UILabel * initiatorLable;

@property (nonatomic,retain)UILabel * placeLable;

@property (nonatomic,retain)UILabel * joinPeopleLable;

@property (nonatomic,retain)UILabel * priceLable;

@property (nonatomic,retain)UILabel * wayOfPayingLable;

@property (nonatomic,strong)UIImageView * portrait; //头像

@property (nonatomic,strong)UILabel *createTime;    //创建时间

@property (nonatomic,strong)UILabel *readers;   //阅读次数

@property (nonatomic,strong)UILabel *sharers;    //分享次数

@end
@implementation DetailsHeaderView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _placeLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, kDeviceWidth-100, 20)];
        _placeLable.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:_placeLable];
        
        _inform = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth-45, 10, 30, 20)];
        _inform.backgroundColor = [UIColor clearColor];
        _inform.titleLabel.font = [UIFont systemFontOfSize:15];
        [_inform setTitleColor:rgb(11, 167, 242, 1) forState:UIControlStateNormal];
        [_inform setTitle:@"投诉" forState:UIControlStateNormal];
        [_inform addTarget:self action:@selector(informAction:) forControlEvents:UIControlEventTouchUpInside];
        _inform.hidden = YES;
        [self addSubview:_inform];
        
        _portrait = [[UIImageView alloc] initWithFrame:CGRectMake(15, 37.5, 20, 20)];
//        _portrait.backgroundColor = [UIColor blackColor];
        QCUserModel *model = [[QCUserManager sharedInstance] getLoginUser];
        [_portrait sd_setImageWithURL:[NSURL URLWithString:model.user.iconAddr]];
        [self addSubview:_portrait];
        
        _initiatorLable = [[UILabel alloc]initWithFrame:CGRectMake(40, 40, 80, 15)];
        _initiatorLable.font = [UIFont systemFontOfSize:KFONT];
        
        _initiatorLable.textColor = rgb(11, 167, 242, 1);
        [self addSubview:_initiatorLable];
        
        _createTime = [[UILabel alloc] initWithFrame:CGRectMake(_initiatorLable.right, _initiatorLable.top, 40, 15)];
        _createTime.font = [UIFont systemFontOfSize:KFONT];
        
//        _createTime.text = @"2-14";
        _createTime.textColor = rgb(144, 144, 144, 1);
        _createTime.backgroundColor = [UIColor clearColor];
        [self addSubview:_createTime];
        
        UIButton *call = [[UIButton alloc] initWithFrame:CGRectMake(_createTime.right+10, _portrait.top, 20, 20)];
        //        call.backgroundColor = [UIColor blueColor];
        [call setImage:[UIImage imageNamed:@"AA_tel-icon"] forState:UIControlStateNormal];
        [call addTarget:self action:@selector(callAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:call];
        
//        图片墙
//        取消活动&投诉列表
        _imageButton = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth-66-15, _portrait.top-2, 66, 23)];
//        [_imageButton setImage:[UIImage imageNamed:@"picwall-icon"] forState:UIControlStateNormal];
        [_imageButton setTitle:@"取消活动" forState:UIControlStateNormal];
        [_imageButton addTarget:self action:@selector(imageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_imageButton];
        
//        _readers = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth-130, _initiatorLable.top, 65, 15)];
//        _readers.backgroundColor = [UIColor clearColor];
//        _readers.font = [UIFont systemFontOfSize:KFONT];
//        _readers.text = @"阅读   10010";
//        [self addSubview:_readers];
//        
//        _sharers = [[UILabel alloc] initWithFrame:CGRectMake(_readers.right, _initiatorLable.top, 65, 15)];
//        _sharers.backgroundColor = [UIColor clearColor];
//        _sharers.font = [UIFont systemFontOfSize:KFONT];
//        _sharers.text = @"分享   10010";
//        [self addSubview:_sharers];
        
//        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 65, kDeviceWidth, 1)];
//        lineView.backgroundColor = [UIColor grayColor];
//        [self addSubview:lineView];
        [self dashLineWithY:70];
        
        //主题
        UIImageView *peopleImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 85, 15, 15)];
//        peopleImage.backgroundColor = [UIColor orangeColor];
        peopleImage.image = [UIImage imageNamed:@"loaction"];
        [self addSubview:peopleImage];
        
        _joinPeopleLable = [[UILabel alloc]initWithFrame:CGRectMake(peopleImage.right+5, 84.5, kDeviceWidth/2-35, 15)];
        _joinPeopleLable.font = [UIFont systemFontOfSize:15];

        _joinPeopleLable.textColor = rgb(144, 144, 144, 1);
        [self addSubview:_joinPeopleLable];

        //时间
        UIImageView *timeImage = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/2, 85, 15, 15)];
//        timeImage.backgroundColor = [UIColor orangeColor];
        timeImage.image = [UIImage imageNamed:@"AA_time-icon-blue"];
        [self addSubview:timeImage];
        
        _timeLable = [[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth/2+20, 84.5, kDeviceWidth/2-20, 15)];
        _timeLable.font = [UIFont systemFontOfSize:KFONT];
        _timeLable.textColor = rgb(144, 144, 144, 1);
        [self addSubview:_timeLable];

        UIImageView *priceImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 111, 15, 15)];
//        priceImage.backgroundColor = [UIColor orangeColor];
        priceImage.image = [UIImage imageNamed:@"AA_money-icon-green"];
        [self addSubview:priceImage];
        
        _priceLable = [[UILabel alloc]initWithFrame:CGRectMake(35, 110.5, kDeviceWidth/2-35, 15)];
        _priceLable.font = [UIFont systemFontOfSize:KFONT];
        _priceLable.textColor = rgb(144, 144, 144, 1);

        [self addSubview:_priceLable];
        
        UIImageView *payTypeImage = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/2, 111, 15, 15)];
//        payTypeImage.backgroundColor = [UIColor orangeColor];
        payTypeImage.image = [UIImage imageNamed:@"AA_card-icon-blue"];
        [self addSubview:payTypeImage];

        _wayOfPayingLable = [[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth/2+20, 110.5, kDeviceWidth/2-20, 15)];
        _wayOfPayingLable.font = [UIFont systemFontOfSize:KFONT];
        _wayOfPayingLable.textColor = rgb(144, 144, 144, 1);
//        _wayOfPayingLable.textAlignment = NSTextAlignmentRight;

        [self addSubview:_wayOfPayingLable];

    }
    return self;
}

- (void)setImageButtonHidden:(BOOL)yesOrNo {
//    _imageButton.hidden = yesOrNo;
    if (yesOrNo) {
        [_imageButton setTitle:@"取消活动" forState:UIControlStateNormal];
    }else {
        [_imageButton setTitle:@"投诉列表" forState:UIControlStateNormal];
    }
}


- (void)setActivityModel:(AAActivity *)activityModel
{
    _activityModel = activityModel;

//    _timeLable.text = [NSString stringWithFormat:@"时间:%@",activityModel.activityDate];
//    _initiatorLable.text = [NSString stringWithFormat:@"发起人:%@",@"sdf"];
//    _placeLable.text = [NSString stringWithFormat:@"地点:%@",activityModel.destName];
//    _joinPeopleLable.text = [NSString stringWithFormat:@"已参加14(上限20)"];
//    _priceLable.text = [NSString stringWithFormat:@"价格:%@",activityModel.avgCost];
//    _wayOfPayingLable.text = [NSString stringWithFormat:@"付费方式:%ld",activityModel.payType];

    if (activityModel != nil) {
        if (activityModel.ctFlag == 1) {
            _inform.hidden = NO;
        }else {
            _inform.hidden = YES;
        }
        
        [_portrait sd_setImageWithURL:[NSURL URLWithString:activityModel.iconAddr] placeholderImage:[UIImage imageNamed:@"useimg"]];
        if (activityModel.createDate != nil && activityModel.createDate.length >=10) {
            _createTime.text = [activityModel.createDate substringWithRange:NSMakeRange(5, 5)];
        }else {
            _createTime.text = activityModel.createDate;
        }
        
        
        _timeLable.text = [NSString stringWithFormat:@"%@   %@   %@",[activityModel.activityDate substringWithRange:NSMakeRange(5, 5)],[activityModel.activityDate substringWithRange:NSMakeRange(11, 5)],[self getWeekdayWithNum:_activityModel.weekday]];
        _initiatorLable.text = [NSString stringWithFormat:@"%@",activityModel.creator];
//        [_initiatorLable sizeToFit];
//        _createTime.left = _initiatorLable.right;
        _placeLable.text = [NSString stringWithFormat:@"%@",activityModel.topic];
        _joinPeopleLable.text = [NSString stringWithFormat:@"已参加%ld人(上限%ld人)",(long)activityModel.participantsCount,(long)activityModel.capacity];
        _priceLable.text = [NSString stringWithFormat:@"%@元", activityModel.avgCost];
        _wayOfPayingLable.text = [NSString stringWithFormat:@"%@",[self getPayTypeWithCost:[activityModel.avgCost integerValue]]];
        
    }
    

}

- (void)informAction:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(informButtonActionWithSender:)]) {
        [self.delegate informButtonActionWithSender:button];
    }
}

- (void)imageButtonAction:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(imageButtonActionWithSender:)]) {
        [self.delegate imageButtonActionWithSender:button];
    }
}

- (void)callAction:(UIButton *)button {
    [QCUtils callTelphoneWithNum:self.activityModel.mobile];
}

- (NSString *)getPayType:(NSInteger)money {
    NSString *typeStr = nil;
    if (money == 0) {
        typeStr = @"免费";
    }else if (money > 0) {
        typeStr = @"预付费";
    }else {
        typeStr = @"";
    }
    
    return typeStr;
}

-(void)dashLineWithY:(CGFloat)y
{
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, y, kDeviceWidth-20, 20)];
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

- (NSString *)getWeekdayWithNum:(NSInteger)num {
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



-(NSString *)getPayTypeWithCost:(NSInteger)avgCost
{
    NSString *typeStr = @"免费";
    if (avgCost > 0) {
        typeStr = @"预付费";
    }
    
    return typeStr;
}
@end
