//
//  LoanConfirmTableViewCell.m
//  YOUXINBAO
//
//  Created by CH10 on 16/1/26.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanConfirmTableViewCell.h"
#import "YXBTool.h"
@interface LoanConfirmTableViewCell ()
@property (nonatomic,weak) UILabel *moneyLabel;//借款金额

@property (nonatomic,weak) UILabel *backTimeLabel;//还款时间
@property (nonatomic,weak) UILabel *durationLabel;//借款时长

@property (nonatomic,weak) UILabel *repayTypeLabel;//还款方式
@property (nonatomic,weak) UILabel *amortizationWayLabel;//分期时长

@property (nonatomic,weak) UILabel *interestLabel;//利息
@property (nonatomic,weak) UILabel *percentLabel;//年化利率

@property (nonatomic,weak) UILabel *loanInfoLabel;//借款说明
@end

@implementation LoanConfirmTableViewCell

//-(void)setLoanRateStr:(NSString *)loanRateStr{
//    _loanRateStr = loanRateStr;
//}
-(void)setModel:(YXBLoan *)model{
    if (_model!=model) {
        _model = model;
        //0
        self.moneyLabel.attributedText = [self attManageStr:_model.money?_model.money:@"0"];
        //1
        self.backTimeLabel.text = _model.backTime;
        self.durationLabel.text = [NSString stringWithFormat:@"借款时长%@天",_model.duration?_model.duration:@"0"];
        //2
        if (_model.repayType == 1){
            self.repayTypeLabel.text = @"分期";
            self.repayTypeLabel.frame = CGRectMake(110, 5, kDeviceWidth-30-44-80, 25);
            self.amortizationWayLabel.hidden = NO;
            self.amortizationWayLabel.text = [NSString stringWithFormat:@"借款时长支持分%ld期",(long)[YXBTool getAmortizationNumWithEndDate:model.backTime]];
            
        }else{//全额
            self.amortizationWayLabel.hidden = YES;
            self.repayTypeLabel.frame = CGRectMake(110, 0, kDeviceWidth-30-44-80, 55);
            self.repayTypeLabel.text = @"全额";
        }
        //3
        if (_model.interestType == 0) {//无息
            self.interestLabel.attributedText = [self attManageStr:@"0"];;
            self.percentLabel.text = @"年化利率0%";//年化利率
        }else{
            self.interestLabel.attributedText = [self attManageStr:_model.interest?_model.interest:@"0"];
            self.percentLabel.text = [NSString stringWithFormat:@"年化利率%@%%",_loanRateStr];//年化利率

//            CGFloat lilv = [YXBTool lilvWithMoney:[_model.money integerValue] timeInterval:[_model.duration integerValue] lixi:[_model.interest integerValue]];
//            self.percentLabel.text = [NSString stringWithFormat:@"年化利率%.1f%%",lilv];//年化利率
        }

        //4
        //1临时周转。 2交房租。3消费。4还信用卡。5报培训班。6考驾照。7其他。
        NSArray *arr = @[@"临时周转",@"交房租",@"消费",
                         @"还款信用卡",@"报培训班",@"考驾照",@"其他"];
        self.loanInfoLabel.text =  [arr objectAtIndex:[_model.purpose integerValue]-1];
    }
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSInteger index = [[reuseIdentifier substringFromIndex:reuseIdentifier.length-1] integerValue];
        [self createCell:index];
    }
    return self;
}
-(void)layoutSubviews{
    self.moneyLabel.textAlignment = NSTextAlignmentRight;

    self.backTimeLabel.textAlignment = NSTextAlignmentRight;
    self.backTimeLabel.font = [UIFont systemFontOfSize:18];
    self.backTimeLabel.textColor = rgb(77, 77, 77, 1);
    
    self.durationLabel.textAlignment = NSTextAlignmentRight;
    self.durationLabel.font = [UIFont systemFontOfSize:13];
    self.durationLabel.textColor = rgb(102, 102, 102, 1);
    
    self.repayTypeLabel.textAlignment = NSTextAlignmentRight;
    self.repayTypeLabel.font = [UIFont systemFontOfSize:18];
    self.repayTypeLabel.textColor = rgb(77, 77, 77, 1);
    
    self.amortizationWayLabel.textAlignment = NSTextAlignmentRight;
    self.amortizationWayLabel.font = [UIFont systemFontOfSize:13];
    self.amortizationWayLabel.textColor = rgb(102, 102, 102, 1);
    
    self.interestLabel.textAlignment = NSTextAlignmentRight;
    
    self.percentLabel.textAlignment = NSTextAlignmentRight;
    self.percentLabel.font = [UIFont systemFontOfSize:13];
    self.percentLabel.textColor = rgb(102, 102, 102, 1);
    
    self.loanInfoLabel.textAlignment = NSTextAlignmentRight;
    self.loanInfoLabel.font = [UIFont systemFontOfSize:18];
    self.loanInfoLabel.textColor = rgb(77, 77, 77, 1);
}
-(void)createCell:(NSInteger)index{
    //创建背景图
    UIView *bgView = [self getBgImgView:index];
    [self.contentView addSubview:bgView];
    
    //创建右侧UI
    switch (index) {
        case 0:{
            UILabel *tMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(105, 0, kDeviceWidth-30-40-80, 50)];
            tMoneyLabel.text = @" 元";
            [bgView addSubview:tMoneyLabel];
            self.moneyLabel = tMoneyLabel;
        }break;
        case 1:{

            UILabel *tBackTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(105, 5, kDeviceWidth-30-40-80, 20)];
            [bgView addSubview:tBackTimeLabel];
            self.backTimeLabel = tBackTimeLabel;
            
            UILabel *tDurationLabel = [[UILabel alloc] initWithFrame:CGRectMake(105, tBackTimeLabel.bottom+3, kDeviceWidth-30-40-80, 20)];
            [bgView addSubview:tDurationLabel];
            self.durationLabel = tDurationLabel;
        }break;
        case 2:{

            UILabel *tRepayTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(105, 5, kDeviceWidth-30-40-80, 20)];
            [bgView addSubview:tRepayTypeLabel];
            self.repayTypeLabel = tRepayTypeLabel;
            
            UILabel *tAmortizationWayLabel = [[UILabel alloc] initWithFrame:CGRectMake(105, 25+5, kDeviceWidth-30-40-80, 20)];
            [bgView addSubview:tAmortizationWayLabel];
            self.amortizationWayLabel = tAmortizationWayLabel;
        }break;
        case 3:{

            UILabel *tInterestLabel = [[UILabel alloc] initWithFrame:CGRectMake(105, 5, kDeviceWidth-30-40-80, 20)];
            [bgView addSubview:tInterestLabel];
            self.interestLabel = tInterestLabel;
            
            UILabel *tPercentLabel = [[UILabel alloc] initWithFrame:CGRectMake(105, 25+5, kDeviceWidth-30-40-80, 20)];
            [bgView addSubview:tPercentLabel];
            self.percentLabel = tPercentLabel;
        }break;
        case 4:{

            UILabel *tLoanInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(105, 0, kDeviceWidth-30-40-80, 55-9)];
            [bgView addSubview:tLoanInfoLabel];
            self.loanInfoLabel = tLoanInfoLabel;
        }break;
        default:
            break;
    }
    
}
//背景View
-(UIView*)getBgImgView:(NSInteger)kind{
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth-30, 55)];
    CGFloat sWidth = bgView.frame.size.width;
    CGFloat sHeight = bgView.frame.size.height;
    
    //创建左侧的背景Label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 80, 55)];
    NSArray *leftArr = @[@"借款金额",@"还款时间",@"还款方式",@"利息",@"借款说明"];
    label.text = [leftArr objectAtIndex:kind];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:17];
    label.textColor = rgb(179, 179, 179, 1);
    
    //创建背景图片
    if (kind == 0) {
        UIImageView *imgtop = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, sWidth, 9)];
        imgtop.image = [UIImage imageNamed:@"qrbgtop_1"];
        [bgView addSubview:imgtop];
        
        UIImageView *imgCon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 9, sWidth, sHeight-9)];
        imgCon.image = [UIImage imageNamed:@"qrbgcon_1"];
        [bgView addSubview:imgCon];
        [self drawLineInView:bgView AtPoint:CGPointMake(15, bgView.frame.size.height-1) AndWidthIs:bgView.frame.size.width-30];

    }else if (kind == 0||kind == 1||kind == 2||kind == 3){
        UIImageView *imgCon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, sWidth, sHeight)];
        imgCon.image = [UIImage imageNamed:@"qrbgcon_1"];
        [bgView addSubview:imgCon];
        [self drawLineInView:bgView AtPoint:CGPointMake(15, bgView.frame.size.height-1) AndWidthIs:bgView.frame.size.width-30];
    }else if(kind==4){
        UIImageView *imgCon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, sWidth, sHeight-9)];
        imgCon.image = [UIImage imageNamed:@"qrbgcon_1"];
        [bgView addSubview:imgCon];
        
        UIImageView *imgFoot = [[UIImageView alloc] initWithFrame:CGRectMake(0, sHeight-9, sWidth, 9)];
        imgFoot.image = [UIImage imageNamed:@"qrbgfoot_1"];
        [bgView addSubview:imgFoot];
        label.center = CGPointMake(label.center.x, label.center.y-4.5);
    }
    [bgView addSubview:label];
    return bgView;
}

//处理str红+黑
-(NSMutableAttributedString*)attManageStr:(NSString*)money{

    NSString *str = [NSString stringWithFormat:@"%@ 元",money];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:rgb(77, 77, 77, 1)}];
    NSRange range = {0,attStr.length-1};
    NSDictionary *dic = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:22],
                          NSForegroundColorAttributeName:rgb(237, 46, 36, 1)};
    [attStr addAttributes:dic range:range];
    return attStr;
}

//画虚线
-(void)drawLineInView:(UIView*)view AtPoint:(CGPoint)point AndWidthIs:(CGFloat)width{
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(point.x, point.y, width, 1)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:line.bounds];
    [shapeLayer setPosition:CGPointMake(line.bounds.size.width/2.0, line.bounds.size.height/2.0)];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    
    // 设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:[rgb(100, 100, 100, 1) CGColor]];
    
    // 0.2f设置虚线的宽度（粗细）
    [shapeLayer setLineWidth:0.2f];
    
    // 3=线的宽度 1=每条线的间距
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:7],
      [NSNumber numberWithInt:2],nil]];
    
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, line.frame.size.width,0);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    [[line layer] addSublayer:shapeLayer];
    [view addSubview:line];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
