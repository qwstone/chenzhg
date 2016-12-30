//
//  jiekuanPickerView.m
//  YOUXINBAO
//
//  Created by Feili on 16/2/20.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "jiekuanPickerView.h"
#import "NSDate+Helpers.h"

@interface jiekuanPickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic,strong)UIPickerView *pickerView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableArray *selectedArray;
@property (nonatomic,strong)NSDate *date;

@end

@implementation jiekuanPickerView

-(instancetype)initWithFrame:(CGRect)frame dataArray:(NSMutableArray *)dataArray
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.selectedArray = [NSMutableArray arrayWithCapacity:3];
        self.dataArray = dataArray;
        self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_pickerView];

    }
    
    return self;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return 4;
    }else if (component == 1) {
        return 12;
        
    }else if (component == 2){
        
        return [[self.date endOfMonth] getDay];
        
    }
    return 3;
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = @"";
    title = self.dataArray[component][row];
    if (component == 0) {
        title = [NSString stringWithFormat:@"%@年",title];
    }else if (component == 1){
        title = [NSString stringWithFormat:@"%@月",title];
    }else if (component == 2){
        title = [NSString stringWithFormat:@"%@日",title];
    }
    return title;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedArray[component][0] = [NSString stringWithFormat:@"%ld",(long)row];
}



@end
