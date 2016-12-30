//
//  CTreasureMoneyNewCell.h
//  YOUXINBAO
//
//  Created by zjp on 15/12/15.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfitHomeDataV3.h"
#import "SelectView.h"
#import "CalculatorViewNew.h"
#import "PayHomeViewController.h"
#define bottomHight         (kDeviceWidth/600*90+10)
@protocol CTreasureMoneyNewCellDelegate <NSObject>
@optional

-(void)CTreasureMoneyNewCell:(NSInteger)index;

-(void)chongzhi;
@end
@interface CTreasureMoneyNewCell : UITableViewCell <SelectViewDelegate,CalculatorViewNewDelegate>{
    CalculatorViewNew  *_jisuanview;
}
@property(nonatomic,strong)ProfitHomeDataV3       *model;
@property (nonatomic,assign)id<CTreasureMoneyNewCellDelegate>delegate;
@end