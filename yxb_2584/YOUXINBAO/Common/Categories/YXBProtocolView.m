//
//  YXBProtocolView.m
//  YOUXINBAO
//
//  Created by zjp on 15/7/17.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "YXBProtocolView.h"
#import "YXBTool.h"

@implementation YXBProtocolView

- (id)initWithType:(TYPE)type Frame:(CGRect)frame location:(HORIZONTALALIGNMENT)location {
    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
        self.location = location;
        [self createView];
        [self layoutSubviews];
        [self setlocation];

    }
    return self;
}

- (void)setTongyibutHidden:(BOOL)tongyibutHidden {
    if (_tongyibutHidden != tongyibutHidden) {
        _tongyibutHidden = tongyibutHidden;
    }
    if (_tongyibutHidden == YES) {
        self.tongyi.width = 0;
        self.tongyi.hidden = YES;
        [self setlocation];
    }
}

- (void)setTiaokuanbutHidden:(BOOL)tiaokuanbutHidden {
    if (_tiaokuanbutHidden != tiaokuanbutHidden) {
        _tiaokuanbutHidden = tiaokuanbutHidden;
    }
    if (_tiaokuanbutHidden == YES) {
        self.tiaokuan.width = 0;
        self.tiaokuan.hidden = YES;
        [self setlocation];
    }
}

- (void)setlocation {
    if (self.location == VIEWAlignmentLeft) {
        self.tongyi.left = 0;
    }else if (self.location == VIEWAlignmentCenter) {
        self.tongyi.left = (kDeviceWidth - [self getYXBProtocolViewWidth])/2;
    }else if (self.location == VIEWAlignmentRight) {
        self.tongyi.left = (kDeviceWidth - [self getYXBProtocolViewWidth]);
    }
    self.tiaokuan.left =  self.tongyi.right+5;
    self.tongyitiaokuan.left = self.tiaokuan.right;
    self.bigbut.frame = CGRectMake(self.tongyi.left, 0, self.tongyi.width + self.tiaokuan.width, self.height);
}


- (void)createView {

    //-----------------------条款
    self.tongyi = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 17, 17)];
    [self.tongyi setBackgroundImage:[UIImage imageNamed:@"rightcheck-icon"] forState:UIControlStateNormal];
    [self.tongyi setBackgroundImage:[UIImage imageNamed:@"right-icon"] forState:UIControlStateSelected];
    self.tongyi.tag = 8008;
    self.tongyi.selected = YES;
    [self.tongyi addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.tongyi];


    
    self.tiaokuan = [[UILabel alloc] initWithFrame:CGRectMake(self.tongyi.right, self.tongyi.top, 45, 17)];
    [self.tiaokuan setAdjustsFontSizeToFitWidth:YES];
    self.tiaokuan.text = @"我同意";
    self.tiaokuan.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.tiaokuan];
    
    self.bigbut = [[UIButton alloc] initWithFrame:CGRectMake(self.tongyi.left, 0, self.tongyi.width + self.tiaokuan.width, self.height)];
//    self.bigbut.backgroundColor = [UIColor redColor];
    self.bigbut.tag = 123;
    [self.bigbut addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.bigbut];
    
    self.tongyitiaokuan = [[UIButton alloc] initWithFrame:CGRectMake(self.tiaokuan.right, self.tongyi.top, self.frame.size.width-50, 17)];
    self.tongyitiaokuan.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.tongyitiaokuan setTitle:@"<查看详情>" forState:UIControlStateNormal];
    [self.tongyitiaokuan setTitleColor:rgb(25, 110, 150, 1) forState:UIControlStateNormal];
    self.tongyitiaokuan.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.tongyitiaokuan setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    self.tongyitiaokuan.tag = 8009;
    [self.tongyitiaokuan addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.tongyitiaokuan];
    
}


- (void)setType:(NSInteger)type {
    if (_type != type) {
        _type = type;
        [self setNeedsLayout];
    }
}


- (void)buttonAction:(UIButton *)sender {
    if (sender.tag == 8008 || sender.tag == 123) {
        self.tongyi.selected = !self.tongyi.selected;
        if ([self.delegate respondsToSelector:@selector(checkButton:)]) {
            [self.delegate checkButton:self.tongyi];
        }
    }else if (sender.tag == 8009) {
        if ([self.delegate respondsToSelector:@selector(protocolButton:)]) {
            [self.delegate protocolButton:sender];
        }
        if (self.type == TYPE_TO_USER_REGIN_PROTOCOL) {
            return;
        }
        [YXBTool jumpInnerSafaryWithUrl:[YXBTool getURL:self.urlStr params:nil] hasTopBar:YES titleName:self.webTitle];
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.type == TYPE_TO_TUHAO_CREATE) {
        self.urlStr = @"webView/explain/tuhaoExplain.jsp?";
        self.webTitle = @"土豪白条做土豪说明";
        self.buttonTitle = @"《土豪条款》";
        
    }else if (self.type == TYPE_TO_TUHAO_LOAN) {
        self.urlStr = @"webView/explain/thjiekuanExplain.jsp?t=1";
        self.webTitle = @"土豪白条土豪借款说明";
        self.buttonTitle = @"《白条借款协议》";
        
    }else if (self.type == TYPE_TO_CREDIT_RATING) {
        self.urlStr = @"webView/user/creditLevel.jsp?t=1";
        self.webTitle = @"我的信用等级";
        self.buttonTitle = @"信用说明";
        
    }else if (self.type == TYPE_TO_USER_REGIN_PROTOCOL) {
        self.urlStr = @"webView/explain/userReg.jsp?t=1";
        self.webTitle = @"用户注册协议";
        self.buttonTitle = @"《用户注册协议》";
        
    }else if (self.type == TYPE_TO_Commodity_service_agreement) {
        self.urlStr = @"webView/explain/fenqiExplain.jsp.jsp?t=1";
        self.webTitle = @"信分期分期商品服务协议";
        self.buttonTitle = @"《商品分期服务协议》";
        
    }else if (self.type == TYPE_TO_Treasure_Money_Service) {
        self.urlStr = @"webView/explain/zhuanqianExplain.jsp?t=1";
        self.webTitle = @"宝赚钱服务协议";
        self.buttonTitle = @"宝赚钱说明";
        
    }else if (self.type == TYPE_TO_AA_CREATE) {
        
        self.urlStr = @"webView/explain/aaExplain.jsp?t=1";
        self.webTitle = @"活动聚会发起服务协议";
        self.buttonTitle = @"《活动聚会发起服务协议》";
        
    }else if (self.type == TYPE_TO_AA_INTO) {
        self.urlStr = @"webView/explain/joinAAExplain.jsp?t=1";
        self.webTitle = @"活动聚会参与服务协议";
        self.buttonTitle = @"《活动聚会参与服务协议》";
        
    }else if (self.type == TYPE_TO_WEIYUE) {
        self.urlStr = @"webView/explain/outTimeExplain.jsp?t=1";
        self.webTitle = @"逾期违约说明";
        self.buttonTitle = @"《逾期违约说明》";
        
    }else if (self.type == TYPE_TO_SMILE) {
        self.urlStr = @"webView/explain/smilePromptExplain.jsp?t=1";
        self.webTitle = @"微笑催款协议";
        self.buttonTitle = @"《商品分期服务协议》";
        
    }else if (self.type == TYPE_TO_HAOYOU_JIERU) {
        
//        self.urlStr = @"";
//        self.webTitle = @"好友借入协议";
//        self.buttonTitle = @"好友之间的借款，本站仅提供合法的电子借条和友情提示催款，如未使用友信宝支付还款，本软件不负责债务纠纷。";
        
    }else if (self.type == TYPE_TO_SHANDIAN_JIECHU) {
        self.urlStr = @"webView/explain/shandianExplain.jsp?t=1";
        self.webTitle = @"闪电借出协议";
        self.buttonTitle = @"《向好友闪电借出协议》";
        
    }else if (self.type == TYPE_TO_HIGH_JIECHU) {
        self.urlStr = @"webView/explain/gaojiExplain.jsp?t=1";
        self.webTitle = @"高级借出协议";
        self.buttonTitle = @"《高级借出协议》";
        
    }else if (self.type == TYPE_TO_HOME_SHUOMING) {
        self.urlStr = @"webView/explain/indexExplain.jsp?t=1";
        self.webTitle = @"首页说明";
        self.buttonTitle = @"《首页说明》";
        
    }else if (self.type == TYPE_TO_GERENSHUOMING) {
        self.urlStr = @"webView/explain/personaExplainl.jsp?t=1";
        self.webTitle = @"个人中心说明";
        self.buttonTitle = @"《个人中心说明》";
        
    }else if (self.type == TYPE_TO_QITALICAI) {
        self.urlStr = @"webView/user/otherLicai.jsp?t=1";
        self.webTitle = @"其他理财";
        self.buttonTitle = @"《其他理财》";
    }
    [self.tongyitiaokuan setTitle:self.buttonTitle forState:UIControlStateNormal];
}


- (CGFloat)getYXBProtocolViewWidth {
    CGFloat Width = 0;
    CGSize size = CGSizeMake(99999, 14);
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14], NSFontAttributeName,nil];
    
    size =[self.buttonTitle boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    Width = size.width + self.tongyi.width + self.tiaokuan.width;
    return Width;
}

@end
