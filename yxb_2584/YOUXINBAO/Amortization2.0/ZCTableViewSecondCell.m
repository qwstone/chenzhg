//
//  ZCTableViewSecondCell.m
//  YOUXINBAO
//
//  Created by CH10 on 15/11/12.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "ZCTableViewSecondCell.h"
#import "UIImageView+WebCache.h"
#import "YXBTool.h"

@interface ZCTableViewSecondCell ()
@property (nonatomic,weak)UIImageView *userImgView;//用户头像
@property (nonatomic,weak)UILabel *nickNameLabel;//昵称
@property (nonatomic,weak)UILabel *guaranteeMoneyLabel;//担保金额
@property (nonatomic,weak)UILabel *payTimeLabel;//付款时间
@end
@implementation ZCTableViewSecondCell


-(void)setPersonModel:(CrowdfundingPerson *)personModel{
    if (_personModel != personModel) {
        _personModel = personModel;
        
        if (_personModel) {
            
            [self.userImgView sd_setImageWithURL:[NSURL URLWithString:_personModel.imageUrl] placeholderImage:[UIImage imageNamed:@"hy-usermr-icon.png"]];
            self.nickNameLabel.text = _personModel.nickName;
            self.guaranteeMoneyLabel.text = _personModel.money;
            self.payTimeLabel.text = _personModel.time;
        }
    }
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if ([reuseIdentifier isEqualToString:@"ThirdCellRecordID"]) {
            [self createRecordCell];
        }else{
            [self createDefaultCell];
        }
    }
    return self;
}
-(void)layoutSubviews{

    _userImgView.layer.cornerRadius = 31/2.0;
    _userImgView.layer.masksToBounds = YES;

    _nickNameLabel.font = [UIFont systemFontOfSize:14];
    
    _guaranteeMoneyLabel.textAlignment = NSTextAlignmentCenter;

    _payTimeLabel.textAlignment = NSTextAlignmentCenter;
    

}
-(void)createRecordCell{

    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 10, 31, 31)];
    _userImgView = imgView;
    [self.contentView  addSubview:imgView];
    
    UILabel *nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_userImgView.right+5, 19, (kDeviceWidth-16)/3.0-5-31, 14)];
    _nickNameLabel = nickNameLabel;
    [self.contentView addSubview:_nickNameLabel];
    
    UILabel *guaranteeMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nickNameLabel.right, 19, (kDeviceWidth-16)/3.0, 14)];
    _guaranteeMoneyLabel = guaranteeMoneyLabel;
    [self.contentView addSubview:_guaranteeMoneyLabel];
    
    UILabel *payTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_guaranteeMoneyLabel.right, 19, (kDeviceWidth-16)/3.0, 14)];
    _payTimeLabel = payTimeLabel;
    [self.contentView addSubview:_payTimeLabel];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, kDeviceWidth, 1)];
    line.backgroundColor = [YXBTool colorWithHexString:@"#efefef"];
    [self.contentView addSubview:line];
}
-(void)createDefaultCell{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((kDeviceWidth-112)/2, 20, 112, 44)];
    imgView.image = [UIImage imageNamed:@"wjl"];
    [self.contentView addSubview:imgView];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
