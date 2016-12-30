//
//  FundDetailInfoView.h
//  YOUXINBAO
//
//  Created by Feili on 15/12/16.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseView.h"
#import "KeyValueModel.h"
#import "ProfitUserBuyDetail.h"

#define LabelHeight 30



@protocol FundDetailCellDelegate <NSObject>

@optional
-(void)refreshDataWithBottom:(BOOL)hasBottom;

@end

@interface FundDetailInfoView : QCBaseView

@property (nonatomic,strong)ProfitUserBuyDetail *detailModel;
@property (nonatomic,strong)KeyValueModel *model;
@property (nonatomic,assign)id<FundDetailCellDelegate>delegate;

@end
