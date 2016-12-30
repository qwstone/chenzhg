//
//  AACreatePickerView.m
//  YOUXINBAO
//
//  Created by CH10 on 15/3/25.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AACreatePickerView.h"

@implementation AACreatePickerView {
    UIPickerView *_pickerView;
    NSInteger _currentComponent;
    NSInteger _currentRow;
}

- (id)initWithFrame:(CGRect)frame Component:(NSInteger)component listArr:(NSArray *)arr
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.component = component;
        self.listArray = arr;
        _currentComponent = 0;
        _currentRow = 0;
        
        /*
        UIImageView * sendBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(-1, 0, kDeviceWidth+2, 50)];
        sendBackImage.backgroundColor = [UIColor whiteColor];
        sendBackImage.layer.borderWidth = 1.0;
        sendBackImage.layer.borderColor = [rgb(255, 156, 146, 1) CGColor];
        sendBackImage.userInteractionEnabled = YES;
        [self addSubview:sendBackImage];
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10, 5, kDeviceWidth-20, 40);
        button.backgroundColor = [UIColor clearColor];
        [button setImage:[UIImage imageNamed:@"register_sure.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
        [sendBackImage addSubview:button];

        */
        
        UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 44)];
        UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(showPickerView)];
        
        UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(sureAction:)];
        toolBar.items = [NSArray arrayWithObject:right];
        
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [toolBar setItems:[NSArray arrayWithObjects:flexibleSpace,left,flexibleSpace,flexibleSpace,flexibleSpace,flexibleSpace,flexibleSpace,flexibleSpace,flexibleSpace,flexibleSpace,right,flexibleSpace, nil]];
//        [sendBackImage addSubview:toolBar];
        [self addSubview:toolBar];

        
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, self.width, self.height-50)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_pickerView];
        
        //        self.layer.borderColor = [[UIColor grayColor] CGColor];
        //        self.layer.borderWidth = 1;
    }
    return self;
}

- (void)sureAction:(UIButton *)button {
    [self showPickerView];
    
    NSArray *array = [self.listArray objectAtIndex:_currentComponent];
    NSString *text = [array objectAtIndex:_currentRow];
    
    if (self.selectedBlock != nil) {
        self.selectedBlock(text,self);
    }
}

- (void)showPickerView {
    [UIView animateWithDuration:.5 animations:^{
        if (!_isShow) {
            self.top -= self.height;
        }else {
            self.top += self.height;
        }
    }];
    _isShow = !_isShow;
}

//选中第row列
- (void)selectedRow:(NSInteger)row inComponent:(NSInteger)component {
    [_pickerView selectRow:row inComponent:component animated:NO];
}

#pragma mark - UIPickerView Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.component;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray *array = [self.listArray objectAtIndex:component];
    return array.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 70;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *showLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,0.0f,150.0f,20.0f)];
    showLabel.backgroundColor = [UIColor clearColor];
    showLabel.textAlignment = NSTextAlignmentCenter;
    
    NSArray *array = [self.listArray objectAtIndex:component];
    showLabel.text = [array objectAtIndex:row];
    
    return showLabel;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSArray *array = [self.listArray objectAtIndex:component];
    NSString *text = [array objectAtIndex:row];
    
    _currentComponent = component;
    _currentRow = row;
    
    if (self.selectedBlock != nil) {
        self.selectedBlock(text,self);
    }
    
    if (self.rowBlock != nil) {
        self.rowBlock(row,self);
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
