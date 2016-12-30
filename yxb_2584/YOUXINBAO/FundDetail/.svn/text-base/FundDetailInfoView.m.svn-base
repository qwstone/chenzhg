//
//  FundDetailInfoView.m
//  YOUXINBAO
//
//  Created by Feili on 15/12/16.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "FundDetailInfoView.h"
#import "YXBTool.h"
#import "ProfitUserBuyDetailTips.h"

@interface FundDetailInfoView ()
{
    UIImageView *jiantouImage;
    BOOL isFirstTime;//是否是第一次刷新界面，第一次刷新界面小于两条时默认需要展开
}
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UIButton *valueBtn;
@property (nonatomic, strong)UIView *bottomView;
@property (nonatomic,assign)BOOL isBottomShow;//默认no隐藏

@end

@implementation FundDetailInfoView

-(void)initViews
{

    CGFloat x = 12,y = 0,w = 65, h = 35;
    self.titleLabel = [self labelWithFrame:ccr(x, y, w, h) fontSize:15 textColor:[YXBTool colorWithHexString:@"#808080"]];
    [self addSubview:_titleLabel];
    
    x = _titleLabel.right + 10;
    w = self.width - 2 * _titleLabel.left - _titleLabel.width;
    self.valueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _valueBtn.frame = ccr(x, y, w, h);
    _valueBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _valueBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    _valueBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    _valueBtn.titleLabel.minimumScaleFactor = 8.0/_valueBtn.titleLabel.font.pointSize;
    [_valueBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [_valueBtn setTitleColor:kRGB(38, 38, 38) forState:UIControlStateNormal];
    [self addSubview:_valueBtn];
    
    jiantouImage = [[UIImageView alloc] initWithFrame:ccr(_valueBtn.width - 15, 0, 18, h)];
    jiantouImage.hidden = YES;
    jiantouImage.image = [UIImage imageNamed:@"xiala.png"];
    jiantouImage.contentMode = UIViewContentModeCenter;
//    jiantouImage.transform = CGAffineTransformMakeRotation(3*M_PI/2.0);

    [_valueBtn addSubview:jiantouImage];
    
    
    self.bottomView = [[UIView alloc] initWithFrame:ccr(x, _valueBtn.bottom, w, 0)];
    _bottomView.hidden = YES;
    _bottomView.backgroundColor = [UIColor clearColor];
    [self addSubview:_bottomView];
    
}

-(void)setModel:(KeyValueModel *)model
{
    if (_model != model) {
        _model = model;
        
        _titleLabel.text = _model.key;
        if ([_model.key isEqualToString:@"购买笔数:"]) {
            CGSize size = [YXBTool getFontSizeWithString:_model.value font:_valueBtn.titleLabel.font constrainSize:CGSizeMake(NSIntegerMax, NSIntegerMax)];
            jiantouImage.left = size.width + 5;
            jiantouImage.hidden = NO;
            NSInteger numberOfTips = [_detailModel.iProfitUserBuyDetailTips count];
            if (numberOfTips <= 0) {
                _isBottomShow = YES;
                [self btnAction];

            }else if (numberOfTips > 0 && numberOfTips < 3)
            {
                _isBottomShow = YES;
                [self btnAction];
                
            }
            else
            {
                _isBottomShow = NO;
                [self btnAction];

            }
            isFirstTime = YES;//是否是第一次刷新界面，第一次刷新界面小于两条时默认需要展开


        }
        else
        {
            jiantouImage.hidden = YES;

        }
        if ([_model.key isEqualToString:@"购买金额:"]) {
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:_model.value];
            [str addAttribute:NSForegroundColorAttributeName value:kRGB(223, 39, 39) range:NSMakeRange(0, _model.value.length - 1)];
            [_valueBtn setAttributedTitle:str forState:UIControlStateNormal];
        }
        else
        {
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:_model.value];
            [_valueBtn setAttributedTitle:str forState:UIControlStateNormal];

        }
        
    }
}



-(void)setProfitWithArray:(NSArray *)pArray;
{
    @synchronized(self) {
        if (_bottomView) {
            [[_bottomView subviews]
             makeObjectsPerformSelector:@selector(removeFromSuperview)];
        }
        NSInteger labelHeight = LabelHeight;
        for (int i = 0; i < [pArray count]; i ++) {
            ProfitUserBuyDetailTips *tip = pArray[i];
            UILabel *label = [self labelWithFrame:ccr(0, 0+i*labelHeight, _bottomView.width, labelHeight) fontSize:14 textColor:[YXBTool colorWithHexString:@"#808080"]];
            NSString *text = [NSString stringWithFormat:@"%@    %@元",tip.time,tip.money];
            label.text = text;
            [_bottomView addSubview:label];
        }
        
        _bottomView.height = [pArray count] * labelHeight;
        self.height = 35 + _bottomView.height;

    }
    
}

-(void)btnAction
{
    if ([_model.key isEqualToString:@"购买笔数:"] && _detailModel != nil)
    {

        if (_isBottomShow) {
            _bottomView.hidden = NO;
            jiantouImage.transform = CGAffineTransformMakeRotation(M_PI);

        }
        else
        {
            _bottomView.hidden = YES;
            jiantouImage.transform = CGAffineTransformIdentity;
            for (UIView *view in _bottomView.subviews) {
                [view removeFromSuperview];
            }

        }
        
        if (_isBottomShow) {
            [self setProfitWithArray:_detailModel.iProfitUserBuyDetailTips];

        }

        if (_delegate && [_delegate respondsToSelector:@selector(refreshDataWithBottom:)])
        {
            [_delegate refreshDataWithBottom:_isBottomShow];
        }
        
        self.isBottomShow = !_isBottomShow;

    }
    else
    {
        _bottomView.hidden = YES;

    }
}

@end
