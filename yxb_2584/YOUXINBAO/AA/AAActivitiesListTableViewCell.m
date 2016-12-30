//
//  AAActivitiesListTableViewCell.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/3/6.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AAActivitiesListTableViewCell.h"
#import "QCConst.h"
#import "UIImageView+WebCache.h"
#import "YXBTool.h"
#import "CustomBadge.h"
#import "AAFlowImageModel.h"
#import <CoreText/CoreText.h>
@interface AAActivitiesListTableViewCell ()
@property(nonatomic,strong)UILabel *weekLabel;
@property(nonatomic,strong)UIImageView *topImageView; //顶部锯齿背景
@property(nonatomic,strong)UIImageView *bottomImageview; //底部锯齿背景
@property(nonatomic,strong)UIImageView *topRightImageView;//右上角付费图标
@property(nonatomic,strong)UILabel *topRightLabel;//状态
@property(nonatomic,strong)CustomBadge *unReadView;//融云未读提示

@end

@implementation AAActivitiesListTableViewCell

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
        UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth - 2 * AAActivitiesListLeftLeft, 130)];
        bgView.backgroundColor = [UIColor clearColor];
        
        self.topImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [bgView addSubview:_topImageView];
        
        self.bottomImageview = [[UIImageView alloc] initWithFrame:CGRectZero];
        [bgView addSubview:_bottomImageview];

        self.topRightImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [bgView addSubview:_topRightImageView];
        
        self.topRightLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _topRightLabel.font = [UIFont systemFontOfSize:12.0];
        _topRightLabel.backgroundColor = [UIColor clearColor];
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
        UIImageView *imageView = [self borderImageViewWithImage:[UIImage imageNamed:@"yxblogo-gray"] frame:CGRectMake(leftAlign, 42, 78, 78)];
        [bgView addSubview:imageView];
        
        _destNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.origin.x+ imageView.width + 10, 50, kDeviceWidth-130, 16)];
        _destNameLabel.text = @"";
        _destNameLabel.minimumScaleFactor = 8.0/_titleLabel.font.pointSize;
        _destNameLabel.adjustsFontSizeToFitWidth = YES;
        _destNameLabel.font = [UIFont boldSystemFontOfSize:16];
        [bgView addSubview:_destNameLabel];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_destNameLabel.origin.x, _destNameLabel.frame.origin.y + _destNameLabel.height + 15, 150, 14)];
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        [bgView addSubview:_timeLabel];
        
        self.weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(_timeLabel.origin.x + _timeLabel.width, _timeLabel.origin.y, 80, 12)];
        _weekLabel.textColor = [UIColor grayColor];
        _weekLabel.font = [UIFont systemFontOfSize:12];
        
        [bgView addSubview:_weekLabel];
        
        _numberOfPeopleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_destNameLabel.origin.x, _weekLabel.frame.origin.y + _weekLabel.height + 15, 100, 17)];
        _numberOfPeopleLabel.textColor = [UIColor grayColor];
        _numberOfPeopleLabel.font = [UIFont systemFontOfSize:14];
        [bgView addSubview:_numberOfPeopleLabel];
        
        self.unReadView = [CustomBadge customBadgeWithString:@"new" withStyle:[BadgeStyle oldStyle]];
        _unReadView.frame = CGRectMake(bgView.width- 40,32, 40, 20);
        [bgView addSubview:_unReadView];
        _unReadView.hidden = YES;

        [self addSubview:bgView];
    }
    
    return self;
}

-(void)resetViewsWidth
{
#define StateLabelWidth 80
    _titleLabel.width = self.width - StateLabelWidth - 5;
    _titleLabel.superview.width = self.width;
    _numberOfPeopleLabel.width = self.width - _numberOfPeopleLabel.frame.origin.x;
    _topImageView.frame = CGRectMake(0, 0, self.width, 32);
    _bottomImageview.frame = CGRectMake(0, _topImageView.height, self.width, AAActivitiesListTableViewCellHeight - _topImageView.height - 10);
    _bottomImageview.image = [UIImage imageNamed:@"whitesawtooht-bg.png"];
    
    _topRightImageView.frame = CGRectMake(self.width - StateLabelWidth, 0, StateLabelWidth - 10, 32);
    _topRightImageView.contentMode = UIViewContentModeRight;
    _topRightLabel.frame = _topRightImageView.frame;
    _topRightLabel.textAlignment = NSTextAlignmentRight;
    
}

- (void)setTactivity:(AAActivity *)tactivity
{
    if (_tactivity != tactivity) {
        _tactivity = tactivity;
        
        _titleLabel.text = tactivity.topic;
        _weekLabel.text = [tactivity getActivityWeekDay];
        NSString *topRightImageName = @"mian-icon.png";
        if (_tactivity.avgCost > 0) {
            topRightImageName = @"fu-icon.png";
        }
        _topRightImageView.image = [UIImage imageNamed:topRightImageName];
//        if (tactivity.previewPics.count != 0) {
//            [_image setImageWithURL:[NSURL URLWithString:tactivity.previewPics[0]] placeholderImage:[UIImage imageNamed:@"iconDefault.jpg"]];
//            
//        }
        [_image sd_setImageWithURL:[NSURL URLWithString:tactivity.iconPic] placeholderImage:[UIImage imageNamed:@"yxblogo-gray.png"]];
//        NSString *imageJson = tactivity.postWallPics;
//        NSError *error;
//        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
//        NSArray *images = [NSJSONSerialization JSONObjectWithData:[imageJson dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
//        NSDictionary *imageDic = [images firstObject];
//        AAFlowImageModel *imageModel = [[AAFlowImageModel alloc] initWithDic:imageDic];
//        [_image setImageWithURL:[NSURL URLWithString:imageModel.url] placeholderImage:[UIImage imageNamed:@"yxblogo-gray.png"]];

        _destNameLabel.text = [NSString stringWithFormat:@"%@(%@)",tactivity.destName,tactivity.distance];
        _timeLabel.text = tactivity.activityDate;
        
        NSString *peopleText = [NSString stringWithFormat:@"已参加 %ld 人 (上限%ld人)",(long)tactivity.participantsCount,(long)tactivity.capacity];
        //    _numberOfPeopleLabel.text = peopleText;
        NSMutableAttributedString *aText = [[NSMutableAttributedString alloc] initWithString:peopleText];
        //参与人数
        NSString *pCount = [NSString stringWithFormat:@"%ld",(long)tactivity.participantsCount];
        //    [aText addAttribute:(NSString *)kCTForegroundColorAttributeName
        //                        value:(id)((rgb(227, 67, 39, 1.0)).CGColor)
        //                        range:NSMakeRange(3, [pCount length])];
        UIFont *font = [UIFont fontWithName:@"Palatino-Roman" size:17.0];
        NSMutableDictionary *attrsDictionary = [NSMutableDictionary dictionaryWithObject:font                                                                forKey:NSFontAttributeName];
        [attrsDictionary setObject:(rgb(227, 67, 39, 1.0)) forKey:NSForegroundColorAttributeName];
        [aText addAttributes:attrsDictionary range:NSMakeRange(4, [pCount length])];
        _numberOfPeopleLabel.attributedText = aText;
        


    }

}


-(void)setUnReadCount:(NSInteger)unReadCount
{
    _unReadCount = unReadCount;
    //添加融云未读提示
    if (_unReadCount > 0) {
        _unReadView.hidden = NO;
        
    }
    else
    {
        _unReadView.hidden = YES;
    }
    _unReadView.hidden = YES;

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
    _isMine = isMine;
    if (_isMine) {
        NSString *stateText = nil;
        switch (_tactivity.status) {
            case A_CHECKING:
            {
                stateText = @"审核中";
            }
                break;
            case A_REJECTED:
            {
                stateText = @"审核未通过";
            }
                break;
            case A_PASSED:
            {
                stateText = @"未开始";
            }
                break;
            case A_STARTED:
            {
                stateText = @"进行中";
            }
                break;
            case A_CANCELED:
            {
                stateText = @"已取消";
            }
                break;
            case A_FINISHED:
            {
                stateText = @"已结束";
            }
                break;
    
            default:
                break;
        }
        
        
        if (stateText == nil) {
            _topRightImageView.hidden = NO;
            [self loadCostImage];
            
            _topRightLabel.hidden = YES;

        }
        else
        {
            _topRightImageView.hidden = YES;
            _topRightLabel.hidden = NO;
            _topRightLabel.text =  stateText;
        }
        
    }
    else
    {
        _topRightLabel.hidden = YES;
        _topRightImageView.hidden = NO;
        [self loadCostImage];
    }
}

-(void)loadCostImage
{
    NSString *topRightImageName = @"mian-icon.png";
    if (_tactivity.avgCost.floatValue > 0) {
        topRightImageName = @"fu-icon.png";
    }
    _topRightImageView.hidden = NO;
    _topRightImageView.layer.contents = (id)[UIImage imageNamed:topRightImageName].CGImage;
}

-(UIImageView*)borderImageViewWithImage:(UIImage *)image frame:(CGRect)frame
{
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"expertUserImg.png"]];
    bgImageView.clipsToBounds = YES;
    bgImageView.frame = frame;
    
    CGFloat space = 2;
    
    CGFloat x = space;
    CGFloat y = space-1;
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
        UIImage *topImage =  [self imageViewWithIndex:_index];
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




@end
