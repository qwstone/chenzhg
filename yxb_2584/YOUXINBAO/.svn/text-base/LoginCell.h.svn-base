//
//  LoginCell.h
//  DiTui
//
//  Created by Feili on 15/5/23.
//  Copyright (c) 2015年 YXBao. All rights reserved.
//

#import "QCBaseCell.h"
#import "LoginModel.h"

#define LoginBgColor rgb(80, 171, 162, 1.0)
#define LoginCellContentHeight 50
#define LoginCellLeftAlign 30

typedef void (^onTextfieldEndBlock)(NSString * text);

typedef void (^onTextfieldBeginBlock)();


@interface LoginCell : QCBaseCell

@property(nonatomic,copy)onTextfieldEndBlock textfieldEndBlock;//
@property(nonatomic,copy)onTextfieldBeginBlock textfieldBeginBlock;//
@property(nonatomic,strong)LoginModel *model;
@property(nonatomic,strong)UITextField *textfield;
@property(nonatomic,strong)NSString *text;

-(void)setMyTextfieldBeginBlock:(void(^)())beginBlock EndBlock:(void(^)(NSString *text))block;

-(void)setSecureText;

-(void)editEnable:(BOOL)isEnable;

/**
 *  @author chenglibin
 *
 *  设置右侧为 选择按钮
 *
 *  @param isNext
 */
-(void)setRightNextImage:(BOOL)isNext;
@end
