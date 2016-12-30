//
//  LoanCenterCell.m
//  YOUXINBAO
//
//  Created by Feili on 15/6/30.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanCenterCell.h"
#import "QCConst.h"
#import "UIImageView+WebCache.h"
#import "YXBTool.h"
#import "CustomBadge.h"
#import <CoreText/CoreText.h>

@interface LoanCenterCell ()

@property (nonatomic,retain)UIImageView * image;
@property (nonatomic,retain)UILabel * titleLabel;
@property (nonatomic,retain)UILabel * timeLabel;
@property (nonatomic,strong)UILabel *moneyLabel;
@property (nonatomic,strong)UILabel *stateLabel;//状态是否还款
@property(nonatomic,strong)UIImageView *topImageView; //顶部锯齿背景
@property(nonatomic,strong)UIImageView *bottomImageview; //底部锯齿背景
@property(nonatomic,strong)UILabel *topRightLabel;//状态
@property(nonatomic,strong)UILabel *peopleLabel;//已收齐未收齐 几人

@end
@implementation LoanCenterCell
- (void)setFrame:(CGRect)frame {
    frame.origin.x = AAActivitiesListLeftLeft;
    frame.size.width = frame.size.width - 2*AAActivitiesListLeftLeft;
    
    [super setFrame:frame];
}

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _index = -1;
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth - 2 * AAActivitiesListLeftLeft, 110)];
        bgView.backgroundColor = [UIColor clearColor];
        
        self.topImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [bgView addSubview:_topImageView];
        
        self.bottomImageview = [[UIImageView alloc] initWithFrame:CGRectZero];
        [bgView addSubview:_bottomImageview];
        
        self.topRightLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _topRightLabel.font = [UIFont systemFontOfSize:12.0];
        _topRightLabel.backgroundColor = [UIColor clearColor];
        _topRightLabel.textColor = [UIColor whiteColor];
        [bgView addSubview:_topRightLabel];
        
        NSLog(@"fff = %lf", self.contentView.frame.size.width);
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, self.width, 30)];
        _titleLabel.text =@"";
        _titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.minimumScaleFactor = 8.0/_titleLabel.font.pointSize;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        //        _titleLabel.backgroundColor = [YXBTool generateRandomColor];
        _titleLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:_titleLabel];
        
        
        CGFloat leftAlign = 15;
        UIImageView *imageView = [self borderImageViewWithImage:[UIImage imageNamed:@"useimg"] frame:CGRectMake(leftAlign, 35, 70, 70)];
        [bgView addSubview:imageView];
        
        
        CGFloat x = imageView.right + 20;
        CGFloat y = imageView.top+10,w = 100, h = 20;
        self.moneyLabel = [self labelWithFrame:CGRectMake(x, y, w, h) fontSize:16 minimumScaleFactor:12.0 adjustsFontSizeToFitWidth:NO textColor:rgb(72, 72, 72, 1.0) backgroundColor:[UIColor clearColor]];
        _moneyLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:_moneyLabel];
        
        //添加时间
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_moneyLabel.left,_moneyLabel.bottom+10, _moneyLabel.width, 14)];
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:_timeLabel];
        
        
        //添加状态 已还款 未还款
        _stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth - 120,LoanCenterCellHeight/2.0, 50, 20)];
        _stateLabel.textColor = [UIColor grayColor];
        _stateLabel.font = [UIFont systemFontOfSize:16];
        _stateLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:_stateLabel];

        //添加已收齐未收齐label
        _peopleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_stateLabel.right,_stateLabel.top, 50, 20)];
        _peopleLabel.textColor = [UIColor grayColor];
        _peopleLabel.font = [UIFont systemFontOfSize:13];
        _peopleLabel.backgroundColor = [UIColor clearColor];
        [bgView addSubview:_peopleLabel];

        
        [self addSubview:bgView];
    }
    
    return self;
}

-(void)resetViewsWidth
{
#define StateLabelWidth 80
    _titleLabel.width = self.width - StateLabelWidth - 5;
    _titleLabel.superview.width = self.width;
    _topImageView.frame = CGRectMake(0, 0, self.width, 32);
    _bottomImageview.frame = CGRectMake(0, _topImageView.height, self.width, LoanCenterCellHeight - _topImageView.height - 10);
    _bottomImageview.image = [UIImage imageNamed:@"whitesawtooht-bg.png"];
    
    _topRightLabel.frame = CGRectMake(self.width - StateLabelWidth, 0, StateLabelWidth - 10, 32);
    _topRightLabel.textAlignment = NSTextAlignmentRight;
}


-(void)setModel:(AALoan *)model
{
    if (_model != model) {
        _model = model;
        _titleLabel.text = model.title;
        [_image sd_setImageWithURL:[NSURL URLWithString:_model.imageUrl] placeholderImage:[UIImage imageNamed:@"useimg.png"]];
        _timeLabel.text = _model.time;
        _moneyLabel.text = [NSString stringWithFormat:@"￥ %@",_model.money];
        _topRightLabel.text = [self acitvityStateWithLoanCenterPay:_model.stateOfInitiator];
        _stateLabel.text = [self payStateWithLoanCenterPay:_model.stateOfAmount];
        _stateLabel.textColor = [self colorWithPayState:_model.stateOfAmount];
        if (_model.stateOfInitiator == LoanCenterStateMine) {
            NSString *peopleText = [NSString stringWithFormat:@"(%ld/%ld)",(long)_model.sumPeople,(long)_model.alreadyPayPeople];
            _peopleLabel.text = peopleText;

        }
        else
        {
            _peopleLabel.text = @"";
        }
    }
}


/**
 *  @author chenglibin
 *
 *  如果是我的活动，显示对应的六种状态
 如果不是我的活动显示，付费免费
 *
 *  @return
 */
//我的活动 改变状态的类型
-(void)setIsMine:(BOOL)isMine
{
    
}

-(UIImageView*)borderImageViewWithImage:(UIImage *)image frame:(CGRect)frame
{
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"expertUserImg.png"]];
    bgImageView.clipsToBounds = YES;
    bgImageView.frame = frame;
    
    CGFloat space = 4;
    
    CGFloat x = space;
    CGFloat y = space-2;
    CGFloat w = frame.size.width - 2 * space;
    CGFloat h = frame.size.height - 2 * space;
    
    self.image = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    _image.layer.cornerRadius = _image.width/2;
    _image.clipsToBounds = YES;
    _image.image = image;
    [bgImageView addSubview:_image];
    
    return bgImageView;
}


-(void)setIndex:(NSInteger)index
{
    if(_index != index)
    {
        _index = index;
//        UIImage *topImage =  [self imageViewWithIndex:_index];
        UIImage *topImage = [self imageViewWithAuthor:_model.stateOfInitiator];
        _topImageView.image = topImage;
        _bottomImageview.image = [UIImage imageNamed:@"whitesawtooht-bg.png"];
        
    }
}

-(UIImage *)imageViewWithIndex:(NSInteger)index
{
    NSString *imageName = @"";
    NSInteger newIndex = index%4;
    switch (newIndex) {
        case 0:
        {
            imageName = @"greensawtooht-bg.png";
        }
            
            break;
        case 1:
        {
            imageName = @"yellowsawtooht-bg.png";
        }
            
            break;
            
        case 2:
        {
            imageName = @"pinksawtooht-bg.png";
        }
            
            break;
            
        case 3:
        {
            imageName = @"bluesawtooht-bg.png";
        }
            
            break;
            
            
        default:
            break;
    }
    
    UIImage *image = [UIImage imageNamed:imageName];
    //    UIImage * newImage = [image stretchableImageWithLeftCapWidth:60 topCapHeight:10];
    
    return image;
    
}

-(UIImage *)imageViewWithAuthor:(LoanCenterState)pay
{
    NSString *imageName = @"";
    switch (pay) {
        case LoanCenterStateMine:
        {
            imageName = @"pinksawtooht-bg.png";
        }
            
            break;
        case LoanCenterStateNotMine:
        {
            imageName = @"greensawtooht-bg.png";
        }
            
            break;
        default:
            break;
    }
    
    UIImage *image = [UIImage imageNamed:imageName];
    //    UIImage * newImage = [image stretchableImageWithLeftCapWidth:60 topCapHeight:10];
    
    return image;
    

}

/**
 * 账单状态 1已经还款 2未还款 3已收齐 4未收齐
 */

-(NSString *)payStateWithLoanCenterPay:(LoanCenterPay)pay
{
    NSString *str = @"";
    switch (pay) {
        case LoanCenterPayHasPayed:
        {
            str = @"已付款";
        }
            break;
        case LoanCenterPayNotPayed:
        {
            str = @"未还款";
        }
            break;
        case LoanCenterPayClosed:
        {
            str = @"已关闭";
        }
            break;

        case LoanCenterPayCollected:
        {
            str = @"已收齐";
        }
            break;
        case LoanCenterPayNotCollected:
        {
            str = @"未收齐";
        }
            break;

            
        default:
            break;
    }
    
    return str;
}

/**
 * 账单状态 1我发起的 2我参与的
 */

-(NSString *)acitvityStateWithLoanCenterPay:(LoanCenterState)pay
{
    NSString *str = @"";
    switch (pay) {
        case LoanCenterStateMine:
        {
            str = @"我发起的";
        }
            break;
        case LoanCenterStateNotMine:
        {
            str = @"我参与的";
        }
            break;
        default:
            break;
    }
    
    return str;
}

-(UIColor *)colorWithPayState:(LoanCenterPay)state
{
    UIColor *color = [UIColor blackColor];
    switch (state) {
        case LoanCenterPayCollected:
        case LoanCenterPayHasPayed:
        {
            color = rgb(76, 169, 98, 1.0);
        }
            break;
        case LoanCenterPayNotCollected:
        case LoanCenterPayNotPayed:
        case LoanCenterPayClosed:
        {
            color = rgb(210, 37, 37, 1.0);
        }
            break;

            
        default:
            break;
    }
    
    return color;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
