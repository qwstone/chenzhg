//
//  YXBLoanCenterCell.m
//  YOUXINBAO
//
//  Created by CH10 on 16/1/29.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "YXBLoanCenterCell.h"
#import "UIImageView+WebCache.h"
#import "YXBTool.h"
@interface YXBLoanCenterCell ()
@property (nonatomic,weak) UIImageView *iconImg;//头像
@property (nonatomic,weak) UIImageView *loanModelImg;//借款类型

@property (nonatomic,weak) UILabel *nickNameLabel;//昵称
@property (nonatomic,weak) UILabel *descriptLabel;//还款类型

@property (nonatomic,weak) UILabel *statusLabel;//借款单状态
@property (nonatomic,weak) UIImageView *detailImg;//详情三角图片
@property (nonatomic,weak) UIImageView *overdueImg;//逾期图片

@property (nonatomic,weak) UILabel *moneyLabel;//借款金额
@property (nonatomic,weak) UILabel *interestLabel;//利息
@property (nonatomic,weak) UILabel *backTimeLabel;//还款时间
@property (nonatomic,weak) UILabel *timeTypeLabel;//时间类型
@end

@implementation YXBLoanCenterCell
+(instancetype)YXBLoanCenterCellWithTableView:(UITableView *)tableView{
    static NSString *cellName = @"cellID";
    YXBLoanCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[YXBLoanCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)setModel:(LoanListItem *)model{
    if (_model!=model) {
        _model = model;
        if(_model){
            //up
            [self.iconImg sd_setImageWithURL:[NSURL URLWithString:_model.imgUrl] placeholderImage:[UIImage imageNamed:@"useimg"]];
            
            NSArray *loanModelImgs = @[@"bg_remind",@"borrow",
                                       @"loanCenter_lender_gray",
                                       @"loanCenter_borrow_gray"];
            self.loanModelImg.image = [UIImage imageNamed:[loanModelImgs objectAtIndex:[_model.loanMode integerValue]-1]];
            
            self.nickNameLabel.text = _model.name;
            
            self.descriptLabel.text = _model.descript;
            
            self.statusLabel.text = _model.loanStatus;
            self.statusLabel.textColor = [YXBTool colorWithHexString:_model.loanStatusRGB];
            
            if ([_model.overduePayment integerValue]==1) {//逾期
                self.overdueImg.hidden = NO;
                self.statusLabel.hidden = YES;
                self.detailImg.hidden = YES;
            }else if ([_model.overduePayment integerValue]==0){
                self.overdueImg.hidden = YES;
                self.statusLabel.hidden = NO;
                self.detailImg.hidden = NO;
            }
            //down
            self.moneyLabel.text = _model.money;
            self.interestLabel.text = _model.interest;
            self.backTimeLabel.text = _model.time;
            self.timeTypeLabel.text = _model.timeString;
        }
    }
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUpView];
        [self createDownView];
    }
    return self;
}
-(void)layoutSubviews{
    //up
//    self.iconImg.backgroundColor = [UIColor redColor];
    self.iconImg.layer.borderColor = rgb(200, 200, 200, 1).CGColor;
    self.iconImg.layer.cornerRadius = self.iconImg.height/2.0;
    self.iconImg.layer.masksToBounds = YES;
    
    self.nickNameLabel.textColor = [YXBTool colorWithHexString:@"353535"];
    self.nickNameLabel.font = [UIFont systemFontOfSize:30.74/2.0];
    
    self.descriptLabel.textColor = [YXBTool colorWithHexString:@"8B8B8B"];
    self.descriptLabel.font = [UIFont systemFontOfSize:23.91/2.0];
    self.descriptLabel.adjustsFontSizeToFitWidth = YES;
    
    self.overdueImg.image = [UIImage imageNamed:@"yuqiStatus"];
    
    self.statusLabel.textAlignment = NSTextAlignmentRight;
    self.statusLabel.font = [UIFont systemFontOfSize:20.49/2.0];

    self.detailImg.image = [UIImage imageNamed:@"next"];
    
    
    //down
    self.moneyLabel.textAlignment = NSTextAlignmentCenter;
    self.moneyLabel.textColor = rgb(237, 46, 36, 1);
    self.moneyLabel.font = [UIFont systemFontOfSize:16];
    self.moneyLabel.adjustsFontSizeToFitWidth = YES;
    
    self.interestLabel.textAlignment = NSTextAlignmentCenter;
    self.interestLabel.textColor = rgb(237, 46, 36, 1);
    self.interestLabel.font = [UIFont systemFontOfSize:16];
    self.interestLabel.adjustsFontSizeToFitWidth = YES;
    
    self.backTimeLabel.textAlignment = NSTextAlignmentCenter;
    self.backTimeLabel.textColor = rgb(84, 84, 84, 1);
    self.backTimeLabel.font = [UIFont systemFontOfSize:16];
    self.backTimeLabel.adjustsFontSizeToFitWidth = YES;
}
//创建上部的UI
-(void)createUpView{
    UIView *upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 80-14)];
    
    UIImageView *bgIconImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 9, 48, 48)];
    bgIconImg.image = [UIImage imageNamed:@"userIconBg"];
    
    UIImageView *tIconImg = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 44 , 44)];
    self.iconImg = tIconImg;
    
    UIImageView *tLoanModelImg = [[UIImageView alloc] initWithFrame:CGRectMake(bgIconImg.right-20, bgIconImg.bottom-15, 27, 15)];
    self.loanModelImg = tLoanModelImg;
    
    CGFloat nickW = kDeviceWidth - 120-tLoanModelImg.right-5;
    UILabel *tNickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(tLoanModelImg.right+5, 33/2.0, nickW, 30.74/2.0)];
    self.nickNameLabel = tNickNameLabel;
    
    UILabel *tDescriptLabel = [[UILabel alloc] initWithFrame:CGRectMake(tLoanModelImg.right+5, tNickNameLabel.bottom+15/2.0, nickW, 23.91/2.0)];
    self.descriptLabel = tDescriptLabel;
    
    UIImageView *tOverdueImg = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth-65-15, 3, 60, 60)];
    self.overdueImg = tOverdueImg;
    
    UILabel *tStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth-120+5, 37/2.0, 100, 14)];
    self.statusLabel = tStatusLabel;
    
    UIImageView *tDetailImg = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth - 30+8, tStatusLabel.bottom+10, 6, 11)];
    self.detailImg = tDetailImg;

    [self.contentView addSubview:upView];
    upView.backgroundColor = [UIColor whiteColor];
    [upView addSubview:bgIconImg];
    [bgIconImg addSubview:tIconImg];
    [upView addSubview:tLoanModelImg];
    [upView addSubview:tNickNameLabel];
    [upView addSubview:tDescriptLabel];
    [upView addSubview:tOverdueImg];
    [upView addSubview:tStatusLabel];
    [upView addSubview:tDetailImg];
}
//创建下部的UI
-(void)createDownView{
    UIView *downBgView = [self createDownBgView];
    downBgView.backgroundColor = [UIColor whiteColor];
    UILabel *tMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, kDeviceWidth/3.0-1-10, 40)];
    self.moneyLabel = tMoneyLabel;
    
    UILabel *tInterestLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/3.0+5, 0, kDeviceWidth/3.0-1-10, 40)];
    self.interestLabel = tInterestLabel;
    
    UILabel *tBackTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/3.0*2+5, 0, kDeviceWidth/3.0-1-10, 40)];
    self.backTimeLabel = tBackTimeLabel;

    [self.contentView addSubview:downBgView];
    [downBgView addSubview:tMoneyLabel];
    [downBgView addSubview:tInterestLabel];
    [downBgView addSubview:tBackTimeLabel];
}
//创建下部的背景框图
-(UIView *)createDownBgView{
    CGFloat h = 60-5;
    UIView *downView = [[UIView alloc] initWithFrame:CGRectMake(0,80-14, kDeviceWidth, h)];
    UIView *H1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 1)];
    UIView *H2 = [[UIView alloc] initWithFrame:CGRectMake(0, h-1, kDeviceWidth, 1)];
    UIView *V1 = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/3.0-1, 0, 1, h)];
    UIView *V2 = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/3.0*2-1, 0, 1, h)];
    H1.backgroundColor = rgb(230, 230, 230, 1);
    H2.backgroundColor = rgb(230, 230, 230, 1);
    V1.backgroundColor = rgb(230, 230, 230, 1);
    V2.backgroundColor = rgb(230, 230, 230, 1);
    [downView addSubview:H1];
    [downView addSubview:H2];
    [downView addSubview:V1];
    [downView addSubview:V2];
    NSArray *arr = @[@"借款金额(元)",@"利息(元)",@"还款时间"];
    for (int i = 0; i < 3; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/3.0*i, h-20, kDeviceWidth/3.0, 11)];
        label.text = [arr objectAtIndex:i];
        label.textColor = rgb(173, 173, 173, 1);
        label.font = [UIFont systemFontOfSize:11];
        label.textAlignment = NSTextAlignmentCenter;
        [downView addSubview:label];
        if(i==2){
            self.timeTypeLabel = label;
        }
    }
    return downView;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
