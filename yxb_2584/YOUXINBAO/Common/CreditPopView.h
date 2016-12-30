//
//  CreditPopView.h
//  YOUXINBAO
//
//  Created by zjp on 15/10/28.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AAShareView.h"
@interface CreditPopView : UIView <AAShareViewDelegate>

@property(nonatomic,copy)NSString *shareStr;
@property(nonatomic,copy)NSString *shareUrl;

- (id)initWithcreditData:(NSDictionary *)creditData;

- (void)show;
- (void)remove;
@end
