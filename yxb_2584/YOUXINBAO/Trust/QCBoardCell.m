//
//  QCBoardCell.m
//  YOUXINBAO
//
//  Created by CH10 on 15/4/10.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBoardCell.h"

@implementation QCBoardCell {
    QCBoardUserView *_user1;
    QCBoardUserView *_user2;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        QCBoardUserView *user1 = [[[NSBundle mainBundle] loadNibNamed:@"QCBoardUserView" owner:self options:nil] lastObject];
//
//        user1.frame = CGRectMake(10, 10, kBoardUserWidth, kBoardUserHeight);
        _user1 = [[QCBoardUserView alloc] initWithFrame:CGRectMake(10, 10, kBoardUserWidth, kBoardUserHeight)];
        [self.contentView addSubview:_user1];
        
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_user1 addGestureRecognizer:tap1];
        
//        QCBoardUserView *user2 = [[[NSBundle mainBundle] loadNibNamed:@"QCBoardUserView" owner:self options:nil] lastObject];
//        user2.frame = CGRectMake(20+kBoardUserWidth, 10, kBoardUserWidth, kBoardUserHeight);
//        [self.contentView addSubview:user2];
        _user2 = [[QCBoardUserView alloc] initWithFrame:CGRectMake(20+kBoardUserWidth, 10, kBoardUserWidth, kBoardUserHeight)];
        [self.contentView addSubview:_user2];
        
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_user2 addGestureRecognizer:tap2];
        
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _user1.rankNum = self.row*2+1;
    
    _user2.rankNum = self.row*2+2;
    
    if (self.dataArr.count > self.row*2) {
        _user1.creditCenter = [self.dataArr objectAtIndex:self.row*2];
        
    }
    
    if (self.dataArr.count > self.row*2+1) {
        _user2.hidden = NO;
        _user2.creditCenter = [self.dataArr objectAtIndex:self.row*2+1];
        
    }else {
        _user2.hidden = YES;
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    if ([tap.view isKindOfClass:[QCBoardUserView class]]) {
        if (self.delegate) {
            [self.delegate QCBoardCellUserDidClick:(QCBoardUserView *)tap.view];
        }
        
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
