//
//  AADetailsSecondView.m
//  YOUXINBAO
//
//  Created by CH10 on 15/3/18.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AADetailsSecondView.h"
//#import "RongLocationViewController.h"
#import "UIImageView+WebCache.h"
#import "AAImageViewController.h"

@implementation AADetailsSecondView {
    myUILabel *_label;
    UIImageView *_imageView;
    UIButton *_imageButton;
    UIView      *_bgView;
//    UIWebView *_webView;
    UIImageView *zpq;
    
//    UIView *_footerView;
//    UIPageControl *_pageControl;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)initViews {
    [self addGrayViewWithFrame:CGRectMake(0, 0, kDeviceWidth, 10)];
    
    
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 25, kDeviceWidth-20, 140)];
//    _scrollView.backgroundColor = [UIColor clearColor];
//    _scrollView.pagingEnabled = YES;
//    _scrollView.showsHorizontalScrollIndicator = NO;
//    _scrollView.showsVerticalScrollIndicator = NO;
//    _scrollView.delegate = self;
    _imageView.userInteractionEnabled = YES;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.backgroundColor = [UIColor clearColor];
    [self addSubview:_imageView];
    
//    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 25, kDeviceWidth-20, 140)];
//    _webView.delegate = self;
//    _webView.scrollView.showsHorizontalScrollIndicator = NO;
//    _webView.scrollView.showsVerticalScrollIndicator = NO;
//    _webView.userInteractionEnabled = YES;
//    [self addSubview:_webView];
    
    _imageButton = [[UIButton alloc] initWithFrame:_imageView.frame];
    _imageButton.backgroundColor = [UIColor clearColor];
    [_imageButton addTarget:self action:@selector(mapAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_imageButton];
    
    zpq = [[UIImageView alloc] initWithFrame:CGRectMake(self.width-60-10, 40, 50, 50)];
    zpq.image = [UIImage imageNamed:@"zpq-icon"];
//    zpq.backgroundColor = rgb(230, 230, 230, 1);
    zpq.contentMode = UIViewContentModeCenter;
    [self addSubview:zpq];
    
    _label = [[myUILabel alloc] initWithFrame:CGRectMake(10, _imageView.bottom+15, kDeviceWidth-20, 0)];
    _label.backgroundColor = [UIColor clearColor];
    _label.textColor = rgb(141, 141, 141, 1);
    _label.numberOfLines = 0;
    _label.font = [UIFont systemFontOfSize:12];
    _label.verticalAlignment = VerticalAlignmentTop;
    [self addSubview:_label];
    
//    _footerView = [self addGrayViewWithFrame:CGRectMake(0, _label.bottom+10, kDeviceWidth, 10)];
    
//    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((kDeviceWidth-100)/2, _scrollView.bottom+5, 100, 10)];
//    _pageControl.backgroundColor = [UIColor clearColor];
//    _pageControl.pageIndicatorTintColor = [UIColor blackColor];
//    _pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
//    [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
//    _pageControl.hidden = YES;
//    [self addSubview:_pageControl];
    
}

- (UIView *)addGrayViewWithFrame:(CGRect)frame {
    UIView *superView = [[UIView alloc] initWithFrame:frame];
    superView.backgroundColor = rgb(241, 240, 248, 1);
    [self addSubview:superView];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 0.5)];
    line1.backgroundColor = rgb(191, 191, 191, 1);
    [superView addSubview:line1];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-0.5, frame.size.width, 0.5)];
    line2.backgroundColor = rgb(191, 191, 191, 1);
    [superView addSubview:line2];
    
    return superView;
}

//- (void)changePage:(UIPageControl *)pageControl {
//    CGRect frame = _scrollView.frame;
//    frame.origin.x = frame.size.width * pageControl.currentPage;
//    frame.origin.y = 0;
//    [_scrollView scrollRectToVisible:frame animated:YES];
//}

- (void)setActivityModel:(AAActivity *)activityModel {
    _activityModel = activityModel;
    if (activityModel != nil) {
////    是否显示图片墙
//        if (_activityModel.type == M_CREATED || _activityModel.type == M_REGISTERED || _activityModel.type == M_CHECKIN || _activityModel.type == M_LODGE) {
//            _imageButton.hidden = NO;
//        }else {
//            _imageButton.hidden = YES;
//        }
        

        _label.text = activityModel.detail;
        NSLog(@"%@",_label.text);
        _label.height = [AADetailsSecondView getHeightFromText:activityModel.detail]-180;
//        _imageView.top = _label.bottom+10;
//        _footerView.top = _label.bottom+10;
//        _pageControl.top = _scrollView.bottom+5;

//        if (activityModel.previewPics.count != 0) {
//            [_imageView setImageWithURL:[activityModel.previewPics firstObject]];
//            
//        }
//        activity.getMapAddr() + "&w=" + tempW + "&h="
//        + tempH + "&pt=android";
//        NSString *imageUrl = [NSString stringWithFormat:@"%@&w=%f&h=140&pt=ios",activityModel.mapAddr,kDeviceWidth-20];
//        NSString *urlStr = [imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSString *imageJson = _activityModel.postWallPics;
        NSError *error;
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        NSArray *images = nil;
        
        
        if (imageJson != nil) {
            images = [NSJSONSerialization JSONObjectWithData:[imageJson dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
        }
        

        NSMutableArray *container = [NSMutableArray new];
        for (NSDictionary *dic in images) {
            AAFlowImageModel *model = [[AAFlowImageModel alloc] initWithDic:dic];

            [container addObject:model];

        }
//         NSLog(@"%ld",_imageView.subviews.count);
        zpq.backgroundColor = [UIColor clearColor];
        //刷新数据时 移除imgv
        [_imageView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//        NSLog(@"%ld",_imageView.subviews.count);
        for (int i = 0; i < container.count; i++) {
            if (i < 3) {
                UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectZero];
                imgv.clipsToBounds = YES;
                imgv.userInteractionEnabled = YES;
                imgv.contentMode = UIViewContentModeScaleAspectFill;
                imgv.backgroundColor = [UIColor clearColor];
                AAFlowImageModel *model = container[i];
                [imgv sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:[UIImage imageNamed:@"yxblogo-grayB"]];
                [_imageView addSubview:imgv];
                if (container.count <= 1) {
                    _imageView.height = kDeviceWidth/320*150;
                    zpq.backgroundColor = rgb(0, 0, 0, 0.3);
                    imgv.frame = CGRectMake(0, 0, kDeviceWidth/320*225, kDeviceWidth/320*150);
                }else if (container.count == 2){
                    _imageView.height = kDeviceWidth/320*111;
                    imgv.frame = CGRectMake(i*(_imageView.width/2+3), 0, _imageView.width/2, (_imageView.width/2-5)/140*110);
                }else if (container.count >= 3){
                    _imageView.height = kDeviceWidth/320*75;
                    imgv.frame = CGRectMake(i*(_imageView.width/3+3), 0, _imageView.width/3-5, (_imageView.width/3-5)/90*75);
                }
                
            }
        }
        if (container.count == 0) {
            UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectZero];
            imgv.clipsToBounds = YES;
            imgv.userInteractionEnabled = YES;
            imgv.contentMode = UIViewContentModeScaleAspectFill;
            imgv.backgroundColor = [UIColor clearColor];
            [imgv sd_setImageWithURL:[NSURL URLWithString:_activityModel.iconPic] placeholderImage:[UIImage imageNamed:@"yxblogo-grayB"]];
            _imageView.height = kDeviceWidth/320*150;
            zpq.backgroundColor = rgb(0, 0, 0, 0.3);
            imgv.frame = CGRectMake(0, 0, kDeviceWidth/320*225, kDeviceWidth/320*150);
            [_imageView addSubview:imgv];
        }
        self.height = _imageView.height + _label.height+50;
        _imageButton.height = self.height;
        _label.top = _imageView.bottom+10;
//                self.height = [AADetailsSecondView getHeightFromText:activityModel.detail];
//
//        [_imageView setImageWithURL:[NSURL URLWithString:_activityModel.iconPic] placeholderImage:nil];
//        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
//        if (activityModel.previewPics.count != 0) {
//            _pageControl.hidden = NO;
//            _pageControl.numberOfPages = activityModel.previewPics.count;
//            _pageControl.currentPage = 0;
//            _scrollView.contentSize = CGSizeMake(_scrollView.width*activityModel.previewPics.count, _scrollView.height);
//            
//            for (int i = 0; i<activityModel.previewPics.count; i++) {
//                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(_scrollView.width*i, 0, _scrollView.width, _scrollView.height)];
//                imageView.backgroundColor = [UIColor clearColor];
//                [imageView setImageWithURL:[activityModel.previewPics objectAtIndex:i]];
//                [_scrollView addSubview:imageView];
//            }
//        }
    }
}


//- (CGFloat)getImgHight{
//    NSString *imageJson = _activityModel.postWallPics;
//    if (imageJson != nil) {
//        
//        NSError *error;
//        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
//        NSArray *images = [NSJSONSerialization JSONObjectWithData:[imageJson dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
//        NSMutableArray *container = [NSMutableArray new];
//        for (NSDictionary *dic in images) {
//            AAFlowImageModel *model = [[AAFlowImageModel alloc] initWithDic:dic];
//            [container addObject:model];
//        }
//        if (container.count > 0) {
//            if (container.count == 1) {
//                return kDeviceWidth/320*150;
//            }else if (container.count == 2){
//                return kDeviceWidth/320*111;
//            }else if (container.count >= 3){
//                return kDeviceWidth/320*75;
//            }
//        }
//        
////        if (container.count > 0) {
////            if (container.count == 1) {
////                AAFlowImageModel *model = container[0];
////                return kDeviceWidth/320*225/model.width*model.height;
////            }else if (container.count == 2){
////                AAFlowImageModel *model = container[0];
////                AAFlowImageModel *model1 = container[1];
////                if (((kDeviceWidth - 20)/2/model.width*model.height) >= ((kDeviceWidth - 20)/2/model1.width*model1.height)) {
////                    return (kDeviceWidth - 20)/2/model.width*model.height;
////                }
////                return (kDeviceWidth - 20)/2/model1.width*model1.height;
////            }else if (container.count >= 3){
////                AAFlowImageModel *model = container[0];
////                AAFlowImageModel *model1 = container[1];
////                AAFlowImageModel *model2 = container[2];
////                NSInteger a = (kDeviceWidth - 20)/3/model.width*model.height;
////                NSInteger b = (kDeviceWidth - 20)/3/model1.width*model1.height;
////                NSInteger z = (kDeviceWidth - 20)/3/model2.width*model2.height;
////                if (a >= b) {
////                    if (a >= z) {
////                        return a;
////                    }else {
////                        return z;
////                    }
////                }else {
////                    if (b >= z) {
////                        return b;
////                    }else {
////                        return z;
////                    }
////                }
////            }
////        }
//    }
//    return 180;
//}


+ (CGFloat)getHeightFromText:(NSString *)text {
    if (text.length == 0 || text == nil) {
        return 180;
    }
    UIFont *font = [UIFont systemFontOfSize:12];
    CGSize size = CGSizeMake(kDeviceWidth-20, 29999);
    if (KDeviceOSVersion >= 7.0)
    {
        NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
        
        size =[text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    }
    else
    {

//        size = [text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
        size = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
    }
    
    return size.height+180;
}

- (void)mapAction:(UIButton *)button {
    if (_activityModel != nil) {
//        CLLocationCoordinate2D location = CLLocationCoordinate2DMake(_activityModel.destLatitude.floatValue, _activityModel.destLongitude.floatValue);
//        
//        RongLocationViewController *locationViewController = [[RongLocationViewController alloc] initWithLocation:location locationName:_activityModel.destName];
//        [self.vc.navigationController pushViewController:locationViewController animated:YES];
        AAImageViewController * imageViewController = [[AAImageViewController alloc]init];
        imageViewController.activity = _activityModel;
        [self.vc.navigationController pushViewController:imageViewController animated:YES];

    }
}

#pragma mark - UIScrollView Delegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat pageWidth = scrollView.frame.size.width;
//    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
//    _pageControl.currentPage = page;
//    
//}

@end

#pragma mark - myLabel
@implementation myUILabel
- (void)awakeFromNib {
    self.verticalAlignment = VerticalAlignmentMiddle;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.verticalAlignment = VerticalAlignmentMiddle;
    }
    return self;
}

- (void)setVerticalAlignment:(VerticalAlignment)verticalAlignment {
    _verticalAlignment = verticalAlignment;
    [self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.verticalAlignment) {
        case VerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case VerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        case VerticalAlignmentMiddle:
            // Fall through.
        default:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
    }
    return textRect;
}

-(void)drawTextInRect:(CGRect)requestedRect {
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}


@end
