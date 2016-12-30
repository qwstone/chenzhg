//
//  NoticeScrollView.h
//  YOUXINBAO
//
//  Created by zjp on 15/5/20.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "HomeModel.h"

@protocol HomeTopScorllViewDelegate <NSObject>
@optional
- (void)HomeTopScorllViewAction:(NSInteger)index info:(NSString *)info type:(NSString *)type;

@end

@interface NoticeScrollView : UIView<UIScrollViewDelegate> {
    BOOL                _isDragging;
    NSInteger           timeNum;
}

@property (nonatomic, assign) id<HomeTopScorllViewDelegate> delegate;
@property(nonatomic,strong)UIImageView      *noticeImg;
@property(nonatomic,strong)UIImageView      *noticeImgs;
@property(nonatomic,strong)NSMutableArray   *imgMuArray;//图片数据
@property(nonatomic,strong)HomeModel        *model;

@property(nonatomic,assign)BOOL             isNoData;
@property(nonatomic,copy)NSString      *noticeImgnomel;//默认图片

@property(nonatomic,strong)UIScrollView     *scrollView;
@property(nonatomic, strong)UIPageControl   *pageControl;


- (void)CPBTimerManagerAction;//在定时器方法里调用此方法 开启定时滚动
@end
