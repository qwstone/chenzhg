//
//  QCSelectRefunCell.m
//  YOUXINBAO
//
//  Created by zjp on 15/6/19.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCSelectRefunCell.h"
#import "LineView.h"
@implementation QCSelectRefunCell{
    
    UIImageView            *_UserImg;
    UIImageView            *_xingbie;
    UILabel             *_nameLabel;
    UILabel             *_lvLabel;
    UILabel             *_moneyLabel;
    UILabel             *_idLabel;
    UIImageView          *_costImg;
    NSMutableAttributedString *strLabel;
    UIImageView *xingbie;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self creat];
        LineView *line = [[LineView alloc] initWithFrame:CGRectMake(10, 64, kDeviceWidth-20, 1)];
        line.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:line];
        UIImageView *img = [self borderImageViewWithImage:nil frame:CGRectMake(kDeviceWidth/320*55, 7.5f, 50, 50)];
        [self.contentView addSubview:img];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake((kDeviceWidth-120)/2+10, 26, 100, 16)];
        _nameLabel.textColor = [YXBTool colorWithHexString:@"#484747"];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.text = @"毕加索";
        [self.contentView addSubview:_nameLabel];
        
        xingbie = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
        xingbie.center = img.center;
        xingbie.left = _nameLabel.right+kDeviceWidth/320*15;
        xingbie.image = [UIImage imageNamed:@"AA_man-icon"];
        [self.contentView addSubview:xingbie];
        
        _costImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 13)];
        _costImg.top = img.top;
        _costImg.left = img.right;
        [self.contentView addSubview:_costImg];
        
        _lvLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/320*260, img.bottom-20, kDeviceWidth/320*60, 20)];
        _lvLabel.center = img.center;
        _lvLabel.left = kDeviceWidth/320*260;
        _lvLabel.text = @"已签到";
        _lvLabel.font = [UIFont systemFontOfSize:16];
        _lvLabel.textColor = [UIColor greenColor];
        [self.contentView addSubview:_lvLabel];
    }
    return self;
}

- (void)setModel:(ActivityMember *)model {
    if (_model != model) {
        _model = model;
        [self setData];
    }
}

- (void)setData {
    [_UserImg sd_setImageWithURL:[NSURL URLWithString:self.model.iconAddr] placeholderImage:[UIImage imageNamed:@"useimg"]];
    /**
     * 性别  0->女 | 1->男
     */
    if (self.model.gender == 1) {
        xingbie.image = [UIImage imageNamed:@"AA_man-icon"];
    }else {
        xingbie.image = [UIImage imageNamed:@"AA_woman-icon"];
    }
    
    _nameLabel.text = self.model.nickname;
    //发起者也默认签到
    if (self.model.type == 4 || self.model.type == 1) {
        _lvLabel.text = @"已签到";
        _lvLabel.textColor = [UIColor greenColor];
    }else{
        _lvLabel.text = @"待签到";
        _lvLabel.textColor = [UIColor lightGrayColor];
    }
    
    if (self.model.payType == 2) {
        _costImg.image = [UIImage imageNamed:@"fufei-icon"];
    }else if (self.model.payType == 3){
        _costImg.image = [UIImage imageNamed:@"jietiao-icon"];
    }

}

-(UIImageView*)borderImageViewWithImage:(UIImage *)image frame:(CGRect)frame
{
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"expertUserImg.png"]];
    bgImageView.clipsToBounds = YES;
    bgImageView.frame = frame;
    
    CGFloat space = 3;
    
    CGFloat x = space;
    CGFloat y = space-1.5;
    CGFloat w = frame.size.width - 2 * space;
    CGFloat h = frame.size.height - 2 * space;
    
    _UserImg = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    _UserImg.layer.cornerRadius = _UserImg.width/2;
    _UserImg.clipsToBounds = YES;
    _UserImg.image = image;
    [bgImageView addSubview:_UserImg];
    
    return bgImageView;
}

- (void)creat{
    if (m_checkImageView == nil)
    {
        m_checkImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AA-check"]];
        m_checkImageView.frame = CGRectMake(10, 20, 25, 25);
        [self addSubview:m_checkImageView];
    }
}

- (void)setChecked:(BOOL)checked{
    if (checked)
    {
        m_checkImageView.image = [UIImage imageNamed:@"AA-checked"];
        self.backgroundView.backgroundColor = [UIColor colorWithRed:223.0/255.0 green:230.0/255.0 blue:250.0/255.0 alpha:1.0];
    }
    else
    {
        m_checkImageView.image = [UIImage imageNamed:@"AA-check"];
        self.backgroundView.backgroundColor = [UIColor whiteColor];
    }
    m_checked = checked;
    
    
}
@end
