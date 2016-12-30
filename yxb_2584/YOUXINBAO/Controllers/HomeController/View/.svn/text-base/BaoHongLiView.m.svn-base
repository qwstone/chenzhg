//
//  BaoHongLiView.m
//  YOUXINBAO
//
//  Created by zjp on 16/1/28.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "BaoHongLiView.h"
#import "ProfitBannerData.h"
#import "YXBTool.h"
#import "PayHomeViewController.h"
@implementation BaoHongLiView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}


- (void)createView {


    UIView *lebal1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth/750*60)];
    lebal1.backgroundColor = rgb(201, 0, 0, 1);
    [self addSubview:lebal1];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/750*28, kDeviceWidth/750*15, kDeviceWidth/750*38, kDeviceWidth/750*32)];
    img.image = [UIImage imageNamed:@"laba"];
    [lebal1 addSubview:img];
    //滑动列表
    _HomeLiseTableView = [[UITableView alloc] initWithFrame:CGRectMake(kDeviceWidth/750*70, 0, kDeviceWidth-kDeviceWidth/750*80, kDeviceWidth/750*60) style:UITableViewStylePlain];
    _HomeLiseTableView.delegate = self;
    _HomeLiseTableView.dataSource = self;
    _HomeLiseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _HomeLiseTableView.backgroundColor = [UIColor clearColor];
    [lebal1 addSubview:_HomeLiseTableView];
    _HomeLiseTableView.userInteractionEnabled = NO;
    
    UIImageView *img22 = [[UIImageView alloc] initWithFrame:CGRectMake(0, kDeviceWidth/750*60, kDeviceWidth, kDeviceWidth/640*273)];
    img22.image = [UIImage imageNamed:@"tophongli"];
    [self addSubview:img22];
    _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/320*15,kDeviceWidth/750*48, kDeviceWidth-kDeviceWidth/320*30, kDeviceWidth/750*88)];
    //        _moneyLabel.text = @"1,798,485.77";
    //        _moneyLabel.backgroundColor = [UIColor greenColor];
    _moneyLabel.textAlignment = NSTextAlignmentCenter;
    _moneyLabel.font = [UIFont boldSystemFontOfSize:kDeviceWidth/750*88];
    _moneyLabel.textColor = [YXBTool colorWithHexString:@"#FFFFFF"];
    [_moneyLabel setAdjustsFontSizeToFitWidth:YES];
    [img22 addSubview:_moneyLabel];
    
    UILabel *lebal = [[UILabel alloc] initWithFrame:CGRectMake(0, kDeviceWidth/750*140, kDeviceWidth, kDeviceWidth/750*48)];
    lebal.textColor = [YXBTool colorWithHexString:@"#FFFFFF"];
    lebal.textAlignment = NSTextAlignmentCenter;
    lebal.font = [UIFont boldSystemFontOfSize:kDeviceWidth/750*35];
//<<<<<<< .mine
    lebal.text = @"无忧借条往来电子借条总金额（元）";
//=======
//    lebal.text = @"友信宝往来电子借条总金额（元）";
//>>>>>>> .r3020
    [img22 addSubview:lebal];
    
    _userNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, kDeviceWidth/750*206, kDeviceWidth- 80,kDeviceWidth/750*28)];
    //        _userNumberLabel.text = @"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈";
    _userNumberLabel.font = [UIFont systemFontOfSize:kDeviceWidth/750*28];
    [_userNumberLabel setAdjustsFontSizeToFitWidth:YES];
    _userNumberLabel.textAlignment = NSTextAlignmentCenter;
    _userNumberLabel.textColor = [YXBTool colorWithHexString:@"#FFFFFF"];
    [img22 addSubview:_userNumberLabel];
    
    
    UIImageView *hongliqianbao = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/750*350/2, kDeviceWidth/750*390, kDeviceWidth/750*400, kDeviceWidth/750*400/358*310)];
    hongliqianbao.image = [UIImage imageNamed:@"qianbao"];
    [self addSubview:hongliqianbao];
    
    _zrhongli = [[UILabel alloc] initWithFrame:CGRectMake(hongliqianbao.width/298*30, hongliqianbao.height/350*180, hongliqianbao.width/298*238, kDeviceWidth/750*90)];
    _zrhongli.textColor = [UIColor whiteColor];
    _zrhongli.textAlignment = NSTextAlignmentCenter;
    [_zrhongli setAdjustsFontSizeToFitWidth:YES];
    _zrhongli.font = [UIFont boldSystemFontOfSize:kDeviceWidth/750*90];
//    _zrhongli.text = @"上次红利(元)";
    [hongliqianbao addSubview:_zrhongli];
    
    UILabel *lebal11 = [[UILabel alloc] initWithFrame:CGRectMake(0, hongliqianbao.height/350*280, hongliqianbao.width, 16)];
    lebal11.textColor = [YXBTool colorWithHexString:@"#FFFFFF"];
    lebal11.textAlignment = NSTextAlignmentCenter;
    lebal11.font = [UIFont systemFontOfSize:16];
    lebal11.text = @"上次红包(元)";
    [hongliqianbao addSubview:lebal11];
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(100, kDeviceWidth/640*640, kDeviceWidth/640*169, kDeviceWidth/640*35)];
    button1.userInteractionEnabled = NO;
    [button1 setBackgroundImage:[UIImage imageNamed:@"yuanjiaojuxing"] forState:UIControlStateNormal];
    [button1 setTitle:@"签到红包" forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize:kDeviceWidth/640*22];
    button1.right = kDeviceWidth/2-kDeviceWidth/640*26;
    [self addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(100, kDeviceWidth/640*640, kDeviceWidth/640*169, kDeviceWidth/640*35)];
    button2.userInteractionEnabled = NO;
    [button2 setBackgroundImage:[UIImage imageNamed:@"yuanjiaojuxing"] forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:kDeviceWidth/640*22];
    [button2 setTitle:@"每日赠送" forState:UIControlStateNormal];
    button2.left = kDeviceWidth/2+kDeviceWidth/640*26;
    [self addSubview:button2];
    
    
    UILabel *linem = [[UILabel alloc] initWithFrame:CGRectMake(15, kDeviceWidth/640*700, kDeviceWidth-30, 0.5f)];
    linem.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:linem];
    
    
    _lishirimoney = [[UILabel alloc] initWithFrame:CGRectMake(0, kDeviceWidth/640*730, kDeviceWidth/3, kDeviceWidth/750*42)];
    //        _lishirimoney.text = @"111.4";
    _lishirimoney.font = [UIFont boldSystemFontOfSize:kDeviceWidth/750*42];
    _lishirimoney.textAlignment = NSTextAlignmentCenter;
    _lishirimoney.textColor = [YXBTool colorWithHexString:@"#ED2E24"];
    [_lishirimoney setAdjustsFontSizeToFitWidth:YES];
    [self addSubview:_lishirimoney];
    UILabel *lishi = [[UILabel alloc] initWithFrame:CGRectMake(0, kDeviceWidth/640*770, kDeviceWidth/3, kDeviceWidth/640*40)];
    lishi.text = @"累计签到红包(元)";
    lishi.font = [UIFont systemFontOfSize:kDeviceWidth/750*30];
    lishi.textAlignment = NSTextAlignmentCenter;
    lishi.textColor = [YXBTool colorWithHexString:@"#808080"];
    [self addSubview:lishi];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/3,kDeviceWidth/640*730, 0.5, kDeviceWidth/640*80)];
    line.backgroundColor = rgb(220, 220, 220, 1);
    [self addSubview:line];
    
    _dangqianmoney = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/3, kDeviceWidth/640*730, kDeviceWidth/3, kDeviceWidth/750*42)];
    _dangqianmoney.textAlignment = NSTextAlignmentCenter;
    [_dangqianmoney setAdjustsFontSizeToFitWidth:YES];
    //        _dangqianmoney.text = @"123.5";
    _dangqianmoney.textColor = [YXBTool colorWithHexString:@"#ED2E24"];
    _dangqianmoney.font = [UIFont boldSystemFontOfSize:kDeviceWidth/750*42];
    [self addSubview:_dangqianmoney];
    UILabel *dangqian = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/3, kDeviceWidth/640*770, kDeviceWidth/3, kDeviceWidth/640*40)];
    dangqian.textAlignment = NSTextAlignmentCenter;
    dangqian.text = @"现金余额(元)";
    dangqian.font = [UIFont systemFontOfSize:kDeviceWidth/750*30];
    dangqian.textColor = [YXBTool colorWithHexString:@"#808080"];
    [self addSubview:dangqian];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/3*2,kDeviceWidth/640*730, 0.5, kDeviceWidth/640*80)];
    line2.backgroundColor = rgb(220, 220, 220, 1);
    [self addSubview:line2];
    
    _wanyuanmoney = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/3*2, kDeviceWidth/640*730, kDeviceWidth/3, kDeviceWidth/750*42)];
    _wanyuanmoney.textAlignment = NSTextAlignmentCenter;
    [_wanyuanmoney setAdjustsFontSizeToFitWidth:YES];
    //        _wanyuanmoney.text = @"222.67";
    _wanyuanmoney.font = [UIFont boldSystemFontOfSize:kDeviceWidth/750*42];
    _wanyuanmoney.textColor = [YXBTool colorWithHexString:@"#ED2E24"];
    [self addSubview:_wanyuanmoney];
    UILabel *wanyuan = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/3*2, kDeviceWidth/640*770, kDeviceWidth/3, kDeviceWidth/640*40)];
    wanyuan.textAlignment = NSTextAlignmentCenter;
    wanyuan.text = @"万元红包(元)";
    wanyuan.font = [UIFont systemFontOfSize:kDeviceWidth/750*30];
    wanyuan.textColor = [YXBTool colorWithHexString:@"#808080"];
    [self addSubview:wanyuan];
    
    
    UIImageView *botm = [[UIImageView alloc] initWithFrame:CGRectMake(0, kDeviceWidth/750*971, kDeviceWidth, kDeviceWidth/640*2010)];
    UIImage *buttonImage = [UIImage imageNamed:@"baohonglibeijing"];
    buttonImage = [buttonImage stretchableImageWithLeftCapWidth:0 topCapHeight:floorf(buttonImage.size.height/2)];//设置拉伸点
    botm.image = buttonImage;
    botm.userInteractionEnabled = YES;
    [self addSubview:botm];

    
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth/750*30, kDeviceWidth/750*90, kDeviceWidth/750*560, kDeviceWidth/750*95)];
    [button3 setBackgroundImage:[UIImage imageNamed:@"linghongli1"] forState:UIControlStateNormal];
    button3.tag = 1000;
    [button3 addTarget:self action:@selector(butACtion:) forControlEvents:UIControlEventTouchUpInside];
    [botm addSubview:button3];
    
    UIButton *button4 = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth/750*620, kDeviceWidth/750*90, kDeviceWidth/750*92, kDeviceWidth/750*95)];
    [button4 setBackgroundImage:[UIImage imageNamed:@"shouyijisuan"] forState:UIControlStateNormal];
    button4.tag = 2000;
    [button4 addTarget:self action:@selector(butACtion:) forControlEvents:UIControlEventTouchUpInside];
    [botm addSubview:button4];

}


- (void)butACtion:(UIButton *)button {
    if (button.tag == 1000) {
        PayHomeViewController *pay = [[PayHomeViewController alloc] init];
//        NSUserDefaults *user111 = [NSUserDefaults standardUserDefaults];
//        NSString*str111=@"333";
//        [user111 setObject:str111 forKey:@"user111"];
//        [user111 synchronize];
               [[YXBTool getCurrentNav] pushViewController:pay animated:YES];
    }else if (button.tag == 2000){
        _jisuanview = [[CalculatorViewNew alloc] initWithFrame:[[UIApplication sharedApplication].delegate window].bounds];
        _jisuanview.delegate = self;
        _jisuanview.lilv = _model.interestRate;
        [[[UIApplication sharedApplication].delegate window] addSubview:_jisuanview];
    }

}

#pragma mark --- CalculatorViewDelegate
- (void)pushChongzhiWebView {
    //    NSString *payUrl = @"http://60.195.254.33:8083/charge/recharge.jsp?a=23";
    //    [YXBTool jumpSafariWithUrl:[YXBTool getURL:payUrl params:nil]];
    PayHomeViewController *pay = [[PayHomeViewController alloc] init];
   

    [[YXBTool getCurrentNav] pushViewController:pay animated:YES];
    
}
- (void)setModel:(ProfitHomeDataV3 *)model {
    if (_model != model) {
        _model = model;
        NSString *string = [NSString stringWithFormat:@"无忧借条累计服务用户 %@ 人",model.peopleNum];
        NSMutableAttributedString* strLabel = [[NSMutableAttributedString alloc] initWithString:string];
        [strLabel addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:kDeviceWidth/750*28]
                         range:[string rangeOfString:model.peopleNum]];
        _userNumberLabel.attributedText = strLabel;
        _moneyLabel.text = model.peopleMoney;
        self.listData = _model.iProfitBannerData;
        self.zrhongli.text = model.yestodayMoney;
        _lishirimoney.text = _model.historyMoney;
        _dangqianmoney.text = _model.moneyOfAccount;
        _wanyuanmoney.text = _model.profitOf10thousand;
    }
}
- (void)setListData:(NSMutableArray *)listData {
    if (_listData != listData) {
        _listData = listData;
        [_HomeLiseTableView reloadData];
    }
}

#pragma mark --- tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return kDeviceWidth/750*60;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellID  =@"cellIDdd";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    ProfitBannerData *dic = self.listData[indexPath.row];
    NSString *string = [NSString stringWithFormat:@"%@ %@ %@ %@",dic.name,dic.str1,dic.money,dic.metric];
    //    NSMutableAttributedString* strLabel = [[NSMutableAttributedString alloc] initWithString:string];
    //    [strLabel addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13]
    //                     range:[string rangeOfString:dic.money]];
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:kDeviceWidth/750*26];
    [cell.textLabel setAdjustsFontSizeToFitWidth:YES];
    cell.textLabel.textColor = [YXBTool colorWithHexString:@"#FFFFFF"];
    //    cell.textLabel.attributedText = strLabel;
    cell.textLabel.text = string;
    
    return cell;
}

@end
