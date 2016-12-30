//
//  QCUserDetailView.m
//  YOUXINBAO
//
//  Created by CH10 on 15/4/11.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCUserDetailView.h"
#import "UIImageView+WebCache.h"

@implementation QCUserDetailView {
    UIImageView *_portrait;
    UILabel *_name;
    UILabel *_design;   //称号
    UILabel *_detail;   //详细信息
    
    UIButton *_addFriend;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        self.backgroundColor = rgb(58, 150, 48, 1);
        
        _portrait = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, 50, 50)];
        _portrait.backgroundColor = [UIColor clearColor];
        [self addSubview:_portrait];
        
        _name = [[UILabel alloc] initWithFrame:CGRectMake(70, 35, 70, 20)];
        _name.textAlignment = NSTextAlignmentCenter;
        _name.font = [UIFont systemFontOfSize:16];
        _name.text = @"阿拉蕾";
        _name.backgroundColor = [UIColor clearColor];
        _name.textColor = [UIColor whiteColor];
        [self addSubview:_name];
        
        //
        
        _design = [[UILabel alloc] initWithFrame:CGRectMake(self.width-135, 35, 135, 20)];
        _design.textAlignment = NSTextAlignmentCenter;
        _design.font = [UIFont systemFontOfSize:16];
        _design.text = @"❀❀";
        _design.backgroundColor = [UIColor clearColor];
        _design.textColor = [UIColor whiteColor];
        [self addSubview:_design];
        
        UILabel *jieQianLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 65, self.width-70, 20)];
        jieQianLabel.font = [UIFont systemFontOfSize:12];
        jieQianLabel.text = @"想借钱的加哥好友,无息哦";
        jieQianLabel.backgroundColor = [UIColor clearColor];
        jieQianLabel.textColor = [UIColor blackColor];
        [self addSubview:jieQianLabel];
        
        _detail = [[UILabel alloc] initWithFrame:CGRectMake(30, 115, self.width-30, 20)];
        _detail.font = [UIFont systemFontOfSize:12];
        _detail.text = @"❀❀";
        _detail.backgroundColor = [UIColor clearColor];
        _detail.textColor = [UIColor whiteColor];
        [self addSubview:_detail];
        
        UILabel *delete = [[UILabel alloc] initWithFrame:CGRectMake(self.width-25, 0, 25, 25)];
        delete.textColor = [UIColor blackColor];
        delete.text = @"×";
        delete.backgroundColor = [UIColor clearColor];
        [self addSubview:delete];
        
        _addFriend = [[UIButton alloc] initWithFrame:CGRectMake(100, 160, 110, 40)];
        [_addFriend setTitle:@"加好友" forState:UIControlStateNormal];
        [_addFriend setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_addFriend addTarget:self action:@selector(addFriend:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_addFriend];
        
    }
    
    return self;
}

- (void)setCreditCenter:(CreditCenter *)creditCenter {
    _creditCenter = creditCenter;
    
    [_portrait sd_setImageWithURL:[NSURL URLWithString:creditCenter.iconAddr]];
    _name.text = creditCenter.realName;
    _design.text = [NSString stringWithFormat:@"❀%@❀",creditCenter.rankTitle];
    _detail.text = creditCenter.detailInfo;
    
    if (creditCenter.friendFlag) {
        [_addFriend setTitle:@"已是好友" forState:UIControlStateNormal];
        [_addFriend setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _addFriend.enabled = NO;
    }else {
        [_addFriend setTitle:@"加好友" forState:UIControlStateNormal];
        [_addFriend setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _addFriend.enabled = YES;
    }
}

- (void)addFriend:(UIButton *)button {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
