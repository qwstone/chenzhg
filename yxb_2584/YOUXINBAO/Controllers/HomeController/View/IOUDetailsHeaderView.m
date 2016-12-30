//
//  IOUDetailsHeaderView.m
//  YOUXINBAO
//
//  Created by zjp on 16/1/30.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "IOUDetailsHeaderView.h"
#import "QuGongzhengViewController.h"

@implementation IOUDetailsHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor redColor];
        [self createView];
    }
    return self;
}



-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        self.height = kDeviceWidth/320*300;
    }
    return self;
}


- (void)setModel:(LoanCertificate *)model {
    if (_model != model) {
        _model = model;
    }
    [self setData];
}

- (void)setData {
    if ([self.model.showAC integerValue]==1) {
       
    }
    else{
        self.qugongzheng.hidden=YES;
    }
    
    [self dashLineWithY:self.miding.height/2 X:5 view:self.miding];
    [self dashLineWithY:self.botimg.height/2 X:5 view:self.botimg];
    self.danjubianhao.text = self.model.certificateID;
    self.jiekuanren.text = self.model.borrowName;
    self.jiekuanrenCall.text = self.model.borrowMobile;
    self.shenfenID.text = self.model.borrowCard;
    self.fangkuanren.text = self.model.lentName;
    self.fangkuanrenCall.text = self.model.lentMobile;
    self.fangkuanrenID.text = self.model.lentCard;
    self.jiekuanjine.text = self.model.money;
    NSString *jiekuanjine = [NSString stringWithFormat:@"%@ 元",_model.money];
    NSMutableAttributedString* strLabel = [[NSMutableAttributedString alloc] initWithString:jiekuanjine];
    [strLabel addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor]
                     range:[jiekuanjine rangeOfString:[NSString stringWithFormat:@"元"]]];
    self.jiekuanjine.attributedText = strLabel;
    self.lixi.text = self.model.interest;
    self.shenqingshijian.text = self.model.askTime;
    self.dakuanshijian.text = self.model.giveMoneyTime;
    self.yanqibuchang.text = self.model.delayMoney;
    self.huankuanfangshi.text = self.model.payMode;
    self.huankuanshijian.text = self.model.repaymentTime;

}

- (void)createView {
  

    UIImageView *imgtop = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.width/580*63)];
    imgtop.image = [UIImage imageNamed:@"jiejxx-top"];
    [self addSubview:imgtop];
    
    UIImageView *imgtop1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.width/580*63, self.width, self.width/580*228)];
    imgtop1.image = [UIImage imageNamed:@"morexx-con"];
    [self addSubview:imgtop1];
    
    
    
    UIImageView *imgtop2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.width/580*291, self.width, self.width/580*37)];
    imgtop2.image = [UIImage imageNamed:@"jiejxx-con"];
    [self addSubview:imgtop2];
    
    [self dashLineWithY:imgtop2.height/2 X:5 view:imgtop2];
    
    UIImageView *imgtop3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.width/580*328, self.width, self.width/580*220)];
    imgtop3.image = [UIImage imageNamed:@"morexx-con"];
    [self addSubview:imgtop3];
    
    UIImageView *imgtop5 = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.width/580*548, self.width, self.width/580*37)];
    imgtop5.image = [UIImage imageNamed:@"jiejxx-con"];
    [self addSubview:imgtop5];
    [self dashLineWithY:imgtop5.height/2 X:5 view:imgtop5];

}



-(void)dashLineWithY:(CGFloat)y X:(CGFloat)x view:(UIView *)view
{
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(getScreenFitSize(x), y, view.width- kDeviceWidth/320*(x*2), getScreenFitSize(0.5))];
    [view addSubview:imageView1];
    
    
    UIGraphicsBeginImageContext(imageView1.frame.size);   //开始画线
    [imageView1.image drawInRect:CGRectMake(0, 0, imageView1.frame.size.width, imageView1.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
    
    
    CGFloat lengths[] = {2,2};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, [UIColor lightGrayColor].CGColor);
    
    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
    CGContextMoveToPoint(line, 0.0, 0.0);    //开始画线
    CGContextAddLineToPoint(line, kDeviceWidth-20, 0.0);
    CGContextStrokePath(line);
    
    imageView1.image = UIGraphicsGetImageFromCurrentImageContext();
}
- (IBAction)qugongzheng:(id)sender {
   
    
    if ([self.delegate respondsToSelector:@selector(buttonDidClick)]) {
        [self.delegate buttonDidClick];
    }
    
}
@end
