//
//  AADetailsSecondView.h
//  YOUXINBAO
//
//  Created by CH10 on 15/3/18.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TActivity.h"
#import "AAActivity.h"
#import "AAFlowImageModel.h"

#define kSecondViewMaxHeight 250

@interface AADetailsSecondView : UIView<UIScrollViewDelegate,UIWebViewDelegate>

@property (nonatomic,retain)AAActivity * activityModel;
@property (nonatomic,strong)UIViewController *vc;

+ (CGFloat)getHeightFromText:(NSString *)text;

@end

/*
 上对齐、底部对齐label
 */
//myLabel
typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;
@interface myUILabel : UILabel

@property (nonatomic,assign) VerticalAlignment verticalAlignment;

@end
