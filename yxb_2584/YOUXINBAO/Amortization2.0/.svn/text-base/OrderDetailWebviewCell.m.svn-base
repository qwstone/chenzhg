//
//  OrderDetailWebviewCell.m
//  YOUXINBAO
//
//  Created by Feili on 15/9/17.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "OrderDetailWebviewCell.h"


@interface OrderDetailWebviewCell ()<UIWebViewDelegate>

@property (nonatomic,strong)UIWebView *webView;
@property (nonatomic,strong)UIButton *zcxqBtn;
@end
@implementation OrderDetailWebviewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

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
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 1)];
    _webView.delegate = self;
    _webView.scrollView.scrollEnabled = NO;
    [self.contentView addSubview:_webView];
    
    self.zcxqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.zcxqBtn.frame = CGRectMake(kDeviceWidth-65-10, 10, 65, 25);
    [self.zcxqBtn setBackgroundImage:[UIImage imageNamed:@"zcxqbut.png"] forState:UIControlStateNormal];
    [self.zcxqBtn addTarget:self action:@selector(zcxqClick) forControlEvents:UIControlEventTouchUpInside];
    self.zcxqBtn.hidden = YES;
    [self.webView addSubview:self.zcxqBtn];
}
-(void)zcxqClick{
    [self.delegate zcxqBtnClick];
}
-(void)setHtmls:(NSString *)htmls
{
    if (_htmls!=htmls) {
        _htmls = htmls;
    }

    [_webView loadHTMLString:htmls baseURL:nil];
    
}

#pragma mark - UIWebView Delegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //UIDataDetectorTypeNone表示不偵測
    webView.dataDetectorTypes = UIDataDetectorTypeNone;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGRect curFrame = webView.frame;
    NSString *curHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"];
    curFrame.size.height = [curHeight floatValue];
    
    webView.frame = CGRectMake(0, 0, kDeviceWidth, curFrame.size.height);
    self.webviewHeight = curFrame.size.height;
    
    if (_delegate && [_delegate respondsToSelector:@selector(needRefreshTableViewWithHeight:)]) {
        [_delegate needRefreshTableViewWithHeight:self.webviewHeight];
    }
}



@end
