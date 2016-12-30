//
//  YXBJieKuanBaseCell.m
//  YOUXINBAO
//
//  Created by Feili on 16/1/26.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "YXBJieKuanBaseCell.h"
#import "DashLine.h"
#import "YXBTool.h"

@interface YXBJieKuanBaseCell ()
{
    UIImageView *bgImage;
    DashLine *vline;
}
@end
@implementation YXBJieKuanBaseCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier width:(CGFloat)width height:(CGFloat)height
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.contentView.backgroundColor = [UIColor brownColor];

        bgImage = [[UIImageView alloc] initWithFrame:ccr(0, 0, kDeviceWidth - 30, height)];
        UIImage *image = [UIImage imageNamed:@"JieKuanbgcon.png"];
//        image = [image stretchableImageWithLeftCapWidth:60 topCapHeight:6];
        bgImage.height = [YXBTool heightWithSize:image.size width:bgImage.width];
        bgImage.image = image;
        [self.contentView addSubview:bgImage];
        self.backgroundColor = [UIColor clearColor];
        
        //添加虚线
        vline = [[DashLine alloc] initWithFrame:CGRectMake(15, self.height - 1, self.width - 35, 1)];
        vline.dashColor = [UIColor lightGrayColor];
        [self.contentView addSubview:vline];
        
        [self initViews];
        

    }
    
    return self;
    
}

-(void)layoutSubviews
{
    bgImage.height = self.height;
    vline.frame = ccr(15, self.height - 1, self.width - 35, 1);
    [super layoutSubviews];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    textField.layer.borderColor = [[UIColor clearColor]CGColor];
    
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 44)];
    //        UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonItem target:self action:@selector(dodo)];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(keyBtnAction:)];
            toolBar.items = [NSArray arrayWithObject:right];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:flexibleSpace, right, nil]];
    textField.inputAccessoryView = toolBar;
    
    /*
    UIImageView * sendBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(-1, 0, kDeviceWidth+2, 50)];
    sendBackImage.backgroundColor = [UIColor whiteColor];
    CALayer * lineup = [CALayer layer];
    lineup.backgroundColor = [rgb(255, 156, 146, 1) CGColor];
    lineup.frame = CGRectMake(0, 0, sendBackImage.width, 1);
    [sendBackImage.layer addSublayer:lineup];
    
    CALayer * linedown = [CALayer layer];
    linedown.backgroundColor = [rgb(255, 156, 146, 1) CGColor];
    linedown.frame = CGRectMake(0, sendBackImage.height-1, sendBackImage.width, 1);
    [sendBackImage.layer addSublayer:linedown];
    sendBackImage.userInteractionEnabled = YES;
    [self createButtonWithframe:CGRectMake(10, 5, kDeviceWidth-20, 40) withImage:@"register_sure.png" withView:sendBackImage withTarget:self withAcation:@selector(keyBtnAction:) withTag:111];
    textField.inputAccessoryView = sendBackImage;
    */
}

-(void)keyBtnAction:(UIButton *)sender
{
    [self.textField resignFirstResponder];
    
}

//创建UIButton
- (void)createButtonWithframe:(CGRect)btnframe withImage:(NSString *)image withView:(UIView *)cview withTarget:(id)t withAcation:(SEL)s withTag:(NSInteger)tag
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = btnframe;
    button.backgroundColor = [UIColor clearColor];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button addTarget:t action:s forControlEvents:UIControlEventTouchUpInside];
    button.tag = tag;
    //    [button setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    button.adjustsImageWhenHighlighted = NO;
    
    [cview addSubview:button];
}


@end
