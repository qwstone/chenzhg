//
//  LoanOrRepayListTableViewCell.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/4/8.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanOrRepayListTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation LoanOrRepayListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.image = [[UIImageView alloc]initWithFrame:CGRectMake(20, 15, 50, 50)];
        self.image.backgroundColor = [UIColor clearColor];
        self.image.layer.cornerRadius = 25;
        self.image.layer.masksToBounds = YES;
        [self.contentView addSubview:_image];
        
#define CellBadgeWidth 15
//        self.unReadView = [[CustomBadge alloc] initWithFrame:CGRectMake(_image.origin.x + _image.width - 10, 0, 15, 15)];
        
        
        self.loanOrRepayImage = [[UIImageView alloc]initWithFrame:CGRectMake(60, 10, 0, 0)];
        self.loanOrRepayImage.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.loanOrRepayImage];
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.image.origin.x+self.image.size.width+20, 20, 100, 20)];
        _nameLabel.adjustsFontSizeToFitWidth = YES;
        _nameLabel.minimumScaleFactor = 8.0/_nameLabel.font.pointSize;
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        self.nameLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel.font = [UIFont systemFontOfSize:15];
        self.nameLabel.textColor=[UIColor blackColor];
        [self.contentView addSubview:_nameLabel];
     
        
        self.moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth-220, 20, 200, 20)];
        self.moneyLabel.backgroundColor = [UIColor clearColor];
        self.moneyLabel.font = [UIFont boldSystemFontOfSize:16];
        self.moneyLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_moneyLabel];
        
        CGFloat timeOrStatusWidth = (kDeviceWidth - 2 * 20 - 60)/2;

        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 80-20-15, timeOrStatusWidth, 20)];
        self.timeLabel.backgroundColor = [UIColor clearColor];
        self.timeLabel.textColor = [UIColor grayColor];
        self.timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.minimumScaleFactor = 10.0/_timeLabel.font.pointSize;
        _timeLabel.adjustsFontSizeToFitWidth = YES;

        [self.contentView addSubview:_timeLabel];
        

        
        self.subStatusLabel = [[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth-timeOrStatusWidth - 20, 80-20-15, timeOrStatusWidth, 20)];
        self.subStatusLabel.backgroundColor = [UIColor clearColor];
        self.subStatusLabel.textAlignment = NSTextAlignmentRight;
        self.subStatusLabel.font = [UIFont systemFontOfSize:14];
        _subStatusLabel.minimumScaleFactor = 10.0/_subStatusLabel.font.pointSize;
        _subStatusLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_subStatusLabel];
//        self.separatorInset = UIEdgeInsetsMake(0, 80, 0, 0);
    }

    return self;
}


- (void)setGuaranteeModel:(GuaranteeRequestListData *)GuaranteeModel {
    _GuaranteeModel = GuaranteeModel;
        [self.image sd_setImageWithURL:[NSURL URLWithString:_GuaranteeModel.guaranteeImgUrl] placeholderImage:[UIImage imageNamed:@"hy-usermr-icon.png"]];
    
    _nameLabel.text = _GuaranteeModel.userName;
    
    self.timeLabel.text = _GuaranteeModel.guaranteeTime;
    
    self.subStatusLabel.text = _GuaranteeModel.guaranteeStatusStr;
    
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%@",_GuaranteeModel.guaranteeMoney];
}


- (void)setLoanModel:(Loan *)loanModel
{
    _loanModel = loanModel;
    [self.image sd_setImageWithURL:[NSURL URLWithString:_loanModel.friendIconAddr] placeholderImage:[UIImage imageNamed:@"useimg"]];
    
    if (_unReadView != nil && [_unReadView superview]) {
        [_unReadView removeFromSuperview];

    }
    /*
    if (_loanModel.unReadCount > 0) {
        self.unReadView = [CustomBadge customBadgeWithString:[NSString stringWithFormat:@"%ld",_loanModel.unReadCount] withStyle:[BadgeStyle oldStyle]];
        _unReadView.frame = CGRectMake(_image.origin.x + _image.width - 15,0, 30, 15);
        
        [_unReadView autoBadgeSizeWithString:[NSString stringWithFormat:@"%ld",_loanModel.unReadCount]];
        [self.contentView addSubview:_unReadView];

    }*/
    /*
    if(_loanModel.unReadCount <= 0)
    {
        _unReadView.badgeText = @"";
        _unReadView.hidden = YES;
    }
    else
    {
        _unReadView.badgeText = [NSString stringWithFormat:@" "];

        _unReadView.badgeText = [NSString stringWithFormat:@"%ld",_loanModel.unReadCount];
        _unReadView.hidden = NO;
        [_unReadView setNeedsLayout];

    }
    
    */
    
    
    if ((_loanModel.friendRealname != nil) && [_loanModel.friendRealname length] > 0) {
        self.nameLabel.text = _loanModel.friendRealname;
       // _nameLabel.textColor = [UIColor blackColor];
        

    }
    /*
    else
    {
        self.nameLabel.text = @"对方暂未实名认证";
        _nameLabel.textColor = [UIColor redColor];

    }
     */
    NSString *money = [NSString stringWithFormat:@"￥%@",_loanModel.money];
//    self.moneyLabel.text = [NSString stringWithFormat:@"￥%@",_loanModel.money];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:money];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, 1)];
    _moneyLabel.attributedText = str;
    
    
    self.timeLabel.text = _loanModel.createDate;
    
    if (_loanModel.mainStatus == 1) {
        self.loanOrRepayImage.image = [UIImage imageNamed:@"huan_icon.png"];
        self.loanOrRepayImage.hidden = NO;

    }else if (_loanModel.mainStatus == 2){
        self.loanOrRepayImage.image = [UIImage imageNamed:@"jie_icon"];
        self.loanOrRepayImage.hidden = NO;


    }else{
        self.loanOrRepayImage.hidden = YES;
    }
    self.loanOrRepayImage.frame = CGRectMake(self.loanOrRepayImage.origin.x, self.loanOrRepayImage.origin.y, self.loanOrRepayImage.image.size.width, self.loanOrRepayImage.image.size.height);
    QCUserModel * user = [[QCUserManager sharedInstance]getLoginUser];
    _subStatusLabel.textColor = [UIColor blackColor];
    if (loanModel.borrowerId  ==  user.user.t_id) {
        //我是借款人
        
        if (loanModel.status == APPLYING_NEEDRECORD) {
            _subStatusLabel.text = @"待录制视频";
            _subStatusLabel.textColor = [UIColor blueColor];
        }
        if (loanModel.status == APPLYING_NEEDCONFIRMRECORD) {
            _subStatusLabel.text = @"待确认视频";
            _subStatusLabel.textColor = [UIColor blueColor];
        }
        
        else if (loanModel.status == APPLYING_NEEDCONFIRM) {
            _subStatusLabel.text = @"待对方同意";
            _subStatusLabel.textColor = [UIColor blueColor];

            
        }else if (loanModel.status == APPLYING_NEEDCONFIRM_NEEDAGREE_BYBORROWER){
            _subStatusLabel.text = @"待确认";
            _subStatusLabel.textColor = [UIColor blueColor];


        }else if (loanModel.status == APPLYING_NEEDPAY){
            _subStatusLabel.text = @"待对方打款";
        }else if (loanModel.status == OFFLINE_LENDMONEY_CONFIRM){
            _subStatusLabel.text = @"线下打款确认";
        }else if (loanModel.status == NEEDREPAY){
            _subStatusLabel.text = @"待还款";
            _subStatusLabel.textColor = [UIColor blueColor];

        }else if (loanModel.status == MODIFY_AFTERLEND_NEEDCONFIRM_BYLENDER){
            _subStatusLabel.text = @"申请修改-放款方确认";
        }else if (loanModel.status == NEEDRECEIVE){
            _subStatusLabel.text = @"线下还款确认";
        }else if (loanModel.status == REPAYED){
            _subStatusLabel.text = @"还款成功";
        }else if (loanModel.status == BORROWERCANCELLED){
            _subStatusLabel.text = @"已取消";
        }else if (loanModel.status == DECLINED){
            _subStatusLabel.text =@"已拒绝";
        }else if (loanModel.status == CLOSED){
            _subStatusLabel.text = @"已关闭";
        }else if (loanModel.status == QUICKLEND_NEEDCONFIRM) {
             _subStatusLabel.text = @"快速放款待您确认";
            _subStatusLabel.textColor = [UIColor blueColor];

        }
        else if (loanModel.status == QUICKLEND_DECLINED) {
            _subStatusLabel.text = @"快速放款您已拒绝";
        }
        else if (loanModel.status == QUICKLEND_CLOSED) {
            _subStatusLabel.text = @"快速放款已关闭";
        }

    }else{
        //我是放款人
        
        if (loanModel.status == APPLYING_NEEDRECORD) {
            _subStatusLabel.text = @"待对方录制视频";
            _subStatusLabel.textColor = [UIColor blueColor];
        }
        if (loanModel.status == APPLYING_NEEDCONFIRMRECORD) {
            _subStatusLabel.text = @"待确认视频";
            _subStatusLabel.textColor = [UIColor blueColor];
        }

        
        if (loanModel.status == APPLYING_NEEDCONFIRM) {
            _subStatusLabel.text = @"待同意";
            _subStatusLabel.textColor = [UIColor blueColor];

        }else if (loanModel.status == APPLYING_NEEDCONFIRM_NEEDAGREE_BYBORROWER){
            _subStatusLabel.text = @"待对方确认";
            _subStatusLabel.textColor = [UIColor blueColor];

            
        }else if (loanModel.status == APPLYING_NEEDPAY){
            _subStatusLabel.text = @"待打款";
        }else if (loanModel.status == OFFLINE_LENDMONEY_CONFIRM){
            _subStatusLabel.text = @"线下打款确认";
        }else if (loanModel.status == NEEDREPAY){
            _subStatusLabel.text = @"待收款";
        }else if (loanModel.status == MODIFY_AFTERLEND_NEEDCONFIRM_BYLENDER){
            
            _subStatusLabel.text = @"申请修改-待确认";
        }else if (loanModel.status == NEEDRECEIVE){
            _subStatusLabel.text = @"线下还款确认";
        }else if (loanModel.status == REPAYED){
            _subStatusLabel.text = @"还款成功";
        }else if (loanModel.status == BORROWERCANCELLED){
            _subStatusLabel.text = @"已取消";
        }else if (loanModel.status == DECLINED){
            _subStatusLabel.text =@"已拒绝";
        }else if (loanModel.status == CLOSED){
            _subStatusLabel.text = @"已关闭";
        }else if (loanModel.status == QUICKLEND_NEEDCONFIRM) {
            _subStatusLabel.text = @"快速放款待对方确认";
            _subStatusLabel.textColor = [UIColor blueColor];

        }
        else if (loanModel.status == QUICKLEND_DECLINED) {
            _subStatusLabel.text = @"快速放款对方已拒绝";
        }
        else if (loanModel.status == QUICKLEND_CLOSED) {
            _subStatusLabel.text = @"快速放款已关闭";
        }

    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
