//
//  MyIOUHeaderView.m
//  YOUXINBAO
//
//  Created by Walice on 16/2/17.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "MyIOUHeaderView.h"
#import "YXBLoanInfoDetails.h"
#import "MoreInformationViewController.h"
#import "QCConsultLixiView.h"

#define sWidth self.frame.size.width
#define sHeight self.frame.size.height

@implementation MyIOUHeaderView{

    UILabel *_fangkuanren;
    UILabel *_jiechujine;
    UILabel *_shenqingTime;
    UILabel *_buchangjine;
    UILabel *_lixi;
    UILabel *_huankuanTime;
    UILabel *_jiaoyiMa;
    UILabel *_zhengjianHao;
    UIImageView *img1;
    UIImageView *img2;
    UIImageView *img3;
    UIImageView *img4;
    UIImageView *img5;
    UIImageView *rightCorner;
    UIButton *reviselixi;
    UIButton *moreInfo;

}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)createView{

    img1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, sWidth, 9)];
    img1.image = [UIImage imageNamed:@"qrbgtop"];
    [self addSubview:img1];
    //以圈为分隔的上半部分的高度是100
    img3=[[UIImageView alloc]initWithFrame:CGRectMake(0, 100, kDeviceWidth-30, 19)];
    img3.image=[UIImage imageNamed:@"YXBjiejxx-con.jpg"];
    [self addSubview:img3];
    
    img2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 9, sWidth, img3.top-9)];
    img2.userInteractionEnabled=YES;
    img2.image = [UIImage imageNamed:@"qrbgcon"];
    [self addSubview:img2];
    
    _fangkuanren=[[UILabel alloc]initWithFrame:CGRectMake(12, 10, (kDeviceWidth-24)/2, 12)];
    _fangkuanren.font=[UIFont systemFontOfSize:12];
    _fangkuanren.textColor = rgb(178, 178, 178, 1);
    //_fangkuanren.backgroundColor=[UIColor redColor];
    [img2 addSubview:_fangkuanren];
    //右上角图片
    rightCorner=[[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth-63-12-17, -9, 63, 46)];
    [img2 addSubview:rightCorner];
    
    _jiechujine=[[UILabel alloc]initWithFrame:CGRectMake(12, _fangkuanren.bottom+10, (kDeviceWidth-24-30)/2, 12)];
    _jiechujine.font=[UIFont systemFontOfSize:12];
    //_jiechujine.backgroundColor=[UIColor greenColor];
    _jiechujine.textColor=rgb(178, 178, 178, 1);
    [img2 addSubview:_jiechujine];
    
    _shenqingTime=[[UILabel alloc]initWithFrame:CGRectMake(_jiechujine.right, _fangkuanren.bottom+10, (kDeviceWidth-24-30)/2, 12)];
    _shenqingTime.textAlignment=NSTextAlignmentLeft;
    //_shenqingTime.backgroundColor=[UIColor yellowColor];
    _shenqingTime.textColor=rgb(178, 178, 178, 1);
    _shenqingTime.font=[UIFont systemFontOfSize:12];
    [img2 addSubview:_shenqingTime];
    
    _lixi=[[UILabel alloc]initWithFrame:CGRectMake(12, _jiechujine.bottom+10, (kDeviceWidth-24-30)/2, 12)];
    _lixi.textColor=rgb(178, 178, 178, 1);
//    _lixi.backgroundColor=[UIColor grayColor];
    _lixi.font=[UIFont systemFontOfSize:12];
    [_lixi setAdjustsFontSizeToFitWidth:YES];
    [img2 addSubview:_lixi];
    
    
    
    //czg
    reviselixi=[[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth/2 - 60, _jiechujine.bottom+9, 50, 20)];
//    reviselixi.backgroundColor = [UIColor grayColor];
    [reviselixi.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [reviselixi addTarget:self action:@selector(reviselixiAction) forControlEvents:UIControlEventTouchUpInside];
    [reviselixi setHidden:YES];
    [img2 addSubview:reviselixi];
    
    _huankuanTime=[[UILabel alloc]initWithFrame:CGRectMake(_lixi.right, _jiechujine.bottom+13, (kDeviceWidth-24-30)/2, 12)];
    _huankuanTime.textColor=rgb(178, 178, 178, 1);
    _huankuanTime.font=[UIFont systemFontOfSize:12];
    _huankuanTime.textAlignment=NSTextAlignmentLeft;
    //_huankuanTime.backgroundColor=[UIColor orangeColor];
    [_huankuanTime setAdjustsFontSizeToFitWidth:YES];
    [img2 addSubview:_huankuanTime];
    
    _buchangjine=[[UILabel alloc]initWithFrame:CGRectMake(12, _lixi.bottom+10, (kDeviceWidth-24-30)/2, 12)];
    _buchangjine.textColor=rgb(178, 178, 178, 1);
    _buchangjine.font=[UIFont systemFontOfSize:12];
    [_buchangjine setAdjustsFontSizeToFitWidth:YES];
    [img2 addSubview:_buchangjine];
    
    

    
    //下部分背景图

    img4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, img3.bottom, sWidth, 50)];
    img4.userInteractionEnabled=YES;
    img4.image = [UIImage imageNamed:@"qrbgcon"];
    [self addSubview:img4];
    
    img5 = [[UIImageView alloc] initWithFrame:CGRectMake(0, img4.bottom, sWidth, 9)];
    img5.image = [UIImage imageNamed:@"qrbgtop2"];
    [self addSubview:img5];
    
    
    _jiaoyiMa=[[UILabel alloc]initWithFrame:CGRectMake(12, 0, kDeviceWidth-30-100, 12)];
    _jiaoyiMa.font=[UIFont systemFontOfSize:12];
    _jiaoyiMa.textColor=rgb(178, 178, 178, 1);
    //_jiaoyiMa.backgroundColor=[UIColor blueColor];
    [_jiaoyiMa setAdjustsFontSizeToFitWidth:YES];
    [img4 addSubview:_jiaoyiMa];
    
    _zhengjianHao=[[UILabel alloc]initWithFrame:CGRectMake(12, _jiaoyiMa.bottom+13, kDeviceWidth-30-100, 12)];
    _zhengjianHao.font=[UIFont systemFontOfSize:12];
    _zhengjianHao.textColor=rgb(178, 178, 178, 1);
   // _zhengjianHao.backgroundColor=[UIColor purpleColor];
    [_zhengjianHao setAdjustsFontSizeToFitWidth:YES];
    [img4 addSubview:_zhengjianHao];
    
    moreInfo=[[UIButton alloc]initWithFrame:CGRectMake(sWidth-12-77, _jiaoyiMa.bottom, 77, 26)];
    [moreInfo addTarget:self action:@selector(moreInfoAction) forControlEvents:UIControlEventTouchUpInside];
    [img4 addSubview:moreInfo];
    
}



- (void)reviselixiAction
{
    if ([self.delegateTwo respondsToSelector:@selector(moreInforButtonDidClick)]) {
        [self.delegateTwo consultButtonDidClick];
    }
}



- (void)moreInfoAction{
    if ([self.delegateTwo respondsToSelector:@selector(moreInforButtonDidClick)]) {
        [self.delegateTwo moreInforButtonDidClick];
    }

}

- (void)setModel:(YXBLoanInfoDetails *)model {
    if (_model != model) {
        _model = model;
    }
    
    [self setdata];
}


- (void)setdata {
    NSString *fangkuanren;
    if (_model.requestPersonIsLender==1) {
       fangkuanren = [NSString stringWithFormat:@"借款人  %@",_model.borrowName];
        NSMutableAttributedString* strLabel = [[NSMutableAttributedString alloc] initWithString:fangkuanren];
        [strLabel addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]
                         range:[fangkuanren rangeOfString:[NSString stringWithFormat:@"%@",_model.borrowName]]];
        _fangkuanren.attributedText = strLabel;
        
        
        //czg  是否显示修改利息按钮
        if ([_model.showModify isEqualToString:@"1"]) {
            NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"修改"];
            NSRange titleRange = {0,[title length]};
            [title addAttribute:NSForegroundColorAttributeName value:rgb(64, 152, 227, 1) range:titleRange];  //设置颜色
            [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
            [reviselixi setAttributedTitle:title
                                  forState:UIControlStateNormal];
            [reviselixi setHidden:NO];
        }
        else [reviselixi setHidden:YES];
    }
    else if(_model.requestPersonIsLender==0){
        fangkuanren = [NSString stringWithFormat:@"放款人  %@",_model.lendName];
        NSMutableAttributedString* strLabel = [[NSMutableAttributedString alloc] initWithString:fangkuanren];
        [strLabel addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]
                         range:[fangkuanren rangeOfString:[NSString stringWithFormat:@"%@",_model.lendName]]];
        _fangkuanren.attributedText = strLabel;
    }
  
    
    
    
    
    NSString *jiechujine = [NSString stringWithFormat:@"借款金额  %@元",_model.money];
    NSMutableAttributedString* strLabel2 = [[NSMutableAttributedString alloc] initWithString:jiechujine];
    [strLabel2 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor]
                      range:[jiechujine rangeOfString:[NSString stringWithFormat:@"%@",_model.money]]];
    [strLabel2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]
                      range:[jiechujine rangeOfString:[NSString stringWithFormat:@"元"]]];
    _jiechujine.attributedText = strLabel2;
    
    
    NSString *lixi = [NSString stringWithFormat:@"利息  %@元",_model.interest];
    NSMutableAttributedString* strLabel3 = [[NSMutableAttributedString alloc] initWithString:lixi];
    [strLabel3 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]
                      range:[lixi rangeOfString:[NSString stringWithFormat:@"%@元",_model.interest]]];
    _lixi.attributedText = strLabel3;
    
    
    NSString *shenqingshijian = [NSString stringWithFormat:@"申请时间  %@",_model.enrolmentTime];
    NSMutableAttributedString* strLabel4 = [[NSMutableAttributedString alloc] initWithString:shenqingshijian];
    [strLabel4 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]
                      range:[shenqingshijian rangeOfString:[NSString stringWithFormat:@"%@",_model.enrolmentTime]]];
    _shenqingTime.attributedText = strLabel4;
    
    
    NSString *huankuanshijian = [NSString stringWithFormat:@"还款时间  %@",_model.payBackTime];
    NSMutableAttributedString* strLabel5 = [[NSMutableAttributedString alloc] initWithString:huankuanshijian];
    [strLabel5 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]
                      range:[huankuanshijian rangeOfString:[NSString stringWithFormat:@"%@",_model.payBackTime]]];
    _huankuanTime.attributedText = strLabel5;
    
    NSString *buchangjine = [NSString stringWithFormat:@"补偿金  %@元",_model.bcj];
    NSMutableAttributedString* strLabel8 = [[NSMutableAttributedString alloc] initWithString:buchangjine];
    [strLabel8 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]
                      range:[buchangjine rangeOfString:[NSString stringWithFormat:@"%@元",_model.bcj]]];
    _buchangjine.attributedText = strLabel8;

    
    
    
    
    NSString *jiaoyima = [NSString stringWithFormat:@"交易码  %@",_model.tradeCode];
    NSMutableAttributedString* strLabel6 = [[NSMutableAttributedString alloc] initWithString:jiaoyima];
    [strLabel6 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]
                      range:[jiaoyima rangeOfString:[NSString stringWithFormat:@"%@",_model.tradeCode]]];
    _jiaoyiMa.attributedText = strLabel6;
    
    
    NSString *zhengjianHao = [NSString stringWithFormat:@"证件号  %@",_model.cardID];
    NSMutableAttributedString* strLabel7 = [[NSMutableAttributedString alloc] initWithString:zhengjianHao];
    [strLabel7 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]
                      range:[zhengjianHao rangeOfString:[NSString stringWithFormat:@"%@",_model.cardID]]];
    _zhengjianHao.attributedText = strLabel7;
    
    rightCorner.image=[UIImage imageNamed:[NSString stringWithFormat:@"YXBLoanState%ld",(long)_model.loanState]];
    if ([_model.isShowMoreInfo isEqualToString:@"0"]) {
        moreInfo.hidden=YES;
    }
    else {
        moreInfo.hidden=NO;
        [moreInfo setImage:[UIImage imageNamed:@"YXBMoreMess"] forState:UIControlStateNormal];
    }
}



@end
