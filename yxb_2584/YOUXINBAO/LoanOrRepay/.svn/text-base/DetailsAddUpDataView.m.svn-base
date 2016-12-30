//
//  DetailsAddUpDataView.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/5/9.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "DetailsAddUpDataView.h"
#import "TCompensationNote.h"


@interface DetailsAddUpDataView ()
@property(nonatomic,strong)UILabel *delayLabel;//延期
@end
@implementation DetailsAddUpDataView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    
    return self;
}

- (void)reloadDataWithArray:(NSArray *)array
{
    for (UIView * view in self.subviews) {
//        if ([view isEqual:[UILabel class]]) {
//            [view removeFromSuperview];
//        }
        [view removeFromSuperview];
        
    }
//    _delayLabel = nil;
    for (NSInteger i = 0; i < array.count; i++) {
        TCompensationNote * note = array[i];

//        if (_delayLabel == nil)
//        {
            UILabel * delayLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, i* DetailsAddUpDataViewHeight, kDeviceWidth-20, DetailsAddUpDataViewHeight)];
            delayLabel.font = [UIFont systemFontOfSize:14];
            delayLabel.textColor = [UIColor grayColor];

            [self addSubview:delayLabel];

            NSString * string = [NSString stringWithFormat:@"%@延期一个月,给予补偿金%@元",note.date,note.money];
            NSInteger length = string.length;
            NSRange  range = NSMakeRange(21, length-22);
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:range];
            delayLabel.attributedText = str;

//        }

    }
    
}


@end
