//
//  GongGaoView.h
//  YOUXINBAO
//
//  Created by zjp on 16/2/17.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBAutoScrollLabel.h"
@interface GongGaoView : UIView<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)NSMutableArray   *DataArray;
@property(nonatomic,strong)UITableView       *HomeLiseTableView;//滑动列表


@end
