//
//  QCBoardUserView.m
//  YOUXINBAO
//
//  Created by CH10 on 15/4/10.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBoardUserView.h"

@implementation QCBoardUserView {
    UILabel *_rank;
    UILabel *_design;
    UILabel *_name;
    UILabel *_detail;
    
    UIImageView *_isFriend;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 25)];
        view1.backgroundColor = rgb(58, 150, 48, 1);
        view1.layer.cornerRadius = 25.0/2;
        view1.layer.masksToBounds = YES;
        [self addSubview:view1];
        
        _rank = [[UILabel alloc] initWithFrame:CGRectMake(5, 2, 21, 21)];
        _rank.font = [UIFont systemFontOfSize:14];
        _rank.backgroundColor = [UIColor whiteColor];
        _rank.textAlignment = NSTextAlignmentCenter;
        _rank.text = @"1";
        [view1 addSubview:_rank];
        
        _rank.layer.cornerRadius = 21.0/2;
        _rank.layer.masksToBounds = YES;
        
        _design = [[UILabel alloc] initWithFrame:CGRectMake(31, 2, self.width-31, 21)];
        _design.font = [UIFont systemFontOfSize:12];
        _design.textColor = [UIColor whiteColor];
        _design.textAlignment = NSTextAlignmentCenter;
        _design.backgroundColor = [UIColor clearColor];
        _design.text = @"❀宇宙土豪❀";
        [view1 addSubview:_design];
        
        UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(5, view1.bottom+5, self.width-10, self.height-view1.bottom-5)];
        view2.backgroundColor = rgb(58, 150, 48, 1);
        [self addSubview:view2];
        
        _isFriend = [[UIImageView alloc] initWithFrame:CGRectMake(view2.width-19, 4, 15, 15)];
        _isFriend.backgroundColor = [UIColor redColor];
        _isFriend.hidden = NO;
        [view2 addSubview:_isFriend];
        
        _name = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, view2.width, 21)];
        _name.font = [UIFont systemFontOfSize:16];
        _name.backgroundColor = [UIColor clearColor];
        _name.textColor = [UIColor whiteColor];
        _name.textAlignment = NSTextAlignmentCenter;
        _name.text = @"阿拉蕾";
        [view2 addSubview:_name];
        
        _detail = [[UILabel alloc] initWithFrame:CGRectMake(5, view2.height-31, view2.width, 21)];
        _detail.font = [UIFont systemFontOfSize:12];
        _detail.backgroundColor = [UIColor clearColor];
        _detail.textAlignment = NSTextAlignmentCenter;
        _detail.text = @"你借出2000元";
        [view2 addSubview:_detail];
    }
    
    return self;
}

- (void)setCreditCenter:(CreditCenter *)creditCenter {
    _creditCenter = creditCenter;
    
    _design.text = [NSString stringWithFormat:@"❀%@❀",creditCenter.rankTitle];
    _name.text = creditCenter.realName;
    _detail.text = [NSString stringWithFormat:@"%@",creditCenter.listInfo];
    
    if (creditCenter.friendFlag) {
        _isFriend.hidden = NO;
    }else {
        _isFriend.hidden = YES;
    }
    
}

- (void)setRankNum:(NSInteger)rankNum {
    _rankNum = rankNum;

    _rank.text = [NSString stringWithFormat:@"%ld",(long)self.rankNum];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
