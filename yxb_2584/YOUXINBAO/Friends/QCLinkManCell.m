//
//  QCLinkManCell.m
//  YOUXINBAO
//
//  Created by ZHANGMIAO on 14-3-6.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCLinkManCell.h"
#import "QCConst.h"
#import "UIView+ViewFrameGeometry.h"
#import "UIImageView+WebCache.h"
#import "MsgCenterMgr.h"
@implementation QCLinkManCell 

- (void)dealloc
{
//    [_detailLabel release];
//    [_delegate release];
//    [_badgeView release];
    [_rightSwipe release];
    [_leftSwipe release];
    [_imageview release];
    [_nameLabel release];
    [super dealloc];
}

-(void)setUserModel:(User *)userModel{
    if (_userModel!=userModel) {
        _userModel = userModel;
        if (_userModel) {
            //头像
            [self.imageview sd_setImageWithURL:[NSURL URLWithString:_userModel.iconAddr] placeholderImage:[UIImage imageNamed:@"userPlace.png"]];
            //昵称
            self.nameLabel.text = _userModel.nickname;

        }
    }
}
-(void)setDic:(NSMutableDictionary *)dic{
    if (_dic != dic) {
        _dic = dic;
        if (_dic.count) {
            //头像
            
            self.imageview.image = [UIImage imageNamed:[self.dic objectForKey:@"imageName"]];

            //昵称
            self.nameLabel.text = [self.dic objectForKey:@"nickName"];
            
            self.arrow.image=[UIImage imageNamed:@"wxck-next"];
        }else{
            for (UIView *view in self.contentView.subviews) {
                [view removeFromSuperview];
            }
        }
        
    }
}
-(void)layoutSubviews{
    _imageview.layer.cornerRadius =10;
    _imageview.layer.masksToBounds = YES;
    
    _nameLabel.font = [UIFont systemFontOfSize:CellLabelFont];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.dic = [[NSMutableDictionary alloc] init];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kLinkManCellHeight-1, kDeviceWidth, 1)];
        lineView.backgroundColor = kLineColor;
        [self.contentView addSubview:lineView];
        
        _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(15, (kLinkManCellHeight-41)/2, 41.5, 41)];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, (kLinkManCellHeight-20)/2, kDeviceWidth -80, 20)];
        
        _arrow=[[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth-15, 15, 10, 20)];
        [self.contentView addSubview:_imageview];
        [self.contentView addSubview:_nameLabel];
        [self.contentView addSubview:_arrow];
        
        UIImageView * cellIndicator = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"new"]];
        cellIndicator.tag=10009;
        cellIndicator.frame = CGRectMake(_imageview.right-12, 0, 28, 15);
        cellIndicator.hidden=YES;
        [self.contentView addSubview:cellIndicator];
        
        
        
//        ///////////////////////
//
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 41)];
//
//        self.selectedBackgroundView = view;
//
//        view.backgroundColor = [UIColor clearColor];
        
        
        _leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
        _leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
        [self.contentView addGestureRecognizer:_leftSwipe];
        
        _rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
        _rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
        [self.contentView addGestureRecognizer:_rightSwipe];
        
        self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.frame = CGRectZero;
        
        _deleteButton.backgroundColor = [UIColor lightGrayColor];
        [_deleteButton setTitle:@"备注" forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_deleteButton];
        if([self.reuseIdentifier isEqualToString:@"cellID1"]){
            [self creat];
        }
//        _badgeView = [[UIImageView alloc] initWithFrame:CGRectMake(240, (kLinkManCellHeight-18)/2, 18, 18)];
//        _badgeView.hidden = YES;
//        _badgeView.image = [UIImage imageNamed:@"friends_badgeMark"];
//        [self.contentView addSubview:_badgeView];
//        
//        UILabel *badgeLabel = [[UILabel alloc] initWithFrame:_badgeView.bounds];
//        badgeLabel.textColor = [UIColor whiteColor];
//        badgeLabel.textAlignment = NSTextAlignmentCenter;
//        badgeLabel.font = [UIFont systemFontOfSize:11.0f];
//        badgeLabel.tag = 1000;
//        badgeLabel.backgroundColor = [UIColor clearColor];
//        [_badgeView addSubview:badgeLabel];
//        [badgeLabel release];
        
//        _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 35, 130, 20)];
//        _detailLabel.text = @"你好";
//        _detailLabel.textColor = rgb(216, 216, 216, 1);
//        _detailLabel.font = [UIFont systemFontOfSize:19];
//        [self.contentView addSubview:_detailLabel];
        
//        _acceptButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
//        _acceptButton.frame = CGRectMake(250, (kLinkManCellHeight-29.5)/2, 47, 29.5);
//        [_acceptButton setImage:[UIImage imageNamed:@"friends_delete1"] forState:UIControlStateNormal];
//        [_acceptButton setImage:[UIImage imageNamed:@"friends_delete2"] forState:UIControlStateHighlighted];
//        [_acceptButton addTarget:self action:@selector(acceptAction:) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:_acceptButton];
        
    }
    return self;
}

- (void)creat{
    if (_m_checkImageView == nil)
    {
        _m_checkImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AA-check"]];
        _m_checkImageView.frame = CGRectMake(kDeviceWidth-55, 20, 25, 25);
        [self addSubview:_m_checkImageView];
    }
}

- (void)setChecked:(BOOL)checked{
    if (checked)
    {
        _m_checkImageView.image = [UIImage imageNamed:@"AA-checked"];
        self.backgroundView.backgroundColor = [UIColor colorWithRed:223.0/255.0 green:230.0/255.0 blue:250.0/255.0 alpha:1.0];
    }
    else
    {
        _m_checkImageView.image = [UIImage imageNamed:@"AA-check"];
        self.backgroundView.backgroundColor = [UIColor whiteColor];
    }
    m_checked = checked;
    
    
}

-(void)loadViewsWidth
{
    _deleteButton.frame = CGRectMake(self.width, 0, 0, self.height);
}

//-(UIImage *)scaleImage:(UIImage *)image
//{
//    CGSize imgSize = CGSizeMake(41.5, 41);
//    UIGraphicsBeginImageContext(imgSize);
//    [image drawInRect:CGRectMake(0,0,imgSize.width,imgSize.height)];
//    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return newImage;
//}

//- (void)setIsNewFriend:(BOOL)isNewFriend {
//    if (_isNewFriend != isNewFriend) {
//        _isNewFriend = isNewFriend;
//        
//    }
//    if (isNewFriend) {
//        _nameLabel.top = 10;
//        _detailLabel.hidden = NO;
//        _acceptButton.hidden = NO;
//    }else {
//        _nameLabel.top = (kLinkManCellHeight-20)/2;
//        _detailLabel.hidden = YES;
//        _acceptButton.hidden = YES;
//    }
//}

#pragma mark - Actions
- (void)swipeAction:(UISwipeGestureRecognizer *)swipe {
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        [UIView animateWithDuration:.2 animations:^{
            self.contentView.bounds = CGRectMake(79, 0, self.contentView.width, self.contentView.height);
            _deleteButton.width = 79;
            
            
        }];
        
        self.isEditing = YES;
        if ([self.delegate respondsToSelector:@selector(QCLinkManCellDidEditing:)]) {
            [self.delegate QCLinkManCellDidEditing:self];
        }
        
    }else {
        [self closeDeleteButton];
    }
}

//- (void)acceptAction:(UIButton *)button {
//    if ([self.delegate respondsToSelector:@selector(acceptButtonClickedLinkManCell:)]) {
//        [self.delegate acceptButtonClickedLinkManCell:self];
//    }
//}

- (void)deleteAction:(UIButton *)button {
    
    if ([self.delegate respondsToSelector:@selector(deleteButtonClickedLinkManCell:userName:)]) {
        [self.delegate deleteButtonClickedLinkManCell:self userName:_nameLabel.text];
    }
}

#pragma mark - Public Methods
- (void)closeSwipeAction {
    _leftSwipe.enabled = NO;
    _rightSwipe.enabled = NO;
}

- (void)openSwipeAction {
    
    _leftSwipe.enabled = YES;
    _rightSwipe.enabled = YES;
    
//    [self closeSwipeAction];
}

- (void)closeDeleteButton {
    
    [UIView animateWithDuration:.2 animations:^{
        self.contentView.bounds = CGRectMake(0, 0, self.contentView.width, self.contentView.height);
        _deleteButton.width = 0;
        
    }];
    self.isEditing = NO;
    
    if ([self.delegate respondsToSelector:@selector(QCLinkManCellDidClose:)]) {
        [self.delegate QCLinkManCellDidClose:self];
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)showNewIcon:(BOOL)isShow
{
    UIImageView *newicon=[self.contentView viewWithTag:10009];
    newicon.hidden = !isShow;

}


@end
