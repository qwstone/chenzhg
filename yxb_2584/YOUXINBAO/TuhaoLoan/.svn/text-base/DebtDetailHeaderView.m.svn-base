//
//  DebtDetailHeaderView.m
//  YOUXINBAO
//
//  Created by Feili on 15/5/20.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "DebtDetailHeaderView.h"
#import "YXBTool.h"
#import "UIImageView+WebCache.h"

#define DebtDetailHeaderViewFont 17
#define DebtDetailHeaderViewLabelTagStart 1000

@interface DebtDetailHeaderView ()
@property(nonatomic,strong)UIImageView  *avatarImageView;//头像
@property(nonatomic,strong)UILabel      *userNameLabel;//用户名
@property(nonatomic,strong)UILabel      *reputationLabel;//信誉等级
@property(nonatomic,strong)UILabel      *canLendAmountLabel;//可借数量
@property(nonatomic,strong)UILabel      *hasLendAmountLabel;//已借数量
@end

@implementation DebtDetailHeaderView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    
    return self;
}

-(void)initViews
{

    CGFloat x = 10,y = 8,w = 60,h = 60;
    UIImageView *imageView = [self borderImageViewWithImage:nil frame:CGRectMake(x, y, w, h)];
    
//    self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
//    _avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
//    _avatarImageView.image = [UIImage imageNamed:@"register_photo.png"];
    [self addSubview:imageView];
    
    self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y+h+5, w, 15)];
    _userNameLabel.textColor = [UIColor blackColor];
    _userNameLabel.backgroundColor = [UIColor clearColor];
    _userNameLabel.text = @"";
    _userNameLabel.minimumScaleFactor = 10.0/_userNameLabel.font.pointSize;
    _userNameLabel.adjustsFontSizeToFitWidth = YES;
    _userNameLabel.textAlignment = NSTextAlignmentCenter;
    _userNameLabel.font = [UIFont systemFontOfSize:DebtDetailHeaderViewFont];
    [self addSubview:_userNameLabel];
    
#define SpaceXBetweenImageAndLabel 20
#define SpaceYBetweenTopAndLabel 25
    
    x = x + w + SpaceXBetweenImageAndLabel;
    y = SpaceYBetweenTopAndLabel;
    w = (kDeviceWidth - x)/2.0;
    h = 15;
    CGFloat x1 = x;
    CGFloat y1 = y;
    CGFloat w1 = w;
    CGFloat h1 = h;
    
    CGFloat const labelYSpace = 20;
    
    //添加信用等级label
    
    self.reputationLabel = [self labelWithFrame:CGRectMake(x1, y1, w1, h1)];
    _reputationLabel.font = [UIFont boldSystemFontOfSize:18.0];
    [self addSubview:_reputationLabel];
    
    //添加可借数量
    y1 = y1 + h1 + labelYSpace;
    self.canLendAmountLabel = [self labelWithFrame:CGRectMake(x1, y1, w1, h1)];
    _canLendAmountLabel.textColor = [UIColor lightGrayColor];
    _canLendAmountLabel.font = [UIFont systemFontOfSize:14.0];
    [self addSubview:_canLendAmountLabel];
    
    //添加已借数量
    x1 = x1 + w1;
    self.hasLendAmountLabel = [self labelWithFrame:CGRectMake(x1, y1, w1, h1)];
    _hasLendAmountLabel.textColor = [UIColor lightGrayColor];

    _hasLendAmountLabel.font = [UIFont systemFontOfSize:14.0];
    [self addSubview:_hasLendAmountLabel];

    
//    for (int i = 0; i < 3; i ++) {
//        y1 = y + (h+labelYSpace)*i;
//        if (i == 2) {
//            x1 = x1 + w1;
//            y1 = y1 -(h+labelYSpace);
//        }
//        UILabel *label = [self labelWithFrame:CGRectMake(x1, y1, w1, h1)];
//        label.tag = DebtDetailHeaderViewLabelTagStart + i;
//        [self addSubview:label];
//        
//    }
    
}

-(void)setModel:(BlankNoteData *)model
{
    if (_model != model) {
        _model = model;
        
        [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:_model.imgurl] placeholderImage:[UIImage imageNamed:@"register_photo.png"]];
        _userNameLabel.text = _model.nickName;
        NSMutableArray *elementArray = [NSMutableArray arrayWithObjects:
                             [NSString stringWithFormat:@"信用等级：%@",@""],
                             [NSString stringWithFormat:@"可借数量：%ld",(long)_model.borrowNumber],
                             [NSString stringWithFormat:@"已经借出：%ld",(long)model.loanNumber
                              ], nil];
        NSMutableAttributedString *canAmountStr = [[NSMutableAttributedString alloc] initWithString:elementArray[1]];
        
        
        NSMutableAttributedString *hasAmountStr = [[NSMutableAttributedString alloc] initWithString:elementArray[2]];

        
        [canAmountStr setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}
                                range:NSMakeRange(5, [canAmountStr length] - 5)];
        [hasAmountStr setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}
                              range:NSMakeRange(5, [hasAmountStr length] - 5)];
        
        _reputationLabel.text = elementArray[0];
        _canLendAmountLabel.attributedText = canAmountStr;
        _hasLendAmountLabel.attributedText = hasAmountStr;
//        for (int i = 0; i < [elementArray count]; i ++) {
//            NSInteger tag = DebtDetailHeaderViewLabelTagStart + i;
//            UILabel *label = (UILabel *)[self viewWithTag:tag];
//            label.text = elementArray[i];
//        }

        
    }
}


-(UILabel *)labelWithFrame:(CGRect)frame
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
//    label.backgroundColor = [YXBTool generateRandomColor];
    label.font = [UIFont systemFontOfSize:DebtDetailHeaderViewFont];
    return label;
}

-(UIImageView*)borderImageViewWithImage:(UIImage *)image frame:(CGRect)frame
{
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"expertUserImg.png"]];
    bgImageView.clipsToBounds = YES;
    bgImageView.frame = frame;
    
    CGFloat space = 2;
    
    CGFloat x = space;
    CGFloat y = space-2;
    CGFloat w = frame.size.width - 2 * space;
    CGFloat h = frame.size.height - 2 * space;
    
    self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    _avatarImageView.layer.cornerRadius = _avatarImageView.width/2;
    _avatarImageView.clipsToBounds = YES;
    _avatarImageView.image = image;
    [bgImageView addSubview:_avatarImageView];
    
    return bgImageView;
}


@end
