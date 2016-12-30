//
//  QCBaseTableView.h
//  YOUXINBAO
//
//  Created by CH10 on 15/4/30.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
@class QCBaseTableView;

@protocol QCBaseTableViewDelegate <NSObject>

@optional
//下拉刷新
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView;

@end

@interface QCBaseTableView : UITableView<MJRefreshBaseViewDelegate>

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style refreshFooter:(BOOL)yesOrNo;

//结束刷新状态，请求结束时调用
- (void)reloadDeals;

// 开始刷新
- (void)beginRefreshing;

@property (nonatomic,assign) id<QCBaseTableViewDelegate> refreshDelegate;
@property (nonatomic,assign) BOOL hasFooter;    //是否添加上拉加载视图
@property (nonatomic,assign) BOOL isRefresh;

@end
