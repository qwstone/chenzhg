//
//  AADetailTwoSectionTableViewCell.m
//  YOUXINBAO
//
//  Created by zjp on 15/5/11.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AADetailTwoSectionTableViewCell.h"

@implementation AADetailTwoSectionTableViewCell {

    AADetailsSecondView * secondView;
}

- (void)awakeFromNib {

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.clipsToBounds = YES;
        secondView = [[AADetailsSecondView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 0)];
        [self.contentView addSubview:secondView];
    }
    return self;
}

- (void)setVc:(UIViewController *)vc {
    _vc = vc;

    secondView.vc = vc;
}


- (void)setActivityModel:(AAActivity *)activityModel {

    if (_activityModel != activityModel) {
        _activityModel = activityModel;
        [secondView setActivityModel:_activityModel];
    }

}
@end
