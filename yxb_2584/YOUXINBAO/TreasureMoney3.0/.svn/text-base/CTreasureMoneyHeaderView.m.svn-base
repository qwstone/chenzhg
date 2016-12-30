//
//  CTreasureMoneyHeaderView.m
//  YOUXINBAO
//
//  Created by zjp on 15/12/14.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "CTreasureMoneyHeaderView.h"

#import "YXBTool.h"
#import "ProfitBannerData.h"
@implementation CTreasureMoneyHeaderView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = rgb(218, 44, 44, 1);
        
        UILabel *lebal1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth/750*60)];
        lebal1.backgroundColor = rgb(0, 0, 0, 0.15f);
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
        [self addSubview:_HomeLiseTableView];
        
        
        
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/320*15,kDeviceWidth/750*100, kDeviceWidth-kDeviceWidth/320*30, kDeviceWidth/750*90)];
        //        _moneyLabel.text = @"1,798,485.77";
        //        _moneyLabel.backgroundColor = [UIColor greenColor];
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        _moneyLabel.font = [UIFont boldSystemFontOfSize:45];
        _moneyLabel.textColor = [UIColor whiteColor];
        [_moneyLabel setAdjustsFontSizeToFitWidth:YES];
        [self addSubview:_moneyLabel];
        
        UILabel *lebal = [[UILabel alloc] initWithFrame:CGRectMake(0, kDeviceWidth/750*220, kDeviceWidth, 20)];
        lebal.textColor = [UIColor whiteColor];
        lebal.textAlignment = NSTextAlignmentCenter;
        lebal.font = [UIFont systemFontOfSize:15];
        lebal.text = @"无忧借条理财总金额(元)";
        [self addSubview:lebal];
        
        _userNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kDeviceWidth/750*360, kDeviceWidth, 20)];
        //        _userNumberLabel.text = @"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈";
        _userNumberLabel.font = [UIFont systemFontOfSize:15];
        [_userNumberLabel setAdjustsFontSizeToFitWidth:YES];
        _userNumberLabel.textAlignment = NSTextAlignmentCenter;
        _userNumberLabel.textColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:_userNumberLabel];
        

        
        
        
    }
    return self;
}
- (void)setModel:(ProfitHomeDataV3 *)model {
    if (_model != model) {
        _model = model;
        NSString *string = [NSString stringWithFormat:@"无忧借条累计服务用户 %@ 人",model.peopleNum];
        NSMutableAttributedString* strLabel = [[NSMutableAttributedString alloc] initWithString:string];
        [strLabel addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14]
                         range:[string rangeOfString:model.peopleNum]];
        _userNumberLabel.attributedText = strLabel;
        _moneyLabel.text = model.peopleMoney;
        self.listData = _model.iProfitBannerData;
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
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    [cell.textLabel setAdjustsFontSizeToFitWidth:YES];
    cell.textLabel.textColor = [UIColor whiteColor];
    //    cell.textLabel.attributedText = strLabel;
    cell.textLabel.text = string;
    
    return cell;
}



@end
