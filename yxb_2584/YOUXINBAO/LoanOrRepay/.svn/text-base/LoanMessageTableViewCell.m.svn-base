//
//  LoanMessageTableViewCell.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/4/11.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanMessageTableViewCell.h"
#import "QCUserManager.h"
#import "UIImageView+WebCache.h"

@interface LoanMessageTableViewCell ()
@property(nonatomic, strong) UIControl *imageControl;//头像点击事件
@end
@implementation LoanMessageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _userimage = [[UIImageView alloc]init];
//        _userimage.backgroundColor = [UIColor yellowColor];
        
        _userimage.layer.masksToBounds = YES;
        _userimage.userInteractionEnabled = YES;
        self.imageControl = [[UIControl alloc] initWithFrame:_userimage.bounds];
        [_userimage addSubview:_imageControl];
        [_imageControl addTarget:self action:@selector(imageAction) forControlEvents:UIControlEventTouchUpInside];
        
        _detailsImage = [[UIImageView alloc]init];
//        _detailsImage.backgroundColor = [UIColor redColor];
        
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:11.5];
//        _timeLabel.backgroundColor = [UIColor redColor];
//        if (me) {
//            _userimage.frame= CGRectMake(kDeviceWidth-60, 10, 50, 50);
//            _detailsImage.frame = CGRectMake(kDeviceWidth-70-200, 10, 200, 100);
//        }else{
//            _userimage.frame= CGRectMake(10, 10, 50, 50);
//            _detailsImage.frame = CGRectMake(70, 10, 200, 100);
//            
//        }

        [self addSubview:_userimage];
        [self addSubview:_detailsImage];
        [self addSubview:_timeLabel];
    }
    return self;
}

- (void)setLoanLog:(TLoanLog *)loanLog
{
    _loanLog = loanLog;
    _timeLabel.text = _loanLog.operationDate;
}
- (void)setLoanWithLog:(TLoanWithLog *)loanWithLog
{
    _loanWithLog = loanWithLog;
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"op_%ld",(long)_loanLog.operationType]];
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    if (userModel.user.t_id != _loanLog.operatorId) {
        [_userimage sd_setImageWithURL:[NSURL URLWithString:loanWithLog.friendIconAddr]];
        _userimage.frame= CGRectMake(15, 15, 45, 45);
        _userimage.layer.cornerRadius = 22.5;
        _imageControl.frame = _userimage.bounds;
        _detailsImage.image = image;
        _detailsImage.frame = CGRectMake(80, 15, 74.5, 27.5);

    }else{
        [_userimage sd_setImageWithURL:[NSURL URLWithString:userModel.user.iconAddr]];
        _userimage.frame= CGRectMake(kDeviceWidth-60, 15, 45, 45);
        _imageControl.frame = _userimage.bounds;

        _userimage.layer.cornerRadius = 22.5;
        _detailsImage.image = image;
        _detailsImage.frame = CGRectMake(kDeviceWidth-80-74.5, 15, 74.5, 27.5);


    }
    _timeLabel.frame = CGRectMake(_detailsImage.origin.x-20, _detailsImage.origin.y+_detailsImage.height, _detailsImage.width+40, 25);

}

-(void)imageAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(userImageClickedWithUserId:)])
    {
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];

        if (userModel.user.t_id != _loanLog.operatorId) {
            [_delegate userImageClickedWithUserId:_loanWithLog.friendId];

        }
        else
        {
            
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
