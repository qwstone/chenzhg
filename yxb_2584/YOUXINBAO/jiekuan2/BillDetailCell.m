//
//  BillDetailCell.m
//  YOUXINBAO
//
//  Created by Walice on 16/1/30.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "BillDetailCell.h"
#import "YXBTool.h"

@interface BillDetailCell ()

@property(nonatomic,retain)UIImageView *imgView;
@property(nonatomic,retain)UIImageView *line;
@property(nonatomic,retain)UILabel *leftLabel;
@property(nonatomic,retain)UILabel *rightLabel;
@property(nonatomic,retain)UILabel *rightLabel2;


@end

@implementation BillDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initViews];
    }
    
    return self;
}


- (void)_initViews{
    
    _line=[[UIImageView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_line];

    _imgView=[[UIImageView alloc]initWithFrame:CGRectZero
              ];
    [self.contentView addSubview:_imgView];
    _leftLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_leftLabel];
    _rightLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_rightLabel];
    _rightLabel2=[[UILabel alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_rightLabel2];
    indexLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    [_imgView addSubview:indexLabel];
    


    [self setNeedsLayout];

}
-(void)setIndex:(NSInteger)index{
    _index = index;
    if (self.index!=1) {
        [self drawLineInView:self.contentView AtPoint:CGPointMake(13, 0) AndWidthIs:self.contentView.frame.size.width];
    }
}
- (void)layoutSubviews{
//cell的默认高度是44
    _line.frame=CGRectMake(0, 0, kDeviceWidth-30, 46);
    _imgView.frame=CGRectMake(16, 9.5,25, 25);
    indexLabel.frame=CGRectMake(2.5, 2.5, 20, 20);
    indexLabel.text=[NSString stringWithFormat:@"%ld",(long)self.index];
    indexLabel.textAlignment=NSTextAlignmentCenter;
    indexLabel.font=[UIFont systemFontOfSize:13];
    [indexLabel setAdjustsFontSizeToFitWidth:YES];
    indexLabel.textColor=[YXBTool colorWithHexString:@"#B3B3B3"];
    _leftLabel.frame=CGRectMake(_imgView.right+30, 0, (kDeviceWidth-80)/2-40, 44);
    _leftLabel.font=[UIFont systemFontOfSize:13];
    _leftLabel.textAlignment=NSTextAlignmentCenter;
    _rightLabel.frame=CGRectMake(_leftLabel.right, 0, (kDeviceWidth-80)/2-40, 44);
    _rightLabel.textAlignment=NSTextAlignmentCenter;
    _rightLabel.font=[UIFont systemFontOfSize:12.0];
    _rightLabel2.frame=CGRectMake(_rightLabel.right, 0, 44, 44);
    _rightLabel2.textAlignment=NSTextAlignmentCenter;
    _rightLabel2.numberOfLines=0;
    _rightLabel2.font=[UIFont systemFontOfSize:12.0];
 
   
    
    [super layoutSubviews];

}


-(void)setModel:(LoanMoreInfoDetail *)model{
    
    _model=model;
    if (_model.iconFlag==1) {
        _imgView.image=[UIImage imageNamed:@"MoreInfo_yihuan"];
        indexLabel.hidden=YES;
    }
    else if (_model.iconFlag==2){
    
        _imgView.image=[UIImage imageNamed:@"MoreInfo_yuqi"];
        indexLabel.hidden=YES;
    }
    else if (_model.iconFlag==3){
    
        _imgView.image=[UIImage imageNamed:@"MoreInfo_daihuan"];
        indexLabel.hidden=YES;
    }
    else{
    
        _imgView.image=[UIImage imageNamed:@"MoreInfo_num"];
        indexLabel.hidden=NO;
    }
    _leftLabel.text=_model.leftStr;
    _leftLabel.textColor=[YXBTool colorWithHexString:[NSString stringWithFormat:@"#%@",_model.leftStrRGB]];
    _rightLabel.text=_model.rightStr;
    _rightLabel2.text=_model.rightStr2;
    _rightLabel.textColor=[YXBTool colorWithHexString:[NSString stringWithFormat:@"#%@",_model.rightStrRGB]];
    _rightLabel2.textColor=[YXBTool colorWithHexString:[NSString stringWithFormat:@"#%@",_model.rightStrRGB]];
    _line.image=[UIImage imageNamed:@"morexx-con"];
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


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
