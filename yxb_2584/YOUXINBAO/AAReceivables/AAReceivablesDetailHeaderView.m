//
//  AAReceivablesDetailHeaderView.m
//  YOUXINBAO
//
//  Created by Feili on 15/6/21.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AAReceivablesDetailHeaderView.h"
#import "UIImageView+WebCache.h"
#import "AAReceivablesConfig.h"
#import "YXBTool.h"
#import "UIAlertView+Block.h"

#define DateLabelFirst 10
#define DateLabelSecond 52

@interface AAReceivablesDetailHeaderView ()
{
    UIImageView *bgimg;
    UIView *bottomView;
    UILabel *titleLabel;
}

@property(nonatomic,strong)UIImageView *avartarImageView;//头像
@property(nonatomic,strong)UILabel     *userNameLabel;//用户名
@property(nonatomic,strong)UIButton     *closeBtn;//关闭aa收款
@property(nonatomic,strong)UILabel      *dateLabel;//日期
@property(nonatomic,strong)UILabel      *moneyLabel;//共XX人，xx钱
@property(nonatomic,strong)UILabel      *remarkLabel;//备注
@property(nonatomic,strong)UIButton     *bottomBtn;//底部按钮


@end
@implementation AAReceivablesDetailHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)initViews
{

    CGFloat x = 10,y = 15,w = kDeviceWidth/2.0, h = 18;
    titleLabel = [self labelWithFrame:CGRectMake(x, y,w, h) fontSize:(NSInteger)14 textColor:[YXBTool colorWithHexString:@"#2f2f2f"]];

    titleLabel.text = @"收款的时候到了~";
    
//    titleLabel.backgroundColor = [YXBTool generateRandomColor];
    [self addSubview:titleLabel];
    
    //添加关闭AA收款
    w = 80, h = 12;
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _closeBtn.frame = CGRectMake(kDeviceWidth - w - 10, y, 80, h);
    [_closeBtn setTitle:@"关闭AA收款" forState:UIControlStateNormal];
    _closeBtn.titleLabel.font = [UIFont systemFontOfSize:(NSInteger)h];
    [_closeBtn setTitleColor:[YXBTool colorWithHexString:@"#3ea3ff"] forState:UIControlStateNormal];
    [_closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
//    _closeBtn.backgroundColor = [YXBTool generateRandomColor];
    [self addSubview:_closeBtn];
    
    //添加日期显示
    self.dateLabel = [self labelWithFrame:CGRectMake(self.width - 100, 0, 90, 30) fontSize:14 textColor:[YXBTool colorWithHexString:@"#303030"]];
//    _dateLabel.backgroundColor = [UIColor brownColor];
    [self addSubview:_dateLabel];
    
    //添加头像用户名
    y = y + 30,w = 50,h = 50;
//    self.avartarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x,y, w, h)];
    UIImageView *imageView = [self borderImageViewWithImage:[UIImage imageNamed:@"yxblogo_gray.png"] frame:CGRectMake(x,y, w, h)];
    imageView.userInteractionEnabled = YES;
    [self addSubview:imageView];
    
    UIControl *imageAction = [[UIControl alloc] initWithFrame:imageView.bounds];
    [imageAction addTarget:self action:@selector(imageButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:imageAction];

    
    y = y + h + 5;
    h = 12;
    self.userNameLabel = [self labelWithFrame:CGRectMake(x, y, w, h) fontSize:(NSInteger)h textColor:[YXBTool colorWithHexString:@"#303030"]];
//    _userNameLabel.backgroundColor = [YXBTool generateRandomColor];
    _userNameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_userNameLabel];
    
    //添加人数钱数
    y = imageView.top;
    x = x +w + 10;
    w = kDeviceWidth - x - 10;
    bgimg = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, self.height - AAReceivablesDetailHeaderViewBottomHeight - 45)];
    UIImage *chatImage = [UIImage imageNamed:@"AA-chatbg.png"];

    UIImage *newImg= [chatImage resizableImageWithCapInsets:UIEdgeInsetsMake(55, 0, 15, 0) resizingMode:UIImageResizingModeStretch];
    bgimg.image = newImg;
    [self addSubview:bgimg];
    
    x = 20, y = 15,w = bgimg.width - 60, h = 14;
    self.moneyLabel = [self labelWithFrame:CGRectMake(x, y, w, h) fontSize:(NSInteger)h textColor:[YXBTool colorWithHexString:@"#303030"]];
    
//    _moneyLabel.backgroundColor = [UIColor greenColor];
    [bgimg addSubview:_moneyLabel];
    
    //添加备注
    y = y + h + 10, w = bgimg.width - 2 *15, h = 100;
    self.remarkLabel = [self labelWithFrame:CGRectMake(x, y, w, h) fontSize:12 textColor:[YXBTool colorWithHexString:@"#b2acac"]];
    _remarkLabel.numberOfLines = 0;
    _remarkLabel.lineBreakMode = NSLineBreakByCharWrapping;
//    _remarkLabel.backgroundColor = [UIColor
// redColor];
    [bgimg addSubview:_remarkLabel];
    
    //添加高度为150的空档
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, bgimg.bottom + 5, self.width, AAReceivablesDetailHeaderViewBottomHeight)];
    bottomView.backgroundColor = [UIColor clearColor];
    [self addSubview:bottomView];
    
    self.bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _bottomBtn.backgroundColor = rgb(51, 142, 250, 1.0);
    _bottomBtn.frame = CGRectMake((kDeviceWidth-177)/2.0, 22, 177, 70);
    _bottomBtn.layer.cornerRadius = 5.0;
    _bottomBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [_bottomBtn addTarget:self action:@selector(payButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:_bottomBtn];
    
    [self bringSubviewToFront:_dateLabel];
    
//    bottomView.clipsToBounds = YES;
//    if (self.isSelectiend) {
//        self.bottomBtn.hidden=YES;
//        UIView *buttonView=[[UIView alloc]initWithFrame:CGRectMake(0, bgimg.bottom+5, self.width, AAReceivablesDetailHeaderViewBottomHeight)];
//        [bottomView addSubview:buttonView];
//        for (int i=0; i<3; i++) {
//            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
//            button.frame=CGRectMake(10*(i+1)+(kDeviceWidth-40)/3*i, buttonView.origin.y, (kDeviceWidth-40)/3, 180);
//            button.backgroundColor=[UIColor redColor];
//            [buttonView addSubview:button];
//        }
//    }
    
}

- (void)setIsSelectFriend:(BOOL)isSelectFriend{

    _isSelectFriend=isSelectFriend;
    
        if (self.isSelectFriend) {
            self.bottomBtn.hidden=YES;
            bottomView.backgroundColor=[UIColor greenColor];
            bottomView.height=150;
            UIView *buttonView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, AAReceivablesDetailHeaderViewBottomHeight)];
//            buttonView.userInteractionEnabled = NO;
            [bottomView addSubview:buttonView];
            for (int i=0; i<3; i++) {
                UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
                button.frame=CGRectMake(10*(i+1)+(kDeviceWidth-40)/3*i, 0, (kDeviceWidth-40)/3, 150);
                button.tag=1000+i;
                [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
                button.backgroundColor=[UIColor redColor];
                [buttonView addSubview:button];
            }
        }

    
}

- (void)buttonAction:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(ButtonClickDelegate:)]) {
        [self.delegate ButtonClickDelegate:sender.tag];
    }

}

-(void)payButtonClicked
{
    if (_model.state == AAMoneyTotalStateNotPayed) {
        if ([self.delegate respondsToSelector:@selector(payButtonClicked)]) {
            [self.delegate payButtonClicked];
        }

    }
}

-(void)closeAction
{
    if ([self.delegate respondsToSelector:@selector(closeAAPay)]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否关闭AA收款？" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        __weak typeof(self) this = self;
        [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            
            if (buttonIndex == 1) {
                [this.delegate closeAAPay];

            }
        }];
    }

}

-(void)setRemarkHeight:(CGFloat)remarkHeight
{
    _remarkLabel.height = remarkHeight;
}

-(void)setModel:(GatheringRecordDetail *)model
{
    if (_model != model) {
        _model = model;
        [_avartarImageView sd_setImageWithURL:[NSURL URLWithString:_model.imageUrl] placeholderImage:[UIImage imageNamed:@"useimg"]];
        _userNameLabel.text = _model.nickName;
        titleLabel.text = _model.title;
        NSString *moneyText = [NSString stringWithFormat:@"共%ld人,每人%@元",(long)_model.peopleSum,_model.moneyPerPeople];
        
        NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc] initWithString:moneyText];
        [aStr addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#d91d3d"] range:[moneyText rangeOfString:[NSString stringWithFormat:@"%ld",(long)_model.peopleSum]]];
        [aStr addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#d91d3d"] range:[moneyText rangeOfString:_model.moneyPerPeople]];
        _moneyLabel.attributedText = aStr;
        
        _remarkLabel.text = _model.describe;
        
        if(_model.state == AAMoneyTotalStateNotPayed)
        {
            [_bottomBtn setTitle:@"去付款" forState:UIControlStateNormal];
            _bottomBtn.backgroundColor = rgb(129, 189, 117, 1.0);
            [_bottomBtn setImage:[UIImage new] forState:UIControlStateNormal];

        }
        else
        {
            [_bottomBtn setTitle:@"" forState:UIControlStateNormal];
            _bottomBtn.backgroundColor = [UIColor clearColor];
            _bottomBtn.backgroundColor = [UIColor clearColor];
            [_bottomBtn setImage:[UIImage imageNamed:[self nameWithStatusCode:_model.state]] forState:UIControlStateNormal];
            _bottomBtn.userInteractionEnabled = NO;

        }
        [self isShowCloseButton];
        _dateLabel.text = _model.time;
        if (_closeBtn.hidden) {
            _dateLabel.top = DateLabelFirst;
        }
        else
        {
            _dateLabel.top = DateLabelSecond;
        }
        
        
    }
}

//根据状态码获取显示名称
-(NSString *)nameWithStatusCode:(AAMoneyTotalState)code
{
    
    NSString *name = @"";
    switch (code) {
        case AAMoneyTotalStateNone:
        {
            name = @"  ";
        }
            break;
        case AAMoneyTotalStatePaying:
        {
            name = @"AA-dsk-stamp.png";
        }
            break;
        case AAMoneyTotalStateClosed:
        {
            name = @"AA-ygb-stamp.png";
        }
            break;
        case AAMoneyTotalStateAARefund:
        {
            name = @"AA-ytk-stamp.png";
        }
            break;
        case AAMoneyTotalStateOK:
        {
            name = @"AA-ysq-stamp.png";
        }
            break;
        case AAMoneyTotalStateClosedNotPayed:
        {
            name = @"AA-ygb-stamp.png";
        }
            break;
        case AAMoneyTotalStatePayed:
        {
            name = @"AA-payded-stamp.png";
        }
            break;
        case AAMoneyTotalStateNotPayed:
        {
            name = @"AA-wfk-stamp.png";
        }
            break;
        case AAMoneyTotalStateMemberRefund:
        {
            name = @"AA-ytk-stamp.png";
        }
            break;



        default:
            break;
    }
    
    return name;
}

-(void)isShowCloseButton
{
    if ([[YXBTool getUserToken] isEqualToString:_model.creatorToken] &&
        _model.state != AAMoneyTotalStateClosed &&
        _model.state != AAMoneyTotalStateAARefund &&
        _model.state != AAMoneyTotalStateClosed)
    {
            _closeBtn.hidden = NO;
    }
    else
    {
        _closeBtn.hidden = YES;
    }
}

-(UIImageView*)borderImageViewWithImage:(UIImage *)image frame:(CGRect)frame
{
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"expertUserImg.png"]];
    bgImageView.clipsToBounds = YES;
    bgImageView.frame = frame;
    
    CGFloat space = 2;
    
    CGFloat x = space;
    CGFloat y = space-2;
    CGFloat w = frame.size.width - 2 * space;
    CGFloat h = frame.size.height - 2 * space;
    
    self.avartarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    _avartarImageView.layer.cornerRadius = _avartarImageView.width/2;
    _avartarImageView.clipsToBounds = YES;
    _avartarImageView.image = image;
    _avartarImageView.userInteractionEnabled = YES;
    [bgImageView addSubview:_avartarImageView];
    
    return bgImageView;
}


-(void)imageButtonAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(userImageClickedWithUserId:)]) {
        [_delegate userImageClickedWithUserId:_model.userId];
    }
}

@end
