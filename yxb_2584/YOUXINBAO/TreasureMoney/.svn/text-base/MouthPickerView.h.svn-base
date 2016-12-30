//
//  MouthPickerView.h
//  YOUXINBAO
//
//  Created by zjp on 15/9/23.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kTimeCustomHeight 216+30

@class MouthPickerView;

typedef void (^AATimePickerViewDidSelectBlock)(NSInteger year, NSInteger month, NSInteger day, NSInteger hour, NSInteger minIndex, MouthPickerView *timePickerView);
typedef void (^caeclDidSelectBlock)(NSInteger year, NSInteger month, NSInteger day, NSInteger hour, NSInteger minIndex, MouthPickerView *timePickerView);
@interface MouthPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) NSDate *date;

@property (nonatomic,copy) AATimePickerViewDidSelectBlock selectedBlock;
@property (nonatomic,copy) caeclDidSelectBlock caeclSelectBlock;
@property (nonatomic,assign) BOOL isShow;


- (id)initWithFrame:(CGRect)frame withHour:(BOOL)dayOrNo;

//显示或隐藏Picker
- (void)showPickerView;

+ (NSString *)getCurrentTime;
@end
