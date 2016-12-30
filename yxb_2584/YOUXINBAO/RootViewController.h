//
//  RootViewController.h
//  YOUXINBAO
//
//  Created by 张淼 on 15/3/6.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCLoginOneViewController.h"
#import "UIImageView+WebCache.h"
#import "NoticeScrollView.h"
#import "HomeMiddleView.h"
#import "HomeBottomView.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequestDelegate.h"
#import "QCCycleScrollView.h"
#import "HomeBottomTablecell.h"
#import "HomeNewBottomView.h"
@interface RootViewController : QCBaseViewController<loginViewDelegate,UIScrollViewDelegate,HomeBottomViewDelegate,HomeMiddleViewDelegate,HomeTopScorllViewDelegate,HomeNewBottomViewDelegate>


@property(nonatomic,strong)UIImageView  *userInfoImgbg;
@property(nonatomic,strong)UIImageView  *userInfoImg;
@property(nonatomic,strong)UIImageView  *navUserImg;
@property(nonatomic,strong)UILabel      *userName;
@property(nonatomic,strong)UIScrollView  *bgScrollView;
@property(nonatomic,strong)NoticeScrollView  *topView;
@property(nonatomic,strong)HomeMiddleView        *middleView;//中部视图背景图
@property(nonatomic,strong)HomeNewBottomView        *bottomView;//低部视图背景图
@property(nonatomic,assign)BOOL         isLogon;

@property(nonatomic,strong)NSMutableArray   *homeAAListData;
@property(nonatomic,strong)NSMutableArray   *homeTopData;//轮播
@property(nonatomic,strong)NSMutableArray   *homeTopDatasss;//轮播

@property(nonatomic,strong)UIImageView      *noticeImgnomel;//默认图片
@property (retain, nonatomic) HttpOperator* iHttpOperator;


@property (assign, nonatomic) BOOL          isNoHomeData;

@property (assign, nonatomic) NSInteger     timeradd;
@end
