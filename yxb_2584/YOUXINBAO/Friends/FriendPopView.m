//
//  FriendPopView.m
//  YOUXINBAO
//
//  Created by CH10 on 15/8/6.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "FriendPopView.h"

#define kCustomItemHeight getScreenFitSize(50.0)
#define kCustomItemWidth getScreenFitSize(150.0)
#define kArrowHeight getScreenFitSize(5.0)

#define kFriendPopTag 30200

@implementation FriendPopView {
    UIImageView *_itemsView;
    CGPoint _originationPoint;
}

- (id)initWithItems:(NSArray *)items {
    if (self = [super init]) {
        [self initViews];
        self.items = items;
    }

    return self;
}

- (void)initViews {
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    self.alpha = 0;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self addGestureRecognizer:tap];
    
    _itemsView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _itemsView.userInteractionEnabled = YES;
    // 伸缩后重新赋值
    UIImage *image = [UIImage imageNamed:@"sweep-tc"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 50)];
    _itemsView.image = image;
    [self addSubview:_itemsView];
}

- (void)setItems:(NSArray *)items {
    _items = items;
    [self reloadItemsView];
}

- (void)reloadItemsView {
    CGFloat w = [(FriendPopItem *)[_items lastObject] width];
    CGFloat h = [(FriendPopItem *)[_items lastObject] height];
//    _itemsView.frame = CGRectMake(0, 0, w, h*_items.count+kArrowHeight);
    
    for (int i = 0; i<_items.count; i++) {
        UIButton *itemView = [_items objectAtIndex:i];
        itemView.frame = CGRectMake(0, h*i+kArrowHeight, w, h);
        itemView.tag = kFriendPopTag+i;
        [itemView addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
        [_itemsView addSubview:itemView];
        
        if (i != _items.count-1) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, itemView.bottom, w, 1)];
            line.backgroundColor = rgb(245, 244, 242, 1);
            [_itemsView addSubview:line];
        }
    }
}

- (void)itemAction:(UIButton *)button {
    [self dismiss];
    if ([self.delegate respondsToSelector:@selector(FriendPopView:clickedAtIndex:)]) {
        [self.delegate FriendPopView:self clickedAtIndex:button.tag-kFriendPopTag];
    }
}

- (void)showFromPoint:(CGPoint)point {
    _originationPoint = point;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    CGFloat w = [(FriendPopItem *)[_items lastObject] width];
    CGFloat h = [(FriendPopItem *)[_items lastObject] height];
    _itemsView.frame = CGRectMake(point.x-w, point.y, w, h*_items.count+kArrowHeight);
    [UIView animateWithDuration:0.2 animations:^{
       self.alpha = 1;
        
    }];

}

- (void)dismiss {
    if (self.superview) {
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 0;
            CGFloat w = [(FriendPopItem *)[_items lastObject] width];
            CGFloat h = [(FriendPopItem *)[_items lastObject] height]*_items.count+kArrowHeight;
            _itemsView.transform = CGAffineTransformMake(0.01, 0, 0, 0.01, w/2, -h/2);

        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

@end

@implementation FriendPopItem {
    UIImage *_image;
    UIImageView *_icon;
    UILabel *_titleLabel;
    NSString *_title;
}

+ (instancetype) menuItem:(NSString *) title
                    image:(UIImage *) image
{
    return [[FriendPopItem alloc] init:title
                                  image:image];
}

- (id)init:(NSString *)title image:(UIImage *)image {
    if (self = [super init]) {
//        self.showsTouchWhenHighlighted = YES;
        _title = title;
        _image = image;
        [self setItemSize:CGSizeMake(kCustomItemWidth, kCustomItemHeight)];
    }
    return self;
}

- (void)setAlignment:(NSTextAlignment)alignment {
    _titleLabel.textAlignment = alignment;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleLabel.textColor = titleColor;
}

- (void)setItemSize:(CGSize)size {
    self.size = size;
    
    //20*18
    _icon = [[UIImageView alloc] initWithFrame:CGRectMake(getScreenFitSize(15.0), (self.height-getScreenFitSize(18.0))/2, getScreenFitSize(20.0), getScreenFitSize(18.0))];
    _icon.image = _image;
    [self addSubview:_icon];
    
    CGFloat labelW = self.width*3/5;
    CGFloat labelH = getScreenFitSize(20.0);
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width-labelW, (self.height-labelH)/2, labelW, labelH)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.text = _title;
    _titleLabel.font = [UIFont systemFontOfSize:getScreenFitSize(17.0)];
    _titleLabel.textColor = [UIColor blackColor];

    [self addSubview:_titleLabel];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    self.backgroundColor = rgb(213, 212, 207, 1);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    self.backgroundColor = [UIColor clearColor];
}
 

@end
