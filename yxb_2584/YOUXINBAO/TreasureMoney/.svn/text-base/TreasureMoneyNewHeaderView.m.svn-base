//
//  TreasureMoneyNewHeaderView.m
//  YOUXINBAO
//
//  Created by zjp on 15/9/22.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "TreasureMoneyNewHeaderView.h"
#import "BaoDynamicCell.h"
#import "YXBTool.h"
#import "ProfitBannerData.h"
@implementation TreasureMoneyNewHeaderView {
//    UILabel *_hongbaoLabel;


}


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage imageNamed:@"newbzqbg"];
        
//        _hongbaoLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/320*45, 0, kDeviceWidth-kDeviceWidth/320*45, kDeviceWidth/320*35)];
//        _hongbaoLabel.text = @"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈";
//        _hongbaoLabel.textColor = [UIColor whiteColor];
//        [self addSubview:_hongbaoLabel];
        
        //滑动列表
        _HomeLiseTableView = [[UITableView alloc] initWithFrame:CGRectMake(kDeviceWidth/320*40, 0, kDeviceWidth-kDeviceWidth/320*45, kDeviceWidth/320*35) style:UITableViewStylePlain];
        _HomeLiseTableView.delegate = self;
        _HomeLiseTableView.dataSource = self;
        _HomeLiseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _HomeLiseTableView.backgroundColor = [UIColor clearColor];
        [self addSubview:_HomeLiseTableView];
        
        _userNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/320*13, _HomeLiseTableView.bottom+kDeviceWidth/320*20, kDeviceWidth-kDeviceWidth/320*25, kDeviceWidth/320*20)];
//        _userNumberLabel.text = @"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈";
        _userNumberLabel.font = [UIFont systemFontOfSize:16];
        [_userNumberLabel setAdjustsFontSizeToFitWidth:YES];
        _userNumberLabel.textColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:_userNumberLabel];
        
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/320*15,_userNumberLabel.bottom+kDeviceWidth/320*5, kDeviceWidth-kDeviceWidth/320*30, self.frame.size.height-_userNumberLabel.bottom-kDeviceWidth/320*10)];
//        _moneyLabel.text = @"1,798,485.77";
//        _moneyLabel.backgroundColor = [UIColor greenColor];
        _moneyLabel.textAlignment = NSTextAlignmentRight;
        _moneyLabel.font = [UIFont boldSystemFontOfSize:55];
        _moneyLabel.textColor = [UIColor whiteColor];
        [_moneyLabel setAdjustsFontSizeToFitWidth:YES];
        [self addSubview:_moneyLabel];
        
        

    }
    return self;
}
- (void)setModel:(ProfitHomeDataV2 *)model {
    if (_model != model) {
        _model = model;
            NSString *string = [NSString stringWithFormat:@"宝赚钱累计为 %@ 用户提供理财总额（元）",model.peopleNum];
        NSMutableAttributedString* strLabel = [[NSMutableAttributedString alloc] initWithString:string];
        [strLabel addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor]
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
    
    return kDeviceWidth/320*35;
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
    NSDictionary *dic = self.listData[indexPath.row];
    NSString *string = [NSString stringWithFormat:@"%@ %@%@ %@",dic[@"name"],dic[@"str1"],dic[@"money"],dic[@"metric"]];
   NSMutableAttributedString* strLabel = [[NSMutableAttributedString alloc] initWithString:string];
    [strLabel addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]
                     range:[string rangeOfString:dic[@"name"]]];
    [strLabel addAttribute:NSForegroundColorAttributeName value:rgb(0, 0, 0, 0.6)
                     range:[string rangeOfString:dic[@"str1"]]];
    [strLabel addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]
                     range:[string rangeOfString:dic[@"money"]]];
    [strLabel addAttribute:NSForegroundColorAttributeName value:rgb(0, 0, 0, 0.6)
                     range:[string rangeOfString:dic[@"metric"]]];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
    [cell.textLabel setAdjustsFontSizeToFitWidth:YES];
    cell.textLabel.attributedText = strLabel;

    return cell;
}

@end
