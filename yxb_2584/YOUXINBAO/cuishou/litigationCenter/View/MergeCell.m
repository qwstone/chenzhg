

//
//  MergeCell.m
//  YOUXINBAO
//
//  Created by pro on 2016/12/14.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "MergeCell.h"
#import "UIImageView+WebCache.h"
@interface MergeCell()

@property (weak, nonatomic) UIImageView *   iconImg;//头像


@property (weak, nonatomic) UILabel     *   nickNameLabel;//昵称
@property (weak, nonatomic) UILabel     *   descriptLabel;//还款类型


@property (weak, nonatomic) UIImageView *   overdueImg;//逾期图片


@property (weak, nonatomic) UILabel *moneyLabel;//借款金额
@property (weak, nonatomic) UILabel *interestLabel;//利息
@property (weak, nonatomic) UILabel *backTimeLabel;//还款时间
@property (weak, nonatomic) UILabel *timeTypeLabel;//时间类型




@end

@implementation MergeCell




-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.backgroundColor = [YXBTool colorWithHexString:@"#e8e8e8"];
        
        [self createUpView];
        [self createDownView];
        
        
    }
    return self;
}



-(void)setModel:(OverdueLoanData *)model{

    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:_model.imageUrl] placeholderImage:[UIImage imageNamed:@"useimg"]];
    self.nickNameLabel.text = model.nickName;
    self.descriptLabel.text = model.name;
    //down
    self.moneyLabel.text = model.money;
    self.interestLabel.text = model.interest;
    self.backTimeLabel.text = model.time;

}



-(void)updateSelectBtnWithCellSection:(NSInteger)section SelectArray:(NSMutableArray *)selectedArray andUnSelectArray:(NSMutableArray *)unselectedArray{


    if (section == 0) {
        return;
    }
    
    NSIndexPath * cupath = [NSIndexPath indexPathForRow:_selectBtn.tag-10 inSection:section];

    //更新选中
    if ([selectedArray containsObject:cupath] && selectedArray.count > 0) {
        [_selectBtn setImage:[UIImage imageNamed:@"LitigationSelected"] forState:UIControlStateNormal];//RadioButton-Unselected
    }else{
        [_selectBtn setImage:[UIImage imageNamed:@"LitigationUnSelected"] forState:UIControlStateNormal];//RadioButton-Unselected
    }
    //刷新未选中
    if ([unselectedArray containsObject:cupath] && unselectedArray.count > 0) {
        [_selectBtn setImage:[UIImage imageNamed:@"LitigationUnSelected"] forState:UIControlStateNormal];//RadioButton-Unselected
    }
}


-(void)selectBtnTouch:(UIButton*)sender{
    
    self.backselectBtnIndex(sender.tag);
}



#pragma mark - UI
//创建上部的UI
-(void)createUpView{
    UIView *upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 80-14)];
    //选择按钮
    UIButton * tselectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tselectBtn.frame = CGRectMake(0, 10, 45, 45);
    [tselectBtn addTarget:self action:@selector(selectBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
    [tselectBtn setImage:[UIImage imageNamed:@"LitigationUnSelected"] forState:UIControlStateNormal];//RadioButton-Unselected
    self.selectBtn = tselectBtn;
    
    
    //头像
    UIImageView *bgIconImg = [[UIImageView alloc] initWithFrame:CGRectMake(45, 9, 48, 48)];
    bgIconImg.image = [UIImage imageNamed:@"userIconBg"];
    
    UIImageView *tIconImg = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 44 , 44)];
    self.iconImg = tIconImg;
    
    
    //昵称
    CGFloat nickW = 120;
    UILabel *tNickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(bgIconImg.right+15, 33/2.0, nickW, 30.74/2.0)];
    tNickNameLabel.textColor = [YXBTool colorWithHexString:@"#353535"];
    tNickNameLabel.font = [UIFont systemFontOfSize:15];
    self.nickNameLabel = tNickNameLabel;
    //真实姓名
    UILabel *tDescriptLabel = [[UILabel alloc] initWithFrame:CGRectMake(bgIconImg.right+15, tNickNameLabel.bottom+15/2.0, nickW, 23.91/2.0)];
    tDescriptLabel.font = [UIFont systemFontOfSize:12];
    tDescriptLabel.textColor = [YXBTool colorWithHexString:@"#8b8b8b"];
    self.descriptLabel = tDescriptLabel;
    
    //状态图片
    UIImageView *toverdueImg = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth-66-16, -3, 66, 66)];
    toverdueImg.image = [UIImage imageNamed:@"yuqiStatus"];
    self.overdueImg = toverdueImg;
    
    
    
   
    
    
    
    [self.contentView addSubview:upView];
    upView.backgroundColor = [UIColor whiteColor];
    [upView addSubview:bgIconImg];
    [bgIconImg addSubview:tIconImg];
    [upView addSubview:tNickNameLabel];
    [upView addSubview:tDescriptLabel];
    [upView addSubview:tselectBtn];
    [upView addSubview:toverdueImg];
  
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
    [tBackTimeLabel setAdjustsFontSizeToFitWidth:YES];
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
    UIView *downView = [[UIView alloc] initWithFrame:CGRectMake(0,80-14, kDeviceWidth, h)];
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
