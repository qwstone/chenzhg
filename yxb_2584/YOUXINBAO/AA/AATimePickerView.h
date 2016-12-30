//
//  AATimePickerView.h
//  YOUXINBAO
//
//  Created by CH10 on 15/3/25.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTimeCustomHeight 216+30

@class AATimePickerView;

typedef void (^AATimePickerViewDidSelectBlock)(NSInteger year, NSInteger month, NSInteger day, NSInteger hour, NSInteger minIndex, AATimePickerView *timePickerView);

@interface AATimePickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate>

@property (nonatomic,retain) NSDate *date;

@property (nonatomic,copy) AATimePickerViewDidSelectBlock selectedBlock;

@property (nonatomic,assign) BOOL isShow;


- (id)initWithFrame:(CGRect)frame withHour:(BOOL)yesOrNo;

//显示或隐藏Picker
- (void)showPickerView;

+ (NSString *)getCurrentTime;


@end
