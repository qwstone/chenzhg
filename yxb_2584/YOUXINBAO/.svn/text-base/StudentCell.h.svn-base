//
//  StudentCell.h
//  YOUXINBAO
//
//  Created by Feili on 15/8/29.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCBaseCell.h"
#import "LoginModel.h"
#import "StudentConfig.h"

#define LoginBgColor rgb(80, 171, 162, 1.0)
#define StudentCellContentHeight 50
#define LoginCellLeftAlign 30

typedef void (^onTextfieldEndBlock)(NSString * text);

typedef void (^onTextfieldBeginBlock)();


@interface StudentCell : QCBaseCell

@property(nonatomic,copy)onTextfieldEndBlock textfieldEndBlock;//
@property(nonatomic,copy)onTextfieldBeginBlock textfieldBeginBlock;//
@property(nonatomic,strong)LoginModel *model;
@property(nonatomic,strong)NSMutableArray *pickerViewData;//pickerView数据源
@property(nonatomic, copy)NSString *text;
@property(nonatomic, assign)StudentVerifyStatusType studentType;
@property(nonatomic,strong)UITextField *textfield; //值
@property(nonatomic,strong)id<UITextFieldDelegate>delegate;
@property(nonatomic,assign)NSInteger index;

-(void)setMyTextfieldBeginBlock:(void(^)())beginBlock EndBlock:(void(^)(NSString *text))block;
-(void)editEnable:(BOOL)isEnable;

@end
