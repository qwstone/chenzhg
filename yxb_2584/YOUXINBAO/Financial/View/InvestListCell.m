//
//  InvestListCell.m
//  YOUXINBAO
//
//  Created by pro on 16/7/25.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "InvestListCell.h"
#import "YXBTool.h"
#import "ZFProgressView.h"
@interface InvestListCell ()

@property (nonatomic, strong) UILabel* assetTitle;//标的标题
@property (nonatomic, strong) UILabel* annualizedReturn;//年化收益
@property (nonatomic, strong) UILabel* limit;//投资期限
@property (nonatomic, strong) UILabel* Amount;//融资金额
@property (nonatomic, strong) UILabel* percentage;//进度百分比

@property (nonatomic, strong) ZFProgressView * probabilityView;
@property (nonatomic, strong) UIImageView    * status;



@end



@implementation InvestListCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [YXBTool colorWithHexString:@"f5f5f5"];
        [self initViews];
    }
    return self;
}
-(void)initViews
{
    //上半部分
    UIView * upView = [[UIView alloc] initWithFrame:CGRectMake(0, 8, kDeviceWidth, 35)];
    upView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:upView];
    //上边分割线
    UIView * upLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 1)];
    upLine.backgroundColor = [YXBTool colorWithHexString:@"#d9d9d9"];
    [upView addSubview:upLine];
    
    //理财标题
    self.assetTitle = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/750*30, upLine.bottom , kDeviceWidth-kDeviceWidth/750*30, 34)];
    _assetTitle.font = [UIFont systemFontOfSize:28*72/96];
    _assetTitle.textColor = [YXBTool colorWithHexString:@"#454545"];
    [upView addSubview:_assetTitle];    
    
    
    //下半部分的label放在一个view中
    UIView * downView = [[UIView alloc] initWithFrame:CGRectMake(0, upView.bottom, kDeviceWidth, 59)];
    downView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:downView];
    
    
    //中间分割线
    UIView * midLine = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/750*30, 0, kDeviceWidth - kDeviceWidth/750*30*2, 1)];
    midLine.backgroundColor = [YXBTool colorWithHexString:@"#d9d9d9"];
    [downView addSubview:midLine];
    
    
    //分成四份   每份长度为
    CGFloat width = kDeviceWidth/4.0;
    //年化收益
    self.annualizedReturn = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, width, 20)];
    _annualizedReturn.textColor = [YXBTool colorWithHexString:@"#FF6600"];
//    _annualizedReturn.backgroundColor = [UIColor orangeColor];
    _annualizedReturn.font = [UIFont systemFontOfSize:30*72/96];
    _annualizedReturn.textAlignment = NSTextAlignmentCenter;
    [downView addSubview:_annualizedReturn];
    
    UILabel * nianhuayilv = [[UILabel alloc] initWithFrame:CGRectMake(0, _annualizedReturn.bottom + 5, width, 15)];
//    nianhuayilv.backgroundColor = [UIColor greenColor];
    nianhuayilv.textColor = [YXBTool colorWithHexString:@"#8C8C8C"];
    nianhuayilv.text = @"预期年化";
    nianhuayilv.textAlignment = NSTextAlignmentCenter;
    nianhuayilv.font = [UIFont systemFontOfSize:22*72/96];
    [downView addSubview:nianhuayilv];
    //间隔线
    UIView * midLine2 = [[UIView alloc] initWithFrame:CGRectMake(_annualizedReturn.right, 4, 1, 50)];
    midLine2.backgroundColor = [YXBTool colorWithHexString:@"#d9d9d9"];
    [downView addSubview:midLine2];

    
    //投资期限
    self.limit = [[UILabel alloc] initWithFrame:CGRectMake(_annualizedReturn.right + 1, 10, width, 20)];
    _limit.textColor = [YXBTool colorWithHexString:@"#333333"];
    _limit.textAlignment = NSTextAlignmentCenter;
    _limit.font = [UIFont systemFontOfSize:30*72/96];
    [downView addSubview:_limit];
    
    UILabel * limitTitle = [[UILabel alloc] initWithFrame:CGRectMake(_annualizedReturn.right + 1, _limit.bottom + 5, width, 15)];
    limitTitle.textColor = [YXBTool colorWithHexString:@"#8C8C8C"];
    limitTitle.text = @"投资期限";
    limitTitle.textAlignment = NSTextAlignmentCenter;
    limitTitle.font = [UIFont systemFontOfSize:22*72/96];
    [downView addSubview:limitTitle];
    //间隔线
    UIView * midLine3 = [[UIView alloc] initWithFrame:CGRectMake(_limit.right, 6, 1, 46)];
    midLine3.backgroundColor = [YXBTool colorWithHexString:@"#d9d9d9"];
    [downView addSubview:midLine3];
    
    //融资金额
    self.Amount = [[UILabel alloc] initWithFrame:CGRectMake(_limit.right + 1, 10, width, 20)];
    _Amount.textColor = [YXBTool colorWithHexString:@"#FF6600"];
    _Amount.textAlignment = NSTextAlignmentCenter;
    [_Amount setAdjustsFontSizeToFitWidth:YES];
    _Amount.font = [UIFont systemFontOfSize:30*72/96];
    [downView addSubview:_Amount];
    
    UILabel * AmountTitle = [[UILabel alloc] initWithFrame:CGRectMake(_limit.right + 1, _limit.bottom + 5, width, 15)];
    AmountTitle.textColor = [YXBTool colorWithHexString:@"#8C8C8C"];
    AmountTitle.text = @"融资规模";
    AmountTitle.textAlignment = NSTextAlignmentCenter;
    AmountTitle.font = [UIFont systemFontOfSize:22*72/96];
    [downView addSubview:AmountTitle];
    //间隔线
    UIView * midLine4 = [[UIView alloc] initWithFrame:CGRectMake(_Amount.right, 4, 1, 50)];
    midLine4.backgroundColor = [YXBTool colorWithHexString:@"#d9d9d9"];
    [downView addSubview:midLine4];
    
    
    
    //环形图
    self.probabilityView = [[ZFProgressView alloc] initWithFrame:CGRectMake(kDeviceWidth-(width-3) + (width-3 - 48)/2, 5, 48, 48)];
    _probabilityView.progressStrokeColor = [YXBTool colorWithHexString:@"#FF6600"];
    _probabilityView.backgroundStrokeColor = [YXBTool colorWithHexString:@"#aaaaaa"];
    _probabilityView.digitTintColor  = [YXBTool colorWithHexString:@"#FF6600"];
    _probabilityView.displayHasFinished = YES;
    [_probabilityView setProgress:0 Animated:NO];
    [downView addSubview:_probabilityView];

    self.status = [[UIImageView alloc] initWithFrame:_probabilityView.frame];
    _status.hidden = YES;
    [downView addSubview:_status];
    
    
    //底部分割线
    UIView * downLine = [[UIView alloc] initWithFrame:CGRectMake(0, downView.frame.size.height-1, kDeviceWidth, 1)];
    downLine.backgroundColor = [YXBTool colorWithHexString:@"#d9d9d9"];
    [downView addSubview:downLine];
    
    
    
    
}

-(void)setModel:(AssetListItem *)model
{
    self.assetTitle.text = model.assetTitle;
    self.annualizedReturn.attributedText = [self SetLabelttributedString:model.annualizedReturn andUnit:@"%"];
    self.limit.attributedText = [self SetLabelttributedString:model.limit andUnit:@"天"];
    self.Amount.attributedText = [self SetLabelttributedString:model.totalMoney andUnit:@"万"];
    self.percentage.text = model.percentage;
    
    if ([model.status isEqualToString:@"0"]) {
        _probabilityView.hidden = NO;
        _status.hidden = YES;
        [_probabilityView setProgress: [model.percentage floatValue]/100.0 Animated:NO];
    }
    else if ([model.status isEqualToString:@"1"]){
        _probabilityView.hidden = YES;
        _status.hidden = NO;
        _status.image = [UIImage imageNamed:@"sellout"];
    }
    else if ([model.status isEqualToString:@"2"]){
        _probabilityView.hidden = YES;
        _status.hidden = NO;
        _status.image = [UIImage imageNamed:@"Clearing"];
    }
    
}




//设置单位
- (NSMutableAttributedString *)SetLabelttributedString:(NSString *)Labelstr andUnit:(NSString *)unit
{
    NSMutableString * str = [[NSMutableString alloc] initWithString:Labelstr];
    [str appendString:unit];
    
    
    NSMutableAttributedString* attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
    //设置单位颜色
    NSRange  range = NSMakeRange(str.length-1, 1);
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:range];
    //设置单位大小
    [attributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"ArialMT" size:13] range:range];
    
    return attributedStr;
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
