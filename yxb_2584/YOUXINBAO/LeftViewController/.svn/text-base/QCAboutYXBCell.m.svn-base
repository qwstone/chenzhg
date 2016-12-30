//
//  QCAboutYXBCell.m
//  YOUXINBAO
//
//  Created by 冰冰 on 15/5/21.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCAboutYXBCell.h"

@implementation QCAboutYXBCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initViews];
    }
    
    return self;
}

- (void)_initViews{
    
    _array2=[NSArray array];
    NSString *str=[NSString stringWithFormat:@"版本号%@",YXB_VERSION_CODE];
//<<<<<<< .mine
//    _array2=@[@[@"软件版本",str],@[@"版权所有",@"北京友信宝网络科技有限公司"],@[@"网站地址",@"www.51jt.com"],@[@"客服电话",@"400-6688-658"],@[@"公司简介",@"无忧借条是全国首款电子借据的手机APP应用。要提供互联网社交金融的服务，服务内容包括1.好友之间的社交账务管理及电子借据认证。2.个人生活账务记录及到期提醒。3.AA聚会互动活动。4.个人无忧借条信用查询"]];
//=======
    _array2=@[@[@"软件版本",str],@[@"版权所有",@"北京友信宝网络科技有限公司"],@[@"网站地址",@"www.51jt.com"],@[@"客服电话",@"400-6688-658"],@[@"公司简介",@"无忧借条是全国首款电子借条的手机APP应用。要提供互联网社交金融的服务，服务内容包括1.好友之间的社交账务管理及电子借条认证。2.个人生活账务记录及到期提醒。3.AA聚会互动活动。4.个人无忧借条信用查询"]];
//>>>>>>> .r3020
    _leftLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    [self addSubview:_leftLabel];
    _rightLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    [self addSubview:_rightLabel];
    

    [self setNeedsLayout];
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];

    
    _leftLabel.textColor=rgb(48, 48, 48, 1);
    _leftLabel.font=[UIFont systemFontOfSize:17];
    if (self.index==4) {
        _rightLabel.frame=CGRectMake(85, 10, kDeviceWidth-130, 144) ;
        _leftLabel.frame=CGRectMake(5, 45, 70, 20);
        _rightLabel.numberOfLines=0;
        
    }
    else{
    _rightLabel.frame=CGRectMake(85, 2, kDeviceWidth-100,48);
    _leftLabel.frame=CGRectMake(5, 15, 70, 20);
    }

    _rightLabel.textColor=rgb(116, 116, 116, 1);
    _rightLabel.font=[UIFont systemFontOfSize:15];
    
}




@end
