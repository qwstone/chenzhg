//
//  GuaranteeDaifuDetailCell.m
//  YOUXINBAO
//
//  Created by zjp on 15/9/15.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "GuaranteeDaifuDetailCell.h"
#import "UIImageView+WebCache.h"
#import "FriendDetailViewController.h"
#import "YXBTool.h"
#define TintWarmingText @"·风险提示：请仔细确认您的好友是否具备偿还能力，如对方无力偿还，您的担保金将会受到损失，对方将进入全国失信人员黑名单"
#define TintWarmingFont 17.0

@implementation GuaranteeDaifuDetailCell {
    UIImageView *_userImg;
    UILabel *_bianhaolabel;
    UILabel *_shengchenglabel;
    UILabel *_danbaolabel;
    UILabel *_userlabel;
    
//     UILabel *_shoukuanlabel;
    
    UILabel *_danbaojine;
     UILabel *_danbaoshouyi;
    
    UIWebView *_shoukuanWeb;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *imgarr = @[@"danbxq-txt-icon",@"danbxq-money-icon"];
        NSArray *titlearr = @[@"担保详情",@"收款详情"];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 50)];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.borderColor = rgb(235, 235, 235, 1).CGColor;
        view.layer.borderWidth = 0.5f;
        [self.contentView addSubview:view];
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(16, 16, 17, 17)];
        img.image = [UIImage imageNamed:imgarr[0]];
        [view addSubview:img];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 16, 200, 17)];
        label.text = titlearr[0];
        [view addSubview:label];
        
        UIButton *view1 = [[UIButton alloc] initWithFrame:CGRectMake(0, view.bottom, kDeviceWidth, 50)];
        view1.tag = 1001;
        [view1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        view1.backgroundColor = [UIColor whiteColor];
        view1.layer.borderColor = rgb(235, 235, 235, 1).CGColor;
        view1.layer.borderWidth = 0.5f;
        [self.contentView addSubview:view1];
        _userlabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 16, kDeviceWidth-70-30, 17)];
        _userlabel.textColor = [UIColor lightGrayColor];
        [_userlabel setAdjustsFontSizeToFitWidth:YES];
        [view1 addSubview:_userlabel];
        _userImg = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth-70, 5, 40, 40)];
        _userImg.layer.cornerRadius = _userImg.width/2;
        _userImg.layer.masksToBounds = YES;
        _userImg.contentMode = UIViewContentModeScaleAspectFit;
        _userImg.image = [UIImage imageNamed:@"homeUserPhoto"];
        [view1 addSubview:_userImg];
        UIImageView *next = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth-25, 16, 10, 18)];
        next.image = [UIImage imageNamed:@"next"];
        [view1 addSubview:next];
        
        UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, view1.bottom, kDeviceWidth, 115)];
        view2.backgroundColor = [UIColor whiteColor];
        view2.layer.borderColor = rgb(235, 235, 235, 1).CGColor;
        view2.layer.borderWidth = 0.5f;
        [self.contentView addSubview:view2];
        UIView *viewline = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/2, 20, 0.5f, 75)];
        viewline.backgroundColor = rgb(235, 235, 235, 1);
        [view2 addSubview:viewline];
        UILabel *danbaojine = [[UILabel alloc] initWithFrame:CGRectMake(0, 75, kDeviceWidth/2, 17)];
        danbaojine.textAlignment = NSTextAlignmentCenter;
        danbaojine.font = [UIFont systemFontOfSize:15];
        danbaojine.text = @"担保金额（元）";
        [view2 addSubview:danbaojine];
        UILabel *danbaoshouyi = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2, 75, kDeviceWidth/2, 17)];
        danbaoshouyi.font = [UIFont systemFontOfSize:15];
        danbaoshouyi.text = @"担保收益（元）";
        danbaoshouyi.textAlignment = NSTextAlignmentCenter;
        [view2 addSubview:danbaoshouyi];
        _danbaojine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth/2, 75)];
        _danbaojine.textAlignment = NSTextAlignmentCenter;
        _danbaojine.font = [UIFont boldSystemFontOfSize:40];
        _danbaojine.textColor = [UIColor redColor];
        _danbaojine.text = @"担保金额（元）";
        [view2 addSubview:_danbaojine];
        _danbaoshouyi = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2, 0, kDeviceWidth/2, 75)];
        _danbaoshouyi.font = [UIFont boldSystemFontOfSize:40];
        _danbaoshouyi.text = @"担保收益（元）";
        _danbaoshouyi.textColor = [UIColor redColor];
        _danbaoshouyi.textAlignment = NSTextAlignmentCenter;
        [view2 addSubview:_danbaoshouyi];
        
        UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, view2.bottom, kDeviceWidth, 15)];
        view3.backgroundColor = rgb(244, 244, 244, 1);
        view3.layer.borderColor = rgb(235, 235, 235, 1).CGColor;
        view3.layer.borderWidth = 0.5f;
        [self.contentView addSubview:view3];
        
        UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(0, view3.bottom, kDeviceWidth, 50)];
        view4.backgroundColor = [UIColor whiteColor];
        view4.layer.borderColor = rgb(235, 235, 235, 1).CGColor;
        view4.layer.borderWidth = 0.5f;
        [self.contentView addSubview:view4];
        UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(16, 16, 17, 17)];
        img1.image = [UIImage imageNamed:imgarr[1]];
        [view4 addSubview:img1];
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(40, 16, 200, 17)];
        label1.text = titlearr[1];
        [view4 addSubview:label1];
        self.stutaLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 16, kDeviceWidth-35, 17)];
        self.stutaLabel.text = titlearr[0];
        self.stutaLabel.textAlignment = NSTextAlignmentRight;
        [view4 addSubview:self.stutaLabel];
        
        UIView *view5 = [[UIView alloc] initWithFrame:CGRectMake(0, view4.bottom, kDeviceWidth, 50)];
        view5.backgroundColor = [UIColor whiteColor];
        view5.layer.borderColor = rgb(235, 235, 235, 1).CGColor;
        view5.layer.borderWidth = 0.5f;
        [self.contentView addSubview:view5];
//        _shoukuanlabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, kDeviceWidth-30, 20)];
//        _shoukuanlabel.font = [UIFont systemFontOfSize:16];
//        _shoukuanlabel.textColor = [UIColor lightGrayColor];
//        _shoukuanlabel.text = @"收款";
//        [view5 addSubview:_shoukuanlabel];
        
        _shoukuanWeb = [[UIWebView alloc] initWithFrame:CGRectMake(10, 10, kDeviceWidth, 30)];
        _shoukuanWeb.backgroundColor = [UIColor clearColor];
        _shoukuanWeb.scrollView.bounces = NO;
        _shoukuanWeb.scrollView.showsHorizontalScrollIndicator = NO;
        _shoukuanWeb.scrollView.showsVerticalScrollIndicator = NO;
        [view5 addSubview:_shoukuanWeb];
        
        UIView *view6 = [[UIView alloc] initWithFrame:CGRectMake(0, view5.bottom, kDeviceWidth, 140 + [[self class] getTintHeight] + 10)];
        view6.backgroundColor = [UIColor whiteColor];
        view6.layer.borderColor = rgb(235, 235, 235, 1).CGColor;
        view6.layer.borderWidth = 0.5f;
        view6.userInteractionEnabled = YES;
        [self.contentView addSubview:view6];
        CGFloat x = 0,y = 0, w = kDeviceWidth, h = 140;
        self.payScrollView = [[PayScrollView alloc] initWithFrame:CGRectMake(x, y, w, h) array:nil];
        [view6 addSubview:_payScrollView];
        
        CGFloat spaceLeft = 10;
        UILabel *tintLabel = [[UILabel alloc] initWithFrame:ccr(spaceLeft, _payScrollView.bottom, kDeviceWidth - 2 * spaceLeft, [[self class] getTintHeight])];
        tintLabel.numberOfLines = 0;
        tintLabel.lineBreakMode = 0;
        tintLabel.textColor = [YXBTool colorWithHexString:@"#EA0329"];
        tintLabel.text = TintWarmingText;
        tintLabel.font = [UIFont systemFontOfSize:TintWarmingFont];
        [view6 addSubview:tintLabel];

        UIView *view7 = [[UIView alloc] initWithFrame:CGRectMake(0, view6.bottom, kDeviceWidth, 80)];
        view7.backgroundColor = [UIColor redColor];
        view7.layer.borderColor = rgb(235, 235, 235, 1).CGColor;
        view7.layer.borderWidth = 0.5f;
        [self.contentView addSubview:view7];
//        view7.backgroundColor = rgb(244, 244, 244, 1);
        view7.backgroundColor = [UIColor whiteColor];

        _bianhaolabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, kDeviceWidth-30, 20)];
        _bianhaolabel.font = [UIFont systemFontOfSize:12];
        _bianhaolabel.textColor = [UIColor lightGrayColor];
//        _bianhaolabel.text = @"哈哈哈哈哈哈哈哈哈哈哈哈哈";
        [view7 addSubview:_bianhaolabel];
        _shengchenglabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10+1*20, kDeviceWidth-30, 20)];
        _shengchenglabel.font = [UIFont systemFontOfSize:12];
        _shengchenglabel.textColor = [UIColor lightGrayColor];
//        _shengchenglabel.text = @"哈哈哈哈哈哈哈哈哈哈哈哈哈";
        [view7 addSubview:_shengchenglabel];
        _danbaolabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10+2*20, kDeviceWidth-30, 20)];
        _danbaolabel.font = [UIFont systemFontOfSize:12];
        _danbaolabel.textColor = [UIColor lightGrayColor];
        [view7 addSubview:_danbaolabel];

    }
    return self;
}


- (void)setModel:(GuaranteeData *)model {
    _model = model;
    _payScrollView.modelArray = _model.guaranteeStages;
    _payScrollView.startYear = _model.startYear;
    
    [_userImg sd_setImageWithURL:[NSURL URLWithString:_model.proposerImgUrl] placeholderImage:[UIImage imageNamed:@"hy-usermr-icon"]];
    
    _userlabel.text = [NSString stringWithFormat:@"申  请  人:     %@",_model.proposerName];
    
    _danbaojine.text = _model.guaranteeMoney;
    _danbaoshouyi.text = model.guaranteeEarnings;
    self.stutaLabel.text = _model.guaranteeStatusStr;
    
    NSLog(@"guaranteeTime---%@",_model.guaranteeTime);

    if (_model.orderID != 0)
    {
    _bianhaolabel.text = [NSString stringWithFormat:@"订单编号: %ld",(long)_model.orderID];
    }

    if (_model.generateTime != nil && ![_model.generateTime isEqualToString:@""]) {
        
    _shengchenglabel.text = [NSString stringWithFormat:@"生成时间: %@",_model.generateTime];
    }

    if (_model.guaranteeTime != nil && ![_model.guaranteeTime isEqualToString:@""]) {
            _danbaolabel.text = [NSString stringWithFormat:@"担保时间: %@",_model.guaranteeTime];
    }

    
//    _shoukuanlabel.text = _model.remark;
    [_shoukuanWeb loadHTMLString:_model.remark baseURL:nil];
//    NSString *strings = [NSString stringWithFormat:@"%@",_model.remark];
//    NSMutableAttributedString *strLabel5 = [[NSMutableAttributedString alloc] initWithString:strings];
//    [strLabel5 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[strings rangeOfString:_model.alreadyReceive]];
//    [strLabel5 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[strings rangeOfString:_model.willReceive]];
//    _shoukuanlabel.attributedText = strLabel5;


}

- (void)buttonAction:(UIButton *)sender {
    if (sender.tag == 1001) {
        NSLog(@"点击");
        User *user = [[User alloc] init];
        user.username = _model.proposerPhoneNumber;
        
        FriendDetailViewController *controller = [[FriendDetailViewController alloc] init];
        controller.user = user;
        [[YXBTool getCurrentNav] pushViewController:controller animated:YES];
    }


}

//获取风险提示高度
+(CGFloat)getTintHeight
{
    CGFloat height = 0;
    CGSize size = [YXBTool getFontSizeWithString:TintWarmingText font:[UIFont systemFontOfSize:TintWarmingFont] constrainSize:CGSizeMake(kDeviceWidth - 20, kDeviceHeight)];
    height = size.height;
    return height;
}


@end
