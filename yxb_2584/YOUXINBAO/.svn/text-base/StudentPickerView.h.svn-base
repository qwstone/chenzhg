//
//  StudentPickerView.h
//  YOUXINBAO
//
//  Created by Feili on 15/8/29.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTimeCustomHeight 216+30

@class StudentPickerView;

typedef void (^AATimePickerViewDidSelectBlock)(NSInteger year, NSInteger month, NSInteger day, NSInteger hour, NSInteger minIndex, StudentPickerView *timePickerView);

@interface StudentPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate>

@property (nonatomic,retain) NSDate *date;

@property (nonatomic,copy) AATimePickerViewDidSelectBlock selectedBlock;

@property (nonatomic,assign) BOOL isShow;

@property (nonatomic,strong) NSMutableArray *yearArray;
@property (nonatomic,strong) NSMutableArray *monthArray;

//- (id)initWithFrame:(CGRect)frame withHour:(BOOL)yesOrNo;

//显示或隐藏Picker
- (void)showPickerView;

+ (NSString *)getCurrentTime;

@end
