//
//  AAInformView.h
//  YOUXINBAO
//
//  Created by CH10 on 15/5/21.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AAInformView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *dataArray;

@end
