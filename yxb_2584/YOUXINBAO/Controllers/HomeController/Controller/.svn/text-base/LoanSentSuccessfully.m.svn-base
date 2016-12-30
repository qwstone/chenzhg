//
//  LoanSentSuccessfully.m
//  YOUXINBAO
//
//  Created by zjp on 16/1/26.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanSentSuccessfully.h"
#import "UIImageView+WebCache.h"
#import "YXBTool.h"
#import "MyLoanViewController.h"
#import "YXBLoanCenterViewController.h"
@interface LoanSentSuccessfully () {
    UIImageView *infoimg;
}

@end

@implementation LoanSentSuccessfully

- (void)dealloc {

    NSLog(@"LoanSentSuccessfully dealloc");
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftView];
    [self setTitle:@"借条发送成功"];
}

- (void)leftClicked {
    [super leftClicked];
    
//    [self dismissViewControllerAnimated:YES completion:^{
        [[YXBTool getCurrentNav] popToRootViewControllerAnimated:YES];
//        YXBLoanCenterViewController *loanCenterVC = [[YXBLoanCenterViewController alloc] init];
//        loanCenterVC.loanType = 2;
//        loanCenterVC.hidesBottomBarWhenPushed = YES;
//        [[YXBTool getCurrentNav] pushViewController:loanCenterVC animated:YES];

//    }];
}

- (void)setData:(CreateLoanResponse *)data {
    if (_data != data) {
        _data = data;
    }
    [self createView];
}

- (void)createView {
    UIScrollView *bgScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    bgScrollView.delaysContentTouches = NO;
    [self.view addSubview:bgScrollView];

    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake((kDeviceWidth-kDeviceWidth/320*93/189*202)/2, kDeviceWidth/320*25, kDeviceWidth/320*93/189*202, kDeviceWidth/320*93)];
    img.image = [UIImage imageNamed:@"SentSuccessfully"];
    [bgScrollView addSubview:img];
    
    UIView *viewbg = [[UIView alloc]initWithFrame:CGRectMake(kDeviceWidth/320*15, img.bottom+kDeviceWidth/320*25, kDeviceWidth/320*290, kDeviceWidth/320*234)];
    viewbg.clipsToBounds = YES;
    viewbg.layer.cornerRadius = 5;
    [bgScrollView addSubview:viewbg];
    
    UIImageView *userimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, viewbg.width, viewbg.width/580*108)];
    userimg.image = [UIImage imageNamed:@"sendbgtop"];
    [viewbg addSubview:userimg];
    
    UIImageView *userim = [[UIImageView alloc] initWithFrame:CGRectMake(viewbg.width/580*50, viewbg.width/580*18, viewbg.width/580*72, viewbg.width/580*72)];
    [userim sd_setImageWithURL:[NSURL URLWithString:self.data.imageUrl] placeholderImage:[UIImage imageNamed:@"index-user-icon.png"]];
    userim.layer.masksToBounds = YES;
    userim.layer.cornerRadius = userim.width/2;
    [userimg addSubview:userim];
    
    UILabel *userlab = [[UILabel alloc] initWithFrame:CGRectMake(userim.right+5, userim.top, 200, userim.height)];
    userlab.font = [UIFont boldSystemFontOfSize:14];
    userlab.text = _data.name;
    [userimg addSubview:userlab];
    

    if (self.data.mobile == nil || [self.data.mobile isEqualToString:@""]) {
        
    }else {
        UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(viewbg.width-viewbg.width/580*120, viewbg.width/580*22, viewbg.width/580*65, viewbg.width/580*65)];
        [button3 setBackgroundImage:[UIImage imageNamed:@"dianhuatu"] forState:UIControlStateNormal];
        [button3 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button3.tag = 300;
        [viewbg addSubview:button3];
    }
    
//-------------------------------
    infoimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, userimg.bottom, userimg.width,viewbg.height - userimg.height -kDeviceWidth/320*10)];
    infoimg.image = [UIImage imageNamed:@"sendbgcon"];
    [viewbg addSubview:infoimg];
    
    NSArray *arr = @[@"借款金额",@"还款时间",@"还款方式",@"支付利息"];
    for (int i = 0; i < 4; i++) {
        
        
        CGFloat lableH = kDeviceWidth/320*30;
        CGFloat lableFontH = lableH * 0.4;

        UILabel *infolab = [[UILabel alloc] initWithFrame:CGRectMake(getScreenFitSize(26), kDeviceWidth/320*30*i+kDeviceWidth/320*14, infoimg.width- kDeviceWidth/320*52, lableH)];
        infolab.textAlignment = NSTextAlignmentLeft;
        infolab.text = arr[i];
        infolab.textColor = [UIColor lightGrayColor];
        infolab.font = [UIFont systemFontOfSize: lableFontH];
        [infoimg addSubview:infolab];
        
        [self dashLineWithY:infolab.bottom];
        
        UILabel *infolab1 = [[UILabel alloc] initWithFrame:CGRectMake(getScreenFitSize(26), kDeviceWidth/320*30*i+kDeviceWidth/320*14, infoimg.width- kDeviceWidth/320*52, lableH)];
        infolab1.textAlignment = NSTextAlignmentRight;
        infolab1.textColor = [UIColor darkTextColor];
        infolab1.font = [UIFont systemFontOfSize:lableFontH];
        if (i == 0) {
//            infolab1.text = [NSString stringWithFormat:@"%@ 元",self.data.money];
            NSString *jiekuanjine = [NSString stringWithFormat:@"%@ 元",self.data.money];
            NSMutableAttributedString* strLabel = [[NSMutableAttributedString alloc] initWithString:jiekuanjine];
            [strLabel addAttribute:NSForegroundColorAttributeName value:[UIColor redColor]
                             range:[jiekuanjine rangeOfString:self.data.money]];
            infolab1.attributedText = strLabel;
        }else if (i == 1){
            infolab1.text = self.data.backTime;
        }else if (i == 2){
            if (self.data.repayType == 0) {
                infolab1.text = @"全额";
            }else if (self.data.repayType == 1){
                infolab1.text = @"分期";
            }
        }else if (i == 3){
            NSString *lixi = [NSString stringWithFormat:@"%@ 元",self.data.interest];
            NSMutableAttributedString* strLabel = [[NSMutableAttributedString alloc] initWithString:lixi];
            [strLabel addAttribute:NSForegroundColorAttributeName value:[UIColor redColor]
                             range:[lixi rangeOfString:self.data.interest]];
            infolab1.attributedText = strLabel;
        }

        [infoimg addSubview:infolab1];
    }

    UIImageView *shuoming = [[UIImageView alloc] initWithFrame:CGRectMake(0, kDeviceWidth/320*147, infoimg.width, kDeviceWidth/320*13)];
    shuoming.contentMode = UIViewContentModeScaleAspectFit;
    if ([self.data.needVideo isEqualToString:@"0"]) {
          shuoming.image = [UIImage imageNamed:@"quwodejieju"];
    }
    if ([self.data.needVideo isEqualToString:@"1"]) {
        shuoming.image = [UIImage imageNamed:@"loan_video"];
    }
    [infoimg addSubview:shuoming];
    
    
    
    UIImageView *footimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, infoimg.bottom, userimg.width,kDeviceWidth/320*10)];
    footimg.image = [UIImage imageNamed:@"sendbgfoot"];
    [viewbg addSubview:footimg];
    
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(viewbg.left, viewbg.bottom+kDeviceWidth/320*13, viewbg.width, viewbg.width/579*84)];
    button1.tag = 100;
    [button1 setBackgroundImage:[UIImage imageNamed:@"chakanwodejietiao"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:button1];
    
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(viewbg.left, button1.bottom+kDeviceWidth/320*13, viewbg.width, viewbg.width/579*84)];
    button2.tag = 200;
    [button2 setBackgroundImage:[UIImage imageNamed:@"fanhuisy"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:button2];
    
    
    bgScrollView.contentSize = CGSizeMake(kDeviceWidth,button2.bottom+20+64);
}



- (void)buttonAction:(UIButton *)button {

    if (button.tag == 100) {
        MyLoanViewController *myLoanListVC = [[MyLoanViewController alloc] init];
        myLoanListVC.loanID = self.data.loanId;
        [self.navigationController pushViewController:myLoanListVC animated:YES];
    }else if (button.tag == 200){
//        [self dismissViewControllerAnimated:YES completion:^{

            [[YXBTool getCurrentNav] popToRootViewControllerAnimated:YES];
//        }];
    }else if (button.tag == 300){
        [YXBTool callTelphoneWithNum:self.data.mobile];
    }

}



-(void)dashLineWithY:(CGFloat)y
{
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(getScreenFitSize(26), y, infoimg.width- kDeviceWidth/320*52, getScreenFitSize(0.5))];
    [infoimg addSubview:imageView1];
    
    
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
