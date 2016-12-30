//
//  MyLoanListTableViewFourCell.m
//  YOUXINBAO
//
//  Created by CH10 on 16/2/17.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "MyLoanListTableViewFourCell.h"
#import "MyLoanListDialogRectView.h"
#import "YXBTool.h"
#import "UIImageView+WebCache.h"
@interface MyLoanListTableViewFourCell ()
{
    UIView *_iconView;
    UIView *_delayBgView;
    UIView *_line;
}

@property (nonatomic,weak)UIImageView *iconImgView;
@property (nonatomic,weak)MyLoanListDialogRectView *dialogRectView;
@property (nonatomic,weak)UILabel *userNameLabel;
@property (nonatomic,weak)UILabel *timeLabel;

@property (nonatomic,weak)UILabel *oldLixiLabel;
@property (nonatomic,weak)UILabel *consultLixiLabel;

@end

@implementation MyLoanListTableViewFourCell
+(instancetype)MyLoanListTableViewFourCellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"cellID4";
    MyLoanListTableViewFourCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[MyLoanListTableViewFourCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
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
        self.oldLixiLabel.attributedText = [self attManageStr:_model.var1];
        self.consultLixiLabel.attributedText = [self attManageStr:_model.var2];
        [self updateFrameWithType:[_model.displayMode integerValue]];
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
        
        [self createDialogView];
        [self.contentView addSubview:_timeLabel];
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
    MyLoanListDialogRectView *tDialogRectView = [[MyLoanListDialogRectView alloc] initWithFrame:CGRectMake(0, 0, 153, 83) andTopImgName:@"myLoanList_DialogLeftTop" cenImgName:@"myLoanList_DialogCent" bottomImgName:@"myLoanList_DialogFoot"];
    self.dialogRectView = tDialogRectView;
    [self.contentView addSubview:tDialogRectView];
    
    _delayBgView = [[UIView alloc] initWithFrame:CGRectMake(8, 0, 153-8, 83)];
    UIImageView *headerImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"myLoanList_Consult"]];
    headerImgView.frame = CGRectMake(10, 10, headerImgView.image.size.width, headerImgView.image.size.height);
    [_delayBgView addSubview:headerImgView];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, headerImgView.bottom+5, _delayBgView.width-20, 1)];
    line.backgroundColor = rgb(165, 165, 165, 1);
    _line = line;
    [_delayBgView addSubview:line];
    
    NSArray *arr = @[@"原利息:",@"修改后利息:"];
    for (int i = 0; i < 2; i ++) {
        //计算长度
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:22.2/2],};
        CGSize strSize = [arr[i] sizeWithAttributes:attributes];
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, headerImgView.bottom+i*25+5, strSize.width+2, 25)];
        
        leftLabel.text = [arr objectAtIndex:i];
        leftLabel.textColor = [YXBTool colorWithHexString:@"#000000"];
        leftLabel.font = [UIFont systemFontOfSize:22.2/2];
        
        
        UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftLabel.right, headerImgView.bottom+i*25+5, _dialogRectView.width-20-leftLabel.width, 25)];
        rightLabel.font = [UIFont systemFontOfSize:11.1];
        if (i == 0) {
            _oldLixiLabel = rightLabel;
        }else if (i == 1){
            _consultLixiLabel = rightLabel;
        }
        [_delayBgView addSubview:leftLabel];
        [_delayBgView addSubview:rightLabel];
    }
    
    [_dialogRectView addSubview:_delayBgView];
    
}
-(void)updateFrameWithType:(NSInteger)type{
    if (type == 1) {//左侧
        _iconView.frame = CGRectMake(23/2.0, _timeLabel.bottom+8.5, 77/2.0, _iconView.height);
        _dialogRectView.topImgName = @"myLoanList_DialogLeftTop";
        _dialogRectView.type = type;
        _delayBgView.frame = CGRectMake(8, _delayBgView.frame.origin.y, _delayBgView.width, _delayBgView.height);
        _dialogRectView.frame = CGRectMake(_iconView.right+7.5, _timeLabel.bottom+8.5,_dialogRectView.width, 83);
    }else if (type == 2){//右侧
        _iconView.frame = CGRectMake(kDeviceWidth-33-_iconView.width-23/2.0, _timeLabel.bottom+8.5, 77/2.0, 77/2.0);
        _delayBgView.frame = CGRectMake(0, _delayBgView.frame.origin.y, _delayBgView.width, _delayBgView.height);
        _dialogRectView.topImgName = @"myLoanList_DialogRightTop";
        _dialogRectView.type = type;
        _dialogRectView.frame = CGRectMake(_iconView.left-7.5-_dialogRectView.width, _timeLabel.bottom+8.5,_dialogRectView.width, 83);
    }
}
//处理str红+黑
-(NSMutableAttributedString*)attManageStr:(NSString*)money{
    
    NSString *str = [NSString stringWithFormat:@"%@  元",money];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:22.2/2],NSForegroundColorAttributeName:rgb(77, 77, 77, 1)}];
    NSRange range = {0,attStr.length-1};
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:11.1],
                          NSForegroundColorAttributeName:rgb(237, 46, 36, 1)};
    [attStr addAttributes:dic range:range];
    return attStr;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
