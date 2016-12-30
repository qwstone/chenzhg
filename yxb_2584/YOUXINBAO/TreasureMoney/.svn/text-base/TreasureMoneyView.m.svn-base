//
//  TreasureMoneyView.m
//  YOUXINBAO
//
//  Created by CH10 on 15/6/4.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "TreasureMoneyView.h"
#import "ProfitDetailOfMonth.h"
#import "BonusListController.h"

@implementation TreasureMoneyView

- (void)awakeFromNib {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
    
}

- (void)setData:(ProfitHomeData *)data {
    _data = data;
    
    if (data != nil) {
        ProfitDetailOfMonth *monthDetail = [self.data.iProfitDetailOfMonth objectAtIndex:self.currentMonth];
         _descriptMoney1.height = kDeviceWidth/5.5;
        _descript1.text = monthDetail.descript1;
        _descript2.text = monthDetail.descript2;
        [_descriptMoney1 numberFrom:0 to:monthDetail.money1.doubleValue fitFontSize:YES style:QCCountLabelStyleRedbag];
        _descriptMoney2.text = monthDetail.money2;
    }
}

- (IBAction)tapAction:(UITapGestureRecognizer *)sender {
    BonusListController *bonusCtrl=[[BonusListController alloc]init];

    [self.viewController.navigationController pushViewController:bonusCtrl animated:YES];
}

- (void)drawRect:(CGRect)rect {
    CGFloat width = kDeviceWidth-30;
    _descript1.top = width/302.5*62.5;
    _descriptMoney1.top = width/302.5*105;
    _hbbgX.top = width/302.5*200;
    _descript2.top = width/302.5*215;
    _descriptMoney2.top = width/302.5*245;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
