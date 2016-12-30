//
//  JoinPeopleTableViewCell.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/3/17.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "JoinPeopleTableViewCell.h"
#import "QCConst.h"
#import "UIImageView+WebCache.h"
#import "StatusHttp.h"
#import "QCLocalLocation.h"
#import "ActivityMember.h"
#import "QCUserManager.h"

#define kCellHeight 65.0

@interface JoinPeopleTableViewCell()<StatusHttpDelegate,UIAlertViewDelegate>

@end

@implementation JoinPeopleTableViewCell
{
    btnStyle btnStyle;
    ActivityMember * member;
    StatusHttp * statusHttp;
}
- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _image = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 45, 45)];
        _image.backgroundColor = [UIColor redColor];
        _image.layer.cornerRadius = 22.5;
        _image.layer.masksToBounds = YES;
        _image.userInteractionEnabled = YES;
        [self addSubview:_image];
        UIControl *imageControl = [[UIControl alloc] initWithFrame:_image.bounds];
        [_image addSubview:imageControl];
        [imageControl addTarget:self action:@selector(imageAction) forControlEvents:UIControlEventTouchUpInside];

        _borrowView = [[UIImageView alloc] initWithFrame:CGRectMake(_image.right, _image.top, 32.5, 13)];
        [self addSubview:_borrowView];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(75, (kCellHeight-20)/2, 65, 20)];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = rgb(98, 96, 96, 1);
        [self addSubview:_nameLabel];
        
        _sexLabel = [[UIImageView alloc]initWithFrame:CGRectMake((kDeviceWidth-13)/2, (kCellHeight-13)/2, 13, 13)];
        [self addSubview:_sexLabel];
    
        _sateLabel = [[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth-150, (kCellHeight-20)/2, 60, 20)];
        _sateLabel.backgroundColor = [UIColor clearColor];
        _sateLabel.textAlignment = NSTextAlignmentCenter;
        _sateLabel.font = [UIFont systemFontOfSize:15];
//        _sateLabel.text = @"签到";
        _sateLabel.textColor = rgb(141, 141, 141, 1);
        [self addSubview:_sateLabel];
        
        _callButton = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth-80, (kCellHeight-49.0/2)/2, 49.0/2, 49.0/2)];
        [_callButton setImage:[UIImage imageNamed:@"AA_tel-icon"] forState:UIControlStateNormal];
        [_callButton addTarget:self action:@selector(callAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_callButton];
        
        _jujueBtn = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth-40, (kCellHeight-49.0/2)/2, 49.0/2, 49.0/2)];
//        _jujueBtn.backgroundColor = [UIColor redColor];
        [_jujueBtn setImage:[UIImage imageNamed:@"AA_cancle-icon"] forState:UIControlStateNormal];
        
        [_jujueBtn addTarget:self action:@selector(jujueBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _jujueBtn.hidden = YES;
        [self addSubview:_jujueBtn];
    }
    statusHttp = [[StatusHttp alloc]init];
    statusHttp.delegate =self;
    return self;
}

- (void)setTacivity:(AAActivity *)tacivity
{
    _tacivity = tacivity;
    if (tacivity != nil) {
        
        if (tacivity.type == M_CREATED) {//如果是创建人
//            if (tacivity.status == A_PASSED) {
//                if (member.status == M_REGISTERED) {
//                    [_sateLabel setTitle: @"为他签到" forState:UIControlStateNormal];
//                    _sateLabel.tag = B_WEITAQIANDAO;
//                }
//                
//            }else if (tacivity.status == A_STARTED){
//                if (member.status != M_CHECKIN) {
//                    [_sateLabel setTitle: @"为他签到" forState:UIControlStateNormal];
//                    _sateLabel.tag = B_WEITAQIANDAO;
//                }else{
//                    [_sateLabel setTitle: @"已签到" forState:UIControlStateNormal];
//                    _sateLabel.tag = B_BUKECAOZHUO;
//                }
//                
//            }else if (tacivity.status == A_FINISHED ||tacivity.status == A_CANCELED){
//                _sateLabel.tag = B_BUKECAOZHUO;
//                
//                if (member.status == M_CHECKIN) {
//                    [_sateLabel setTitle: @"已签到" forState:UIControlStateNormal];
//                }else if (member.status == M_REGISTERED){
//                    [_sateLabel setTitle: @"已报名" forState:UIControlStateNormal];
//                }
//            }
            if (tacivity.status == A_PASSED){
                _jujueBtn.hidden = NO;
            }else{
                _jujueBtn.hidden = YES;
            }
            _callButton.hidden = NO;
            
            _nameLabel.frame = CGRectMake(75, (kCellHeight-20)/2, (kDeviceWidth-13)/2-75-10, 20);
            
            _sexLabel.frame = CGRectMake((kDeviceWidth-13)/2, (kCellHeight-13)/2, 13, 13);
            
            _sateLabel.frame = CGRectMake(kDeviceWidth-150, (kCellHeight-20)/2, 60, 20);
        }else{
            //若果是参与者
            _jujueBtn.hidden = YES;
            _callButton.hidden = YES;
            
            _nameLabel.frame = CGRectMake(75, (kCellHeight-20)/2, (kDeviceWidth-13)/3*2-75-10, 20);
            
            _sexLabel.frame = CGRectMake((kDeviceWidth-13)/3*2, (kCellHeight-13)/2, 13, 13);
            
            _sateLabel.frame = CGRectMake(kDeviceWidth-80, (kCellHeight-20)/2, 60, 20);
            
//            QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
//            if (tacivity.status == A_STARTED) {
//                if (member.userId == userModel.user.t_id) {//我自己
//                    if (member.status == M_CHECKIN) {
//                        [_sateLabel setTitle: @"已签到" forState:UIControlStateNormal];
//                        _sateLabel.tag = B_BUKECAOZHUO;
//                        
//                    }else{
//                        [_sateLabel setTitle: @"签到" forState:UIControlStateNormal];
//                        _sateLabel.tag = B_QIANDAO;
//                        
//                    }
//                    
//                }else{
//                    if (member.status == M_CHECKIN) {
//                        [_sateLabel setTitle: @"已签到" forState:UIControlStateNormal];
//                        _sateLabel.tag = B_BUKECAOZHUO;
//                        
//                    }else{
//                        [_sateLabel setTitle: @"已报名" forState:UIControlStateNormal];
//                        _sateLabel.tag = B_BUKECAOZHUO;
//                    }
//                }
//            }else if (tacivity.status == A_PASSED){
//                if (member.status != M_CHECKIN && member.userId == userModel.user.t_id) {
//                    [_sateLabel setTitle: @"签到" forState:UIControlStateNormal];
//                    _sateLabel.tag = B_BUKECAOZHUO;
//                }else{
//                    [_sateLabel setTitle: @"已报名" forState:UIControlStateNormal];
//                    _sateLabel.tag = B_BUKECAOZHUO;
//                }
//            }else if (tacivity.status == A_FINISHED){
//                if (member.status != M_CHECKIN) {
//                    [_sateLabel setTitle: @"已报名" forState:UIControlStateNormal];
//                    _sateLabel.tag = B_BUKECAOZHUO;
//                    
//                }else{
//                    [_sateLabel setTitle: @"签到" forState:UIControlStateNormal];
//                    _sateLabel.tag = B_BUKECAOZHUO;
//                }
//            }
            
            
        }
        
        member = tacivity.participants[_row];
        _nameLabel.text = member.nickname;
        [_image sd_setImageWithURL:[NSURL URLWithString:member.iconAddr] placeholderImage:[UIImage imageNamed:@"useimg"]];
        /**
         * 性别  0->女 | 1->男
         */
        if (member.gender == 1) {
            _sexLabel.image = [UIImage imageNamed:@"AA_man-icon"];
        }else {
            _sexLabel.image = [UIImage imageNamed:@"AA_woman-icon"];
        }
        //        _sexLabel.text = member.gender;
        if (member.type == 4) {
            _sateLabel.text = @"已签到";
        }else {
            _sateLabel.text = @"待签到";
        }
        
        if (member.payType == 2) {
            _borrowView.image = [UIImage imageNamed:@"fufei-icon"];
        }else if (member.payType == 3) {
            _borrowView.image = [UIImage imageNamed:@"jietiao-icon"];
        }
        
    }
}

//- (void)statusAction:(UIButton *)sender
//{
//    NSLog(@"tag =%d",sender.tag);
//    if (sender.tag == B_WEITAQIANDAO){
//        NSString *longitude = [NSString stringWithFormat:@"%f",[[QCLocalLocation    shareInstance] longitude]];
//        NSString *latitude = [NSString stringWithFormat:@"%f",[[QCLocalLocation shareInstance] latitude]];
//        [statusHttp checkInTActivityParticipantByCreator:_tacivity friendId:member.userId Longitude:longitude Latitude:latitude];
//    }else if (sender.tag == B_QIANDAO){
//        NSString *longitude = [NSString stringWithFormat:@"%f",[[QCLocalLocation shareInstance] longitude]];
//        NSString *latitude = [NSString stringWithFormat:@"%f",[[QCLocalLocation shareInstance] latitude]];
//        [statusHttp checkInTActivityParticipant:_tacivity Longitude:longitude Latitude: latitude];
//
//    }else if (sender.tag == B_BUKECAOZHUO){
//    
//    }
//
//}

//- (void)httpCompleteWithResultSet:(TResultSet *)set
//{
//    if (set.errCode !=0) {
//        UIAlertView * alerView = [[UIAlertView alloc]initWithTitle:nil message:set.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alerView show];
//    }
//}

- (void)callAction:(UIButton *)button {
    if (member) {
        [QCUtils callTelphoneWithNum:member.mobile];
    }
}

- (void)jujueBtnAction:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(JoinPeopleTableViewCellRejectButtonDidClicked:)]) {
        [self.delegate JoinPeopleTableViewCellRejectButtonDidClicked:self];
    }
    //    [statusHttp rejectTActivityParticipantWith:_tacivity with:member.userId];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)imageAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(userImageClickedWithUserId:)])
    {
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        
        if (userModel.user.t_id != member.userId) {
            [_delegate userImageClickedWithUserId:member.userId];
            
        }
        else
        {
            
        }
    }
}
#pragma mark - StatusHttpDelegate
- (void)httpCompleteWithResultSet:(TResultSet *)set withHttpTag:(NSInteger)tag{
    
}
@end
