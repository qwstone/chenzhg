//
//  DishonestyTableViewCell.m
//  YOUXINBAO
//
//  Created by zjp on 15/6/15.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "DishonestyTableViewCell.h"
#import "UIImageViewToGary.h"
#import "YXBTool.h"
@implementation DishonestyTableViewCell{
    
    UIImageViewToGary            *_UserImg;
    UILabel             *_nameLabel;
    UILabel             *_lvLabel;
    UILabel             *_moneyLabel;
    UILabel             *_idLabel;
    UIImageView         *_usercheckImg;
    NSMutableAttributedString *strLabel;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *img = [self borderImageViewWithImage:nil frame:CGRectMake(10, 7.5f, 50, 50)];
        [self.contentView addSubview:img];
        
        
        _usercheckImg = [[UIImageView alloc] initWithFrame:CGRectMake(img.right-18, img.top, 18, 18)];
        _usercheckImg.image = [YXBTool grayscale:[UIImage imageNamed:@"usercheck"] type:1] ;
        [self.contentView addSubview:_usercheckImg];
//        _UserImg = [[UIImageViewToGary alloc] initWithFrame:CGRectMake(10, 7.5f, 50, 50)];
//        _UserImg.layer.cornerRadius = _UserImg.width/2;
//        _UserImg.layer.masksToBounds = YES;
////        _UserImg.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
////        _UserImg.layer.borderWidth = 2;
//        _UserImg.layer.shadowOpacity = 1;
//        _UserImg.layer.shadowRadius = 3;
//        _UserImg.layer.shadowOffset = CGSizeMake(2,3);
//        [self.contentView addSubview:_UserImg];
//        _UserImg.backgroundColor = [YXBTool colorWithHexString:@"#484747"];
//        _UserImg.userInteractionEnabled=NO;
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(img.right+20, img.top+5, kDeviceWidth, 20)];
        _nameLabel.textColor = [YXBTool colorWithHexString:@"#484747"];
        _nameLabel.font = [UIFont systemFontOfSize:16];
       // _nameLabel.text = @"毕加索";
        [self.contentView addSubview:_nameLabel];

        _lvLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.left, img.bottom-20, kDeviceWidth-_nameLabel.left, 20)];
        _lvLabel.font = [UIFont systemFontOfSize:12];
        _lvLabel.text = @"失信原因：";
        _lvLabel.textColor = [UIColor orangeColor];
        [self.contentView addSubview:_lvLabel];
        
        _idLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth-120, _nameLabel.top, 150, 20)];
        _idLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        _idLabel.font = [UIFont systemFontOfSize:12];
        _idLabel.textColor = [YXBTool colorWithHexString:@"#b3b3b3"];
        [self.contentView addSubview:_idLabel];

    }
    
    return self;
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
    
    _UserImg = [[UIImageViewToGary alloc] initWithFrame:CGRectMake(x, y, w, h)];
    _UserImg.layer.cornerRadius = _UserImg.width/2;
    _UserImg.clipsToBounds = YES;
    _UserImg.image = image;
    [bgImageView addSubview:_UserImg];
    

    return bgImageView;
}

- (void)setModel:(DishonestBoard *)model {
    if (_model != model) {
        _model = model;
        [self requestdata];
    }

}

- (void)requestdata {
    [_UserImg sd_setImageWithURL:[NSURL URLWithString:self.model.iconAddr] placeholderImage:[UIImage imageNamed:@"useimg"]];
    _nameLabel.text = self.model.realname;
    _idLabel.text = self.model.idCardNo;
    
    
    if (self.model.friendFlag == 1) {
        _usercheckImg.hidden = NO;
    }else {
        _usercheckImg.hidden = YES;
    }
    NSString *string = [NSString stringWithFormat:@"欠债%@，逾期未还",self.model.loanMoneyDesc];
    strLabel = [[NSMutableAttributedString alloc] initWithString:string];
    [strLabel addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#8c8a8a"] range:NSMakeRange(0,strLabel.length)];
    [strLabel addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#f8a053"] range:[string rangeOfString:@"失信原因"]];
    [strLabel addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#f54c35"] range:[string rangeOfString:self.model.loanMoneyDesc]];
    _lvLabel.attributedText = strLabel;

}



@end
