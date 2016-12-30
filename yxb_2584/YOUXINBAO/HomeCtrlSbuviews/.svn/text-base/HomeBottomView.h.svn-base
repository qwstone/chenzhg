//
//  HomeBottomView.h
//  YOUXINBAO
//
//  Created by zjp on 15/5/20.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeBottomViewDelegate <NSObject>

@optional
- (void)HomeBottomViewAction:(NSInteger)senderTag;

@end

@interface HomeBottomView : UIView <UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)UITableView        *HomeLiseTableView;//滑动列表
@property (nonatomic, assign) id<HomeBottomViewDelegate> delegate;
@property(nonatomic,strong)NSMutableArray   *bottomViewMuArray;

@property(nonatomic,assign)BOOL             isNoData;
@property(nonatomic,strong)UILabel          *noLoanTextLabel;
@property(nonatomic,strong)UIImageView       *noLoanimg;

@property(nonatomic,strong)UIButton         *hasNewfbut;
@end
