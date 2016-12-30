//
//  HuankuanDetailCell.h
//  YOUXINBAO
//
//  Created by Walice on 16/2/18.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HuankuanDetailDelegate <NSObject>

- (void)buttonDidClick;

@end

@interface HuankuanDetailCell : UITableViewCell

@property(nonatomic,retain)UIButton *button;
@property(nonatomic,assign)id<HuankuanDetailDelegate>delegate;

@end
