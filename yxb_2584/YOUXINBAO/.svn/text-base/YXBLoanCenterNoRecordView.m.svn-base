//
//  YXBLoanCenterNoRecordView.m
//  YOUXINBAO
//
//  Created by CH10 on 16/2/24.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "YXBLoanCenterNoRecordView.h"
#import "YXBTool.h"
#import "YXBJieKuanController.h"
@interface YXBLoanCenterNoRecordView ()
{
    CGFloat _heightToTop;

}
@property (nonatomic,weak)UIImageView *noRecordImgView;
@property (nonatomic,weak)UILabel *noRecordLabel;
@property (nonatomic,weak)UIButton *quickLoanBtn;//快速借款
@property (nonatomic,weak)UIImageView *infoImgView;

@end

@implementation YXBLoanCenterNoRecordView


-(void)setType:(NSInteger)type{

    _type = type;
    if (_type == 0) {
        _noRecordLabel.text = @"您还没有借款交易，赶紧去玩转借条吧！";
        _quickLoanBtn.hidden = YES;
        _infoImgView.hidden = YES;
    }else if(_type==1){
        _noRecordLabel.text = @"这里没有已还清的借条哦！";
        _quickLoanBtn.hidden = YES;
        _infoImgView.hidden = YES;
    }else if(_type == 2){
        _noRecordLabel.text = @"您还没有借款交易，赶紧去玩转借条吧！";
        _quickLoanBtn.hidden = NO;
        _infoImgView.hidden = NO;
    }
    else if(_type == 5){
        _noRecordLabel.text = @"所有待催收数据都在这了！";
        _quickLoanBtn.hidden = NO;
        _infoImgView.hidden = NO;
    }
    else if(_type == 3){
        _noRecordLabel.text = @"所有待催中收数据都在这了！";
        _quickLoanBtn.hidden = NO;
        _infoImgView.hidden = NO;
    }else if(_type == 4){
        _noRecordLabel.text = @"所有待催收结束数据都在这了！";
        _quickLoanBtn.hidden = NO;
        _infoImgView.hidden = NO;
    }
    else{
        _noRecordLabel.text = @"这里没有失效的数据哦！";
    }
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _heightToTop = (kDeviceHeight==480?75.5-40:75.5);
        
        UIImageView *tNoRecordImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loanCenter_noRecord"]];
        tNoRecordImgView.frame = CGRectMake((self.width-tNoRecordImgView.image.size.width)/2.0+12, _heightToTop, tNoRecordImgView.image.size.width, tNoRecordImgView.image.size.height);
        [self addSubview:tNoRecordImgView];
        self.noRecordImgView = tNoRecordImgView;
        
        UILabel *tNoRecordLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _noRecordImgView.bottom+25, self.width, 23.89/2.0)];
        tNoRecordLabel.textColor = rgb(175, 175, 175, 1);
//        tNoRecordLabel.text = @"您还没有借款提交，赶紧去玩转借条吧！";
        tNoRecordLabel.textAlignment = NSTextAlignmentCenter;
        tNoRecordLabel.font = [UIFont systemFontOfSize:23.89/2.0];
        [self addSubview:tNoRecordLabel];
        self.noRecordLabel = tNoRecordLabel;
        
        NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:27.3/2.0],NSForegroundColorAttributeName:rgb(237, 46, 36, 1),NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        
        NSAttributedString *quickLoanStr = [[NSAttributedString alloc] initWithString:@"快速借款" attributes:dict];
        UIButton *tQuickLoanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tQuickLoanBtn.frame = CGRectMake((self.width-100)/2.0, tNoRecordLabel.bottom+25/2.0, 100, 27.3/2.0);
        [tQuickLoanBtn setAttributedTitle:quickLoanStr forState:UIControlStateNormal];
        [tQuickLoanBtn addTarget:self action:@selector(quickLoanBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tQuickLoanBtn];
        self.quickLoanBtn = tQuickLoanBtn;
        
        UIImageView *tInfoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loanCenter_down"]];
        tInfoImgView.frame = CGRectMake(31/2.0, tQuickLoanBtn.bottom+115/2.0, (self.width-31), tInfoImgView.image.size.height);
        [self addSubview:tInfoImgView];
        self.infoImgView = tInfoImgView;
    }
    return self;
}

-(void)quickLoanBtnClick{
    NSLog(@"快速借款");
    //完善信息
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    if (userModel.user.accountStatus == 0) {
        [self toAuthentication];
        return;
    }
    
    YXBJieKuanController *controller = [[YXBJieKuanController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    [[YXBTool getCurrentNav] pushViewController:controller animated:YES];
}
//完善信息
- (void)toAuthentication {
    
    AuthenticationViewController *authentic = [[AuthenticationViewController alloc] init];
    [[YXBTool getCurrentNav] pushViewController:authentic animated:YES];
}

@end
