//
//  QCBaseTextField.m
//  YOUXINBAO
//
//  Created by CH10 on 15/3/25.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseTextField.h"

@implementation QCBaseTextField

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addInputAccessoryView:self];
    }
    
    return self;
}

//添加键盘辅助视图
- (void)addInputAccessoryView:(UITextField *)textField {
    UIView *sureView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 49)];
    sureView.backgroundColor = [UIColor whiteColor];
    
    CALayer *upLayer = [CALayer layer];
    upLayer.backgroundColor = [rgb(255, 156, 146, 1) CGColor];
    upLayer.frame = CGRectMake(0, 0, kDeviceWidth, 1);
    [sureView.layer addSublayer:upLayer];
    
    CALayer *downLayer = [CALayer layer];
    downLayer.backgroundColor = [rgb(255, 156, 146, 1) CGColor];
    downLayer.frame = CGRectMake(0, 49-1, kDeviceWidth, 1);
    [sureView.layer addSublayer:downLayer];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"register_sure"] forState:UIControlStateNormal];
    button.frame = CGRectMake((kDeviceWidth-300)/2, (49-40)/2, 300, 40);
    [button addTarget:self action:@selector(closeKeyBoardAction) forControlEvents:UIControlEventTouchUpInside];
    [sureView addSubview:button];
    
    textField.inputAccessoryView = sureView;
}

- (void)closeKeyBoardAction {
    [self.selectedDelegate baseTextFieldSureButtonDidselected:self];
    [self resignFirstResponder];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
