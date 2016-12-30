//
//  MoreInformationHeaderView.m
//  YOUXINBAO
//
//  Created by zjp on 16/1/30.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "MoreInformationHeaderView.h"
#import "MyLoanViewController.h"
@implementation MoreInformationHeaderView {
    UILabel *_jiaoyihao;
    UILabel *_huankuanren;
    UILabel *_jiekuanzonge;
    
    UILabel *interest;
    UILabel *_buchangjin;
    UILabel *payMode;

    UILabel *askTime;
    UILabel *payTime;
    UILabel *payPurpose;

    
    UIImageView *loanStatus;


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


- (void)createView {
    
    
    
    
    
//    img1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.width/580*17)];
//    UIImage *imgss = [UIImage imageNamed:@"morexx-top"];
//    img1.image = imgss;
//    [self addSubview:img1];
//    
//    img2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, img1.bottom, self.width, kDeviceHeight-img1.bottom)];
//    UIImage *imgsss = [UIImage imageNamed:@"morexx-con"];
//    img2.image = imgsss;
//    [self addSubview:img2];
    
    
    //header 背景
    
    UIView * headerBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, kDeviceWidth/640*325)];
    headerBG.layer.borderColor = [YXBTool colorWithHexString:@"#dadada"].CGColor;
    headerBG.layer.borderWidth = 1;
    headerBG.layer.cornerRadius = 6;
    headerBG.layer.masksToBounds = YES;
    headerBG.backgroundColor = [YXBTool colorWithHexString:@"#ffffff"];
    [self addSubview:headerBG];
    
    

    _jiaoyihao = [[UILabel alloc] initWithFrame:CGRectMake(15, kDeviceWidth/640*29, kDeviceWidth/640*515, 12)];
    _jiaoyihao.font = [UIFont systemFontOfSize:12];
    _jiaoyihao.textColor = [UIColor lightGrayColor];
    [_jiaoyihao setAdjustsFontSizeToFitWidth:YES];
    [self addSubview:_jiaoyihao];
    
    
    _huankuanren = [[UILabel alloc] initWithFrame:CGRectMake(15, kDeviceWidth/640*75, kDeviceWidth/640*515, 12)];
    _huankuanren.font = [UIFont systemFontOfSize:12];
    _huankuanren.textColor = [UIColor lightGrayColor];
     [_huankuanren setAdjustsFontSizeToFitWidth:YES];
    [self addSubview:_huankuanren];
    
    
    _jiekuanzonge = [[UILabel alloc] initWithFrame:CGRectMake(15, kDeviceWidth/640*125, self.width/2-15, 12)];
    _jiekuanzonge.font = [UIFont systemFontOfSize:12];
    _jiekuanzonge.textColor = [UIColor lightGrayColor];
     [_jiekuanzonge setAdjustsFontSizeToFitWidth:YES];
    [self addSubview:_jiekuanzonge];
    
    
    
    //row3
    interest = [[UILabel alloc] initWithFrame:CGRectMake(15, kDeviceWidth/640*175, self.width/2, 12)];
    interest.font = [UIFont systemFontOfSize:12];
    interest.textColor = [UIColor lightGrayColor];
     [interest setAdjustsFontSizeToFitWidth:YES];
    [self addSubview:interest];
    askTime = [[UILabel alloc] initWithFrame:CGRectMake(self.width/2, kDeviceWidth/640*175, self.width/2-15, 12)];
    askTime.font = [UIFont systemFontOfSize:12];
    askTime.textColor = [UIColor lightGrayColor];
     [askTime setAdjustsFontSizeToFitWidth:YES];
    [self addSubview:askTime];
    
    //row4
    _buchangjin = [[UILabel alloc] initWithFrame:CGRectMake(15, kDeviceWidth/640*225, self.width/2, 12)];
    _buchangjin.font = [UIFont systemFontOfSize:12];
    _buchangjin.textColor = [UIColor lightGrayColor];
    [_buchangjin setAdjustsFontSizeToFitWidth:YES];
    [self addSubview:_buchangjin];
    
    payTime = [[UILabel alloc] initWithFrame:CGRectMake(self.width/2, kDeviceWidth/640*225, self.width/2, 12)];
    payTime.font = [UIFont systemFontOfSize:12];
    payTime.textColor = [UIColor lightGrayColor];
     [payTime setAdjustsFontSizeToFitWidth:YES];
    [self addSubview:payTime];
    
    
    payMode = [[UILabel alloc] initWithFrame:CGRectMake(15, kDeviceWidth/640*275, self.width/2-15, 12)];
    payMode.font = [UIFont systemFontOfSize:12];
    payMode.textColor = [UIColor lightGrayColor];
     [payMode setAdjustsFontSizeToFitWidth:YES];
    [self addSubview:payMode];
    
    
    payPurpose = [[UILabel alloc] initWithFrame:CGRectMake(self.width/2, kDeviceWidth/640*275, self.width/2, 12)];
    payPurpose.font = [UIFont systemFontOfSize:12];
    payPurpose.textColor = [UIColor lightGrayColor];
     [payPurpose setAdjustsFontSizeToFitWidth:YES];
    [self addSubview:payPurpose];
    
    
    
//    _yanqiimg = [[UIImageView alloc] initWithFrame:CGRectMake(self.width/580*454, 0, self.width/580*126, self.width/580*92)];
//    UIImage *im = [UIImage imageNamed:@"yanqijietiao"];
//    _yanqiimg.image = im;
//    [self addSubview:_yanqiimg];
//    _yanqi = [[UILabel alloc] initWithFrame:CGRectMake(15, kDeviceWidth/640*275, self.width/2-15, 12)];
//    _yanqi.font = [UIFont systemFontOfSize:12];
//    _yanqi.textColor = [UIColor lightGrayColor];
//    [_yanqi setAdjustsFontSizeToFitWidth:YES];
//    [self addSubview:_yanqi];
    
    
    
    
    
   
    
    
}


- (void)setModel:(LoanMoreInfo *)model {
    if (_model != model) {
        _model = model;
    }
    
    [self setdata];
}


- (void)setdata {
    NSString *jiaoyihao = [NSString stringWithFormat:@"交易号  %@",_model.tradeID];
    NSMutableAttributedString* strLabel = [[NSMutableAttributedString alloc] initWithString:jiaoyihao];
    [strLabel addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]
                     range:[jiaoyihao rangeOfString:[NSString stringWithFormat:@"%@",_model.tradeID]]];
    _jiaoyihao.attributedText = strLabel;
    
    
    NSString *huankuanren = [NSString stringWithFormat:@"借款人  %@",_model.name];
    NSMutableAttributedString* strLabel1 = [[NSMutableAttributedString alloc] initWithString:huankuanren];
    [strLabel1 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]
                     range:[huankuanren rangeOfString:[NSString stringWithFormat:@"%@",_model.name]]];
    _huankuanren.attributedText = strLabel1;
    
    NSString *jiekuanzonge = [NSString stringWithFormat:@"借款金额  %@元",_model.money];
    NSMutableAttributedString* strLabel2 = [[NSMutableAttributedString alloc] initWithString:jiekuanzonge];
    [strLabel2 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor]
                      range:[jiekuanzonge rangeOfString:[NSString stringWithFormat:@"%@",_model.money]]];
    [strLabel2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]
                      range:[jiekuanzonge rangeOfString:[NSString stringWithFormat:@"元"]]];
    _jiekuanzonge.attributedText = strLabel2;
    
    
    NSString *zonglixi = [NSString stringWithFormat:@"利 息  %@元",_model.interest];
    NSMutableAttributedString* strLabel3 = [[NSMutableAttributedString alloc] initWithString:zonglixi];
    [strLabel3 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]
                      range:[zonglixi rangeOfString:[NSString stringWithFormat:@"%@元",_model.interest]]];
    interest.attributedText = strLabel3;
    
    
    NSString *shenqingshijian = [NSString stringWithFormat:@"申请时间  %@",_model.askTime];
    NSMutableAttributedString* strLabel4 = [[NSMutableAttributedString alloc] initWithString:shenqingshijian];
    [strLabel4 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]
                      range:[shenqingshijian rangeOfString:[NSString stringWithFormat:@"%@",_model.askTime]]];
    askTime.attributedText = strLabel4;
    
    
    NSString *buchangjinStr = [NSString stringWithFormat:@"补偿金  %@元",_model.deleyMoney];
    NSMutableAttributedString* buchangjinAtt = [[NSMutableAttributedString alloc] initWithString:buchangjinStr];
    [strLabel3 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]
                      range:[buchangjinStr rangeOfString:[NSString stringWithFormat:@"%@元",_model.deleyMoney]]];
    _buchangjin.attributedText = buchangjinAtt;
    
    
    
    
    NSString *huankuanshijian = [NSString stringWithFormat:@"还款时间  %@",_model.payTime];
    NSMutableAttributedString* strLabel5 = [[NSMutableAttributedString alloc] initWithString:huankuanshijian];
    [strLabel5 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]
                      range:[huankuanshijian rangeOfString:[NSString stringWithFormat:@"%@",_model.payTime]]];
    payTime.attributedText = strLabel5;
    
    

    
    NSString *huankuanfanshi = [NSString stringWithFormat:@"还款方式  %@",_model.payMode];
    NSMutableAttributedString* strLabel6 = [[NSMutableAttributedString alloc] initWithString:huankuanfanshi];
    [strLabel6 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]
                      range:[huankuanfanshi rangeOfString:[NSString stringWithFormat:@"%@",_model.payMode]]];
    payMode.attributedText = strLabel6;
    
    
    NSString *jiekuanyongtu = [NSString stringWithFormat:@"借款用途  %@",_model.payPurpose];
    NSMutableAttributedString* strLabel7 = [[NSMutableAttributedString alloc] initWithString:jiekuanyongtu];
    [strLabel7 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]
                      range:[jiekuanyongtu rangeOfString:[NSString stringWithFormat:@"%@",_model.payPurpose]]];
    payPurpose.attributedText = strLabel7;
    
    
    
//    if (_model.hasDelay == 1) {
//        img2.height = kDeviceWidth/640*50 + kDeviceWidth/640*270-img1.bottom;
//        img.top = kDeviceWidth/640*50+kDeviceWidth/640*270;
//        _yanqiimg.hidden = NO;
//        NSString *yanqi = [NSString stringWithFormat:@"补偿金额  %@",_model.deleyMoney];
//        NSMutableAttributedString* strLabel8 = [[NSMutableAttributedString alloc] initWithString:yanqi];
//        [strLabel8 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]
//                          range:[yanqi rangeOfString:[NSString stringWithFormat:@"%@",_model.deleyMoney]]];
//        _yanqi.attributedText = strLabel8;
//    }else if (_model.hasDelay == 0){
//        _yanqiimg.hidden = YES;
//        img2.height = kDeviceWidth/640*270-img1.bottom;
//        img.top = kDeviceWidth/640*270;
//    }



}




@end
