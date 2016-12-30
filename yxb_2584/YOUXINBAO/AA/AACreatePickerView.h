//
//  AACreatePickerView.h
//  YOUXINBAO
//
//  Created by CH10 on 15/3/25.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCreatePickerCustomHeight 216+30

@class AACreatePickerView;

typedef void (^AACreatePickerViewDidSelectBlock)(NSString *text, AACreatePickerView *createPickerView);
typedef void (^AACreatePickerViewRowBlock)(NSInteger row, AACreatePickerView *createPickerView);

@interface AACreatePickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

/*
 //componen 组数
 //listArr 传入二元数组，每组显示的字符串
 例如:
 NSArray *arr = [NSArray arrayWithObjects:@[@"111",@"222"], @[@"333",@"444"], nil];
 AACreatePickerView *picker = [[AACreatePickerView alloc] initWithFrame:frame Component:2 listArr:arr];
 */
- (id)initWithFrame:(CGRect)frame Component:(NSInteger)component listArr:(NSArray *)arr;

//显示或隐藏Picker
- (void)showPickerView;

//选中第row列
- (void)selectedRow:(NSInteger)row inComponent:(NSInteger)component;

@property (nonatomic,assign) NSInteger component;
@property (nonatomic,strong) NSArray *listArray;

@property (nonatomic,assign) BOOL isShow;

@property (nonatomic,copy) AACreatePickerViewDidSelectBlock selectedBlock;

@property (nonatomic,copy) AACreatePickerViewRowBlock rowBlock;

@end
