//
//  MyLoanListRequireVideoAlert.m
//  YOUXINBAO
//
//  Created by CH10 on 16/3/23.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "MyLoanListRequireVideoAlert.h"

@implementation MyLoanListRequireVideoAlert

{
    BOOL _selected;
}
-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    _titleLabel.text = _titleStr;
}
-(instancetype)initWithFrame:(CGRect)frame delegate:(id<CTAlertViewDelegate>)delegate btnHeight:(CGFloat)btnHeight cancleBtnTitle:(NSString *)cancleBtnTitle otherBtnTitle:(NSArray *)otherBtnTitles{
    self = [super initWithFrame:frame delegate:delegate btnHeight:btnHeight cancleBtnTitle:cancleBtnTitle otherBtnTitle:otherBtnTitles];
    if (self) {
        CGFloat th = kDeviceWidth==320?0:5;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10+20+th, self.contentView.width-30, 23)];
//        titleLabel.text = @"确认同意借钱给小张吗？";
        titleLabel.font = [UIFont systemFontOfSize:18];
        [titleLabel adjustsFontSizeToFitWidth];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, titleLabel.bottom+10+th, self.contentView.width-60, 37)];
        messageLabel.text = @"由于借款金额较高,为保障资金安全,您需要向借款人索要信誉视频";
        messageLabel.textColor = rgb(142, 142, 142, 1);
        messageLabel.numberOfLines = 0;
        messageLabel.font = [UIFont systemFontOfSize:13];
        messageLabel.textAlignment = NSTextAlignmentCenter;
 
        UILabel *videolab=[[UILabel alloc]initWithFrame:CGRectMake(15, messageLabel.bottom+5, self.contentView.width-30, 25)];
        videolab.text = @"向借款人索要视频";
        videolab.textColor = rgb(142, 142, 142, 1);
        videolab.numberOfLines = 0;
        videolab.font = [UIFont systemFontOfSize:13];
        videolab.textAlignment = NSTextAlignmentCenter;

        //是否索要视频
        UIButton *videoRequestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        videoRequestBtn.frame = CGRectMake(15, messageLabel.bottom+5, self.contentView.width-30, 25);
        videoRequestBtn.tag = 2000;
        [videoRequestBtn setImage:[UIImage imageNamed:@"myLoanList_text_click"] forState:UIControlStateSelected];
        [videoRequestBtn setImage:[UIImage imageNamed:@"myLoanList_text_notclick"] forState:UIControlStateNormal];
        [videoRequestBtn addTarget:self action:@selector(videoRequestBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.titleLabel = titleLabel;
        self.messageLabel = messageLabel;
        self.videoRequestBtn = videoRequestBtn;
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.messageLabel];
//        [self.contentView addSubview:videoRequestBtn];
//          [self.contentView addSubview:videolab];
       
    }
    return self;
}
-(void)videoRequestBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    _selected = btn.selected;
    [self.delegat ctAlertVideoBtnSelected:_selected];
}

@end
