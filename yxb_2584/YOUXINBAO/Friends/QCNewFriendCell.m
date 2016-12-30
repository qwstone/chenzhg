//
//  QCNewFriendCell.m
//  YOUXINBAO
//
//  Created by CH10 on 14-5-23.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCNewFriendCell.h"
#import "QCConst.h"
#import "UIView+ViewFrameGeometry.h"
#import "UIImageView+WebCache.h"

@implementation QCNewFriendCell {
    UIButton *_deleteButton;
    
    UISwipeGestureRecognizer *_leftSwipe;
    UISwipeGestureRecognizer *_rightSwipe;
    
    BOOL _isAdded;
}

//- (void)dealloc
//{
//    self.user = nil;
//    [_leftSwipe release];
//    [_rightSwipe release];
//    [_detailLabel release];
//    //    [_delegate release];
//    [_imageview release];
//    [_nameLabel release];
//    [super dealloc];
//}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        // Initialization code
        _isAdded = NO;
        
        _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(15, (kNewFriendCellHeight-41)/2, 41.5, 41)];
       // _imageview.backgroundColor=[UIColor redColor];
        _imageview.layer.cornerRadius = 10;
        _imageview.layer.masksToBounds = YES;

        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 10, 130, 20)];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        //_nameLabel.backgroundColor = [UIColor purpleColor];
        
        [self.contentView addSubview:_imageview];
        [self.contentView addSubview:_nameLabel];
        
        _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 35, 180, 20)];
        _detailLabel.textColor = rgb(142, 142, 142, 1);
        _detailLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_detailLabel];

        _acceptButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        CGFloat w = 47;
//        CGFloat buttonGap = 15.0;
//        _acceptButton.frame = CGRectMake(kDeviceWidth - w-buttonGap*2, 0, w+buttonGap*2, kNewFriendCellHeight);
        _acceptButton.frame=CGRectMake(kDeviceWidth-70, 15, 60, 30);
        _acceptButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
//        _acceptButton.layer.cornerRadius = 3.0;
        [_acceptButton setImage:[UIImage imageNamed:@"hy-js-icon.png"] forState:UIControlStateNormal];
        [_acceptButton addTarget:self action:@selector(acceptAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_acceptButton];
        
        _leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
        _leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
        [self.contentView addGestureRecognizer:_leftSwipe];
        
        _rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
        _rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
        [self.contentView addGestureRecognizer:_rightSwipe];
        
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.frame = CGRectMake(kDeviceWidth, 0, 0, kNewFriendCellHeight);
//        [_deleteButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [_deleteButton setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        _deleteButton.adjustsImageWhenHighlighted = YES;
        [_deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_deleteButton];
    }
    return self;
}

- (void)setUser:(TFriendRelation *)user {
    if (_user != user) {
        _user = user;
        
        _nameLabel.text = user.friendUser.nickname;
        if ([user.note isEqualToString:@""]) {
            _detailLabel.text=@"请加我为好友吧!";
        }
        else{

        _detailLabel.text = user.note;
        }
        
        [_imageview sd_setImageWithURL:[NSURL URLWithString:user.friendUser.iconAddr] placeholderImage:[UIImage imageNamed:@"hy-usermr-icon.png"]];
        if (user.relationType == 1) {
            [self changeAcceptType];
        }
        else {
        [_acceptButton setImage:[UIImage imageNamed:@"hy-js-icon.png"] forState:UIControlStateNormal];

        }
    }
    
}

-(void)setTUser:(User *)tUser
{
    if (_tUser != tUser) {
        _tUser = tUser;
        if (_tUser.realname.length == 0) {
            _nameLabel.text = _tUser.nickname;
        }else {
            _nameLabel.text = _tUser.nickname;
        }
        
        _detailLabel.text = _tUser.signature;
        [_imageview sd_setImageWithURL:[NSURL URLWithString:_tUser.iconAddr] placeholderImage:[UIImage imageNamed:@"hy-usermr-icon.png"]];

    }
}

-(void)setIsFromSearch:(BOOL)isFromSearch
{
    _isFromSearch = isFromSearch;
//    [_acceptButton setTitle:@"添加" forState:UIControlStateNormal];
    [_acceptButton setImage:[UIImage imageNamed:@"add-friend"] forState:UIControlStateNormal];
//    _acceptButton.userInteractionEnabled = NO;

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
        if ([self.delegate respondsToSelector:@selector(QCNewFriendCellDidEditing:)]) {
            [self.delegate QCNewFriendCellDidEditing:self];
        }
        
    }else {
        [self closeDeleteButton];
    }
}

- (void)acceptAction:(UIButton *)button {
    if (_isAdded) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(acceptButtonClickedNewFriendCell:)]) {
        [self.delegate acceptButtonClickedNewFriendCell:self];
    }
}

- (void)deleteAction:(UIButton *)button {
    
    if ([self.delegate respondsToSelector:@selector(deleteButtonClickedNewFriendCell:userName:)]) {
        [self.delegate deleteButtonClickedNewFriendCell:self userName:_nameLabel.text];
    }
}

#pragma mark - Public Methods
- (void)changeAcceptType {
    _isAdded = YES;
    [_acceptButton setImage:nil forState:UIControlStateNormal];
//    _acceptButton.backgroundColor = [UIColor lightGrayColor];
    [_acceptButton setTitleColor:rgb(128, 128, 128, 1) forState:UIControlStateNormal];
 //   [_acceptButton setImage:[UIImage imageNamed:@"added-friend"] forState:UIControlStateNormal];
    [_acceptButton setTitle:@"已添加" forState:UIControlStateNormal];
//    _acceptButton.layer.cornerRadius = 3.0;
    _acceptButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
}

- (void)closeSwipeAction {
    _leftSwipe.enabled = NO;
    _rightSwipe.enabled = NO;
}

- (void)openSwipeAction {
    _leftSwipe.enabled = YES;
    _rightSwipe.enabled = YES;
}

- (void)closeDeleteButton {
    
    [UIView animateWithDuration:.2 animations:^{
        self.contentView.bounds = CGRectMake(0, 0, self.contentView.width, self.contentView.height);
        _deleteButton.width = 0;
        
    }];
    self.isEditing = NO;
    
    if ([self.delegate respondsToSelector:@selector(QCNewFriendCellDidClose:)]) {
        [self.delegate QCNewFriendCellDidClose:self];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



@end

