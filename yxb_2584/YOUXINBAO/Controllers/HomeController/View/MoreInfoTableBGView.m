//
//  MoreInfomationFootView.m
//  YOUXINBAO
//
//  Created by Feili on 16/12/21.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "MoreInfoTableBGView.h"
#import "MyLoanViewController.h"
@interface MoreInfoTableBGView()

@end


@implementation MoreInfoTableBGView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initView];
    }
    return self;
}


-(void)initView{
    //借条资金详情
    UIView * detailView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, kDeviceWidth/640*85)];
    detailView.backgroundColor = [UIColor redColor];
    [self addSubview:detailView];
    //标题
    UILabel * detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, self.width/2, kDeviceWidth/640*85)];
    detailLabel.text = @"借条资金详情";
    detailLabel.font = [UIFont boldSystemFontOfSize:15];
    detailLabel.textColor = [UIColor whiteColor];
    [detailView addSubview:detailLabel];
    
    //按钮
    UIImageView * detailBtnIcon = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - kDeviceWidth/640*29 -10, kDeviceWidth/640*28, kDeviceWidth/640*29, kDeviceWidth/640*29)];
    detailBtnIcon.image = [UIImage imageNamed:@"pron"];
    [detailView addSubview:detailBtnIcon];
    
    UILabel * detailBtnLabel = [[UILabel alloc] initWithFrame:CGRectMake(detailBtnIcon.frame.origin.x - 60, 0, 60, kDeviceWidth/640*85)];
    detailBtnLabel.text = @"上一个借条";
    detailBtnLabel.textAlignment = NSTextAlignmentRight;
    detailBtnLabel.font = [UIFont systemFontOfSize:10];
    detailBtnLabel.textColor = [UIColor whiteColor];
    [detailView addSubview:detailBtnLabel];
    
    
    
    UIButton * detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    detailBtn.frame = CGRectMake(detailBtnLabel.frame.origin.x, 0, self.width - detailBtnLabel.frame.origin.x, kDeviceWidth/640*85);
    [detailBtn addTarget:self action:@selector(lastLoanClick) forControlEvents:UIControlEventTouchUpInside];
    [detailView addSubview:detailBtn];
}


-(void)setLoanId:(NSInteger)loanId{
    _loanId = loanId;
}







#pragma mark - ButtonAction
-(void)lastLoanClick{
    MyLoanViewController *myLoanListVC = [[MyLoanViewController alloc] init];
    myLoanListVC.loanID = _loanId;
    [[YXBTool getCurrentNav] pushViewController:myLoanListVC animated:YES];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
