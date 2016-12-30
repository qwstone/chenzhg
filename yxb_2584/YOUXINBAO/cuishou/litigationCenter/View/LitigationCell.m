//
//  LitigationCell.m
//  YOUXINBAO
//
//  Created by pro on 2016/12/7.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LitigationCell.h"
#import "UIImageView+WebCache.h"
#import "MergeViewController.h"
@interface LitigationCell ()

@property (weak, nonatomic) UIImageView *   iconImg;//头像
@property (weak, nonatomic) UIImageView *   bgIconImg;//头像背景

@property (weak, nonatomic) UILabel     *   nickNameLabel;//昵称
@property (weak, nonatomic) UILabel     *   descriptLabel;//还款类型


@property (weak, nonatomic) UIImageView *   overdueImg;//逾期图片


@property (weak, nonatomic) UILabel *moneyLabel;//借款金额
@property (weak, nonatomic) UILabel *interestLabel;//利息
@property (weak, nonatomic) UILabel *backTimeLabel;//还款时间
@property (weak, nonatomic) UILabel *timeTypeLabel;//时间类型



/**
 待诉讼情况下  cell会多出一个选中按钮和一个合并诉讼按钮
 */
@property (weak, nonatomic) UIImageView * yuqiIcon;//逾期图片
@property (weak, nonatomic) UIButton    * mergeBtn;//合并按钮

/**
    状态图片 CuiShouZhong  CuiShousuccessful CuiShoufailure
 */
@property (weak,nonatomic)  UIImageView * stateIcon;//状态图片


@end

@implementation LitigationCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.backgroundColor = [YXBTool colorWithHexString:@"#e8e8e8"];
        [self createUpView];
        [self createDownView];
        
        
    }
    return self;
}




/**
 赋值

 @param model 赋值数据
 */
-(void)setModel:(OverdueLoanData *)model{
    
    
    if (_model != model) {
        _model = model;
        if (_model) {
            [self.iconImg sd_setImageWithURL:[NSURL URLWithString:_model.imageUrl] placeholderImage:[UIImage imageNamed:@"useimg"]];
            self.nickNameLabel.text = model.nickName;
            self.descriptLabel.text = model.name;

            //待诉讼
            if ([model.loanState isEqualToString:@"0"]) {
                
                self.bgIconImg.frame = CGRectMake(45, 9, 48, 48);
                
                _selectBtn.hidden = NO;
                _mergeBtn.hidden = NO;
                _yuqiIcon.hidden = NO;
                _stateIcon.hidden = YES;
            }
            else{
                self.bgIconImg.frame = CGRectMake(10, 9, 48, 48);
                //诉讼中
                if ([model.loanState isEqualToString:@"1"]){
                    self.stateIcon.image = [UIImage imageNamed:@"litigationing"];
                }
                //诉讼结束
                else{
                    self.stateIcon.image = [UIImage imageNamed:@"litigationed"];
                }
                _selectBtn.hidden = YES;
                _mergeBtn.hidden = YES;
                _yuqiIcon.hidden = YES;
                _stateIcon.hidden = NO;
            }
            
            self.nickNameLabel.frame = CGRectMake(_bgIconImg.right+15, 33/2.0, 120, 30.74/2.0);
            self.descriptLabel.frame = CGRectMake(_bgIconImg.right+15, _nickNameLabel.bottom+15/2.0, 120, 23.91/2.0);
            
            
            
            //down
            self.moneyLabel.text = _model.money;
            self.interestLabel.text = _model.interest;
            self.backTimeLabel.text = _model.time;
        }
    }
    
    
    
}



/**
 更新选择按钮状态

 @param current  当前选中按钮index
 @param previous 之前选中按钮index
 */
-(void)updateSelectBtnWithCurrentIndex:(NSInteger)current {
    if (self.selectBtn.tag == current) {
        [_selectBtn setImage:[UIImage imageNamed:@"LitigationSelected"] forState:UIControlStateNormal];
    }
    else
    {
        [_selectBtn setImage:[UIImage imageNamed:@"LitigationUnSelected"] forState:UIControlStateNormal];
    }

}


#pragma mark - Action


/**
 合并诉讼
 */
-(void)MergeLitigation{
    MergeViewController * mergeVC = [[MergeViewController alloc] init];
    mergeVC.loanId = _model.loanID;
    mergeVC.money = [_model.money intValue];

    mergeVC.model = _model;
    [[YXBTool getCurrentNav] pushViewController:mergeVC animated:YES];
}



/**
 当前选中按钮

 @param sender 当前按钮
 */
-(void)selectBtnTouch:(UIButton *)sender{
    _selectBtn.selected = !_selectBtn.selected;
    if (_selectBtn.selected) {
        [_selectBtn setImage:[UIImage imageNamed:@"LitigationSelected"] forState:UIControlStateNormal];//RadioButton-Unselected
        self.backselectBtnIndex(sender.tag);
    }else{
        [_selectBtn setImage:[UIImage imageNamed:@"LitigationUnSelected"] forState:UIControlStateNormal];//RadioButton-Unselected
    }
    
}



#pragma mark - UI
//创建上部的UI
-(void)createUpView{
    UIView *upView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kDeviceWidth, 80-14)];
    //选择按钮
    UIButton * tselectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tselectBtn.frame = CGRectMake(0, 0, 45, 66);
    [tselectBtn addTarget:self action:@selector(selectBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
    [tselectBtn setImage:[UIImage imageNamed:@"LitigationUnSelected"] forState:UIControlStateNormal];//RadioButton-Unselected
    self.selectBtn = tselectBtn;
    
    
    //头像
    UIImageView *tbgIconImg = [[UIImageView alloc] initWithFrame:CGRectMake(45, 9, 48, 48)];
    tbgIconImg.image = [UIImage imageNamed:@"userIconBg"];
    self.bgIconImg = tbgIconImg;
    
    UIImageView *tIconImg = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 44 , 44)];
    self.iconImg = tIconImg;
    
    
    //昵称
    CGFloat nickW = 120;
    UILabel *tNickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_bgIconImg.right+15, 33/2.0, nickW, 30.74/2.0)];
    tNickNameLabel.textColor = [YXBTool colorWithHexString:@"#353535"];
    tNickNameLabel.font = [UIFont systemFontOfSize:15];
    self.nickNameLabel = tNickNameLabel;
    //真实姓名
    UILabel *tDescriptLabel = [[UILabel alloc] initWithFrame:CGRectMake(_bgIconImg.right+15, tNickNameLabel.bottom+15/2.0, nickW, 23.91/2.0)];
    tDescriptLabel.font = [UIFont systemFontOfSize:12];
    tDescriptLabel.textColor = [YXBTool colorWithHexString:@"#8b8b8b"];
    self.descriptLabel = tDescriptLabel;
    
    //状态图片
    UIImageView *tstateIcon = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth-66-16, -3, 66, 66)];
    
    self.stateIcon = tstateIcon;
    
    
    //逾期图片
    UIImageView *tyuqiIcon = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth-55-16-44, 11, 44, 44)];
    tyuqiIcon.image = [UIImage imageNamed:@"yuqiStatus"];
    self.yuqiIcon = tyuqiIcon;

    
    //合并按钮
    UIButton * tmergeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tmergeBtn.frame = CGRectMake(kDeviceWidth - 55, 0, 55, 66);
    [tmergeBtn setTitle:@"合并\n诉讼" forState:UIControlStateNormal];
    [tmergeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tmergeBtn addTarget:self action:@selector(MergeLitigation) forControlEvents:UIControlEventTouchUpInside];
    tmergeBtn.titleLabel.lineBreakMode = 0;
    tmergeBtn.backgroundColor = [YXBTool colorWithHexString:@"#ec2b2d"];
    self.mergeBtn = tmergeBtn;
    
  
    
    [self.contentView addSubview:upView];
    upView.backgroundColor = [UIColor whiteColor];
    [upView addSubview:tbgIconImg];
    [tbgIconImg addSubview:tIconImg];
    [upView addSubview:tNickNameLabel];
    [upView addSubview:tDescriptLabel];
    [upView addSubview:tselectBtn];
    [upView addSubview:tmergeBtn];
    [upView addSubview:tyuqiIcon];
    [upView addSubview:tstateIcon];
}
//创建下部的UI
-(void)createDownView{
    UIView *downBgView = [self createDownBgView];
    downBgView.backgroundColor = [UIColor whiteColor];
    UILabel *tMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, kDeviceWidth/3.0-1-10, 40)];
    tMoneyLabel.textColor = [YXBTool colorWithHexString:@"#ED2E24"];
    tMoneyLabel.textAlignment = NSTextAlignmentCenter;
    self.moneyLabel = tMoneyLabel;
    
    UILabel *tInterestLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/3.0+5, 0, kDeviceWidth/3.0-1-10, 40)];
    tInterestLabel.textColor = [YXBTool colorWithHexString:@"#545454"];
    tInterestLabel.textAlignment = NSTextAlignmentCenter;
    self.interestLabel = tInterestLabel;
    
    UILabel *tBackTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/3.0*2+5, 0, kDeviceWidth/3.0-1-10, 40)];
    tBackTimeLabel.adjustsFontSizeToFitWidth = YES;
    tBackTimeLabel.textColor = [YXBTool colorWithHexString:@"#545454"];
    tBackTimeLabel.textAlignment = NSTextAlignmentCenter;
    self.backTimeLabel = tBackTimeLabel;
    
    [self.contentView addSubview:downBgView];
    [downBgView addSubview:tMoneyLabel];
    [downBgView addSubview:tInterestLabel];
    [downBgView addSubview:tBackTimeLabel];
}
//创建下部的背景框图
-(UIView *)createDownBgView{
    CGFloat h = 60-5;
    UIView *downView = [[UIView alloc] initWithFrame:CGRectMake(0,10+80-14, kDeviceWidth, h)];
    UIView *H1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 1)];
    UIView *H2 = [[UIView alloc] initWithFrame:CGRectMake(0, h-1, kDeviceWidth, 1)];
    UIView *V1 = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/3.0-1, 0, 1, h)];
    UIView *V2 = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/3.0*2-1, 0, 1, h)];
    H1.backgroundColor = rgb(230, 230, 230, 1);
    H2.backgroundColor = rgb(230, 230, 230, 1);
    V1.backgroundColor = rgb(230, 230, 230, 1);
    V2.backgroundColor = rgb(230, 230, 230, 1);
    [downView addSubview:H1];
    [downView addSubview:H2];
    [downView addSubview:V1];
    [downView addSubview:V2];
    NSArray *arr = @[@"借款金额(元)",@"利息(元)",@"还款时间"];
    for (int i = 0; i < 3; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/3.0*i, h-20, kDeviceWidth/3.0, 11)];
        label.text = [arr objectAtIndex:i];
        label.textColor = rgb(173, 173, 173, 1);
        label.font = [UIFont systemFontOfSize:11];
        label.textAlignment = NSTextAlignmentCenter;
        [downView addSubview:label];
        if(i==2){
            self.timeTypeLabel = label;
        }
    }
    return downView;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
