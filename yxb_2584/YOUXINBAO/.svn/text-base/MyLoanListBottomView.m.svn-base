//
//  MyLoanListBottomView.m
//  YOUXINBAO
//
//  Created by CH10 on 16/2/18.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "MyLoanListBottomView.h"
#import "YXBTool.h"

@interface MyLoanListBottomView ()

@property (nonatomic,weak)UIButton *typeOneBtn;
@property (nonatomic,weak)UIButton *typeSecondBtn0;
@property (nonatomic,weak)UIButton *typeSecondBtn1;
@property (nonatomic,weak)UIView *lineView;
@end

@implementation MyLoanListBottomView

-(void)displayWithBtnIds:(NSArray *)btnIds{
    if (btnIds.count==1) {
        _typeOneBtn.hidden = NO;
        _lineView.hidden = YES;
        _typeSecondBtn0.hidden = YES;
        _typeSecondBtn1.hidden = YES;
        [_typeOneBtn setImage:[UIImage imageNamed:[btnIds objectAtIndex:0]] forState:UIControlStateNormal];
        [_typeOneBtn setImage:[UIImage imageNamed:[btnIds objectAtIndex:0]] forState:UIControlStateHighlighted];
        _typeOneBtn.tag = [[btnIds objectAtIndex:0] integerValue];
    }else if (btnIds.count == 2){
        _typeOneBtn.hidden = YES;
        _typeSecondBtn0.hidden = NO;
        _typeSecondBtn1.hidden = NO;
        _lineView.hidden = NO;
        [_typeSecondBtn0 setImage:[UIImage imageNamed:[btnIds objectAtIndex:0]] forState:UIControlStateNormal];
        [_typeSecondBtn0 setImage:[UIImage imageNamed:[btnIds objectAtIndex:0]] forState:UIControlStateHighlighted];
        _typeSecondBtn0.tag = [[btnIds objectAtIndex:0] integerValue];
        
        [_typeSecondBtn1 setImage:[UIImage imageNamed:[btnIds objectAtIndex:1]] forState:UIControlStateNormal];
        [_typeSecondBtn1 setImage:[UIImage imageNamed:[btnIds objectAtIndex:1]] forState:UIControlStateHighlighted];
        _typeSecondBtn1.tag = [[btnIds objectAtIndex:1] integerValue];

    }
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, self.width, self.height);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.hidden = YES;
        btn.backgroundColor = [YXBTool colorWithHexString:@"#ed2e24"];
        [self addSubview:btn];
        _typeOneBtn = btn;
        
        for (int i = 0; i < 2; i ++) {
            UIButton *btns = [UIButton buttonWithType:UIButtonTypeCustom];
            btns.frame = CGRectMake(i*self.width/2.0, 0, self.width/2.0, self.height);
            [btns addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btns.backgroundColor = [YXBTool colorWithHexString:@"#ed2e24"];
            [self addSubview:btns];
            btns.hidden = YES;
            if (i ==0) {
                _typeSecondBtn0 = btns;
            }else{
                _typeSecondBtn1 = btns;
            }
            
        }
        UIView *vline = [[UIView alloc] initWithFrame:CGRectMake(self.width/2.0-0.5, 0, 1, self.height)];
        vline.backgroundColor = [UIColor whiteColor];
        vline.hidden = YES;
        [self addSubview:vline];
        _lineView = vline;
    }
    return self;
}
//-(MyLoanListBottomView *)initWithFrame:(CGRect)rect andBtnIds:(NSArray*)btnIds{
//    
//    self = [super initWithFrame:rect];
//    if (self) {
//        if (btnIds.count) {
//            self.backgroundColor = [YXBTool colorWithHexString:@"#ed2e24"];
//            if (btnIds.count == 1) {//一个按钮
//                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//                btn.frame = CGRectMake(0, 0, self.width, self.height);
//                [btn setImage:[UIImage imageNamed:[btnIds objectAtIndex:0]] forState:UIControlStateNormal];
//                [btn setImage:[UIImage imageNamed:[btnIds objectAtIndex:0]] forState:UIControlStateHighlighted];
//                [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//                btn.tag = [[btnIds objectAtIndex:0] integerValue];
//                btn.backgroundColor = [YXBTool colorWithHexString:@"#ed2e24"];
//                [self addSubview:btn];
//            }else if(btnIds.count == 2){//两个按钮
//                for (int i = 0; i < 2; i ++) {
//                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//                    btn.frame = CGRectMake(i*self.width/2.0, 0, self.width/2.0, self.height);
//                    [btn setImage:[UIImage imageNamed:[btnIds objectAtIndex:i]] forState:UIControlStateNormal];
//                    [btn setImage:[UIImage imageNamed:[btnIds objectAtIndex:i]] forState:UIControlStateHighlighted];
//                    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//                    btn.tag = [[btnIds objectAtIndex:i] integerValue];
//                    btn.backgroundColor = [YXBTool colorWithHexString:@"#ed2e24"];
//                    [self addSubview:btn];
//                    
//                }
//                UIView *vline = [[UIView alloc] initWithFrame:CGRectMake(self.width/2.0-0.5, 0, 1, self.height)];
//                vline.backgroundColor = [UIColor whiteColor];
//                [self addSubview:vline];
//
//            }
//        }
//
//    }
//    
//    
//    return self;
//}
-(void)btnClick:(UIButton*)btn{
    [self.delegate bottomClickedBtnId:(myLoanListBottomImgCode)btn.tag];
}
@end
