//
//  ISendPickerView.h
//  YOUXINBAO
//
//  Created by zjp on 15/4/29.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AACreatePickerView.h"


@protocol ISendPickerViewDelegate <NSObject>

- (void)ISendPickerViewOK;

@end
@interface ISendPickerView : AACreatePickerView



@property (nonatomic,assign) BOOL isShowing;
@property (nonatomic,assign) NSInteger row;
@property (nonatomic, assign) id <ISendPickerViewDelegate>delegate;
@end
