//
//  HomeOfShiXin.m
//  YOUXINBAO
//
//  Created by 密码是111 on 16/9/26.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "HomeOfShiXinView.h"
#import "LoseCreditSalaViewController.h"
@implementation HomeOfShiXinView
{
    UILabel*_nameLab;
    UILabel*_TELLab;
    UILabel*_cardLab;
    UILabel*_stauesLab;
    
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
//        [self createButton];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)createView {
    CGFloat linw = kDeviceWidth/640*4;
    UIView * linnn = [[UIView alloc] initWithFrame:CGRectMake(0, 0, linw+kDeviceWidth/750*2  , kDeviceWidth/750*72)];
    linnn.backgroundColor = [YXBTool colorWithHexString:@"#e84a44"];
    linnn.layer.cornerRadius = kDeviceWidth/640*2;
//    [self addSubview:linnn];
    
    //上半部分
    UIView * upView = [[UIView alloc] initWithFrame:CGRectMake(linw, 0, kDeviceWidth-linw, kDeviceWidth/750*72)];
    upView.backgroundColor = [UIColor whiteColor];
    [self addSubview:upView];
    
    UIImageView *img = [[UIImageView alloc ]initWithFrame:CGRectMake(kDeviceWidth/750*25, kDeviceWidth/750*20, kDeviceWidth/750*165, kDeviceWidth/750*42)];
    img.image = [UIImage imageNamed:@"ShiXinImg"];
    [upView addSubview:img];

    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/750*35 + kDeviceWidth/750*152 + kDeviceWidth/750*15 , kDeviceWidth/750*36, kDeviceWidth/750*507, 1)];
    line.backgroundColor = [YXBTool colorWithHexString:@"#FDE9F0"];
    [upView addSubview:line];
    
    UIButton *one = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth/750*30,kDeviceWidth/750*22+img.bottom, kDeviceWidth/750*96, kDeviceWidth/750*58)];
    [one setBackgroundImage:[UIImage imageNamed:@"ShiXin_name"] forState:UIControlStateNormal];
    [self addSubview:one];
    
    UIButton *tow = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth/750*3+one.right,kDeviceWidth/750*22+img.bottom, kDeviceWidth/750*134, kDeviceWidth/750*58)];
    [tow setBackgroundImage:[UIImage imageNamed:@"ShiXin_TEL"] forState:UIControlStateNormal];
    [self addSubview:tow];
    
    UIButton *three = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth/750*6+tow.right,kDeviceWidth/750*22+img.bottom, kDeviceWidth/750*238, kDeviceWidth/750*58)];
    [three setBackgroundImage:[UIImage imageNamed:@"ShiXin_Card"] forState:UIControlStateNormal];
    [self addSubview:three];
    
    UIButton *four = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth/750*9+three.right,kDeviceWidth/750*22+img.bottom, kDeviceWidth/750*200, kDeviceWidth/750*58)];
    [four setBackgroundImage:[UIImage imageNamed:@"ShiXin_stues"] forState:UIControlStateNormal];
    [self addSubview:four];
    
    UIImageView *imgname = [[UIImageView alloc ]initWithFrame:CGRectMake(kDeviceWidth/750*30, kDeviceWidth/750*7+one.bottom, kDeviceWidth/750*96, kDeviceWidth/750*244)];
    imgname.image=[UIImage imageNamed:@"ShiXin_lab_name"];
//    imgname.backgroundColor =[UIColor colorWithPatternImage: [UIImage imageNamed:@"ShiXin_lab_name"]];
       [self addSubview:imgname];
    
    UIImageView *imgTEL = [[UIImageView alloc ]initWithFrame:CGRectMake(kDeviceWidth/750*5+imgname.right, kDeviceWidth/750*7+one.bottom, kDeviceWidth/750*134, kDeviceWidth/750*244)];
    imgTEL.image=[UIImage imageNamed:@"ShiXin_lab_tel"];
       [self addSubview:imgTEL];
    UIImageView *imgCard = [[UIImageView alloc ]initWithFrame:CGRectMake(kDeviceWidth/750*5+imgTEL.right, kDeviceWidth/750*7+one.bottom, kDeviceWidth/750*238, kDeviceWidth/750*244)];
    imgCard.image=[UIImage imageNamed:@"ShiXin_lab_card"];
//    imgCard.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ShiXin_lab_card"]];
    [self addSubview:imgCard];
    UIImageView *imgstaues = [[UIImageView alloc ]initWithFrame:CGRectMake(kDeviceWidth/750*5+imgCard.right, kDeviceWidth/750*7+one.bottom, kDeviceWidth/750*200, kDeviceWidth/750*244)];
    imgstaues.image=[UIImage imageNamed:@"Shixin_lab_staues"];

//    imgstaues.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Shixin_lab_staues"]];
    [self addSubview:imgstaues];
    for (int i = 0 ; i < 4; i++) {
        
        _nameLab=[[UILabel alloc] initWithFrame:CGRectMake(0,0+kDeviceWidth/750*61*i, kDeviceWidth/750*96, kDeviceWidth/750*61)];
        _nameLab.textColor = [UIColor blackColor];
        _nameLab.font = [UIFont boldSystemFontOfSize:kDeviceWidth/750*25];
        _nameLab.textAlignment = NSTextAlignmentCenter;
        _nameLab.textColor=rgb(60, 60, 70, 1);
        _nameLab.tag=i+100;
        [_nameLab setAdjustsFontSizeToFitWidth:YES];

        [imgname addSubview:_nameLab];
        _TELLab=[[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/750*6,0+kDeviceWidth/750*i*61, kDeviceWidth/750*124, kDeviceWidth/750*61)];
        _TELLab.textColor = [UIColor blackColor];
        _TELLab.font = [UIFont boldSystemFontOfSize:kDeviceWidth/750*25];
        _TELLab.textColor=rgb(60, 60, 70, 1);
        _TELLab.textAlignment = NSTextAlignmentCenter;
        _TELLab.tag=i+200;
        [_TELLab setAdjustsFontSizeToFitWidth:YES];

        [imgTEL addSubview:_TELLab];

        _cardLab=[[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/750*6,0+kDeviceWidth/750*i*61, kDeviceWidth/750*226, kDeviceWidth/750*61)];
        _cardLab.textColor = [UIColor blackColor];
        _cardLab.font = [UIFont boldSystemFontOfSize:kDeviceWidth/750*25];
        _cardLab.textAlignment = NSTextAlignmentCenter;
        _cardLab.textColor=rgb(60, 60, 70, 1);
        _cardLab.tag=i+300;
        [_cardLab setAdjustsFontSizeToFitWidth:YES];
        [imgCard addSubview:_cardLab];

        _stauesLab=[[UILabel alloc] initWithFrame:CGRectMake(0,0+kDeviceWidth/750*i*61, kDeviceWidth/750*200, kDeviceWidth/750*61)];
        _stauesLab.textColor = [UIColor blackColor];
        _stauesLab.font = [UIFont boldSystemFontOfSize:kDeviceWidth/750*25];
        _stauesLab.textColor=rgb(60, 60, 70, 1);
        _stauesLab.textAlignment = NSTextAlignmentCenter;
        _stauesLab.tag=i+400;
        [_stauesLab setAdjustsFontSizeToFitWidth:YES];
        [imgstaues addSubview:_stauesLab];

        
    }
   
    UIButton *big = [[UIButton alloc] initWithFrame:self.bounds];
    [big addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:big];
    
}

-(void)butAction:(UIButton*)button{
    LoseCreditSalaViewController *losecreditsala = [[LoseCreditSalaViewController alloc] init];
    losecreditsala.hidesBottomBarWhenPushed = YES;
    [[YXBTool getCurrentNav] pushViewController:losecreditsala animated:YES];
}
-(void)setDataArray:(NSMutableArray *)DataArray{
    
    _DataArray=DataArray;
    for (int i = 0 ; i < 4; i++) {
        UILabel *find_label = (UILabel *)[self viewWithTag:i+100];
        find_label.text=[DataArray[i] objectForKey:@"name"];
        UILabel *find_label1 = (UILabel *)[self viewWithTag:i+200];
        find_label1.text=[DataArray[i] objectForKey:@"mobile"];
        UILabel *find_label2 = (UILabel *)[self viewWithTag:i+300];
        find_label2.text=[DataArray[i] objectForKey:@"idcard"];
        UILabel *find_label3 = (UILabel *)[self viewWithTag:i+400];
        find_label3.text=[DataArray[i] objectForKey:@"state"];
            }
}
@end
