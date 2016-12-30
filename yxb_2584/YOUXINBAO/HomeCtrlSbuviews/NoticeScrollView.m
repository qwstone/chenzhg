//
//  NoticeScrollView.m
//  YOUXINBAO
//
//  Created by zjp on 15/5/20.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "NoticeScrollView.h"
#import "YXBTool.h"
@implementation NoticeScrollView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.noticeImgs = [[UIImageView alloc] initWithFrame:self.bounds];
        self.noticeImgs.userInteractionEnabled = YES;
        [self addSubview:self.noticeImgs];
        UIButton *button = [[UIButton alloc] initWithFrame:self.noticeImgs.bounds];
        button.tag = 10086;
        [button addTarget:self action:@selector(jumpButAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.noticeImgs addSubview:button];
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentOffset = CGPointMake(self.bounds.size.width, self.bounds.size.height);
            _scrollView.contentSize = CGSizeMake(kDeviceWidth,self.frame.size.height);
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = YES;
        _scrollView.bounces = NO;
//        [_scrollView setBackgroundColor:[UIColor greenColor]];
        _scrollView.tag = 11111;
        [self addSubview:_scrollView];

        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, frame.size.height-20, kDeviceWidth, 20)];
//        _pageControl.userInteractionEnabled = NO;
        [_pageControl setBackgroundColor:[UIColor clearColor]];
        _pageControl.autoresizingMask = UIViewAutoresizingNone;
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = 1;
        [_pageControl addTarget:self action:@selector(pageAction:)
               forControlEvents:UIControlEventValueChanged];
        [self addSubview:_pageControl];
    }
    return self;
}

- (void)setNoticeImgnomel:(NSString *)noticeImgnomel {
    if (_noticeImgnomel != noticeImgnomel) {
        _noticeImgnomel = noticeImgnomel;
        self.noticeImgs.image = [UIImage imageNamed:self.noticeImgnomel];
    }
}


- (void)CPBTimerManagerAction {
    if (_isDragging == NO) {
        
        if (self.imgMuArray.count > 1){
            timeNum ++;
            if (timeNum == 2) {//定时器 每调用两次，滑动一次
                timeNum = 0;
                
                CGPoint p = self.scrollView.contentOffset;
                p.x += self.scrollView.bounds.size.width;
                
                if (p.x == (self.scrollView.contentSize.width-kDeviceWidth)){
                    [UIView animateWithDuration:2.0 animations:^{
                        self.scrollView.contentOffset = p;
                    } completion:^(BOOL finished) {
                        [self.scrollView setContentOffset:CGPointMake(kDeviceWidth, 0.0f) animated:NO];
                    }];
                }
                
                if (p.x > (self.scrollView.contentSize.width-kDeviceWidth)){
                    p.x = 0;
                    self.scrollView.contentOffset = p;
                }
                
                if (p.x != 0) {
                    [UIView beginAnimations:nil context:nil];
                    [UIView setAnimationDuration:2.0];
                    self.scrollView.contentOffset = p;
                    [UIView commitAnimations];
                }
            }

        }
    }
    
}


- (void)setImgMuArray:(NSMutableArray *)imgMuArray {

        _imgMuArray = imgMuArray;
        [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        _pageControl.numberOfPages = 1;
        [self createView];


}

//- (void)setIsNoData:(BOOL)isNoData {
//    if (_isNoData != isNoData) {
//        _isNoData = isNoData;
//        
//        if (_isNoData == YES) {
//            [self noDataView];
//        }else if (_isNoData == NO){
//            if (_noticeImgnomel != nil) {
//                [_noticeImgnomel removeFromSuperview];
//            }
//            [self createView];
//        }
//    }
//}
//
//
////没有数据时显示的视图
//- (void)noDataView {
//    _scrollView.contentSize = CGSizeMake(kDeviceWidth,self.frame.size.height);
//    [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    _noticeImgnomel = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, self.height)];
//    [_scrollView addSubview:_noticeImgnomel];
//    UIImage *img = [UIImage imageNamed:@"banner"];
//    if (kDeviceHeight == 480) {
//        img = [UIImage imageNamed:@"banner-i4"];
//    }else {
//        img = [UIImage imageNamed:@"banner"];
//    }
//    _noticeImgnomel.image = img;
//    _noticeImgnomel.userInteractionEnabled = YES;
//    UIButton *button = [[UIButton alloc] initWithFrame:_noticeImgnomel.frame];
//    button.tag = 10086;
//    [button addTarget:self action:@selector(jumpButAction:) forControlEvents:UIControlEventTouchUpInside];
//    [_noticeImgnomel addSubview:button];
//}

- (void)createView {

    if (_imgMuArray.count >= 2) {
        [_imgMuArray insertObject:_imgMuArray.lastObject atIndex:0];
        [_imgMuArray addObject:[_imgMuArray objectAtIndex:1]];
    }
    _scrollView.contentSize = CGSizeMake(kDeviceWidth*_imgMuArray.count,self.frame.size.height);
    [_scrollView setContentOffset:CGPointMake(kDeviceWidth, 0.0f) animated:NO];
    for (int i = 0; i < _imgMuArray.count; i++) {
        self.model = _imgMuArray[i];
        _noticeImg = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth*i, 0, kDeviceWidth, self.frame.size.height)];
        _noticeImg.userInteractionEnabled = YES;
        [_noticeImg sd_setImageWithURL:[NSURL URLWithString:self.model.imgUrl] placeholderImage:[UIImage imageNamed:self.noticeImgnomel]];
        [_scrollView addSubview:_noticeImg];
        UIButton *button = [[UIButton alloc] initWithFrame:_noticeImg.bounds];
        button.tag = i;
        [button addTarget:self action:@selector(jumpButAction:) forControlEvents:UIControlEventTouchUpInside];
        [_noticeImg addSubview:button];
    }
        _pageControl.numberOfPages = _imgMuArray.count-2;
}



//button 点击事件
- (void)jumpButAction:(UIButton *)sender {
    if (sender.tag == 10086) {
        NSLog(@"没网时,显示的公告！");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无网络连接" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else {
        HomeModel  *model = nil;
        if (self.imgMuArray.count > 0) {
            model = self.imgMuArray[sender.tag];
        }

        if ([self.delegate respondsToSelector:@selector(HomeTopScorllViewAction:info:type:)]) {
            [self.delegate HomeTopScorllViewAction:sender.tag info:model.val type:model.type];
        }
    }

}




#pragma mark --- scrollView
- (void)pageAction:(UIPageControl *)pageControl {
    
    NSInteger page = pageControl.currentPage;
    NSInteger offsetX = page * kDeviceWidth;
    [_scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

//结束减速
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.tag == 11111) {
//        NSLog(@"%ld",(long)scrollView.contentOffset.x);
        int page = scrollView.contentOffset.x / kDeviceWidth;
//        if (page <= self.imgMuArray.count && (page > 0)) {
            _pageControl.currentPage = page-1;
//        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    _isDragging = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.tag == 11111) {
        CGPoint p = scrollView.contentOffset;
        if (p.x >= (_scrollView.contentSize.width-kDeviceWidth)){
            [_scrollView setContentOffset:CGPointMake(kDeviceWidth, 0.0f) animated:NO];
        }
        if (p.x == 0){
            [_scrollView setContentOffset:CGPointMake(_scrollView.contentSize.width-2*kDeviceWidth, 0.0f) animated:NO];
        }
    }
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:1.0f];
}

- (void)delayMethod {
    _isDragging = NO;
}

- (UIViewController *)viewController {
    UIResponder *next = self.nextResponder;
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
    }while(next != nil);
    return nil;
}
@end
