//
//  BorrowingShellsView.m
//  YOUXINBAO
//
//  Created by zjp on 16/2/20.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "BorrowingShellsView.h"
#import "UIImageView+WebCache.h"
#import "YXBTool.h"
#import "MyLoanViewController.h"
@implementation BorrowingShellsView {

    UIImageView *_bgViewOne;
    UIImageView *_bgViewTwo;
    UILabel *_titleLabel;
    UIImageView *qianm;
    
}


- (id)initWithcreditData:(NSDictionary *)creditData {
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    self = [super initWithFrame:window.bounds];
    if (self) {
        self.loanId = creditData[@"loanId"];
        self.backgroundColor = rgb(0, 0, 0, 0.5);
        if ([creditData[@"type"] isEqualToString:@"0"]) {
            [self jiekuan:creditData];
        }else if ([creditData[@"type"] isEqualToString:@"1"]) {
            [self fangkuan:creditData];
        }

    }
    return self;
}



- (void)jiekuan:(NSDictionary *)dic {
    _bgViewOne = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/640*38+kDeviceWidth, kDeviceWidth/640*545, kDeviceWidth/640*564, kDeviceWidth/640*359)];
    _bgViewOne.image = [UIImage imageNamed:@"houmiande"];
    _bgViewOne.userInteractionEnabled = YES;
    _bgViewOne.clipsToBounds = NO;
    [self addSubview:_bgViewOne];
    

    

    UIView *clipview = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/640*50, kDeviceWidth/640*130, kDeviceWidth/640*540, kDeviceWidth/640*700)];
    clipview.clipsToBounds = YES;
    clipview.userInteractionEnabled = YES;
    [self addSubview:clipview];
    
    _bgViewTwo = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/640*12, kDeviceWidth/640*700, kDeviceWidth/640*516, kDeviceWidth/640*700)];
    _bgViewTwo.image = [UIImage imageNamed:@"BorrowingShells2"];
    _bgViewTwo.userInteractionEnabled = YES;
    [clipview addSubview:_bgViewTwo];
    
    UIImageView *title = [[UIImageView alloc ]initWithFrame:CGRectMake(-kDeviceWidth/640*12, kDeviceWidth/640*68, kDeviceWidth/640*201, kDeviceWidth/640*56)];
    title.image = [UIImage imageNamed:@"titleloan"];
    [_bgViewTwo addSubview:title];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/640*12, 0, kDeviceWidth/640*189, kDeviceWidth/640*50)];
    _titleLabel.textColor = [UIColor whiteColor];
    //        _titleLabel.backgroundColor = [UIColor blackColor];
    _titleLabel.text = @"借款请求";
    _titleLabel.font = [UIFont systemFontOfSize:kDeviceWidth/640*30];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [title addSubview:_titleLabel];
    
    UIButton *close = [[UIButton alloc] initWithFrame:CGRectMake(_bgViewTwo.width-kDeviceWidth/640*50, kDeviceWidth/640*21, kDeviceWidth/640*40, kDeviceWidth/640*40)];
    [close setBackgroundImage:[UIImage imageNamed:@"loanPopClose"] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    [_bgViewTwo addSubview:close];
    
    UIImageView *userimg = [[UIImageView alloc ]initWithFrame:CGRectMake((_bgViewTwo.width-kDeviceWidth/640*123)/2, kDeviceWidth/640*30, kDeviceWidth/640*122, kDeviceWidth/640*122)];
    userimg.layer.cornerRadius = userimg.width/2;
    userimg.layer.masksToBounds = YES;
    [userimg sd_setImageWithURL:[NSURL URLWithString:dic[@"pic"]] placeholderImage:[UIImage imageNamed:@"useimg"]];
    [_bgViewTwo addSubview:userimg];
    
    UILabel *namelabel = [[UILabel alloc] initWithFrame:CGRectMake(userimg.left, userimg.bottom+kDeviceWidth/640*13, userimg.width, kDeviceWidth/750*32)];
    namelabel.textColor = [UIColor blackColor];
    namelabel.text = dic[@"name"];
    namelabel.font = [UIFont systemFontOfSize:kDeviceWidth/750*32];
    namelabel.textAlignment = NSTextAlignmentCenter;
    [_bgViewTwo addSubview:namelabel];
    
    UILabel *pingji1 = [[UILabel alloc] initWithFrame:CGRectMake(0, namelabel.bottom+kDeviceWidth/750*10, _bgViewTwo.width, kDeviceWidth/750*60)];
    pingji1.textColor = [YXBTool colorWithHexString:@"#e94d3c"];
    pingji1.text = dic[@"level"];
    pingji1.font = [UIFont boldSystemFontOfSize:kDeviceWidth/750*60];
    pingji1.textAlignment = NSTextAlignmentCenter;
    [_bgViewTwo addSubview:pingji1];
    UILabel *pingji = [[UILabel alloc] initWithFrame:CGRectMake(0, pingji1.bottom+kDeviceWidth/750*5, _bgViewTwo.width, kDeviceWidth/750*40)];
    pingji.textColor = [UIColor blackColor];
    pingji.text = @"无忧借条信用评级";
    pingji.font = [UIFont systemFontOfSize:kDeviceWidth/750*36];
    pingji.textAlignment = NSTextAlignmentCenter;
    [_bgViewTwo addSubview:pingji];

//    UILabel *lll = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/640*49, pingji.bottom+kDeviceWidth/640*12, kDeviceWidth/640*416, 0.2f)];
//    lll.backgroundColor = [UIColor lightGrayColor];
//    [_bgViewTwo addSubview:lll];
    UILabel *shifouzhengchang = [[UILabel alloc] initWithFrame:CGRectMake(0, pingji.bottom+kDeviceWidth/750*10, _bgViewTwo.width, kDeviceWidth/750*28)];
    shifouzhengchang.textColor = [YXBTool colorWithHexString:@"#7D7D7D"];
    shifouzhengchang.text = dic[@"msg"];;
    shifouzhengchang.font = [UIFont systemFontOfSize:kDeviceWidth/750*28];
    shifouzhengchang.textAlignment = NSTextAlignmentCenter;
    [_bgViewTwo addSubview:shifouzhengchang];
    
    
    UIImageView *quanquan = [[UIImageView alloc ]initWithFrame:CGRectMake(kDeviceWidth/640*24, shifouzhengchang.bottom+ kDeviceWidth/640*20, kDeviceWidth/640*466, kDeviceWidth/750*400)];
    quanquan.image = [UIImage imageNamed:@"BorrowingShells32"];
    [_bgViewTwo addSubview:quanquan];
    
    [self dashLineWithY:kDeviceWidth/640*85 X:kDeviceWidth/640*37 view:quanquan];
    [self dashLineWithY:kDeviceWidth/640*148 X:kDeviceWidth/640*37 view:quanquan];
    [self dashLineWithY:kDeviceWidth/640*211 X:kDeviceWidth/640*37 view:quanquan];
    [self dashLineWithY:kDeviceWidth/640*274 X:kDeviceWidth/640*37 view:quanquan];

    
    UILabel *money = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/640*37, kDeviceWidth/640*45, kDeviceWidth/640*342, kDeviceWidth/640*35)];
    money.textColor = [YXBTool colorWithHexString:@"#7D7D7D"];
    money.text = @"张馨予";
    money.font = [UIFont systemFontOfSize:kDeviceWidth/640*32];
    money.textAlignment = NSTextAlignmentLeft;
    [quanquan addSubview:money];
    NSString *moneystr = [NSString stringWithFormat:@"借款金额：%@ 元",dic[@"money"]];
    NSMutableAttributedString* strLabel1 = [[NSMutableAttributedString alloc] initWithString:moneystr];
    [strLabel1 addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#e94d3c"]
                     range:[moneystr rangeOfString:dic[@"money"]]];
    [strLabel1 addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:kDeviceWidth/640*32]
                     range:[moneystr rangeOfString:dic[@"money"]]];
    money.attributedText = strLabel1;
    
    UILabel *lixi = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/640*37, kDeviceWidth/640*108, kDeviceWidth/640*342, kDeviceWidth/640*35)];
    lixi.textColor = [YXBTool colorWithHexString:@"#7D7D7D"];
    lixi.text = @"张馨予";
    lixi.font = [UIFont systemFontOfSize:kDeviceWidth/640*32];
    lixi.textAlignment = NSTextAlignmentLeft;
    [quanquan addSubview:lixi];
    NSString *lixistr = [NSString stringWithFormat:@"预计收益：%@ 元",dic[@"profit"]];
    NSMutableAttributedString* strLabel2 = [[NSMutableAttributedString alloc] initWithString:lixistr];
    [strLabel2 addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#e94d3c"]
                      range:[lixistr rangeOfString:dic[@"profit"]]];
    [strLabel2 addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:kDeviceWidth/640*32]
                      range:[lixistr rangeOfString:dic[@"profit"]]];
    lixi.attributedText = strLabel2;
    
    

    UILabel *nianhua = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/640*37,kDeviceWidth/640*171 , kDeviceWidth/640*342, kDeviceWidth/640*35)];
    nianhua.textColor = [YXBTool colorWithHexString:@"#7D7D7D"];
    nianhua.text = [NSString stringWithFormat:@"年化收益率：%@",dic[@"rate"]];
    nianhua.font = [UIFont systemFontOfSize:kDeviceWidth/640*32];
    nianhua.textAlignment = NSTextAlignmentLeft;
    [quanquan addSubview:nianhua];
    
    UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/640*37,kDeviceWidth/640*234, kDeviceWidth/640*342, kDeviceWidth/640*35)];
    time.textColor = [YXBTool colorWithHexString:@"#7D7D7D"];
    time.text = [NSString stringWithFormat:@"还款时间：%@",dic[@"date"]];
    time.font = [UIFont systemFontOfSize:kDeviceWidth/640*32];
    time.textAlignment = NSTextAlignmentLeft;
    [quanquan addSubview:time];

    

    

    
    qianm = [[UIImageView alloc ]initWithFrame:CGRectMake(kDeviceWidth/640*38+kDeviceWidth, kDeviceWidth/640*764, kDeviceWidth/640*564, kDeviceWidth/640*140)];
    qianm.image = [UIImage imageNamed:@"qianmiande"];
    qianm.userInteractionEnabled = YES;
    [self addSubview:qianm];
    
    UIButton *shaohou = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth/640*24, kDeviceWidth/640*37, kDeviceWidth/640*243, kDeviceWidth/640*85)];
    [shaohou setBackgroundImage:[UIImage imageNamed:@"shaohoubanli"] forState:UIControlStateNormal];
    [shaohou setBackgroundImage:[UIImage imageNamed:@"shaohoubanli_h"] forState:UIControlStateHighlighted];
    [shaohou addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    [qianm addSubview:shaohou];
    
    UIButton *liji = [[UIButton alloc] initWithFrame:CGRectMake(qianm.width-kDeviceWidth/640*267, kDeviceWidth/640*37, kDeviceWidth/640*243, kDeviceWidth/640*85)];
    [liji setBackgroundImage:[UIImage imageNamed:@"lijibanli"] forState:UIControlStateNormal];
    [liji setBackgroundImage:[UIImage imageNamed:@"lijibanli_h"] forState:UIControlStateHighlighted];
    [liji addTarget:self action:@selector(chakan) forControlEvents:UIControlEventTouchUpInside];
    [qianm addSubview:liji];
}

- (void)fangkuan:(NSDictionary *)dic {
    
    _bgViewOne = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/640*38+kDeviceWidth, kDeviceWidth/640*545, kDeviceWidth/640*564, kDeviceWidth/640*359)];
    _bgViewOne.image = [UIImage imageNamed:@"houmiande"];
    _bgViewOne.userInteractionEnabled = YES;
    _bgViewOne.clipsToBounds = NO;
    [self addSubview:_bgViewOne];
    

    
    UIView *clipview = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/640*50, kDeviceWidth/640*165, kDeviceWidth/640*540, kDeviceWidth/640*653)];
    clipview.clipsToBounds = YES;
    clipview.userInteractionEnabled = YES;
    [self addSubview:clipview];
    
    _bgViewTwo = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/640*12, kDeviceWidth/640*653, kDeviceWidth/640*516, kDeviceWidth/640*653)];
    _bgViewTwo.image = [UIImage imageNamed:@"BorrowingShells2"];
    _bgViewTwo.userInteractionEnabled = YES;
    [clipview addSubview:_bgViewTwo];
    
    UIImageView *title = [[UIImageView alloc ]initWithFrame:CGRectMake(-kDeviceWidth/640*12, kDeviceWidth/640*68, kDeviceWidth/640*201, kDeviceWidth/640*56)];
    title.image = [UIImage imageNamed:@"titleloan"];
    [_bgViewTwo addSubview:title];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/640*12, 0, kDeviceWidth/640*189, kDeviceWidth/640*50)];
    _titleLabel.textColor = [UIColor whiteColor];
    //        _titleLabel.backgroundColor = [UIColor blackColor];
    _titleLabel.text = @"土豪放款";
    _titleLabel.font = [UIFont systemFontOfSize:kDeviceWidth/640*30];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [title addSubview:_titleLabel];
    
    UIButton *close = [[UIButton alloc] initWithFrame:CGRectMake(_bgViewTwo.width-kDeviceWidth/640*50, kDeviceWidth/640*21, kDeviceWidth/640*40, kDeviceWidth/640*40)];
    [close setBackgroundImage:[UIImage imageNamed:@"loanPopClose"] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    [_bgViewTwo addSubview:close];
    
    UIImageView *userimg = [[UIImageView alloc ]initWithFrame:CGRectMake((_bgViewTwo.width-kDeviceWidth/640*123)/2, kDeviceWidth/640*30, kDeviceWidth/640*122, kDeviceWidth/640*122)];
    userimg.layer.cornerRadius = userimg.width/2;
    userimg.layer.masksToBounds = YES;
    [userimg sd_setImageWithURL:[NSURL URLWithString:dic[@"pic"]] placeholderImage:[UIImage imageNamed:@"useimg"]];
    [_bgViewTwo addSubview:userimg];
    
    UILabel *namelabel = [[UILabel alloc] initWithFrame:CGRectMake(userimg.left, userimg.bottom+kDeviceWidth/640*13, userimg.width, kDeviceWidth/640*30)];
    namelabel.textColor = [UIColor blackColor];
    namelabel.text = dic[@"name"];
    namelabel.font = [UIFont systemFontOfSize:kDeviceWidth/640*30];
    namelabel.textAlignment = NSTextAlignmentCenter;
    [_bgViewTwo addSubview:namelabel];
    
    
    UIImageView *quanquan = [[UIImageView alloc ]initWithFrame:CGRectMake(kDeviceWidth/640*24, namelabel.bottom+ kDeviceWidth/640*28, kDeviceWidth/640*466, kDeviceWidth/640*324)];
    quanquan.image = [UIImage imageNamed:@"BorrowingShells32"];
    [_bgViewTwo addSubview:quanquan];
    
    [self dashLineWithY:kDeviceWidth/640*85 X:kDeviceWidth/640*37 view:quanquan];
    [self dashLineWithY:kDeviceWidth/640*148 X:kDeviceWidth/640*37 view:quanquan];
    [self dashLineWithY:kDeviceWidth/640*211 X:kDeviceWidth/640*37 view:quanquan];
    [self dashLineWithY:kDeviceWidth/640*274 X:kDeviceWidth/640*37 view:quanquan];
    
    UILabel *money = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/640*37, kDeviceWidth/640*45, kDeviceWidth/640*342, kDeviceWidth/640*35)];
    money.textColor = [UIColor darkGrayColor];
    money.text = @"张馨予";
    money.font = [UIFont systemFontOfSize:kDeviceWidth/640*32];
    money.textAlignment = NSTextAlignmentLeft;
    [quanquan addSubview:money];
    NSString *jiekuanjine = [NSString stringWithFormat:@"借款金额：%@ 元",dic[@"money"]];
    NSMutableAttributedString* strLabel = [[NSMutableAttributedString alloc] initWithString:jiekuanjine];
    [strLabel addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#e94d3c"]
                     range:[jiekuanjine rangeOfString:dic[@"money"]]];
    [strLabel addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:kDeviceWidth/640*32]
                     range:[jiekuanjine rangeOfString:dic[@"money"]]];
    money.attributedText = strLabel;
    
    UILabel *lixi = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/640*37, kDeviceWidth/640*108, kDeviceWidth/640*342, kDeviceWidth/640*35)];
    lixi.textColor = [UIColor darkGrayColor];
    lixi.text = @"张馨予";
    lixi.font = [UIFont systemFontOfSize:kDeviceWidth/640*32];
    lixi.textAlignment = NSTextAlignmentLeft;
    [quanquan addSubview:lixi];
    NSString *lixijine = [NSString stringWithFormat:@"应还利息：%@ 元",dic[@"profit"]];
    NSMutableAttributedString* strLabel1 = [[NSMutableAttributedString alloc] initWithString:lixijine];
    [strLabel1 addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#e94d3c"]
                     range:[lixijine rangeOfString:dic[@"profit"]]];
    [strLabel1 addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:kDeviceWidth/640*32]
                     range:[lixijine rangeOfString:dic[@"profit"]]];
    lixi.attributedText = strLabel1;
    
    UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/640*37, kDeviceWidth/640*171, kDeviceWidth/640*342, kDeviceWidth/640*35)];
    time.textColor = [UIColor darkGrayColor];
    
    time.font = [UIFont systemFontOfSize:kDeviceWidth/640*32];
    time.textAlignment = NSTextAlignmentLeft;
    [quanquan addSubview:time];
    NSString *shijian = [NSString stringWithFormat:@"还款时间：%@",dic[@"date"]];
    time.text = shijian;
//    NSMutableAttributedString* strLabel2 = [[NSMutableAttributedString alloc] initWithString:shijian];
//    [strLabel2 addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#e94d3c"]
//                      range:[shijian rangeOfString:dic[@"date"]]];
//    [strLabel2 addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:kDeviceWidth/640*30]
//                      range:[shijian rangeOfString:dic[@"date"]]];
//    time.attributedText = strLabel2;
    
    UILabel *type = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/640*37, kDeviceWidth/640*234, kDeviceWidth/640*342, kDeviceWidth/640*35)];
    type.textColor = [UIColor darkGrayColor];
    
    type.font = [UIFont systemFontOfSize:kDeviceWidth/640*32];
    type.textAlignment = NSTextAlignmentLeft;
    [quanquan addSubview:type];
    NSString *typee = [NSString stringWithFormat:@"还款方式：%@",dic[@"loanType"]];
    type.text = typee;
//    NSMutableAttributedString* strLabel3 = [[NSMutableAttributedString alloc] initWithString:typee];
//    [strLabel3 addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#e94d3c"]
//                      range:[typee rangeOfString:dic[@"loanType"]]];
//    [strLabel3 addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:kDeviceWidth/640*30]
//                      range:[typee rangeOfString:dic[@"loanType"]]];
//    type.attributedText = strLabel3;
    
    
    qianm = [[UIImageView alloc ]initWithFrame:CGRectMake(kDeviceWidth/640*38+kDeviceWidth, kDeviceWidth/640*764, kDeviceWidth/640*564, kDeviceWidth/640*140)];
    qianm.image = [UIImage imageNamed:@"qianmiande"];
    qianm.userInteractionEnabled = YES;
    [self addSubview:qianm];
    
    UIButton *shaohou = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth/640*24, kDeviceWidth/640*37, kDeviceWidth/640*243, kDeviceWidth/640*85)];
    [shaohou setBackgroundImage:[UIImage imageNamed:@"shaohoubanli"] forState:UIControlStateNormal];
    [shaohou setBackgroundImage:[UIImage imageNamed:@"shaohoubanli_h"] forState:UIControlStateHighlighted];
    [shaohou addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    [qianm addSubview:shaohou];
    
    UIButton *liji = [[UIButton alloc] initWithFrame:CGRectMake(qianm.width-kDeviceWidth/640*267, kDeviceWidth/640*37, kDeviceWidth/640*243, kDeviceWidth/640*85)];
    [liji setBackgroundImage:[UIImage imageNamed:@"lijibanli"] forState:UIControlStateNormal];
    [liji setBackgroundImage:[UIImage imageNamed:@"lijibanli_h"] forState:UIControlStateHighlighted];
    [liji addTarget:self action:@selector(chakan) forControlEvents:UIControlEventTouchUpInside];
    [qianm addSubview:liji];
}


- (void)chakan {

    MyLoanViewController *myLoanListVC = [[MyLoanViewController alloc] init];
    myLoanListVC.loanID = [self.loanId integerValue];
    myLoanListVC.hidesBottomBarWhenPushed = YES;
    [[YXBTool getCurrentNav] pushViewController:myLoanListVC animated:YES];
    [self removeFromSuperview];
}

- (void)show {
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        _bgViewOne.transform = CGAffineTransformMakeTranslation(-(kDeviceWidth*1.1), 0);
        qianm.transform = CGAffineTransformMakeTranslation(-(kDeviceWidth*1.1), 0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            _bgViewOne.transform = CGAffineTransformMakeTranslation(-kDeviceWidth, 0);
            qianm.transform = CGAffineTransformMakeTranslation(-kDeviceWidth, 0);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                _bgViewTwo.transform = CGAffineTransformMakeTranslation(0, -(_bgViewTwo.height));
            } completion:^(BOOL finished) {
                
            }];
        }];
    }];
    
}

- (void)remove {
    [UIView animateWithDuration:0.3 animations:^{
        _bgViewTwo.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            _bgViewOne.transform = CGAffineTransformIdentity;
            qianm.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
            [self removeFromSuperview];
        }];
    }];

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

@end
