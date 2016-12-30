//
//  XLCycleScrollView.h
//  CycleScrollViewDemo
//
//  Created by xie liang on 9/14/12.
//  Copyright (c) 2012 xie liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QCCycleScrollViewDelegate;
@protocol QCCycleScrollViewDatasource;

@interface QCCycleScrollView : UIView<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    
//    id<QCCycleScrollViewDelegate> _delegate;
//    id<QCCycleScrollViewDatasource> _datasource;
    
    NSInteger _totalPages;
    NSInteger _curPage;
    
    NSMutableArray *_curViews;
}

@property (nonatomic,readonly) UIScrollView *scrollView;
@property (nonatomic,readonly) UIPageControl *pageControl;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,assign,setter = setDataource:) id<QCCycleScrollViewDatasource> datasource;
@property (nonatomic,assign,setter = setDelegate:) id<QCCycleScrollViewDelegate> delegate;

- (void)reloadData;
- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index;

- (void)pageUp;     //上一页
- (void)pageDown;   //下一页

@end

@protocol QCCycleScrollViewDelegate <NSObject>

@optional
- (void)didClickPage:(QCCycleScrollView *)csView atIndex:(NSInteger)index;

@end

@protocol QCCycleScrollViewDatasource <NSObject>

@required
- (NSInteger)numberOfPages;
- (UIView *)pageAtIndex:(NSInteger)index;

@end
