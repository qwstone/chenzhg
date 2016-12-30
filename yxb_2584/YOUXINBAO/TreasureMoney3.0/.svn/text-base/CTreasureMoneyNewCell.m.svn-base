//
//  TreasureMoneyNewCell.m
//  YOUXINBAO
//
//  Created by zjp on 15/9/22.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "CTreasureMoneyNewCell.h"
#import "YXBTool.h"
#import "PayHomeViewController.h"
#import "CTreasureMoneyOneView.h"
@implementation CTreasureMoneyNewCell {
    UILabel *_zuorimoney;
    UILabel *_lishirimoney;
    UILabel *_dangqianmoney;
    UILabel *_wanyuanmoney;
    UIView *bgview;
    UIView *bgview2;
    CTreasureMoneyOneView *onev;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *arr = @[@"理财赚钱",@"余额赚钱"];
//        NSArray *arrimg = @[@"newbzq-yue-gray",@"newbzq-qd-gray"];
//        NSArray *arrlit = @[@"newbzq-yue-red",@"newbzq-qd-red"];
        SelectView *view = [[SelectView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth/375*50) WithArray:arr imgArray:nil imgArraylight:nil];
        view.delegate =self;
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/2, 12, 0.5, 23)];
        line1.backgroundColor = rgb(220, 220, 220, 1);
        [view addSubview:line1];
        
        bgview = [[UIView alloc] initWithFrame:CGRectMake(0, view.bottom, kDeviceWidth, kDeviceWidth/375*330)];
//        bgview.backgroundColor = [UIColor brownColor];
        [self.contentView addSubview:bgview];
//                self.contentView.backgroundColor = [UIColor grayColor];
        bgview2 = [[UIView alloc] initWithFrame:CGRectMake(0, view.bottom, kDeviceWidth, kDeviceWidth/375*380-50)];
//        bgview2.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:bgview2];
        
        
        bgview.hidden = YES;
        bgview2.hidden = NO;
        
        onev = [[CTreasureMoneyOneView alloc]initWithFrame:CGRectMake(0, 15, kDeviceWidth, 200)];
        [bgview2 addSubview:onev];

        _zuorimoney = [[UILabel alloc] initWithFrame:CGRectMake(15, kDeviceWidth/375*10, kDeviceWidth-30, kDeviceWidth/375*60)];
        _zuorimoney.textAlignment = NSTextAlignmentCenter;
        _zuorimoney.font = [UIFont boldSystemFontOfSize:58];
        [_zuorimoney setAdjustsFontSizeToFitWidth:YES];
        _zuorimoney.textColor = [YXBTool colorWithHexString:@"#ED2E24"];
        [bgview addSubview:_zuorimoney];
        UILabel *zri = [[UILabel alloc] initWithFrame:CGRectMake(0, kDeviceWidth/375*70, kDeviceWidth, 20)];
        zri.text = @"昨日余额收益(元)";
        zri.font = [UIFont systemFontOfSize:14];
        zri.textAlignment = NSTextAlignmentCenter;
        zri.textColor = [YXBTool colorWithHexString:@"#808080"];
        [bgview addSubview:zri];
        
        UIButton *buttonsy = [[UIButton alloc] initWithFrame:CGRectMake((kDeviceWidth-(143+kDeviceWidth/750*30))/2, kDeviceWidth/375*110, 143/2, 47/2)];
        buttonsy.tag = 1122;
        [buttonsy setBackgroundImage:[UIImage imageNamed:@"suishicq"] forState:UIControlStateNormal];
        [buttonsy addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
        [bgview addSubview:buttonsy];
        
        UIButton *buttongao = [[UIButton alloc] initWithFrame:CGRectMake(buttonsy.right+kDeviceWidth/750*30, kDeviceWidth/375*110, 143/2, 47/2)];
        buttongao.tag = 2233;
        [buttongao setBackgroundImage:[UIImage imageNamed:@"gaosy"] forState:UIControlStateNormal];
        [buttongao addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
        [bgview addSubview:buttongao];
        
        
        UILabel *linem = [[UILabel alloc] initWithFrame:CGRectMake(15, kDeviceWidth/375*150, kDeviceWidth-30, 0.5f)];
        linem.backgroundColor = [UIColor lightGrayColor];
        [bgview addSubview:linem];
  
        
        _lishirimoney = [[UILabel alloc] initWithFrame:CGRectMake(0, kDeviceWidth/375*168, kDeviceWidth/3, 25)];
        //        _lishirimoney.text = @"111.4";
        _lishirimoney.font = [UIFont boldSystemFontOfSize:25];
        _lishirimoney.textAlignment = NSTextAlignmentCenter;
        _lishirimoney.textColor = rgb(218, 44, 44, 1);
        [_lishirimoney setAdjustsFontSizeToFitWidth:YES];
        [bgview addSubview:_lishirimoney];
        UILabel *lishi = [[UILabel alloc] initWithFrame:CGRectMake(0, kDeviceWidth/375*170+20, kDeviceWidth/3, 20)];
        lishi.text = @"历史收益(元)";
        lishi.font = [UIFont systemFontOfSize:11];
        lishi.textAlignment = NSTextAlignmentCenter;
        lishi.textColor = [YXBTool colorWithHexString:@"#808080"];
        [bgview addSubview:lishi];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/3,kDeviceWidth/375*170, 0.5, 40)];
        line.backgroundColor = rgb(220, 220, 220, 1);
        [bgview addSubview:line];
        
        _dangqianmoney = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/3, kDeviceWidth/375*168, kDeviceWidth/3, 25)];
        _dangqianmoney.textAlignment = NSTextAlignmentCenter;
        [_dangqianmoney setAdjustsFontSizeToFitWidth:YES];
        //        _dangqianmoney.text = @"123.5";
        _dangqianmoney.textColor = rgb(218, 44, 44, 1);
        _dangqianmoney.font = [UIFont boldSystemFontOfSize:20];
        [bgview addSubview:_dangqianmoney];
        UILabel *dangqian = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/3, kDeviceWidth/375*170+20, kDeviceWidth/3, 20)];
        dangqian.textAlignment = NSTextAlignmentCenter;
        dangqian.text = @"当前余额(元)";
        dangqian.font = [UIFont systemFontOfSize:11];
        dangqian.textColor = [YXBTool colorWithHexString:@"#808080"];
        [bgview addSubview:dangqian];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/3*2,kDeviceWidth/375*170, 0.5, 40)];
        line2.backgroundColor = rgb(220, 220, 220, 1);
        [bgview addSubview:line2];
        
        _wanyuanmoney = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/3*2, kDeviceWidth/375*168, kDeviceWidth/3, 25)];
        _wanyuanmoney.textAlignment = NSTextAlignmentCenter;
        [_wanyuanmoney setAdjustsFontSizeToFitWidth:YES];
        //        _wanyuanmoney.text = @"222.67";
        _wanyuanmoney.font = [UIFont boldSystemFontOfSize:20];
        _wanyuanmoney.textColor = rgb(218, 44, 44, 1);
        [bgview addSubview:_wanyuanmoney];
        UILabel *wanyuan = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/3*2, kDeviceWidth/375*170+20, kDeviceWidth/3, 20)];
        wanyuan.textAlignment = NSTextAlignmentCenter;
        wanyuan.text = @"万元收益(元)";
        wanyuan.font = [UIFont systemFontOfSize:11];
        wanyuan.textColor = [YXBTool colorWithHexString:@"#808080"];
        [bgview addSubview:wanyuan];
        
        
        UILabel *xieyi = [[UILabel alloc] initWithFrame:CGRectMake(0, bgview.height-bottomHight-20, kDeviceWidth, 14)];
        xieyi.textAlignment = NSTextAlignmentCenter;
        xieyi.text = @"此项目由全彩时代网络科技有限公司安全担保";
        xieyi.font = [UIFont systemFontOfSize:12];
        xieyi.textColor = [YXBTool colorWithHexString:@"#969696"];
        [bgview addSubview:xieyi];
        UIImageView *botview = [[UIImageView alloc] initWithFrame:CGRectMake((kDeviceWidth-[YXBTool getFontSizeWithString:xieyi.text font:xieyi.font constrainSize:CGSizeMake(1000, 14)].width)/2-15, bgview.height-bottomHight-20, 12, 14)];
        botview.image = [UIImage imageNamed:@"CTMbj"];
        [bgview addSubview:botview];
        
        UILabel *xieyi1 = [[UILabel alloc] initWithFrame:CGRectMake(0, bgview.height-bottomHight-20, kDeviceWidth, 14)];
        xieyi1.textAlignment = NSTextAlignmentCenter;
        xieyi1.text = @"此项目由无忧借条科技有限公司安全担保";
        xieyi1.font = [UIFont systemFontOfSize:12];
        xieyi1.textColor = [YXBTool colorWithHexString:@"#969696"];
        [bgview2 addSubview:xieyi1];
        UIImageView *botview1 = [[UIImageView alloc] initWithFrame:CGRectMake((kDeviceWidth-[YXBTool getFontSizeWithString:xieyi1.text font:xieyi1.font constrainSize:CGSizeMake(1000, 14)].width)/2-15, bgview.height-bottomHight-20, 12, 14)];
        botview1.image = [UIImage imageNamed:@"CTMbj"];
        [bgview2 addSubview:botview1];
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
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(9, 8, (kDeviceWidth-10)*0.8, (botview.height-10)*0.85)];
    button.tag = 888;
    [button setBackgroundImage:[UIImage imageNamed:@"chargeEarn"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(bottomAction:) forControlEvents:UIControlEventTouchUpInside];
    [botview addSubview:button];
    
    
    //64*88
    UIButton *count = [[UIButton alloc] initWithFrame:CGRectMake(button.right+10, button.top,button.height, button.height)];
    count.tag = 999;
    [count setBackgroundImage:[UIImage imageNamed:@"shouyijs"] forState:UIControlStateNormal];
    [count addTarget:self action:@selector(bottomAction:) forControlEvents:UIControlEventTouchUpInside];
    [botview addSubview:count];
    
    UIView *botview22 = [[UIView alloc] initWithFrame:CGRectMake(0,bgview2.height-bottomHight, kDeviceWidth, bottomHight)];
    botview22.backgroundColor = rgb(244, 244, 244, 1);
    //    view.backgroundColor = [UIColor redColor];
    [bgview2 addSubview:botview22];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(9, 5, kDeviceWidth-20, botview.height-10)];
    button2.layer.cornerRadius = 3;
    button2.backgroundColor = rgb(218, 44, 44, 1);
    [button2 setTitle:@"我要理财" forState:UIControlStateNormal];
    button2.tag = 777;
    [button2 addTarget:self action:@selector(bottomAction:) forControlEvents:UIControlEventTouchUpInside];
    [botview22 addSubview:button2];
}


- (void)butAction:(UIButton *)sender {
    if (sender.tag == 1122) {
        
    }else if (sender.tag == 2233){
    
    }

}

- (void)bottomAction:(UIButton *)sender {

    if (sender.tag == 888) {
//        NSLog(@"充值赚钱");
//        
//        if (_delegate && [_delegate respondsToSelector:@selector(chongzhi)]) {
//            [_delegate chongzhi];
//        }
        PayHomeViewController *controller = [[PayHomeViewController alloc] init];
        [[YXBTool getCurrentNav] pushViewController:controller animated:YES];
        
    }else if (sender.tag == 999){
        _jisuanview = [[CalculatorViewNew alloc] initWithFrame:[[UIApplication sharedApplication].delegate window].bounds];
        _jisuanview.delegate = self;
        _jisuanview.lilv = _model.interestRate;
        [[[UIApplication sharedApplication].delegate window] addSubview:_jisuanview];
    }else if (sender.tag == 777){
        [onev CTreasureMoneyNewCell];
//        NSString * string = @"友信宝理财赚钱项目即将开放，项目团队正在努力开发，争取尽快为您带来高收益、安全可靠的理财产品，敬请关注";
//        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:nil message: string delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alertView show];
    }
    
}
#pragma mark --- CalculatorViewDelegate
- (void)pushChongzhiWebView {
    //    NSString *payUrl = @"http://60.195.254.33:8083/charge/recharge.jsp?a=23";
    //    [YXBTool jumpSafariWithUrl:[YXBTool getURL:payUrl params:nil]];
    PayHomeViewController *pay = [[PayHomeViewController alloc] init];
    [[YXBTool getCurrentNav] pushViewController:pay animated:YES];
    
}

- (void)setModel:(ProfitHomeDataV3 *)model {
    if (_model != model) {
        _model = model;
        _zuorimoney.text = _model.yestodayMoney;
        if ([_model.yestodayMoney floatValue] <= 0) {
            _zuorimoney.text = @"暂无收益";
        }
        _lishirimoney.text = _model.historyMoney;
        _dangqianmoney.text = _model.moneyOfAccount;
        _wanyuanmoney.text = _model.profitOf10thousand;
        onev.model = model.iProfitRegularBrief;
    }
}


#pragma SelectViewDelegate
- (void)SelectViewSelectedIndex:(NSInteger)index {
    NSLog(@"%ld",(long)index);
    if ([self.delegate respondsToSelector:@selector(CTreasureMoneyNewCell:)]) {
        [self.delegate CTreasureMoneyNewCell:index];
    }
    if (index == 1) {
        bgview.hidden = NO;
        bgview2.hidden = YES;
    }else if (index ==0) {
        bgview.hidden = YES;
        bgview2.hidden = NO;
    }
}


@end
