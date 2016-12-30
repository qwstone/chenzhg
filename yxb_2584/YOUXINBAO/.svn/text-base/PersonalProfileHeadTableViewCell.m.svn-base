//
//  PersonalProfileHeadTableViewCell.m
//  YOUXINBAO
//
//  Created by CH10 on 15/9/25.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "PersonalProfileHeadTableViewCell.h"
#import "YXBTool.h"
#define RightWidth1 25
#define RightWidth2 32
@implementation PersonalProfileHeadTableViewCell

- (void)awakeFromNib {

}
-(void)setImage2Array:(NSMutableArray *)image2Array{
    _image2Array = image2Array;
    
}
-(void)setUserModel:(QCUserModel *)userModel{
    if (_userModel !=userModel) {
        _userModel = userModel;
        if (userModel.user!=nil) {
            _levelView.stateString = [userModel.user levelFormatWithDesc];
        }
    }
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.image2Array = [[NSMutableArray alloc] init];
        _rownameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 22.5, 200, 20)];
        _rownameLabel.center = CGPointMake(_rownameLabel.center.x, self.center.y);
        _rownameLabel.textColor = [YXBTool colorWithHexString:@"#1B1B1B"];
        _rownameLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_rownameLabel];
        
        if ([reuseIdentifier isEqualToString:@"userImageID"]) {//头像
            
            _rownameLabel.frame = CGRectMake(15, 22.5, 120, 20);
            _userimageView = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth-RightWidth1-50, 5, 48.5, 48.5)];
            if (kDeviceWidth>375) {
                _userimageView = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth-RightWidth2-50, 5, 48.5, 48.5)];
            }
            _userimageView.backgroundColor = [UIColor clearColor];
            _userimageView.layer.masksToBounds = YES;
            _userimageView.layer.cornerRadius = 24.25;
            _userimageView.layer.borderColor = [rgb(200, 200, 200, 1)  CGColor];
//            _userimageView.layer.borderColor = [[UIColor grayColor]  CGColor];
            _userimageView.layer.borderWidth = 2.5;
            [self.contentView addSubview:_userimageView];
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if ([reuseIdentifier isEqualToString:@"wordID"]){//文字
            _detailsLabel = [[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth-RightWidth1-200, 15, 200, 20)];
            if (kDeviceWidth>375) {
                _detailsLabel = [[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth-RightWidth2-200, 15, 200, 20)];
            }
            _detailsLabel.center = CGPointMake(_detailsLabel.center.x,self.center.y);
            _detailsLabel.textAlignment = NSTextAlignmentRight;
            _detailsLabel.textColor = [YXBTool colorWithHexString:@"#959595"];
            _detailsLabel.font = [UIFont systemFontOfSize:13];
            [self.contentView addSubview:_detailsLabel];
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if ([reuseIdentifier isEqualToString:@"imageID"]){//图片1
            _detailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth-RightWidth1-15, 10, 15, 15)];
            if (kDeviceWidth>375) {
                _detailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth-RightWidth2-15, 10, 15, 15)];
            }
            _detailImageView.center = CGPointMake(_detailImageView.center.x, self.center.y);
            [self.contentView addSubview:_detailImageView];
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if ([reuseIdentifier isEqualToString:@"imageID2"]){//图片2
            _levelView = [[YXBLevelView alloc] initWithFrame:CGRectMake(kDeviceWidth-RightWidth1-100, 5, 100, 20)];
            if (kDeviceWidth>375) {
                _levelView = [[YXBLevelView alloc] initWithFrame:CGRectMake(kDeviceWidth-RightWidth1-100, 5, 100, 20)];
            }
            _levelView.center = CGPointMake(_levelView.center.x, self.center.y);
            [self.contentView addSubview:_levelView];
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
