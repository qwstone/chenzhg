//
//  MyLoanListTableViewTwoCell.m
//  YOUXINBAO
//
//  Created by CH10 on 16/2/16.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "MyLoanListTableViewTwoCell.h"
#import "YXBTool.h"
#import "UIImageView+WebCache.h"
@interface MyLoanListTableViewTwoCell ()
{
    UIView *_iconView;
}
@property (nonatomic,weak)UIImageView *iconImgView;
@property (nonatomic,weak)UIImageView *stateImgView;
@property (nonatomic,weak)UILabel *userNameLabel;
@property (nonatomic,weak)UILabel *timeLabel;

@end

@implementation MyLoanListTableViewTwoCell
+(instancetype)MyLoanListTableViewTwoCellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"cellID2";
    MyLoanListTableViewTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[MyLoanListTableViewTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}
-(void)setModel:(YXBLoanDialogue *)model{
    if (_model!=model) {
        _model = model;
        
        self.timeLabel.text = _model.time;
        [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:_model.imgUrl] placeholderImage:[UIImage imageNamed:@"useimg"]];
        self.userNameLabel.text = _model.name;
        
        [self updateFrameWithType:[_model.displayMode integerValue] andStateImageName:_model.var1];
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
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *tTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 17/2.0, 20, 20.49/2.0+6)];
        self.timeLabel = tTimeLabel;
        
        [self createIconView];
        
        
        UIImageView *tStateImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];

        self.stateImgView = tStateImgView;
        [self.contentView addSubview:_timeLabel];
        [self.contentView addSubview:_stateImgView];
    }
    return self;
}
-(void)stateImgViewClicked:(UITapGestureRecognizer*)tap{
    self.updateVideoClicked();
}
-(void)createIconView{
    UIView *tIconView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 38.5, 40+8.5+6)];
    _iconView = tIconView;
    
    UIImageView *bgIconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 38.5, 38.5)];
    bgIconImgView.image = [UIImage imageNamed:@"userIconBg"];
    UIImageView *tIconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(3.5/2, 3.5/2, 35 , 35)];
    
    self.iconImgView = tIconImgView;
    [bgIconImgView addSubview:_iconImgView];
    
    UILabel *tUserNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, bgIconImgView.bottom+3, bgIconImgView.width, 8.5)];
    self.userNameLabel = tUserNameLabel;

    
    [_iconView addSubview:bgIconImgView];
    [_iconView addSubview:self.userNameLabel];
    
    [self.contentView addSubview:_iconView];
}
-(void)updateFrameWithType:(NSInteger)type andStateImageName:(NSString *)imgName{
    
    NSString *fullImgName = nil;
    self.stateImgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    
    [self.stateImgView addGestureRecognizer:tap];
    if ([imgName integerValue] == picShangChuanShiPin) {//上传视频
        [tap addTarget:self action:@selector(stateImgViewClicked:)];
    }else{
        [tap removeTarget:self action:@selector(stateImgViewClicked:)];
    }
    if (type == 1) {//左侧
        fullImgName = [NSString stringWithFormat:@"L%@",imgName];
        _iconView.frame = CGRectMake(23/2.0, _timeLabel.bottom+8.5, 77/2.0, _iconView.height);
        self.stateImgView.image = [UIImage imageNamed:fullImgName];
        _stateImgView.frame = CGRectMake(_iconView.right+7.5, _timeLabel.bottom+8.5,_stateImgView.image.size.width, _stateImgView.image.size.height);
    }else if (type == 2){//右侧
        fullImgName = [NSString stringWithFormat:@"R%@",imgName];
        _iconView.frame = CGRectMake(kDeviceWidth-33-_iconView.width-23/2.0, _timeLabel.bottom+8.5, 77/2.0, 77/2.0);
        _stateImgView.image = [UIImage imageNamed:fullImgName];
        _stateImgView.frame = CGRectMake(_iconView.left-7.5-_stateImgView.image.size.width, _timeLabel.bottom+8.5, _stateImgView.image.size.width, _stateImgView.image.size.height);
        
        
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
