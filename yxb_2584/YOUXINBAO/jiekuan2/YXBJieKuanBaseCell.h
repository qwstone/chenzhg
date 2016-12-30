//
//  YXBJieKuanBaseCell.h
//  YOUXINBAO
//
//  Created by Feili on 16/1/26.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseCell.h"
#import "JieKuanConfig.h"
#import "CustomTextField.h"

@interface YXBJieKuanBaseCell : QCBaseCell
@property (nonatomic,strong)CustomTextField *textField;

@property (nonatomic,assign)id<JieKuanCellDelegate>delegate;
@property (nonatomic,strong)YXBLoan *loan;

-(void)textFieldDidBeginEditing:(UITextField *)textField;


@end
