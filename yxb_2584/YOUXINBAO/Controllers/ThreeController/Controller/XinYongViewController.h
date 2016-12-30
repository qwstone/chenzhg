//
//  XinYongViewController.h
//  YOUXINBAO
//
//  Created by zjp on 16/2/16.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "KVNProgress.h"
@interface XinYongViewController : QCBaseViewController
@property(nonatomic,copy)NSString *titleName;
- (id)initWithURL:(NSString *)url;
@property(nonatomic,strong)UIActivityIndicatorView   *activity;
@property(nonatomic,strong)UIWebView *webView;
@end
