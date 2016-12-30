//
//  MyOrderScheduleTopViewNew.m
//  YOUXINBAO
//
//  Created by Feili on 15/7/15.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "MyOrderScheduleTopViewNew.h"
#import "YXBTool.h"
#import "MyOrderNewScheduleTopView.h"

@interface MyOrderScheduleTopViewNew ()
{
    UIButton *devideC;
    MyOrderNewScheduleTopView *topSecion;//顶部区域
}

@property(nonatomic,strong)UIView *scheduleBgView;//进度板背景
@property(nonatomic,strong)UIView *schedulePanel;//进度板

@end

@implementation MyOrderScheduleTopViewNew

-(void)initViews
{
    CGFloat x = 0, y = 0, w = kDeviceWidth,h = 220;
    topSecion = [[MyOrderNewScheduleTopView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    topSecion.clipsToBounds = YES;
    [self addSubview:topSecion];
    
    /*
    x = 0, y = y + h + 20, w = kDeviceWidth, h = 50;
    devideC = [UIButton buttonWithType:UIButtonTypeCustom];
    devideC.backgroundColor = [UIColor whiteColor];
    devideC.frame = CGRectMake(x, y, w, h);
    devideC.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [devideC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [devideC addTarget:self action:@selector(contactInfo) forControlEvents:UIControlEventTouchUpInside];
    devideC.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [devideC setTitle:@"  分期合同" forState:UIControlStateNormal];
    [self addSubview:devideC];
    
    UIImageView *nextView = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/2, 0, kDeviceWidth/2-20, h)];
    nextView.contentMode = UIViewContentModeRight;
    nextView.image = [UIImage imageNamed:@"xinfenq-next.png"];
    [devideC addSubview:nextView];
    */
    
    x = 0;
    y = y + h + 15;
    h = 90;
    w = self.width - 2 * x;
    [self addNewSchedulePanelWithFrame:CGRectMake(x, y, w, h)];


}

-(void)contactInfo
{
    
    if (_delegate && [_delegate respondsToSelector:@selector(contactInfo)]) {
        [_delegate contactInfo];
    }
}


-(void)addNewSchedulePanelWithFrame:(CGRect)frame
{
    
    UIView *scheduleBgView = [[UIView alloc] initWithFrame:frame];
    scheduleBgView.backgroundColor = [UIColor whiteColor];
    //    scheduleBgView.layer.borderColor = rgb(213, 213, 213, 1.0).CGColor;
    //    scheduleBgView.layer.borderWidth = 1.0;
    self.scheduleBgView = scheduleBgView;
    
    [self addSubview:scheduleBgView];
    self.schedulePanel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scheduleBgView.width, scheduleBgView.height)];
    _schedulePanel.contentMode = UIViewContentModeCenter;
    _schedulePanel.layer.contentsScale = [[UIScreen mainScreen] scale];
    //    _schedulePanel.layer.contents = (id)[UIImage imageNamed:@""]
    [scheduleBgView addSubview:_schedulePanel];
}

-(void)setModel:(CommerceOrderDetail *)model
{
    if (_model != model) {
        _model = model;
        self.schedulePanel.layer.contents = (id)[UIImage imageNamed:[self imageNameWithState:(_model.orderState)]].CGImage;
        topSecion.model = _model;
        
    }
}


-(NSString *)imageNameWithState:(MyOrderScheduleType)schedule
{
    NSString *imageName = @"xfq-lcend.png";
    
    /*
    if (schedule >= 0 && schedule <= 100) {
        imageName = @"borrowsteps01.png";
        
    }else if (schedule >= 100 && schedule <= MyOrderScheduleTypeQueren){
        
        imageName = @"borrowsteps02.png";
    }else if (schedule >= MyOrderScheduleTypeQueren && schedule <= MyOrderScheduleTypeMianqian){
        
        imageName = @"borrowsteps03.png";
    }else if (schedule >= MyOrderScheduleTypeMianqian && schedule <= MyOrderScheduleTypeDaozhang){
        
        imageName = @"borrowsteps04.png";
    }else if (schedule >= MyOrderScheduleTypeDaozhang && schedule <= MyOrderScheduleTypeHuankuaning){
        
        imageName = @"borrowsteps05.png";
    }else
    {
        imageName = @"borrowsteps01.png";
        
    }
    */
    return imageName;
}



@end
