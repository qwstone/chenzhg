//
//  FundDetailCell.m
//  YOUXINBAO
//
//  Created by Feili on 15/12/16.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "FundDetailCell.h"
#import "FundDetailInfoView.h"

@interface FundDetailCell ()

@property (nonatomic,strong)FundDetailInfoView *infoView;
@end

@implementation FundDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    
    return self;
}

-(void)initViews
{
    self.infoView = [[FundDetailInfoView alloc] initWithFrame:ccr(30, 0, kDeviceWidth - 60, 35)];
    [self.contentView addSubview:_infoView];
}

-(void)setModel:(KeyValueModel *)model
{
    if (_model != model) {
        _model = model;
        _infoView.model = _model;
    }
}

-(void)setDetailModel:(ProfitUserBuyDetail *)detailModel
{
    if (_detailModel != detailModel) {
        _detailModel = detailModel;
        _infoView.detailModel = _detailModel;
    }
}

-(void)setDelegate:(id<FundDetailCellDelegate>)delegate
{
    if (_delegate != delegate) {
        _delegate = delegate;
        _infoView.delegate = _delegate;
        
    }
}

@end
