//
//  SetViewController.h
//  YOUXINBAO
//
//  Created by 张淼 on 15/4/17.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "SetBaseViewController.h"
#import "HttpOperator.h"

@interface SetViewController : SetBaseViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (retain, nonatomic) HttpOperator* iHttpOperator;


@end
