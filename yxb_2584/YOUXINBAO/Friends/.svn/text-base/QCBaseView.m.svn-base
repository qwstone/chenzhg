//
//  QCBaseView.m
//  YOUXINBAO
//
//  Created by Feili on 15/5/13.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseView.h"


@implementation QCBaseView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    
    return self;
}

-(void)initViews
{
    
}

-(UIImageView*)borderImageViewWithImage:(UIImage *)image frame:(CGRect)frame imageView:(UIImageView *)imageView
{
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"expertUserImg.png"]];
    bgImageView.clipsToBounds = YES;
    bgImageView.frame = frame;
    
    CGFloat space = 4;
    
    CGFloat x = space;
    CGFloat y = space-2;
    CGFloat w = frame.size.width - 2 * space;
    CGFloat h = frame.size.height - 2 * space;
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    imageView.layer.cornerRadius = imageView.width/2;
    imageView.clipsToBounds = YES;
    imageView.image = image;
    [bgImageView addSubview:imageView];
    
    return bgImageView;
}

-(UILabel *)labelWithFrame:(CGRect)frame fontSize:(NSInteger)fontSize textColor:(UIColor *)textColor
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
//    label.backgroundColor = [YXBTool generateRandomColor];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.minimumScaleFactor = 10.0/label.font.pointSize;
    label.adjustsFontSizeToFitWidth = YES;
    label.textColor = textColor;
    
    return label;
}


@end
