//
//  YXBHomeController.h
//  YOUXINBAO
//
//  Created by zjp on 16/1/26.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "NoticeScrollView.h"
#import "HomeCtrMidView.h"
#import "HomeCtrBotView.h"
#import "HomeOfShiXinView.h"
#import "GongGaoView.h"
#import "BaoHongLiView.h"
#import "CPBTimerManager.h"
#import "QCDeviceModel.h"
#import "QCDeviceManager.h"
#import "DishonestUser.h"

@class LiCaiViewOfHome;

@interface YXBHomeController : QCBaseViewController <HomeTopScorllViewDelegate,QCBaseTableViewDelegate,CPBTimerDelegate,UIScrollViewDelegate> {
    CPBTimerManager             *_timerManager;
    NSInteger                   _timeHomeRequest;
    UIScrollView                *_guideChartscrollView;   
    NSInteger                       postion;
   }

@property(nonatomic,strong)UIView *bgview;
@property(nonatomic,strong)UIScrollView  *bgScrollView;
@property(nonatomic,strong)NoticeScrollView  *topView;
@property(nonatomic,strong)HomeCtrMidView *midView;
@property(nonatomic,strong)HomeCtrBotView *botView;
@property(nonatomic,strong)GongGaoView *gonggao;
@property(nonatomic,strong)BaoHongLiView *gonggaoqqq;
@property(nonatomic,strong)HomeOfShiXinView *homeofshixinView;
@property (nonatomic,strong)QCBaseTableView *tableView;

@property (strong, nonatomic) DishonestUser * Dishonestmodel;
@property(nonatomic,strong)LiCaiViewOfHome *licaiNew;
@property(nonatomic,strong)NSMutableArray   *homeTopData;//轮播
@property(nonatomic,strong)NSDictionary   *homeShiXinData;//失信大厅
@property(nonatomic,strong)NSDictionary   *licaidic;//理财
@property(nonatomic,strong)NSDictionary   *hongbaodic;//红包

@end
