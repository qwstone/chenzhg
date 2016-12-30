//
//  QCCarouselItem.m
//  YOUXINBAO
//
//  Created by CH10 on 15/6/30.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCCarouselItem.h"
#import "YXBTool.h"

@implementation QCCarouselItem {
    UILabel *_yesterday;
    UILabel *_yesterdayMoney;
    UILabel *_history;
    UILabel *_historyMoney;
    UILabel *_wanyuanmoney;
    UILabel * _zhouqi;
    UILabel *_nianhua;
    UILabel *_name;
}

- (id)initWithFrame:(CGRect)frame type:(NSInteger)type dic:(NSDictionary *)dic {
    if (self = [super initWithFrame:frame]) {

        self.index = type;

        self.line = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.line];
//        
//        if (type == 0) {
//            //红
//            self.layer.contents = (id)[UIImage imageNamed:@"circle"].CGImage;
//            //            lineImage = [UIImage imageNamed:@"bzq-red-x"];
//        }else if (type == 1) {
//            //黄
//            self.layer.contents = (id)[UIImage imageNamed:@"circle"].CGImage;
//            //            lineImage = [UIImage imageNamed:@"bzq-yellow-x"];
//        }else if (type == 2) {
//            //蓝
//            self.layer.contents = (id)[UIImage imageNamed:@"circle"].CGImage;
//            //            lineImage = [UIImage imageNamed:@"bzq-blue-x"];
//        }
        self.line.image = [UIImage imageNamed:@"circle"];

        CGFloat wieth = frame.size.width;
        CGFloat hight = frame.size.height;
        
        _name = [[UILabel alloc] initWithFrame:CGRectMake(wieth/4, hight/400*35, wieth/2, hight/400*36)];
        _name.textAlignment = NSTextAlignmentCenter;
        [_name setAdjustsFontSizeToFitWidth:YES];
        _name.text = dic[@"name"];
        _name.font = [UIFont systemFontOfSize:18];
        _name.textColor = [UIColor whiteColor];
        [self.line addSubview:_name];
        
        _nianhua = [[UILabel alloc] initWithFrame:CGRectMake(wieth/3, hight/400*113, wieth/3, hight/400*60)];
        _nianhua.textAlignment = NSTextAlignmentCenter;
        [_nianhua setAdjustsFontSizeToFitWidth:YES];
        _nianhua.text = dic[@"percent"];//[NSString stringWithFormat:@"%f",[dic[@"percent"] floatValue]];
        _nianhua.font = [UIFont boldSystemFontOfSize:30];
        _nianhua.textColor = [UIColor whiteColor];
        [self.line addSubview:_nianhua];
        UILabel *nianh = [[UILabel alloc] initWithFrame:CGRectMake(0, hight/400*190, wieth, hight/400*22)];
        nianh.textAlignment = NSTextAlignmentCenter;
        nianh.text = @"年化收益率(百分比)";
        [nianh setAdjustsFontSizeToFitWidth:YES];
        nianh.font = [UIFont systemFontOfSize:11];
        nianh.textColor = [UIColor whiteColor];
        [self.line addSubview:nianh];
        
        _wanyuanmoney = [[UILabel alloc] initWithFrame:CGRectMake(wieth/16*3.5, hight/400*260, wieth/4, hight/400*30)];
        _wanyuanmoney.textAlignment = NSTextAlignmentCenter;
        [_wanyuanmoney setAdjustsFontSizeToFitWidth:YES];
        _wanyuanmoney.text = dic[@"earningsOf10thousand"];
        _wanyuanmoney.font = [UIFont boldSystemFontOfSize:15];
        _wanyuanmoney.textColor = [UIColor whiteColor];
        [self.line addSubview:_wanyuanmoney];
        UILabel *wanyuan = [[UILabel alloc] initWithFrame:CGRectMake(wieth/16*3.5, hight/400*295, wieth/4, hight/400*22)];
        wanyuan.textAlignment = NSTextAlignmentCenter;
        wanyuan.text = @"万元收益(元)";
        [wanyuan setAdjustsFontSizeToFitWidth:YES];
        wanyuan.font = [UIFont systemFontOfSize:11];
        wanyuan.textColor = [UIColor whiteColor];
        [self.line addSubview:wanyuan];
        
        _zhouqi = [[UILabel alloc] initWithFrame:CGRectMake(wieth/16*8.5, hight/400*260, wieth/4, hight/400*30)];
        _zhouqi.textAlignment = NSTextAlignmentCenter;
        [_zhouqi setAdjustsFontSizeToFitWidth:YES];
        _nianhua.text = dic[@"time"];
        _zhouqi.font = [UIFont boldSystemFontOfSize:20];
        _zhouqi.textColor = [UIColor whiteColor];
        [self.line addSubview:_zhouqi];
        UILabel *zhouq = [[UILabel alloc] initWithFrame:CGRectMake(wieth/16*8.5, hight/400*295, wieth/4, hight/400*22)];
        zhouq.textAlignment = NSTextAlignmentCenter;
        zhouq.text = @"理财周期(天)";
        [zhouq setAdjustsFontSizeToFitWidth:YES];
        zhouq.font = [UIFont systemFontOfSize:11];
        zhouq.textColor = [UIColor whiteColor];
        [self.line addSubview:zhouq];
    }
    
    return self;

}


- (id)initWithFrame:(CGRect)frame type:(NSInteger)type{
    if (self = [super initWithFrame:frame]) {
//        self.layer.cornerRadius = frame.size.width/2;
//        self.layer.masksToBounds = YES;
//        self.backgroundColor = [UIColor greenColor];
//        _yesterday = [[UILabel alloc] initWithFrame:CGRectZero];
//        _yesterday.backgroundColor = [UIColor clearColor];
//        _yesterday.textColor = [YXBTool colorWithHexString:@"#FFFFFF"];
//        _yesterday.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:_yesterday];
//        
//        _yesterdayMoney = [[UILabel alloc] initWithFrame:CGRectZero];
//        _yesterdayMoney.backgroundColor = [UIColor clearColor];
//        _yesterdayMoney.textColor = [YXBTool colorWithHexString:@"#FFFFFF"];
//        _yesterdayMoney.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:_yesterdayMoney];
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:line];
        
        UIImage *lineImage;
        
        if (type == 0) {
            //红
            self.layer.contents = (id)[UIImage imageNamed:@"circle"].CGImage;
//            lineImage = [UIImage imageNamed:@"bzq-red-x"];
        }else if (type == 1) {
            //黄
            self.layer.contents = (id)[UIImage imageNamed:@"circle"].CGImage;
//            lineImage = [UIImage imageNamed:@"bzq-yellow-x"];
        }else if (type == 2) {
            //蓝
            self.layer.contents = (id)[UIImage imageNamed:@"circle"].CGImage;
//            lineImage = [UIImage imageNamed:@"bzq-blue-x"];
        }
        line.image = lineImage;
        
//        _history = [[UILabel alloc] initWithFrame:CGRectZero];
//        _history.backgroundColor = [UIColor clearColor];
//        _history.textColor = [YXBTool colorWithHexString:@"#FFFFFF"];
//        _history.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:_history];
//        
//        _historyMoney = [[UILabel alloc] initWithFrame:CGRectZero];
//        _historyMoney.backgroundColor = [UIColor clearColor];
//        _historyMoney.textColor = [YXBTool colorWithHexString:@"#FFFFFF"];
//        _historyMoney.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:_historyMoney];
//        
//        if (kDeviceWidth == 320.0) {
//            _yesterday.frame = CGRectMake(0, frame.size.height/360*75, frame.size.width, 18);
//            _yesterday.font = [UIFont systemFontOfSize:16];
//            
//            _yesterdayMoney.frame = CGRectMake(0, frame.size.height/360*140, frame.size.width, 35);
//            _yesterdayMoney.font = [UIFont systemFontOfSize:34];
//            
//            line.frame = CGRectMake((frame.size.width-lineImage.size.width)/2, frame.size.height/360*220, lineImage.size.width, lineImage.size.height);
//            
//            _history.frame = CGRectMake(0, frame.size.height/360*240, frame.size.width, 13);
//            _history.font = [UIFont systemFontOfSize:12];
//            
//            _historyMoney.frame = CGRectMake(0, frame.size.height/360*285, frame.size.width, 15);
//            _historyMoney.font = [UIFont systemFontOfSize:14];
//        }else if (kDeviceWidth == 375.0) {
//            _yesterday.frame = CGRectMake(0, frame.size.height/360*75, frame.size.width, 20);
//            _yesterday.font = [UIFont systemFontOfSize:18];
//            
//            _yesterdayMoney.frame = CGRectMake(0, frame.size.height/360*140, frame.size.width, 42);
//            _yesterdayMoney.font = [UIFont systemFontOfSize:41];
//            
//            line.frame = CGRectMake((frame.size.width-lineImage.size.width)/2, frame.size.height/360*220, lineImage.size.width, lineImage.size.height);
//            
//            _history.frame = CGRectMake(0, frame.size.height/360*240, frame.size.width, 15);
//            _history.font = [UIFont systemFontOfSize:14];
//            
//            _historyMoney.frame = CGRectMake(0, frame.size.height/360*285, frame.size.width, 15);
//            _historyMoney.font = [UIFont systemFontOfSize:14];
//        }else if (kDeviceWidth == 414.0) {
//            _yesterday.frame = CGRectMake(0, frame.size.height/360*75, frame.size.width, 22);
//            _yesterday.font = [UIFont systemFontOfSize:20];
//            
//            _yesterdayMoney.frame = CGRectMake(0, frame.size.height/360*140, frame.size.width, 46);
//            _yesterdayMoney.font = [UIFont systemFontOfSize:45];
//            
//            line.frame = CGRectMake((frame.size.width-lineImage.size.width)/2, frame.size.height/360*220, lineImage.size.width, lineImage.size.height);
//            
//            _history.frame = CGRectMake(0, frame.size.height/360*240, frame.size.width, 20);
//            _history.font = [UIFont systemFontOfSize:18];
//            
//            _historyMoney.frame = CGRectMake(0, frame.size.height/360*285, frame.size.width, 20);
//            _historyMoney.font = [UIFont systemFontOfSize:18];
//        }
        CGFloat wieth = frame.size.width;
        CGFloat hight = frame.size.height;
        
        _name = [[UILabel alloc] initWithFrame:CGRectMake(wieth/4, hight/400*35, wieth/2, hight/400*38)];
        _name.textAlignment = NSTextAlignmentCenter;
        [_name setAdjustsFontSizeToFitWidth:YES];
                _wanyuanmoney.text = @"222.67";
        _name.font = [UIFont systemFontOfSize:20];
        _name.textColor = [UIColor whiteColor];
        [self addSubview:_name];
        
        _nianhua = [[UILabel alloc] initWithFrame:CGRectMake(wieth/3, hight/400*113, wieth/3, hight/400*60)];
        _nianhua.textAlignment = NSTextAlignmentCenter;
        [_nianhua setAdjustsFontSizeToFitWidth:YES];
        //        _wanyuanmoney.text = @"222.67";
        _nianhua.font = [UIFont boldSystemFontOfSize:30];
        _nianhua.textColor = [UIColor whiteColor];
        [self addSubview:_nianhua];
        UILabel *nianh = [[UILabel alloc] initWithFrame:CGRectMake(0, hight/400*190, wieth, hight/400*22)];
        nianh.textAlignment = NSTextAlignmentCenter;
        nianh.text = @"年化收益率(百分比)";
        [nianh setAdjustsFontSizeToFitWidth:YES];
        nianh.font = [UIFont systemFontOfSize:11];
        nianh.textColor = [UIColor whiteColor];
        [self addSubview:nianh];
        
        _wanyuanmoney = [[UILabel alloc] initWithFrame:CGRectMake(wieth/16*3.5, hight/400*260, wieth/4, hight/400*30)];
        _wanyuanmoney.textAlignment = NSTextAlignmentCenter;
        [_wanyuanmoney setAdjustsFontSizeToFitWidth:YES];
        //        _wanyuanmoney.text = @"222.67";
        _wanyuanmoney.font = [UIFont boldSystemFontOfSize:15];
        _wanyuanmoney.textColor = [UIColor whiteColor];
        [self addSubview:_wanyuanmoney];
        UILabel *wanyuan = [[UILabel alloc] initWithFrame:CGRectMake(wieth/16*3.5, hight/400*295, wieth/4, hight/400*22)];
        wanyuan.textAlignment = NSTextAlignmentCenter;
        wanyuan.text = @"万元收益(元)";
        [wanyuan setAdjustsFontSizeToFitWidth:YES];
        wanyuan.font = [UIFont systemFontOfSize:11];
        wanyuan.textColor = [UIColor whiteColor];
        [self addSubview:wanyuan];
        
        _zhouqi = [[UILabel alloc] initWithFrame:CGRectMake(wieth/16*8.5, hight/400*260, wieth/4, hight/400*30)];
        _zhouqi.textAlignment = NSTextAlignmentCenter;
        [_zhouqi setAdjustsFontSizeToFitWidth:YES];
        //        _wanyuanmoney.text = @"222.67";
        _zhouqi.font = [UIFont boldSystemFontOfSize:20];
        _zhouqi.textColor = [UIColor whiteColor];
        [self addSubview:_zhouqi];
        UILabel *zhouq = [[UILabel alloc] initWithFrame:CGRectMake(wieth/16*8.5, hight/400*295, wieth/4, hight/400*22)];
        zhouq.textAlignment = NSTextAlignmentCenter;
        zhouq.text = @"理财周期(天)";
        [zhouq setAdjustsFontSizeToFitWidth:YES];
        zhouq.font = [UIFont systemFontOfSize:11];
        zhouq.textColor = [UIColor whiteColor];
        [self addSubview:zhouq];
    }
    
    return self;
}

- (void)setRoundData:(ProfitRoundData *)roundData {
    _roundData = roundData;
    
    _yesterday.text = roundData.str1;
    if (roundData.str2.length != 0 && roundData.str2 != nil) {
        UIFont *font;
        if (kDeviceWidth == 320.0) {
            font = [UIFont systemFontOfSize:24];
        }else if (kDeviceWidth == 375.0) {
            font = [UIFont systemFontOfSize:26];
        }else if (kDeviceWidth == 414.0) {
            font = [UIFont systemFontOfSize:30];
        }
        if (KDeviceOSVersion>5.0) {
            NSMutableAttributedString *moneyAttributString = [[NSMutableAttributedString alloc] initWithString:roundData.str2];
            //设置字符串的样式   NSFontAttributeName:样式名称
            [moneyAttributString addAttribute:NSFontAttributeName
                                        value:font
                                        range:NSMakeRange(roundData.str2.length-2, 2)];
            _yesterdayMoney.attributedText = moneyAttributString;
            
        }else {
            _yesterdayMoney.text = roundData.str2;
        }
        
    }
    _history.text = roundData.str3;
    _historyMoney.text = roundData.str4;
}

+ (CGFloat)getCarouselHeightAndWidth {
    CGFloat height;
    if (kDeviceWidth == 320.0) {
        height = 180.0;
    }else if (kDeviceWidth == 375.0) {
        height = 211.0;
    }else if (kDeviceWidth >= 414.0) {
        height = 233.0;
    }
    
    return height;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
