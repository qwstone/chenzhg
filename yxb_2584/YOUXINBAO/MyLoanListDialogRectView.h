//
//  MyLoanListDialogRectView.h
//  YOUXINBAO
//
//  Created by CH10 on 16/2/18.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyLoanListDialogRectView : UIView

@property (nonatomic,copy)NSString *topImgName;
@property (nonatomic,copy)NSString *cenImgName;
@property (nonatomic,copy)NSString *bottomImgName;
@property (nonatomic,assign)NSInteger type;
- (instancetype)initWithFrame:(CGRect)frame andTopImgName:(NSString *)topImgName cenImgName:(NSString *)cenImgName bottomImgName:(NSString *)bottomImgName;
@end
