//
//  BaoHongLiView.h
//  YOUXINBAO
//
//  Created by zjp on 16/1/28.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfitHomeDataV3.h"
#import "CalculatorViewNew.h"
@interface BaoHongLiView : UIView<UITableViewDataSource,UITableViewDelegate,CalculatorViewNewDelegate>{
    UILabel *_lishirimoney;
    UILabel *_dangqianmoney;
    UILabel *_wanyuanmoney;
    CalculatorViewNew  *_jisuanview;
}

@property(nonatomic,strong)UITableView        *HomeLiseTableView;//滑动列表
@property(nonatomic,strong)NSMutableArray       *listData;

@property(nonatomic,strong)ProfitHomeDataV3 *model;
@property(nonatomic,strong)UILabel *userNumberLabel;
@property(nonatomic,strong)UILabel *moneyLabel;
@property(nonatomic,strong)UILabel *zrhongli;
@end
