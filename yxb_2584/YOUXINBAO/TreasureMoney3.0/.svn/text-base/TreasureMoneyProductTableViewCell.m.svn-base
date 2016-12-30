//
//  TreasureMoneyProductTableViewCell.m
//  YOUXINBAO
//
//  Created by CH10 on 15/12/14.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "TreasureMoneyProductTableViewCell.h"
#import "UserManager.h"
#import "YXBTool.h"

@interface TreasureMoneyProductTableViewCell ()
/**项目公司*/
@property (nonatomic,weak)UILabel *projectNameLabel;
/**项目说明*/
@property (nonatomic,weak)UILabel *projectDesLabel;

/**万份收益*/
@property (nonatomic,weak)UILabel *lucreLabel;
/**理财周期*/
@property (nonatomic,weak)UILabel *periodLabel;

/**产品类型*/
@property (nonatomic,weak)UILabel *categoryLabel;
/**年化收益*/
@property (nonatomic,weak)UILabel *lucrePercentLabel;
/**结算方式*/
@property (nonatomic,weak)UILabel *repayWayLabel;

/**可用余额*/
@property (nonatomic,weak)UILabel *remainderMoneyLabel;
/**快速充值*/
@property (nonatomic,weak)UIButton *chongzhiBtn;

/**预期总收益*/
@property (nonatomic,weak)UILabel *totalLucreLabel;
/**预计到期日*/
@property (nonatomic,weak)UILabel *daoqiLabel;
@end
@implementation TreasureMoneyProductTableViewCell

-(void)setRemainingMoney:(NSString *)remainingMoney{
    if (remainingMoney!=_remainingMoney) {
        _remainingMoney = remainingMoney;
        if (_remainingMoney) {
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元",_remainingMoney] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor blackColor]}];
            NSRange range0 = {0,_remainingMoney.length};
            [str setAttributes:@{NSForegroundColorAttributeName:rgb(237, 46, 36, 1)} range:range0];
            self.remainderMoneyLabel.attributedText = str;
            
        }
    }
}
-(void)setBuyMoney:(NSInteger)buyMoney{
    if (_buyMoney!=buyMoney) {
        _buyMoney = buyMoney;
        if (buyMoney>=100) {//>0
            if (self.model) {
                float perdayLucre = [_model.earningsOf10thousand floatValue]/10000.0*buyMoney;
//                perdayLucre = (NSInteger)(perdayLucre*100)/100.0;
                NSString *perStr = [NSString stringWithFormat:@"%.2f",perdayLucre];
                NSString *totalStr = [NSString stringWithFormat:@"%.2f",perdayLucre*[_model.period integerValue]];
                self.totalLucreLabel.attributedText = [self textManageWith:perStr totalStr:totalStr];
            }
            
        }else{//0
            self.totalLucreLabel.attributedText = [self textManageWith:@"0.00" totalStr:@"0.00"];
        }
    }
}
-(void)setModel:(ProfitRegularDetail *)model{
    if (_model!=model) {
        _model = model;
        if (_model!=nil) {
            
            self.projectNameLabel.text = _model.projectName;
            
            self.projectDesLabel.text = _model.projectDes;
            
            self.lucreLabel.text = _model.earningsOf10thousand;
            self.periodLabel.text = _model.period;
            
            self.categoryLabel.text = _model.name;
            self.lucrePercentLabel.text = [NSString stringWithFormat:@"%@%%", _model.percent];
            self.repayWayLabel.text = _model.settlement;
            self.daoqiLabel.text = _model.expectedTime;
        }
    }
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat y=0.00;
        if ([reuseIdentifier isEqualToString:@"cellID0"]) {
            [self createCell0];
            y=70;
        }else if ([reuseIdentifier isEqualToString:@"cellID1"]) {
            [self createCell1];
            y=130;
            
        }else if ([reuseIdentifier isEqualToString:@"cellID2"]){
            [self createCell2];
            y=110;
            
        }else if ([reuseIdentifier isEqualToString:@"cellID3"]){
            [self createCell3];
            y=100;
            
        }else if ([reuseIdentifier isEqualToString:@"cellID4"]){
            [self createCell4];
            y=70;
        }
        UILabel *separateLine = [[UILabel alloc] initWithFrame:CGRectMake(10, y-1, kDeviceWidth-20, 1)];
        if ([reuseIdentifier isEqualToString:@"cellID0"]) {
            separateLine.frame = CGRectMake(0, 70-1, kDeviceWidth, 1);
        }
        separateLine.backgroundColor = rgb(217, 217, 217, 1);
        [self.contentView addSubview:separateLine];
        
    }
    return self;
}
-(void)layoutSubviews{
    //cell0
    
    //cell1
    self.lucreLabel.textAlignment = NSTextAlignmentCenter;
    self.lucreLabel.textColor = rgb(237, 46, 36, 1);
    self.lucreLabel.font = [UIFont boldSystemFontOfSize:40];
    self.periodLabel.textAlignment = NSTextAlignmentCenter;
    self.periodLabel.textColor = rgb(237, 46, 36, 1);
    self.periodLabel.font = [UIFont boldSystemFontOfSize:40];
    //cell2
    self.categoryLabel.font = [UIFont systemFontOfSize:14];
    self.categoryLabel.textColor = rgb(51, 51, 51, 1);
    self.lucrePercentLabel.font = [UIFont systemFontOfSize:14];
    self.lucrePercentLabel.textColor = rgb(51, 51, 51, 1);
    self.repayWayLabel.font = [UIFont systemFontOfSize:14];
    self.repayWayLabel.textColor = rgb(51, 51, 51, 1);
    //cell3
    self.remainderMoneyLabel.adjustsFontSizeToFitWidth = YES;
    
    //cell4
    self.totalLucreLabel.adjustsFontSizeToFitWidth = YES;
    self.daoqiLabel.font = [UIFont systemFontOfSize:14];
    self.daoqiLabel.textColor = rgb(51, 51, 51, 1);

}

-(void)createCell0{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 70)];
    headerView.backgroundColor = rgb(237, 237, 237, 1);
    
    UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kDeviceWidth-20, 20)];
    companyLabel.font = [UIFont systemFontOfSize:13];
    companyLabel.textColor = rgb(237, 46, 36, 1);
    [headerView addSubview:companyLabel];

    UILabel *declareLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, companyLabel.bottom+10, kDeviceWidth-20-100, 20)];
    
    declareLabel.font = [UIFont systemFontOfSize:13];
    declareLabel.textColor = rgb(237, 46, 36, 1);
    
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:rgb(42, 124, 225, 1),NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    
    NSAttributedString *profilDetailStr = [[NSAttributedString alloc] initWithString:@"点击查看项目详情" attributes:dict];
    UIButton *detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    detailBtn.frame = CGRectMake(kDeviceWidth-130, companyLabel.bottom+10, 100, 20);
    [detailBtn setAttributedTitle:profilDetailStr forState:UIControlStateNormal];
    [detailBtn addTarget:self action:@selector(detailBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:detailBtn];
    
    UIImageView *detailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth-37, companyLabel.bottom+10+5, 10, 10)];
    detailImageView.image = [UIImage imageNamed:@"arrow_right"];
    [headerView addSubview:detailImageView];
    [headerView addSubview:declareLabel];
    if (kDeviceWidth==320) {
        declareLabel.frame = CGRectMake(10, companyLabel.bottom+10, kDeviceWidth-100, 20);
        detailBtn.frame = CGRectMake(kDeviceWidth-105, companyLabel.bottom+10, 100, 20);
        detailBtn.titleLabel.font = [UIFont systemFontOfSize:9];
        detailImageView.frame = CGRectMake(kDeviceWidth-37+22, companyLabel.bottom+10+5, 10, 10);
    }
    self.projectNameLabel = companyLabel;
    self.projectDesLabel = declareLabel;
    [self.contentView addSubview:headerView];
}
-(void)createCell1{
    UILabel *tempLucreLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, kDeviceWidth/2.0-20, 40)];
    self.lucreLabel = tempLucreLabel;
    [self.contentView addSubview:tempLucreLabel];
    
    UILabel *Hline = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2.0-1,10, 1, 110)];
    Hline.backgroundColor = rgb(217, 217, 217, 1);
    [self.contentView addSubview:Hline];
    
    UILabel *tempPeriodLabel = [[UILabel alloc] initWithFrame:CGRectMake(Hline.right+10, 20, kDeviceWidth/2.0-20, 40)];
    self.periodLabel = tempPeriodLabel;
    [self.contentView addSubview:tempPeriodLabel];
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, tempLucreLabel.bottom+20, kDeviceWidth/2.0-20, 20)];
    leftLabel.text = @"万份收益(元)";
    leftLabel.textColor = rgb(128, 128, 128, 1);
    leftLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:leftLabel];
    
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2.0+10, tempLucreLabel.bottom+20, kDeviceWidth/2.0-20, 20)];
    rightLabel.text = @"理财周期(天)";
    rightLabel.textColor = rgb(128, 128, 128, 1);
    rightLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:rightLabel];
    
}
-(void)createCell2{
    NSArray *array = @[@"产品类型：",@"年化收益率：",@"结算方式："];
    for (int i = 0; i <3; i ++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 13+32*i, 100, 14)];
        label.textColor = rgb(128, 128, 128, 1);
        label.text = [array objectAtIndex:i];
        label.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:label];
        
        UILabel *label2 = [[UILabel alloc] init];
        label2.font = [UIFont systemFontOfSize:14];
        if (i==0) {
            label2.frame = CGRectMake(label.right-30, 13+32*i, kDeviceWidth-100-20, 14);
            self.categoryLabel = label2;
        }else if (i==1){
            label2.frame = CGRectMake(label.right-15, 13+32*i, kDeviceWidth-100-20, 14);
            self.lucrePercentLabel = label2;
        }else{
            label2.frame = CGRectMake(label.right-30, 13+32*i, kDeviceWidth-100-20, 14);
            self.repayWayLabel = label2;
        }
        [self.contentView addSubview:label2];
    }
    
}
-(void)createCell3{
    NSArray *array = @[@"可用余额：",@"购买金额："];
    for (int i = 0; i < 2; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10+50*i, 70, 14)];
        label.text = [array objectAtIndex:i];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = rgb(128, 128, 128, 1);
        [self.contentView addSubview:label];
    }
    
    UILabel *tempRemainderMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, kDeviceWidth/2.0-80+40, 14)];
    self.remainderMoneyLabel = tempRemainderMoneyLabel;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"0.00元" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor blackColor]}];
    NSRange range0 = {0,4};
    [str setAttributes:@{NSForegroundColorAttributeName:rgb(237, 46, 36, 1)} range:range0];
    self.remainderMoneyLabel.attributedText = str;
    [self.contentView addSubview:self.remainderMoneyLabel];
    
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:rgb(56, 121, 217, 1),NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSAttributedString *chongzhiStr = [[NSAttributedString alloc] initWithString:@"快速充值" attributes:dict];
    
    UIButton *tempChongzhiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tempChongzhiBtn.frame = CGRectMake(kDeviceWidth-100-20, 10, 100, 14);
    [tempChongzhiBtn setAttributedTitle:chongzhiStr forState:UIControlStateNormal];
    [tempChongzhiBtn addTarget:self action:@selector(chongzhiBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.chongzhiBtn = tempChongzhiBtn;
    [self.contentView addSubview:self.chongzhiBtn];
}
-(void)createCell4{
    UILabel *yuqiLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 14)];
    yuqiLabel.text = @"预期总收益:";
    yuqiLabel.font = [UIFont systemFontOfSize:14];
    yuqiLabel.textColor = rgb(128, 128, 128, 1);
    [self.contentView addSubview:yuqiLabel];
    UILabel *equalDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30+10, 100, 14)];
    equalDateLabel.text = @"预计到期日:";
    equalDateLabel.font = [UIFont systemFontOfSize:14];
    equalDateLabel.textColor = rgb(128, 128, 128, 1);
    [self.contentView addSubview:equalDateLabel];

    UILabel *tempTotalLucreLabel = [[UILabel alloc] initWithFrame:CGRectMake(yuqiLabel.right-20, 7, kDeviceWidth-10-yuqiLabel.right+20, 20)];
    self.totalLucreLabel = tempTotalLucreLabel;
    self.totalLucreLabel.attributedText = [self textManageWith:@"0.00" totalStr:@"0.00"];
    [self.contentView addSubview:self.totalLucreLabel];
    
    UILabel *tempDaoqiLabel = [[UILabel alloc] initWithFrame:CGRectMake(equalDateLabel.right-20, 30+10, 100, 14)];
    self.daoqiLabel = tempDaoqiLabel;
    [self.contentView addSubview:self.daoqiLabel];
}

-(NSMutableAttributedString *)textManageWith:(NSString *)perStr totalStr:(NSString *)totalStr{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[ NSString stringWithFormat:@"%@元    每日收益%@元",totalStr,perStr]];
    NSRange range0 = {0,str.length};
    NSRange range1 = {0,totalStr.length};
    NSRange range2 = {totalStr.length+9,perStr.length};
    NSDictionary *dic0 = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor blackColor]};
    NSDictionary *dic1 = @{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:rgb(237, 46, 36, 1)};
    NSDictionary *dic2 = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:rgb(237, 46, 36, 1)};
    [str setAttributes:dic0 range:range0];
    [str setAttributes:dic1 range:range1];
    [str setAttributes:dic2 range:range2];
    return str;
}
-(void)chongzhiBtnClick:(UIButton *)btn{
    NSLog(@"充值");
    [self.delegate chongZhiAction];
}
-(void)detailBtnClick:(UIButton *)btn{
    [self.delegate detailBtnAction];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
