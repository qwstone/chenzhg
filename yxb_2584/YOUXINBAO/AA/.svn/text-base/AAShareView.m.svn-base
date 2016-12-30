//
//  AAShareView.m
//  YOUXINBAO
//
//  Created by CH10 on 15/6/22.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AAShareView.h"
#import "YXBTool.h"

#define kTopItemHeight 83*kDeviceWidth/320
#define kItemWidth 60.5*kDeviceWidth/320
#define kCenterItemHeight 79*kDeviceWidth/320
#define kLeftOrigin 18*kDeviceWidth/320
#define kGap 14*kDeviceWidth/320
#define kTopTag 100001
#define kCenterTag 100010
#define kCancelTag 100100

@implementation AAShareView {
    UIView *_shareView;
    UIView *_center;
    
    CGFloat _shareHeight;   //总高度
}

- (id)init {
    self = [self initWithType:AAShareViewTypeAA];
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [self initWithType:AAShareViewTypeAA];
    return self;
}

- (id)initWithType:(AAShareViewType)type {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.type = type;
        [self initViews];
    }
    
    return self;
}

- (void)initViews {
    CGFloat topHeight = getScreenFitSize(120.5);
    CGFloat cancelH = 45*kDeviceWidth/320;
    CGFloat lineH = getScreenFitSize(0.5);
    if (self.type == AAShareViewTypeAA) {
        _shareHeight = getScreenFitSize(278);
    }else if (self.type == AAShareViewTypeFriend) {
        _shareHeight = topHeight+cancelH+lineH;
    }
    _shareView = [[UIView alloc] initWithFrame:CGRectMake(0, kDeviceHeight, kDeviceWidth, _shareHeight)];
    _shareView.backgroundColor = [UIColor whiteColor];
//    _shareView.layer.borderColor =  [YXBTool colorWithHexString:@"#EFE8E8"].CGColor;
//    _shareView.layer.borderWidth = 1.0;
    [self addSubview:_shareView];
    
    UIView *top = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, topHeight)];
    top.backgroundColor = [UIColor clearColor];
    [_shareView addSubview:top];
    
//    NSArray *topImages = @[@"Share-wechat",@"Share-pyq",@"Share-qq",@"Share-qkj"];
    NSArray *topImages = @[@"Share-wechat",@"Share-pyq"];
    for (int i = 0; i<topImages.count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kLeftOrigin+(kItemWidth+kGap)*i, 22.5*kDeviceWidth/320, kItemWidth, kTopItemHeight)];
        [button setImage:[UIImage imageNamed:topImages[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:topImages[i]] forState:UIControlStateHighlighted];
        button.tag = kTopTag+i;
        [button addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
        [top addSubview:button];
    }
    
    _center = [[UIView alloc] initWithFrame:CGRectMake(0, top.bottom, kDeviceWidth, kCenterItemHeight+(18+15)*kDeviceWidth/320)];
    _center.backgroundColor = [UIColor clearColor];
    [_shareView addSubview:_center];
    
    if (self.type == AAShareViewTypeAA) {
        _center.hidden = NO;
    }else if (self.type == AAShareViewTypeFriend) {
        _center.hidden = YES;
    }
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, lineH)];
    line1.backgroundColor = [YXBTool colorWithHexString:@"#EFE8E8"];
    [_center addSubview:line1];
    
    NSArray *centerImages = @[@"Share-ts",@"Share-AAsk",@"Share-AAtk"];
    for (int i = 0; i<centerImages.count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kLeftOrigin+(kItemWidth+kGap)*i, 17.5*kDeviceWidth/320, kItemWidth, kTopItemHeight)];
        [button setImage:[UIImage imageNamed:centerImages[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:centerImages[i]] forState:UIControlStateHighlighted];
        button.tag = kCenterTag+i;
        [button addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
        [_center addSubview:button];
    }
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0,_shareHeight-cancelH-lineH, kDeviceWidth, lineH)];
    line2.backgroundColor = [YXBTool colorWithHexString:@"#EFE8E8"];
    [_shareView addSubview:line2];
    
    UIButton *cancel = [[UIButton alloc] initWithFrame:CGRectMake(0, _shareHeight-cancelH, kDeviceWidth, cancelH)];
    [cancel setTitle:@"取     消" forState:UIControlStateNormal];
    [cancel setTitleColor:[YXBTool colorWithHexString:@"#58CEFE"] forState:UIControlStateNormal];
    cancel.titleLabel.font = [UIFont systemFontOfSize:20*kDeviceWidth/320];
    cancel.tag = kCancelTag;
    [cancel addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
    [_shareView addSubview:cancel];
}

- (void)itemAction:(UIButton *)button {
    [self hide];
    if (button.tag == kTopTag) {
        //微信好友
        if ([self.delegate respondsToSelector:@selector(AAShareViewWeixinSessionButtonDidClicked:)]) {
            [self.delegate AAShareViewWeixinSessionButtonDidClicked:self];
        }
    }else if (button.tag == kTopTag+1) {
        //朋友圈
        if ([self.delegate respondsToSelector:@selector(AAShareViewWeixinTimelineContentButtonDidClicked:)]) {
            [self.delegate AAShareViewWeixinTimelineContentButtonDidClicked:self];
        }
    }else if (button.tag == kTopTag+2) {
        //QQ
    }else if (button.tag == kTopTag+3) {
        //QQ空间
    }else if (button.tag == kCenterTag) {
        //投诉
        if ([self.delegate respondsToSelector:@selector(AAShareViewLodgeButtonDidClicked:)]) {
            [self.delegate AAShareViewLodgeButtonDidClicked:self];
        }
    }else if (button.tag == kCenterTag+1) {
        //AA收款
        if ([self.delegate respondsToSelector:@selector(AAShareViewGatheringButtonDidClicked:)]) {
            [self.delegate AAShareViewGatheringButtonDidClicked:self];
        }
    }else if (button.tag == kCenterTag+2) {
        //AA退款
        if ([self.delegate respondsToSelector:@selector(AAShareViewRefundingButtonDidClicked:)]) {
            [self.delegate AAShareViewRefundingButtonDidClicked:self];
        }
    }else if (button.tag == kCancelTag) {
        //取消
    }
    
}

- (void)setLodgeButtonHidden:(BOOL)yesOrNo {
    UIButton *lodge = (UIButton *)[_center viewWithTag:kCenterTag];
    lodge.hidden = yesOrNo;
    
    if (yesOrNo) {
        for (int i = kCenterTag+2; i>kCenterTag; i--) {
            UIButton *last = (UIButton *)[_center viewWithTag:i-1];
            UIButton *next = (UIButton *)[_center viewWithTag:i];
            CGRect lastFrame = last.frame;
            next.frame = lastFrame;
            
        }
        
    }
}

- (void)show {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.35 animations:^{
        _shareView.frame = CGRectMake(0, kDeviceHeight-_shareHeight, kDeviceWidth, _shareHeight);
    }];
}
- (void)hide {
    [UIView animateWithDuration:0.35 animations:^{
        _shareView.frame = CGRectMake(0, kDeviceHeight, kDeviceWidth, _shareHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
