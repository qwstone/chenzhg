//
//  LoseCreditSalaHead.m
//  YOUXINBAO
//
//  Created by pro on 16/9/27.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoseCreditSalaHead.h"

@implementation LoseCreditSalaHead



-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
        //        [self createButton];
        self.backgroundColor = [UIColor colorWithRed:222/255.0 green:41/255.0 blue:43/255.0 alpha:1];
    }
    return self;
}

-(void)createView
{
    UIFont * font = [UIFont boldSystemFontOfSize:16];
    //姓名
    UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/750*11, 1, kDeviceWidth/750*120, 35)];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.text = @"借款人";
    nameLabel.font = font;
    [self addSubview:nameLabel];
    
    //电话
    UILabel * mobileLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabel.right + kDeviceWidth/750*8, 1, kDeviceWidth/750*160, 35)];
    mobileLabel.textColor = [UIColor whiteColor];
    mobileLabel.textAlignment = NSTextAlignmentCenter;
    mobileLabel.text = @"手机";
    mobileLabel.font = font;
    [self addSubview:mobileLabel];
    
    //身份证号308 256
    UILabel * idcardLabel = [[UILabel alloc] initWithFrame:CGRectMake(mobileLabel.right + kDeviceWidth/750*16, 1, kDeviceWidth/750*240, 35)];
    idcardLabel.textColor = [UIColor whiteColor];
    idcardLabel.textAlignment = NSTextAlignmentCenter;
    idcardLabel.text = @"身份证";
    idcardLabel.font = font;
    [self addSubview:idcardLabel];
    
    //状态564 184 748 2
    UILabel * stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(idcardLabel.right + kDeviceWidth/750*16, 1, kDeviceWidth/750*168, 35)];
    stateLabel.textColor = [UIColor whiteColor];
    stateLabel.textAlignment = NSTextAlignmentCenter;
    stateLabel.text = @"状态";
    stateLabel.font = font;
    [self addSubview:stateLabel];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
