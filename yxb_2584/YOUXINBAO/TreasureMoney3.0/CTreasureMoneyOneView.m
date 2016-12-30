////
////  CTreasureMoneyOneView.m
////  YOUXINBAO
////
////  Created by zjp on 15/12/15.
////  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
////
//
//#import "CTreasureMoneyOneView.h"
//#import "QCCarouselItem.h"
//#import "ProfitRegularBrief.h"
//
//@implementation CTreasureMoneyOneView{
//
//    UILabel *_wanyuanmoney;
//    UILabel * _zhouqi;
//    UILabel *_nianhua;
//    UILabel *_name;
//}
//
//
//
//-(instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.clipsToBounds = YES;
//        self.index = 0;
//        UIButton *left = [[UIButton alloc] initWithFrame:CGRectMake(0, (frame.size.height-72)/2, 36, 72)];
//        left.tag = 1122;
//        [left setBackgroundImage:[UIImage imageNamed:@"leftf"] forState:UIControlStateNormal];
//        [left addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:left];
//        
//        UIButton *right = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth-36, (frame.size.height-72)/2, 36, 72)];
//        right.tag = 2233;
//        [right setBackgroundImage:[UIImage imageNamed:@"rightf"] forState:UIControlStateNormal];
//        [right addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:right];
//        
//        
//        _carousel = [[iCarousel alloc] initWithFrame:CGRectMake(36, 0, kDeviceWidth-72, frame.size.height)];
//        _carousel.delegate = self;
////        _carousel.backgroundColor = [UIColor redColor];
//        _carousel.dataSource = self;
//        _carousel.type = iCarouselTypeRotary;
//        _carousel.centerItemWhenSelected = YES;
//        _carousel.decelerationRate = 0.1;
//        //        _carousel.perspective = 0.1;
////        _carousel.clipsToBounds = YES;
//        [self addSubview:_carousel];
//        
//    }
//    return self;
//}
//
//- (void)setModel:(NSMutableArray *)model {
//    if (_model != model) {
//        _model = model;
//    }
//    self.index = 0;
//    [self kongzhi];
//    [_carousel reloadData];
//}
//
//
//- (void)butAction:(UIButton *)sender {
//
//    if (sender.tag == 1122) {
//        if (self.index == 2) {
//            self.index = -1;
//        }
//        self.index += 1;
//        
//    }else if (sender.tag == 2233){
//        if (self.index == 0) {
//            self.index = 3;
//        }
//        self.index -= 1;
//    }
//    
//    [self kongzhi];
//}
//
//
//- (void)kongzhi {
//    CGRect frameMax = CGRectMake(0, 0, kDeviceWidth/375*170, kDeviceWidth/375*170);
//    CGRect frameMin = CGRectMake((frameMax.size.width-(self.width-frameMax.size.width)/3.5)/2,(frameMax.size.width-(self.width-frameMax.size.width)/3.5)/2, (self.width-frameMax.size.width)/3.5, (self.width-frameMax.size.width)/3.5);
//    [UIView animateWithDuration:0.4 animations:^{
//        
//        if (self.index == 0) {
//            self.img0.frame = frameMax;
//            self.img1.frame = frameMin;
//            self.img2.frame = frameMin;
//                    self.img0.alpha = 1;
//                    self.img1.alpha = 0;
//                    self.img2.alpha = 0;
////                    self.img0.hidden = NO;
////                    self.img1.hidden = YES;
////                    self.img2.hidden = YES;
//        }else if (self.index == 1){
//            self.img1.frame = frameMax;
//            self.img0.frame = frameMin;
//            self.img2.frame = frameMin;
//                    self.img1.alpha = 1;
//                    self.img0.alpha = 0;
//                    self.img2.alpha = 0;
////                    self.img1.hidden = NO;
////                    self.img0.hidden = YES;
////                    self.img2.hidden = YES;
//        }else if (self.index == 2){
//            self.img2.frame = frameMax;
//            self.img0.frame = frameMin;
//            self.img1.frame = frameMin;
//                    self.img2.alpha = 1;
//                    self.img0.alpha = 0;
//                    self.img1.alpha = 0;
////                    self.img2.hidden = NO;
////                    self.img0.hidden = YES;
////                    self.img1.hidden = YES;
//        }
//        [_carousel scrollToItemAtIndex:self.index animated:YES];
//    } completion:^(BOOL finished) {
//        
//    }];
//
//}
//
//#pragma mark iCarousel methods
//
//- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
//{
//    //return the total number of items in the carousel
//    return 3;
//}
//
//- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
//{
//    
//    //create new view if no view is available for recycling
//    if (view == nil)
//    {
//        //don't do anything specific to the index within
//        //this `if (view == nil) {...}` statement because the view will be
//        //recycled and used with other index values later
//        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth/375*170, kDeviceWidth/375*170)];
//        ProfitRegularBrief *data;
//        if (index<_model.count) {
//            data = _model[index];
//        }
//        //ProfitRegularBrief *data = _model[index];
//        UIImageView* _line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, (self.width-view.width)/3.5, (self.width-view.width)/3.5)];
//                _line1.center = view.center;
//        [view addSubview:_line1];
//        _line1.image = [UIImage imageNamed:@"circle-small"];
//        UILabel *xiao = [[UILabel alloc] initWithFrame:_line1.bounds];
//        xiao.textAlignment = NSTextAlignmentCenter;
////        xiao.text = [NSString stringWithFormat:@"%@%%",data.percent];
//        [xiao setAdjustsFontSizeToFitWidth:YES];
//        xiao.font = [UIFont boldSystemFontOfSize:20];
//        xiao.textColor = [UIColor whiteColor];
//        [_line1 addSubview:xiao];
//        NSString *string1 = [NSString stringWithFormat:@"%@%%",data.percent];
//        NSMutableAttributedString* strLabel1 = [[NSMutableAttributedString alloc] initWithString:string1];
//        [strLabel1 addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15]
//                         range:[string1 rangeOfString:@"%"]];
//        xiao.attributedText = strLabel1;
//        
//        UILabel *xiao1 = [[UILabel alloc] initWithFrame:CGRectMake(_line1.left, _line1.bottom, _line1.width, 13)];
//        xiao1.textAlignment = NSTextAlignmentCenter;
//        xiao1.text = [NSString stringWithFormat:@"%@",data.name];
//        [xiao1 setAdjustsFontSizeToFitWidth:YES];
//        xiao1.font = [UIFont boldSystemFontOfSize:15];
//        xiao1.textColor = [YXBTool colorWithHexString:@"#4D4D4D"];
//        [view addSubview:xiao1];
//        
//        UILabel *xiao2 = [[UILabel alloc] initWithFrame:CGRectMake(_line1.left, xiao1.bottom, _line1.width, 12)];
//        xiao2.textAlignment = NSTextAlignmentCenter;
//        xiao2.text = [NSString stringWithFormat:@"%@天定期",data.time];
//        [xiao2 setAdjustsFontSizeToFitWidth:YES];
//        xiao2.font = [UIFont systemFontOfSize:9];
//        xiao2.textColor = [YXBTool colorWithHexString:@"#4D4D4D"];
//        [view addSubview:xiao2];
//        
//       UIImageView* _line = [[UIImageView alloc] initWithFrame:view.bounds];
//        [view addSubview:_line];
//        _line.image = [UIImage imageNamed:@"circle"];
//        
//        CGFloat wieth = view.size.width;
//        CGFloat hight = view.size.height;
//        
//        _name = [[UILabel alloc] initWithFrame:CGRectMake(wieth/4, hight/400*35, wieth/2, hight/400*36)];
//        _name.textAlignment = NSTextAlignmentCenter;
//        [_name setAdjustsFontSizeToFitWidth:YES];
//        _name.text = data.name;
//        _name.font = [UIFont systemFontOfSize:18];
//        _name.textColor = [UIColor whiteColor];
//        [_line addSubview:_name];
//        
//        _nianhua = [[UILabel alloc] initWithFrame:CGRectMake(wieth/3, hight/400*113, wieth/3, hight/400*60)];
//        _nianhua.textAlignment = NSTextAlignmentCenter;
////        _nianhua.text = [NSString stringWithFormat:@"%@%%",data.percent];
//        _nianhua.font = [UIFont boldSystemFontOfSize:30];
//        [_nianhua setAdjustsFontSizeToFitWidth:YES];
//        _nianhua.textColor = [UIColor whiteColor];
//        [_line addSubview:_nianhua];
//        NSString *string = [NSString stringWithFormat:@"%@%%",data.percent];
//        NSMutableAttributedString* strLabel = [[NSMutableAttributedString alloc] initWithString:string];
//        [strLabel addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20]
//                         range:[string rangeOfString:@"%"]];
//        _nianhua.attributedText = strLabel;
//        UILabel *nianh = [[UILabel alloc] initWithFrame:CGRectMake(0, hight/400*190, wieth, hight/400*22)];
//        nianh.textAlignment = NSTextAlignmentCenter;
//        nianh.text = @"年化收益率(百分比)";
//        [nianh setAdjustsFontSizeToFitWidth:YES];
//        nianh.font = [UIFont systemFontOfSize:11];
//        nianh.textColor = [UIColor whiteColor];
//        [_line addSubview:nianh];
//        
//        _wanyuanmoney = [[UILabel alloc] initWithFrame:CGRectMake(wieth/16*3.5, hight/400*260, wieth/4, hight/400*30)];
//        _wanyuanmoney.textAlignment = NSTextAlignmentCenter;
//        _wanyuanmoney.text = data.earningsOf10thousand;
//        _wanyuanmoney.font = [UIFont boldSystemFontOfSize:15];
//        [_wanyuanmoney setAdjustsFontSizeToFitWidth:YES];
//        _wanyuanmoney.textColor = [UIColor whiteColor];
//        [_line addSubview:_wanyuanmoney];
//        UILabel *wanyuan = [[UILabel alloc] initWithFrame:CGRectMake(wieth/16*3.5, hight/400*295, wieth/4, hight/400*22)];
//        wanyuan.textAlignment = NSTextAlignmentCenter;
//        wanyuan.text = @"万元收益(元)";
//        [wanyuan setAdjustsFontSizeToFitWidth:YES];
//        wanyuan.font = [UIFont systemFontOfSize:11];
//        wanyuan.textColor = [UIColor whiteColor];
//        [_line addSubview:wanyuan];
//        
//        _zhouqi = [[UILabel alloc] initWithFrame:CGRectMake(wieth/16*8.5, hight/400*260, wieth/4, hight/400*30)];
//        _zhouqi.textAlignment = NSTextAlignmentCenter;
//        _zhouqi.font = [UIFont boldSystemFontOfSize:15];
//        _zhouqi.textColor = [UIColor whiteColor];
//        [_zhouqi setAdjustsFontSizeToFitWidth:YES];
//        _zhouqi.text = [NSString stringWithFormat:@"%@",data.time];//data.time;
//        [_line addSubview:_zhouqi];
//        UILabel *zhouq = [[UILabel alloc] initWithFrame:CGRectMake(wieth/16*8.5, hight/400*295, wieth/4, hight/400*22)];
//        zhouq.textAlignment = NSTextAlignmentCenter;
//        zhouq.text = @"理财周期(天)";
//        [zhouq setAdjustsFontSizeToFitWidth:YES];
//        zhouq.font = [UIFont systemFontOfSize:11];
//        zhouq.textColor = [UIColor whiteColor];
//        [_line addSubview:zhouq];
//        if (index == 0) {
//            self.img0 = _line;
//
////            self.img0.hidden = NO;
//        }
//        if (index == 1) {
//            self.img1 = _line;
////            self.img1.hidden = YES;
//        }
//        if (index == 2) {
//            self.img2 = _line;
////            self.img2.hidden = YES;
//        }
//    }
//    
//                [self kongzhi];
//    
//    return view;
//}
//
//
//-(void)CTreasureMoneyNewCell {
//    ProfitRegularBrief *data = _model[self.index];
//    TreasureMoneyProductViewController *TMPVC = [[TreasureMoneyProductViewController alloc] init];
//    TMPVC.regularID = data.regularID;//[_model[index][@"regularID"] integerValue];
//    [[YXBTool getCurrentNav] pushViewController:TMPVC animated:YES];
//}
//- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
//
//    if (self.index == index) {
//        ProfitRegularBrief *data = _model[index];
//        TreasureMoneyProductViewController *TMPVC = [[TreasureMoneyProductViewController alloc] init];
//        TMPVC.regularID = data.regularID;//[_model[index][@"regularID"] integerValue];
//        [[YXBTool getCurrentNav] pushViewController:TMPVC animated:YES];
//    }
//    self.index = index;
//    [self kongzhi];
//    
//}
//
//
//
//@end

//
//  CTreasureMoneyOneView.m
//  YOUXINBAO
//
//  Created by zjp on 15/12/15.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "CTreasureMoneyOneView.h"
#import "QCCarouselItem.h"
#import "ProfitRegularBrief.h"

@implementation CTreasureMoneyOneView{
    
    UILabel *_wanyuanmoney;
    UILabel * _zhouqi;
    UILabel *_nianhua;
    UILabel *_name;
}



-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.index = 0;
        UIButton *left = [[UIButton alloc] initWithFrame:CGRectMake(0, (frame.size.height-72)/2, 36, 72)];
        left.tag = 1122;
        [left setBackgroundImage:[UIImage imageNamed:@"leftf"] forState:UIControlStateNormal];
        [left addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:left];
        
        UIButton *right = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth-36, (frame.size.height-72)/2, 36, 72)];
        right.tag = 2233;
        [right setBackgroundImage:[UIImage imageNamed:@"rightf"] forState:UIControlStateNormal];
        [right addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:right];
        
        
        _carousel = [[iCarousel alloc] initWithFrame:CGRectMake(36, 0, kDeviceWidth-72, frame.size.height)];
        _carousel.delegate = self;
        //        _carousel.backgroundColor = [UIColor redColor];
        _carousel.dataSource = self;
        _carousel.type = iCarouselTypeRotary;
        _carousel.centerItemWhenSelected = YES;
        _carousel.decelerationRate = 0.1;
        //        _carousel.perspective = 0.1;
        //        _carousel.clipsToBounds = YES;
        [self addSubview:_carousel];
        
    }
    return self;
}

- (void)setModel:(NSMutableArray *)model {
    if (_model != model) {
        _model = model;
    }
    self.index = 0;
    [self kongzhi];
    [_carousel reloadData];
}


- (void)butAction:(UIButton *)sender {
    
    if (sender.tag == 1122) {
        if (self.index == 2) {
            self.index = -1;
        }
        self.index += 1;
        
    }else if (sender.tag == 2233){
        if (self.index == 0) {
            self.index = 3;
        }
        self.index -= 1;
    }
    
    [self kongzhi];
}


- (void)kongzhi {
    CGRect frameMax = CGRectMake(0, 0, kDeviceWidth/375*170, kDeviceWidth/375*170);
    CGRect frameMin = CGRectMake((frameMax.size.width-(self.width-frameMax.size.width)/3.5)/2,(frameMax.size.width-(self.width-frameMax.size.width)/3.5)/2, (self.width-frameMax.size.width)/3.5, (self.width-frameMax.size.width)/3.5);
    [UIView animateWithDuration:0.4 animations:^{
        
        if (self.index == 0) {
            self.img0.frame = frameMax;
            self.img1.frame = frameMin;
            self.img2.frame = frameMin;
            self.img0.alpha = 1;
            self.img1.alpha = 0;
            self.img2.alpha = 0;
            //                    self.img0.hidden = NO;
            //                    self.img1.hidden = YES;
            //                    self.img2.hidden = YES;
        }else if (self.index == 1){
            self.img1.frame = frameMax;
            self.img0.frame = frameMin;
            self.img2.frame = frameMin;
            self.img1.alpha = 1;
            self.img0.alpha = 0;
            self.img2.alpha = 0;
            //                    self.img1.hidden = NO;
            //                    self.img0.hidden = YES;
            //                    self.img2.hidden = YES;
        }else if (self.index == 2){
            self.img2.frame = frameMax;
            self.img0.frame = frameMin;
            self.img1.frame = frameMin;
            self.img2.alpha = 1;
            self.img0.alpha = 0;
            self.img1.alpha = 0;
            //                    self.img2.hidden = NO;
            //                    self.img0.hidden = YES;
            //                    self.img1.hidden = YES;
        }
        [_carousel scrollToItemAtIndex:self.index animated:NO];
    } completion:^(BOOL finished) {
        
    }];
    
}

#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return 3;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth/375*170, kDeviceWidth/375*170)];
        ProfitRegularBrief *data = _model[index];
        UIImageView* _line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, (self.width-view.width)/3.5, (self.width-view.width)/3.5)];
        _line1.center = view.center;
        [view addSubview:_line1];
        _line1.image = [UIImage imageNamed:@"circle-small"];
        UILabel *xiao = [[UILabel alloc] initWithFrame:_line1.bounds];
        xiao.textAlignment = NSTextAlignmentCenter;
        //        xiao.text = [NSString stringWithFormat:@"%@%%",data.percent];
        [xiao setAdjustsFontSizeToFitWidth:YES];
        xiao.font = [UIFont boldSystemFontOfSize:20];
        xiao.textColor = [UIColor whiteColor];
        [_line1 addSubview:xiao];
        NSString *string1 = [NSString stringWithFormat:@"%@%%",data.percent];
        NSMutableAttributedString* strLabel1 = [[NSMutableAttributedString alloc] initWithString:string1];
        [strLabel1 addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15]
                          range:[string1 rangeOfString:@"%"]];
        xiao.attributedText = strLabel1;
        
        UILabel *xiao1 = [[UILabel alloc] initWithFrame:CGRectMake(_line1.left, _line1.bottom, _line1.width, 13)];
        xiao1.textAlignment = NSTextAlignmentCenter;
        xiao1.text = [NSString stringWithFormat:@"%@",data.name];
        [xiao1 setAdjustsFontSizeToFitWidth:YES];
        xiao1.font = [UIFont boldSystemFontOfSize:15];
        xiao1.textColor = [YXBTool colorWithHexString:@"#4D4D4D"];
        [view addSubview:xiao1];
        
        UILabel *xiao2 = [[UILabel alloc] initWithFrame:CGRectMake(_line1.left, xiao1.bottom, _line1.width, 12)];
        xiao2.textAlignment = NSTextAlignmentCenter;
        xiao2.text = [NSString stringWithFormat:@"%@天定期",data.time];
        [xiao2 setAdjustsFontSizeToFitWidth:YES];
        xiao2.font = [UIFont systemFontOfSize:9];
        xiao2.textColor = [YXBTool colorWithHexString:@"#4D4D4D"];
        [view addSubview:xiao2];
        
        UIImageView* _line = [[UIImageView alloc] initWithFrame:view.bounds];
        [view addSubview:_line];
        _line.image = [UIImage imageNamed:@"circle"];
        
        CGFloat wieth = view.size.width;
        CGFloat hight = view.size.height;
        
        _name = [[UILabel alloc] initWithFrame:CGRectMake(wieth/4, hight/400*35, wieth/2, hight/400*36)];
        _name.textAlignment = NSTextAlignmentCenter;
        [_name setAdjustsFontSizeToFitWidth:YES];
        _name.text = data.name;
        _name.font = [UIFont systemFontOfSize:18];
        _name.textColor = [UIColor whiteColor];
        [_line addSubview:_name];
        
        _nianhua = [[UILabel alloc] initWithFrame:CGRectMake(wieth/3, hight/400*113, wieth/3, hight/400*60)];
        _nianhua.textAlignment = NSTextAlignmentCenter;
        //        _nianhua.text = [NSString stringWithFormat:@"%@%%",data.percent];
        _nianhua.font = [UIFont boldSystemFontOfSize:30];
        _nianhua.textColor = [UIColor whiteColor];
        [_line addSubview:_nianhua];
        NSString *string = [NSString stringWithFormat:@"%@%%",data.percent];
        NSMutableAttributedString* strLabel = [[NSMutableAttributedString alloc] initWithString:string];
        [strLabel addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20]
                         range:[string rangeOfString:@"%"]];
        _nianhua.attributedText = strLabel;
        [_nianhua setAdjustsFontSizeToFitWidth:YES];
        UILabel *nianh = [[UILabel alloc] initWithFrame:CGRectMake(0, hight/400*190, wieth, hight/400*22)];
        nianh.textAlignment = NSTextAlignmentCenter;
        nianh.text = @"年化收益率(百分比)";
        [nianh setAdjustsFontSizeToFitWidth:YES];
        nianh.font = [UIFont systemFontOfSize:11];
        nianh.textColor = [UIColor whiteColor];
        [_line addSubview:nianh];
        
        _wanyuanmoney = [[UILabel alloc] initWithFrame:CGRectMake(wieth/16*3.5, hight/400*260, wieth/4, hight/400*30)];
        _wanyuanmoney.textAlignment = NSTextAlignmentCenter;
        _wanyuanmoney.text = data.earningsOf10thousand;
        _wanyuanmoney.font = [UIFont boldSystemFontOfSize:15];
        [_wanyuanmoney setAdjustsFontSizeToFitWidth:YES];
        _wanyuanmoney.textColor = [UIColor whiteColor];
        [_line addSubview:_wanyuanmoney];
        UILabel *wanyuan = [[UILabel alloc] initWithFrame:CGRectMake(wieth/16*3.5, hight/400*295, wieth/4, hight/400*22)];
        wanyuan.textAlignment = NSTextAlignmentCenter;
        wanyuan.text = @"万元收益(元)";
        [wanyuan setAdjustsFontSizeToFitWidth:YES];
        wanyuan.font = [UIFont systemFontOfSize:11];
        wanyuan.textColor = [UIColor whiteColor];
        [_line addSubview:wanyuan];
        
        _zhouqi = [[UILabel alloc] initWithFrame:CGRectMake(wieth/16*8.5, hight/400*260, wieth/4, hight/400*30)];
        _zhouqi.textAlignment = NSTextAlignmentCenter;
        _zhouqi.font = [UIFont boldSystemFontOfSize:15];
        _zhouqi.textColor = [UIColor whiteColor];
        [_zhouqi setAdjustsFontSizeToFitWidth:YES];
        _zhouqi.text = [NSString stringWithFormat:@"%@",data.time];//data.time;
        [_line addSubview:_zhouqi];
        UILabel *zhouq = [[UILabel alloc] initWithFrame:CGRectMake(wieth/16*8.5, hight/400*295, wieth/4, hight/400*22)];
        zhouq.textAlignment = NSTextAlignmentCenter;
        zhouq.text = @"理财周期(天)";
        [zhouq setAdjustsFontSizeToFitWidth:YES];
        zhouq.font = [UIFont systemFontOfSize:11];
        zhouq.textColor = [UIColor whiteColor];
        [_line addSubview:zhouq];
        if (index == 0) {
            self.img0 = _line;
            
            //            self.img0.hidden = NO;
        }
        if (index == 1) {
            self.img1 = _line;
            //            self.img1.hidden = YES;
        }
        if (index == 2) {
            self.img2 = _line;
            //            self.img2.hidden = YES;
        }
    }
    
    [self kongzhi];
    
    return view;
}


-(void)CTreasureMoneyNewCell {
    ProfitRegularBrief *data = _model[self.index];
    TreasureMoneyProductViewController *TMPVC = [[TreasureMoneyProductViewController alloc] init];
    TMPVC.regularID = data.regularID;//[_model[index][@"regularID"] integerValue];
    [[YXBTool getCurrentNav] pushViewController:TMPVC animated:YES];
}
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    
    if (self.index == index) {
        ProfitRegularBrief *data = _model[index];
        TreasureMoneyProductViewController *TMPVC = [[TreasureMoneyProductViewController alloc] init];
        TMPVC.regularID = data.regularID;//[_model[index][@"regularID"] integerValue];
        [[YXBTool getCurrentNav] pushViewController:TMPVC animated:YES];
    }
    self.index = index;
    [self kongzhi];
    
}


@end

