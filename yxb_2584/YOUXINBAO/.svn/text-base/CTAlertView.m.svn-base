//
//  CTAlertView.m
//  LearningRoad
//
//  Created by CH10 on 16/3/14.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "CTAlertView.h"

@interface CTAlertView ()<UIGestureRecognizerDelegate>
@property (nonatomic,weak) UIButton *cancleBtn;

@property (nonatomic,weak) UIView *bgView;
@property (nonatomic,assign) CGFloat btnHeight;
@property (nonatomic,strong) NSMutableArray *otherBtnTitles;

@end


@implementation CTAlertView

//contentView;
//*btnBgColor;
//*btnTextColor
//*rectColor;
-(void)setBtnBgColor:(UIColor *)btnBgColor{
    _btnBgColor = btnBgColor;
    _btnBgView.backgroundColor = _btnBgColor;
}
-(void)setBtnTextColor:(UIColor *)btnTextColor{
    _btnTextColor = btnTextColor;
    for (UIView *line in _btnBgView.subviews) {
        if([line isKindOfClass:[UIButton class]]){
            [(UIButton*)line setTitleColor:_btnTextColor forState:UIControlStateNormal];
        }
    }
}
-(void)setRectColor:(UIColor *)rectColor{
    _rectColor = rectColor;
    for (UIView *line in _btnBgView.subviews) {
        if(![line isKindOfClass:[UIButton class]]){
            line.backgroundColor = _rectColor;
        }
    }
}
-(void)dealloc{
    [_bgView removeFromSuperview];
    [_contentView removeFromSuperview];
    _bgView = nil;
    
    _contentView = nil;
}
+(instancetype)ctAlertWithFrame:(CGRect)frame delegate:(id<CTAlertViewDelegate>)delegate btnHeight:(CGFloat)btnHeight cancleBtnTitle:(NSString*)cancleBtnTitle otherBtnTitle:(NSArray *)otherBtnTitles{
    CTAlertView *alert = [[CTAlertView alloc] initWithFrame:frame delegate:delegate btnHeight:btnHeight cancleBtnTitle:cancleBtnTitle otherBtnTitle:otherBtnTitles];
    return alert;
}
-(instancetype)initWithFrame:(CGRect)frame delegate:(id<CTAlertViewDelegate>)delegate btnHeight:(CGFloat)btnHeight cancleBtnTitle:(NSString*)cancleBtnTitle otherBtnTitle:(NSArray *)otherBtnTitles{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.delegate = delegate;
        self.btnHeight = btnHeight;
        otherBtnTitles = otherBtnTitles;
        [self createUIWithFrame:frame andBtnHeight:btnHeight];
        [self createBtnWithCancleBtnTitle:cancleBtnTitle andOtherBtnTitles:otherBtnTitles];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _otherBtnTitles = [[NSMutableArray alloc] init];
    }
    return self;
}
//创建蒙版，contentview，btnBgView
-(void)createUIWithFrame:(CGRect)frame andBtnHeight:(CGFloat)btnHeight{
    self.backgroundColor = [UIColor clearColor];
    UIView *tBgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    tBgView.backgroundColor = [UIColor blackColor];
    tBgView.alpha = 0.7;
    _bgView = tBgView;
    [self addSubview:_bgView];
    UIView *tContentView = [[UIView alloc] initWithFrame:frame];
    tContentView.center = _bgView.center;
    tContentView.backgroundColor = [UIColor whiteColor];
    tContentView.layer.cornerRadius = 6;
    tContentView.layer.masksToBounds = YES;
    _contentView = tContentView;
    [self addSubview:_contentView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [_bgView addGestureRecognizer:tap];
    
    UIView *tBtnBgView = [[UIView alloc] initWithFrame:CGRectMake(0, _contentView.height-btnHeight, _contentView.width, btnHeight)];
    _btnBgView = tBtnBgView;
    [_contentView addSubview:tBtnBgView];
}
//创建btn
-(void)createBtnWithCancleBtnTitle:(NSString *)cancleBtnTitle andOtherBtnTitles:(NSArray*)otherBtnTitles{
    if (otherBtnTitles.count) {
        [self createCancleBtnWithFrame:CGRectMake(0, 0, _btnBgView.width/(otherBtnTitles.count+1), _btnBgView.height) title:cancleBtnTitle];
        [self createOtherBtnWithTitles:otherBtnTitles];
    }else{
        [self createCancleBtnWithFrame:CGRectMake(0, 0, _btnBgView.width, _btnBgView.height) title:cancleBtnTitle];
    }
    UIView *hLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _contentView.width, 1)];
    hLine.backgroundColor = rgb(160, 160, 160, 1);
    [_btnBgView addSubview:hLine];
    
}
//创建取消按钮
-(void)createCancleBtnWithFrame:(CGRect)frame title:(NSString *)title{
    UIButton *tCancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tCancleBtn.frame = frame;
    tCancleBtn.tag = 12000;
    //    tCancleBtn.backgroundColor = [UIColor redColor];
    tCancleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [tCancleBtn setTitle:title forState:UIControlStateNormal];
    [tCancleBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [tCancleBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.cancleBtn = tCancleBtn;
    [_btnBgView addSubview:tCancleBtn];
}
//创建其他按钮
-(void)createOtherBtnWithTitles:(NSArray *)otherBtnTitles{
    for (int i = 0; i < otherBtnTitles.count; i++) {
        
        UIButton *otherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        otherBtn.frame = CGRectMake(_btnBgView.width/(otherBtnTitles.count+1)*(i+1), 0, _btnBgView.width/(otherBtnTitles.count+1), _btnBgView.height);
        [otherBtn setTitle:[otherBtnTitles objectAtIndex:i] forState:UIControlStateNormal];
        [otherBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        otherBtn.tag = 12001+i;
        
        [otherBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_btnBgView addSubview:otherBtn];
        
        UIView *vline = [[UIView alloc] initWithFrame:CGRectMake(otherBtn.left-1, 0, 1, _btnHeight)];
        vline.backgroundColor = rgb(160, 160, 160, 1);
        [_btnBgView addSubview:vline];
        
    }
}


//alert显示和隐藏
-(void)alertShow{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
-(void)alertHidden{
    [self removeFromSuperview];
}
//按钮点击事件
-(void)btnClick:(UIButton *)btn{
    
    [self.delegate ctAlertView:self didClickedBtnAtIndex:btn.tag-12000];
    [self alertHidden];
}
//点击蒙版隐藏
-(void)tapClick:(UITapGestureRecognizer *)tap{
    [self alertHidden];
}
@end
