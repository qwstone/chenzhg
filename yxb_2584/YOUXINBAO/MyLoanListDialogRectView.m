//
//  MyLoanListDialogRectView.m
//  YOUXINBAO
//
//  Created by CH10 on 16/2/18.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "MyLoanListDialogRectView.h"

@implementation MyLoanListDialogRectView
{
    UIImageView *_topImgView;
    UIImageView *_cenImgView;
    UIImageView *_bottomImgView;
}
//-(void)setFrame:(CGRect)frame{
//    self.frame = frame;
//    
//}
-(void)setType:(NSInteger)type{
    if (_type !=type) {
        _type = type;
        if (_type == 1) {//左侧
            _cenImgView.frame = CGRectMake(_topImgView.width-_cenImgView.width, _cenImgView.frame.origin.y, _cenImgView.width, self.height-_topImgView.height-_bottomImgView.height);
            _bottomImgView.frame = CGRectMake(_topImgView.width-_bottomImgView.width,_cenImgView.bottom, _bottomImgView.width, _bottomImgView.height);
        }else if (type==2){//右侧
            _cenImgView.frame = CGRectMake(0, _cenImgView.frame.origin.y, _cenImgView.width, self.height-_topImgView.height-_bottomImgView.height);
            _bottomImgView.frame = CGRectMake(0,_cenImgView.bottom, _bottomImgView.width, _bottomImgView.height);
        }
    }
}
-(void)setTopImgName:(NSString *)topImgName{
    if (_topImgName!=topImgName) {
        _topImgName = topImgName;
        _topImgView.image = [UIImage imageNamed:_topImgName];
    }
}
-(void)setCenImgName:(NSString *)cenImgName{
    if (_cenImgName!=cenImgName) {
        _cenImgName = cenImgName;
        _cenImgView.image = [UIImage imageNamed:_cenImgName];
    }
}
-(void)setBottomImgName:(NSString *)bottomImgName{
    if (_bottomImgName!=bottomImgName) {
        _bottomImgName = bottomImgName;
        _bottomImgView.image = [UIImage imageNamed:_bottomImgName];
    }
}
- (instancetype)initWithFrame:(CGRect)frame andTopImgName:(NSString *)topImgName cenImgName:(NSString *)cenImgName bottomImgName:(NSString *)bottomImgName
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *topImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:topImgName]];
        UIImageView *cenImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:cenImgName]];
        UIImageView *bottomImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:bottomImgName]];
        
        topImgView.frame = CGRectMake(0, 0, topImgView.image.size.width, topImgView.image.size.height);
        bottomImgView.frame = CGRectMake(0, self.height-bottomImgView.height, bottomImgView.width, bottomImgView.image.size.height);
        cenImgView.frame = CGRectMake(0, topImgView.bottom, cenImgView.image.size.width, self.height-topImgView.height-bottomImgView.height);
        
        _topImgView = topImgView;
        _cenImgView = cenImgView;
        _bottomImgView = bottomImgView;
        
        [self addSubview:topImgView];
        [self addSubview:cenImgView];
        [self addSubview:bottomImgView];

    }
    return self;
}
@end
