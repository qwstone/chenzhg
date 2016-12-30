//
//  AAFlowView.h
//  YOUXINBAO
//
//  Created by CH10 on 15/4/1.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AAImageTableViewCell.h"
@class AAFlowView;

@protocol AAFlowViewDelegate <NSObject>

/*
 返回每个cell的高度
 */
- (CGFloat)AAFlowView:(AAFlowView *)flowView heightForRowAtIndexPath:(IndexPath *)indexPath;


/*
 跟据参数indexPath的行列属性，定位哪行哪列被选中
 */
- (void)AAFlowView:(AAFlowView *)flowView didSelectRowAtIndexPath:(IndexPath *)indexPath;


@end


@protocol AAFlowViewDataSource<NSObject>

/*
 配置每个cell的子视图，添加返回的视图到cell上
 */

- (UIView *)AAFlowView:(AAFlowView *)flowView cellForRowAtIndexPath:(IndexPath *)indexPath;

/*
 将cell上的子视图传出，方便自定义子视图的样式，实现个性化定制
 */
-(void)AAFlowView:(AAFlowView *)flowView relayoutCellSubview:(UIView *)view withIndexPath:(IndexPath *)indexPath;


/*
 返回瀑布效果的列数
 */
- (NSInteger)numberOfColumsInAAFlowView:(AAFlowView *)flowView;

/*
 返回cell的总数，每个cell的行号通过总数和列号来确定
 */
- (NSInteger)numberOfAllAAFlowView:(AAFlowView *)flowView;

@end


@interface AAFlowView : UIScrollView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign) NSInteger columnCount;
@property (nonatomic,assign) NSInteger cellsTotal;
@property (nonatomic,assign) float cellWidth;
@property (nonatomic,assign) id<AAFlowViewDelegate> AAFlowViewDelegate;
@property (nonatomic,assign) id<AAFlowViewDataSource> AAFlowViewDatasource;

- (void)reloadData;
- (NSInteger)AAFlowView:(AAFlowView *)flowView numberOfRowsInColumn:(NSInteger)colunm;
-(void)relayoutDisplaySubviews;

@end
