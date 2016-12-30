//
//  MyLoanListTableViewOneCell.m
//  YOUXINBAO
//
//  Created by CH10 on 16/2/17.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "MyLoanListTableViewOneCell.h"
#import "MyLoanListDialogRectView.h"
#import "UIImageView+WebCache.h"
#import "YXBTool.h"
#import "UIImageView+WebCache.h"
@interface MyLoanListTableViewOneCell ()
{
    UIView *_iconView;
}

@property (nonatomic,weak)UIImageView *iconImgView;
@property (nonatomic,weak)MyLoanListDialogRectView *dialogRectView;
@property (nonatomic,weak)UILabel *userNameLabel;
@property (nonatomic,weak)UILabel *timeLabel;
@property (nonatomic,weak)UILabel *contentLable;

@end

@implementation MyLoanListTableViewOneCell
+(instancetype)MyLoanListTableViewOneCellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"cellID1";
    MyLoanListTableViewOneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[MyLoanListTableViewOneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)setModel:(YXBLoanDialogue *)model{
    if (_model!=model) {
        _model = model;
        
        self.userNameLabel.text = _model.name;
        self.timeLabel.text = _model.time;
        [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:_model.imgUrl] placeholderImage:[UIImage imageNamed:@"useimg"]];
        self.contentLable.text = _model.var1;
        CGSize size = [YXBTool getFontSizeWithString:_model.var1 font:[UIFont systemFontOfSize:11.1] constrainSize:CGSizeMake(_contentLable.width, 10000)];
        [self updateFrameWithType:[_model.displayMode integerValue] AndDialogHeight:size.height];
    }
}
-(void)layoutSubviews{
    self.timeLabel.font = [UIFont systemFontOfSize:20.49/2.0];
    CGSize size = [_timeLabel.text boundingRectWithSize:CGSizeMake(kDeviceWidth, _timeLabel.height) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20.49/2.0]} context:nil].size;
    self.timeLabel.frame = CGRectMake(_timeLabel.frame.origin.x, _timeLabel.frame.origin.y, size.width+6, _timeLabel.height);
    self.timeLabel.center = CGPointMake(self.center.x, 17/2.0+_timeLabel.height/2.0);
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.backgroundColor = rgb(185, 185, 185, 1);
    self.timeLabel.layer.cornerRadius = self.timeLabel.height/2.0;
    self.timeLabel.layer.masksToBounds = YES;
    
    self.iconImgView.layer.cornerRadius = _iconImgView.height/2.0;
    self.iconImgView.layer.masksToBounds = YES;
    
    self.userNameLabel.font = [UIFont systemFontOfSize:17.08/2.0];
    self.userNameLabel.textColor = [YXBTool colorWithHexString:@"#808080"];
    self.userNameLabel.textAlignment = NSTextAlignmentCenter;
    
    self.contentLable.numberOfLines = 0;
    self.contentLable.textColor = rgb(60, 60, 60, 1);
    self.contentLable.font = [UIFont systemFontOfSize:11.1];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *tTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 17/2.0, 20, 20.49/2.0+6)];
        self.timeLabel = tTimeLabel;
        [self.contentView addSubview:_timeLabel];
        
        [self createIconView];
        
        [self createDialogView];
        
    }
    return self;
}
-(void)createIconView{
    UIView *tIconView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 38.5, 40+8.5+6)];
    _iconView = tIconView;
    
    UIImageView *bgIconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 38.5, 38.5)];
    bgIconImgView.image = [UIImage imageNamed:@"userIconBg"];
    UIImageView *tIconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(3.5/2, 3.5/2, 35, 35)];
    self.iconImgView = tIconImgView;
    [bgIconImgView addSubview:_iconImgView];
    
    UILabel *tUserNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, bgIconImgView.bottom+3, bgIconImgView.width, 8.5)];
    self.userNameLabel = tUserNameLabel;
    
    
    [_iconView addSubview:bgIconImgView];
    [_iconView addSubview:self.userNameLabel];
    
    [self.contentView addSubview:_iconView];
}
-(void)createDialogView{
    MyLoanListDialogRectView *tDialogRectView = [[MyLoanListDialogRectView alloc] initWithFrame:CGRectMake(0, 0, 153, 113) andTopImgName:@"myLoanList_DialogLeftTop" cenImgName:@"myLoanList_DialogCent" bottomImgName:@"myLoanList_DialogFoot"];
    self.dialogRectView = tDialogRectView;
    [self.contentView addSubview:tDialogRectView];

    //对话内容
    UILabel *tContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 5+10, _dialogRectView.width-20, 20)];
    [_dialogRectView addSubview:tContentLabel];
    self.contentLable = tContentLabel;
}
-(void)updateFrameWithType:(NSInteger)type AndDialogHeight:(CGFloat)dH{

    CGFloat dialogH = dH+10+12+10;
    NSLog(@"计算文字高度 %f",dialogH);

    if (type == 1) {//左侧
        _iconView.frame = CGRectMake(23/2.0, _timeLabel.bottom+8.5, 77/2.0, _iconView.height);
        
        _dialogRectView.topImgName = @"myLoanList_DialogLeftTop";
        _dialogRectView.frame = CGRectMake(_iconView.right+7.5, _timeLabel.bottom+8.5,_dialogRectView.width, dialogH);
        _dialogRectView.type = type;

        _contentLable.frame = CGRectMake(13, _contentLable.frame.origin.y, _contentLable.width, dH);
        
    }else if (type == 2){//右侧
        _iconView.frame = CGRectMake(kDeviceWidth-33-_iconView.width-23/2.0, _timeLabel.bottom+8.5, 77/2.0, 77/2.0);
        
        _dialogRectView.topImgName = @"myLoanList_DialogRightTop";
        _dialogRectView.frame = CGRectMake(_iconView.left-7.5-_dialogRectView.width, _timeLabel.bottom+8.5,_dialogRectView.width, dialogH);
        _dialogRectView.type = type;
        
        _contentLable.frame = CGRectMake(5, _contentLable.frame.origin.y, _contentLable.width, dH);
    }
    _dialogRectView.type = 0;
}
- (void)awakeFromNib {
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
