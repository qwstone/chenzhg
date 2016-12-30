//
//  JieKuanInstance.h
//  YOUXINBAO
//
//  Created by Feili on 16/1/28.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXBLoan.h"
@interface JieKuanInstance : NSObject

@property (nonatomic,strong)YXBLoan *yxbLoan;
//@property (nonatomic,assign)NSInteger hiddenType;  //0——确定按钮  1——顶部切换按钮   2 其它关闭键盘事件

+(instancetype)shareInstance;

@end
