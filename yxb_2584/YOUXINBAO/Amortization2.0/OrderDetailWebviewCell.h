//
//  OrderDetailWebviewCell.h
//  YOUXINBAO
//
//  Created by Feili on 15/9/17.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseCell.h"

@protocol OrderDetailWebviewCellDelegate <NSObject>

-(void)needRefreshTableViewWithHeight:(NSInteger)height;
-(void)zcxqBtnClick;
@end

@interface OrderDetailWebviewCell : QCBaseCell

@property (nonatomic,strong)NSString *htmls;
@property (nonatomic,assign)CGFloat webviewHeight;
@property (nonatomic,assign)id <OrderDetailWebviewCellDelegate>delegate;
@end
