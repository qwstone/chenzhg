//
//  JieKuanYongTuCell.m
//  YOUXINBAO
//
//  Created by Feili on 16/1/26.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "JieKuanYongTuCell.h"
#import "AACreatePickerView.h"

@interface JieKuanYongTuCell ()

@property (nonatomic,strong)AACreatePickerView *usedPickerView;
@property (nonatomic,strong)NSArray *dataArray;
@property (nonatomic,strong)UIButton *btn;
@end

@implementation JieKuanYongTuCell

-(void)initViews
{
    self.dataArray = [NSArray arrayWithObjects:@"临时周转",@"交房租",@"消费",@"还信用卡",@"报培训班",@"考驾照",@"其它", nil];

    UILabel *yongtuLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 80, 40)];
    yongtuLabel.text = @"借款用途";
    yongtuLabel.font = [UIFont systemFontOfSize:JieKuanBaseFontSize];
//    yongtuLabel.textColor = kRGB(91, 91, 91);
    [self.contentView addSubview:yongtuLabel];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = ccr(yongtuLabel.right, 0, kDeviceWidth - yongtuLabel.right - 45 - 20, self.height);
    btn.titleLabel.font = [UIFont systemFontOfSize:JieKuanBaseFontSize];
    //    btn.backgroundColor = [UIColor brownColor];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [btn setTitle:self.dataArray[0] forState:UIControlStateNormal];
    [JieKuanInstance shareInstance].yxbLoan.purpose = @"1";
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside]
    ;
    self.btn = btn;
    [self.contentView addSubview:btn];
    
    
    UIImageView *jianImage = [[UIImageView alloc] initWithFrame:ccr(btn.right, btn.top, 20, btn.height)];
    jianImage.image = [UIImage imageNamed:@"next.png"];
    jianImage.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:jianImage];
    
    
//    [self createPickerView];
    
    
}

-(void)btnAction:(UIButton *)sender
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(jiekuanEndEdit)]) {
        [self.delegate jiekuanEndEdit];
        
    }

    [self createPickerView];
//    [_usedPickerView showPickerView];
    
}


-(void)createPickerView
{
    
    if (_usedPickerView == nil) {
        NSArray *array = [NSArray arrayWithObjects:_dataArray, nil];
        __weak typeof(self) weakSelf = self;
        self.usedPickerView = [[AACreatePickerView alloc] initWithFrame:CGRectMake(0, kDeviceHeight + 20, kDeviceWidth, 250) Component:1 listArr:array];
        
        _usedPickerView.rowBlock = ^ (NSInteger row, AACreatePickerView *createPickerView) {
            
            if (row < [_dataArray count]) {
                
                [weakSelf.btn setTitle:weakSelf.dataArray[row] forState:UIControlStateNormal];
                if (self.delegate && [self.delegate respondsToSelector:@selector(updateJieKuanYongTu:)]) {
                    [weakSelf.delegate updateJieKuanYongTu:row];
                }
                
            }
            
        };
        
//        if (_usedPickerView == nil || _usedPickerView.superview == nil)
//        {
        UIWindow *mWindow = [[[UIApplication sharedApplication] delegate] window];
        if (!mWindow.isKeyWindow) {
            [mWindow makeKeyAndVisible];
            
        }
        
        [mWindow addSubview:_usedPickerView];
        [_usedPickerView showPickerView];
            
//        }

    }
    else
    {
        [_usedPickerView showPickerView];
    }

    
}


-(void)setLoan:(YXBLoan *)loan
{
    NSInteger index = [loan.purpose integerValue];
    
    if (index != 0) {
        if (index - 1 >= 0) {
            [self.btn setTitle:_dataArray[index-1] forState:UIControlStateNormal];

        }
    }
    
    
}


@end
