//
//  AddressListCell.m
//  YOUXINBAO
//
//  Created by Walice on 15/9/10.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AddressListCell.h"
#import "QCAddFriendViewController.h"


#define kAddTag 30070
#define kAddedTag 30071
#define kInviteTag 30072

@implementation AddressListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initViews];
    }
    
    return self;
}

- (void)_initViews{
    
    _label=[[UILabel alloc]initWithFrame:CGRectZero];
    CGFloat labelWidth=40;
    _label.frame=CGRectMake(10, 10, labelWidth, labelWidth);
    _label.layer.cornerRadius=5;
    _label.clipsToBounds = YES;
    _label.backgroundColor=rgb(197, 210, 227, 1);
    _label.textColor=[UIColor whiteColor];
    [self.contentView addSubview:_label];
    
    _nameLabel=[[UILabel alloc]initWithFrame:CGRectZero];
     _nameLabel.frame=CGRectMake(_label.right+10, 15, 200, 15);
    _nameLabel.textColor=rgb(0, 0, 0, 1);
    [self.contentView addSubview:_nameLabel];
    
    _phoneLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    _phoneLabel.frame=CGRectMake(_label.right+10, 35, 200, 15);
    _phoneLabel.textColor=rgb(168, 168, 168, 1);
    [self.contentView addSubview:_phoneLabel];
    
    _rightButton1=[[UIButton alloc]initWithFrame:CGRectZero];
    _rightButton1.frame=CGRectMake(kDeviceWidth-80, 20, 50, 30);
    [_rightButton1 setBackgroundImage:[UIImage imageNamed:@"tj"] forState:UIControlStateNormal];
    [_rightButton1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_rightButton1];
    
    _rightButton2=[[UIButton alloc]initWithFrame:CGRectZero];
    _rightButton2.frame=CGRectMake(kDeviceWidth-80, 20, 50, 30);
    [_rightButton2 setBackgroundImage:[UIImage imageNamed:@"yq"] forState:UIControlStateNormal];
    [_rightButton2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_rightButton2];
    
    _rightButton3=[[UIButton alloc]initWithFrame:CGRectZero];
    _rightButton3.frame=CGRectMake(kDeviceWidth-80, 20, 50, 30);
    [_rightButton3 setBackgroundImage:[UIImage imageNamed:@"ytj"] forState:UIControlStateNormal];
    [_rightButton3 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_rightButton3];
    

    
}



- (void)setModel:(QCAddressBook *)model{

    _model=model;
    [self relodUI];
}
- (void)setTypeDic:(NSMutableDictionary *)typeDic{

    _typeDic=typeDic;
    [self relodUI];
    
}

- (void)relodUI{

     if (_searchText.length <= 0) {
     
         if ([[self.model.name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] > 0) {
             _nameLabel.text = self.model.name;
             _phoneLabel.text=self.model.tel;
             _label.text=[self.model.name substringWithRange:NSMakeRange(self.model.name.length-1, 1)];
             _label.textAlignment=NSTextAlignmentCenter;
         } else {
  
         _nameLabel.text = nil;
         }
         _nameLabel.backgroundColor = [UIColor clearColor];
     
     
         QCUserModel *localUser = [[QCUserManager sharedInstance] getLoginUser];
         User *user = localUser.user;
     
    
         if (self.model.resStatus  == 0) {
             _rightButton1.hidden=NO;
             _rightButton2.hidden=YES;
             _rightButton3.hidden=YES;
             _rightButton1.tag = kAddTag;
         } else if (self.model.resStatus  == -1) {
//             [_rightButton setTitleColor:rgb(255, 80, 0, 1) forState:UIControlStateNormal];
//            // [_rightButton setTitle:@"邀请" forState:UIControlStateNormal];
// 
//             _rightButton.titleLabel.font = [UIFont systemFontOfSize:17.0];
             _rightButton1.hidden=YES;
             _rightButton2.hidden=NO;
             _rightButton3.hidden=YES;
             _rightButton2.tag = kInviteTag;
         }else if (self.model.resStatus  == 1 || self.model.tel == user.username){
 
              //[_rightButton setTitle:@"" forState:UIControlStateNormal];
             _rightButton1.hidden=YES;
             _rightButton2.hidden=YES;
             _rightButton3.hidden=NO;
             _rightButton3.tag = kAddedTag;
         }


     }

   
}

- (void)buttonAction:(UIButton *)button{
    if([self.delegate respondsToSelector:@selector(QCAddressListPushAction:addressBook:)]){
        [self.delegate QCAddressListPushAction:button.tag addressBook:self.model];
    };
  
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
