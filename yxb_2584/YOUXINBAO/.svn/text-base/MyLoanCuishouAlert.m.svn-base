//
//  MyLoanCuishouAlert.m
//  YOUXINBAO
//
//  Created by CH10 on 16/4/7.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "MyLoanCuishouAlert.h"
@implementation MyLoanCuishouAlert

{
    BOOL _selected;
}
-(void)setMessageWithLenderName:(NSString*)lenderName BorrowName:(NSString*)borrowName{
    NSMutableAttributedString *attstr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"        %@",lenderName] attributes:@{NSForegroundColorAttributeName:[YXBTool colorWithHexString:@"2f2d32"],NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)}];
    NSMutableAttributedString *attstr2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",borrowName] attributes:@{NSForegroundColorAttributeName:[YXBTool colorWithHexString:@"2f2d32"],NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)}];
    
    NSMutableAttributedString *attstrcen = [[NSMutableAttributedString alloc] initWithString:@"确认使用无忧借条催收服务，拟催回所欠款项，并愿意在催款成功后支付相应佣金。" attributes:@{NSForegroundColorAttributeName:[YXBTool colorWithHexString:@"2f2d32"]}];
    
    [attstrcen insertAttributedString:attstr2 atIndex:16];
    [attstrcen insertAttributedString:attstr1 atIndex:0];
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.lineSpacing = 10;
    [attstrcen addAttribute:NSParagraphStyleAttributeName value:para range:NSRangeFromString(attstrcen.string)];
    _titleLabel.attributedText = attstrcen;
}
-(instancetype)initWithFrame:(CGRect)frame delegate:(id<CTAlertViewDelegate>)delegate btnHeight:(CGFloat)btnHeight cancleBtnTitle:(NSString *)cancleBtnTitle otherBtnTitle:(NSArray *)otherBtnTitles{
    self = [super initWithFrame:frame delegate:delegate btnHeight:btnHeight cancleBtnTitle:cancleBtnTitle otherBtnTitle:otherBtnTitles];
    if (self) {
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, self.contentView.width-30, self.contentView.height -25-self.btnBgView.height-20)];
        //        titleLabel.text = @"确认同意借钱给小张吗？";
        titleLabel.font = [UIFont systemFontOfSize:18];
        titleLabel.numberOfLines = 0;
        [titleLabel adjustsFontSizeToFitWidth];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        
        UIButton *videoRequestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        videoRequestBtn.frame = CGRectMake(15, titleLabel.bottom+5, self.contentView.width-30, 25);
        videoRequestBtn.tag = 2000;
        [videoRequestBtn setImage:[UIImage imageNamed:@"myloan_cuishou_selected"] forState:UIControlStateHighlighted];
        [videoRequestBtn setImage:[UIImage imageNamed:@"myloan_cuishou_selected"] forState:UIControlStateNormal];
        [videoRequestBtn addTarget:self action:@selector(videoRequestBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.titleLabel = titleLabel;
        self.videoRequestBtn = videoRequestBtn;
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.videoRequestBtn];
        self.btnTextColor = rgb(80, 145, 243, 1);
    }
    return self;
}
-(void)videoRequestBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    _selected = btn.selected;
    [self.delegat ctAlertAgreeBtnSelected:_selected];
}


@end
