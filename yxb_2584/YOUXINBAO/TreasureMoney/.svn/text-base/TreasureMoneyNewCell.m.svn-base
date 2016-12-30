//
//  TreasureMoneyNewCell.m
//  YOUXINBAO
//
//  Created by zjp on 15/9/22.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "TreasureMoneyNewCell.h"
#import "YXBTool.h"
#import "PayHomeViewController.h"

@implementation TreasureMoneyNewCell {
    UILabel *_zuorimoney;
    UILabel *_lishirimoney;
    UILabel *_dangqianmoney;
    UILabel *_wanyuanmoney;
    UIView *bgview;
    UIView *bgview2;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *arr = @[@"余额赚钱",@"理财赚钱"];
        NSArray *arrimg = @[@"newbzq-yue-gray",@"newbzq-qd-gray"];
        NSArray *arrlit = @[@"newbzq-yue-red",@"newbzq-qd-red"];
        SelectView *view = [[SelectView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth/375*50) WithArray:arr imgArray:arrimg imgArraylight:arrlit];
        view.delegate =self;
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/2, 12, 0.5, 23)];
        line1.backgroundColor = rgb(220, 220, 220, 1);
        [view addSubview:line1];
        
        bgview = [[UIView alloc] initWithFrame:CGRectMake(0, view.bottom, kDeviceWidth, kDeviceWidth/375*330)];
        [self.contentView addSubview:bgview];
//        self.contentView.backgroundColor = [UIColor redColor];
        bgview2 = [[UIView alloc] initWithFrame:CGRectMake(0, view.bottom, kDeviceWidth, kDeviceWidth/375*380-50)];
        [self.contentView addSubview:bgview2];
        
        
        bgview.hidden = NO;
        bgview2.hidden = YES;
        
        _carousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 15, kDeviceWidth, kDeviceWidth/375*200)];
        _carousel.delegate = self;
//        _carousel.backgroundColor = [UIColor redColor];
        _carousel.dataSource = self;
        _carousel.type = iCarouselTypeRotary;
        _carousel.centerItemWhenSelected = YES;
        _carousel.decelerationRate = 0.1;
//        _carousel.perspective = 0.1;
        [bgview2 addSubview:_carousel];
        
        UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake((kDeviceWidth-280)/2, _carousel.bottom+kDeviceWidth/320*10, 280, 16)];
        img2.image = [UIImage imageNamed:@"newbzq-abtxt"];
        [bgview2 addSubview:img2];
        
        
        UILabel *zuori = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 100, 20)];
        zuori.text = @"上次收益(元)";
        zuori.textColor = [YXBTool colorWithHexString:@"#969696"];
        [bgview addSubview:zuori];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth-80, 20, 65, 20)];
        img.image = [UIImage imageNamed:@"newbzq-scsq"];
        [bgview addSubview:img];
        
        _zuorimoney = [[UILabel alloc] initWithFrame:CGRectMake(15, kDeviceWidth/375*80-23, kDeviceWidth-30, 100)];
        _zuorimoney.textAlignment = NSTextAlignmentCenter;
        _zuorimoney.font = [UIFont boldSystemFontOfSize:80];
        [_zuorimoney setAdjustsFontSizeToFitWidth:YES];
        _zuorimoney.textColor = [YXBTool colorWithHexString:@"#EF5D29"];
        [bgview addSubview:_zuorimoney];
        UIImageView *img3 = [[UIImageView alloc] initWithFrame:CGRectMake((kDeviceWidth-kDeviceWidth/320*207)/2, _zuorimoney.bottom, kDeviceWidth/320*207, kDeviceWidth/320*18)];
        img3.contentMode = UIViewContentModeScaleAspectFit;
        img3.image = [UIImage imageNamed:@"txttt"];
        [bgview addSubview:img3];
        
        _lishirimoney = [[UILabel alloc] initWithFrame:CGRectMake(0, kDeviceWidth/375*200, kDeviceWidth/3, 20)];
//        _lishirimoney.text = @"111.4";
        _lishirimoney.font = [UIFont boldSystemFontOfSize:20];
        _lishirimoney.textAlignment = NSTextAlignmentCenter;
        _lishirimoney.textColor = [UIColor darkGrayColor];
        [_lishirimoney setAdjustsFontSizeToFitWidth:YES];
        [bgview addSubview:_lishirimoney];
        UILabel *lishi = [[UILabel alloc] initWithFrame:CGRectMake(0, kDeviceWidth/375*200+20, kDeviceWidth/3, 20)];
        lishi.text = @"历史收益(元)";
        lishi.font = [UIFont boldSystemFontOfSize:14];
        lishi.textAlignment = NSTextAlignmentCenter;
        lishi.textColor = [YXBTool colorWithHexString:@"#969696"];
        [bgview addSubview:lishi];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/3,kDeviceWidth/375*200, 0.5, 40)];
        line.backgroundColor = rgb(220, 220, 220, 1);
        [bgview addSubview:line];
        
        _dangqianmoney = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/3, kDeviceWidth/375*200, kDeviceWidth/3, 20)];
        _dangqianmoney.textAlignment = NSTextAlignmentCenter;
         [_dangqianmoney setAdjustsFontSizeToFitWidth:YES];
//        _dangqianmoney.text = @"123.5";
        _dangqianmoney.textColor = [UIColor darkGrayColor];
        _dangqianmoney.font = [UIFont boldSystemFontOfSize:20];
        [bgview addSubview:_dangqianmoney];
        UILabel *dangqian = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/3, kDeviceWidth/375*200+20, kDeviceWidth/3, 20)];
        dangqian.textAlignment = NSTextAlignmentCenter;
        dangqian.text = @"当前余额(元)";
        dangqian.font = [UIFont boldSystemFontOfSize:14];
        dangqian.textColor = [YXBTool colorWithHexString:@"#969696"];
        [bgview addSubview:dangqian];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/3*2,kDeviceWidth/375*200, 0.5, 40)];
        line2.backgroundColor = rgb(220, 220, 220, 1);
        [bgview addSubview:line2];
        
        _wanyuanmoney = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/3*2, kDeviceWidth/375*200, kDeviceWidth/3, 20)];
        _wanyuanmoney.textAlignment = NSTextAlignmentCenter;
        [_wanyuanmoney setAdjustsFontSizeToFitWidth:YES];
//        _wanyuanmoney.text = @"222.67";
         _wanyuanmoney.font = [UIFont boldSystemFontOfSize:20];
        _wanyuanmoney.textColor = [UIColor darkGrayColor];
        [bgview addSubview:_wanyuanmoney];
        UILabel *wanyuan = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/3*2, kDeviceWidth/375*200+20, kDeviceWidth/3, 20)];
        wanyuan.textAlignment = NSTextAlignmentCenter;
        wanyuan.text = @"万元收益(元)";
        wanyuan.font = [UIFont boldSystemFontOfSize:14];
        wanyuan.textColor = [YXBTool colorWithHexString:@"#969696"];
        [bgview addSubview:wanyuan];
       
        [self createBottomView];
    }
    return self;
}
//底部视图
- (void)createBottomView {
    UIView *botview = [[UIView alloc] initWithFrame:CGRectMake(0, bgview.height-bottomHight, kDeviceWidth, bottomHight)];
    botview.backgroundColor = rgb(244, 244, 244, 1);
    //    view.backgroundColor = [UIColor redColor];
    [bgview addSubview:botview];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(9, 8, (kDeviceWidth-10)*0.85, (botview.height-10)*0.85)];
    [button setBackgroundImage:[UIImage imageNamed:@"newbzq-cz-but"] forState:UIControlStateNormal];
    button.tag = 888;
    [button addTarget:self action:@selector(bottomAction:) forControlEvents:UIControlEventTouchUpInside];
    [botview addSubview:button];
    
    
    //64*88
    UIButton *count = [[UIButton alloc] initWithFrame:CGRectMake(button.right+10, button.top,button.height/44*34, button.height)];
    [count setBackgroundImage:[UIImage imageNamed:@"bzq-suan"] forState:UIControlStateNormal];
    count.tag = 999;
    [count addTarget:self action:@selector(bottomAction:) forControlEvents:UIControlEventTouchUpInside];
    [botview addSubview:count];
    
    UIView *botview22 = [[UIView alloc] initWithFrame:CGRectMake(0,bgview2.height-bottomHight, kDeviceWidth, bottomHight)];
    botview22.backgroundColor = rgb(244, 244, 244, 1);
    //    view.backgroundColor = [UIColor redColor];
    [bgview2 addSubview:botview22];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(9, 5, kDeviceWidth-20, botview.height-10)];
    [button2 setBackgroundImage:[UIImage imageNamed:@"newbzq-buy-but"] forState:UIControlStateNormal];
    button2.tag = 777;
    [button2 addTarget:self action:@selector(bottomAction:) forControlEvents:UIControlEventTouchUpInside];
    [botview22 addSubview:button2];
}

- (void)bottomAction:(UIButton *)sender {
    if (sender.tag == 888) {
        NSLog(@"充值赚钱");

        if (_delegate && [_delegate respondsToSelector:@selector(chongzhi)]) {
            [_delegate chongzhi];
        }
        
    }else if (sender.tag == 999){
        _jisuanview = [[CalculatorView alloc] initWithFrame:[[UIApplication sharedApplication].delegate window].bounds];
        _jisuanview.delegate = self;
        _jisuanview.lilv = _model.interestRate;
        [[[UIApplication sharedApplication].delegate window] addSubview:_jisuanview];
    }else if (sender.tag == 777){
        NSString * string = @"无忧借条理财赚钱项目即将开放，项目团队正在努力开发，争取尽快为您带来高收益、安全可靠的理财产品，敬请关注";
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:nil message: string delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }
    
}
#pragma mark --- CalculatorViewDelegate
- (void)pushChongzhiWebView {
    //    NSString *payUrl = @"http://60.195.254.33:8083/charge/recharge.jsp?a=23";
    //    [YXBTool jumpSafariWithUrl:[YXBTool getURL:payUrl params:nil]];
    PayHomeViewController *pay = [[PayHomeViewController alloc] init];
    [[YXBTool getCurrentNav] pushViewController:pay animated:YES];
    
}

- (void)setModel:(ProfitHomeDataV2 *)model {
    if (_model != model) {
        _model = model;
        _zuorimoney.text = _model.yestodayMoney;
        if ([_model.yestodayMoney floatValue] <= 0) {
            _zuorimoney.text = @"暂无收益";
        }
        _lishirimoney.text = _model.historyMoney;
        _dangqianmoney.text = _model.moneyOfAccount;
        _wanyuanmoney.text = _model.profitOf10thousand;
    }
}


#pragma SelectViewDelegate
- (void)SelectViewSelectedIndex:(NSInteger)index {
    NSLog(@"%ld",(long)index);
    if ([self.delegate respondsToSelector:@selector(TreasureMoneyNewCell:)]) {
        [self.delegate TreasureMoneyNewCell:index];
    }
    if (index == 0) {
        bgview.hidden = NO;
        bgview2.hidden = YES;
    }else if (index ==1) {
        bgview.hidden = YES;
        bgview2.hidden = NO;
    }
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
        
        view = [[QCCarouselItem alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth/375*200, kDeviceWidth/375*200) type:index];
        
    }
    
    
    
    return view;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    
    
}
@end
