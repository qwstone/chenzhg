//
//  ServiceView.m
//  YOUXINBAO
//
//  Created by pro on 2016/12/8.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "ServiceView.h"

#define SERVICE_STR     @"客服电话：400-6688-658"

@implementation ServiceView

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initServiceView];
    }
    return self;
}


-(void)initServiceView{
    
    //计算长度
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15],};
    CGSize strSize = [SERVICE_STR sizeWithAttributes:attributes];
    
    UIImageView * serviceImg = [[UIImageView alloc] initWithFrame:CGRectMake((kDeviceWidth-strSize.width - 21 - 5)/2, 0, 21, 21)];
    serviceImg.image = [UIImage imageNamed:@"cs_phoneIcon"];
    [self addSubview:serviceImg];
    
    UILabel *tel = [[UILabel alloc] initWithFrame:CGRectMake(serviceImg.right + 5, 0 , strSize.width, 21)];
    tel.backgroundColor = [UIColor yellowColor];
    tel.textColor = [YXBTool colorWithHexString:@"#A8A8A8"];
    tel.font = [UIFont systemFontOfSize:15];
    tel.textAlignment = NSTextAlignmentCenter;
    tel.backgroundColor = [UIColor clearColor];
    NSMutableAttributedString * telStr =[[NSMutableAttributedString alloc] initWithString:SERVICE_STR];
    [telStr addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#ed2e24"] range:NSMakeRange(5, 12)];
    tel.attributedText = telStr;
    [self addSubview:tel];
    
    //添加拨打电话功能
    UIButton * callTelephone = [UIButton buttonWithType:UIButtonTypeCustom];
    callTelephone.frame = CGRectMake(serviceImg.right + 5 + strSize.width/3, 0 , strSize.width/3*2, 21);
    [callTelephone addTarget:self action:@selector(callTelephoneSelect) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:callTelephone];
    
    
    
   

}

-(void)callTelephoneSelect{
    [YXBTool callTelphoneWithNum:@"400-6688-658"];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
