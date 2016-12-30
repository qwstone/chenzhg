//
//  CalculatorView.m
//  YOUXINBAO
//
//  Created by zjp on 15/6/1.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "CalculatorView.h"

@implementation CalculatorView {
    UILabel             *money;
    UITextField         *_textFiled1;
    UITextField         *_textFiled2;
    UIView              *bgView;
    UIDynamicAnimator   * _animator;
}



-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.bounds = [[UIApplication sharedApplication].delegate window].bounds;
        self.backgroundColor = rgb(1, 1, 1,0.3);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:tap];
        [self NSNotificationCenters];
        [self createView];
        
    }
    return self;
}

- (void)NSNotificationCenters {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

#pragma mark --- 键盘通知
- (void)keyboardDidShow:(NSNotification *)info
{

    CGRect kebordFrame = [info.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:0.3 animations:^{
        bgView.bottom = kDeviceHeight-kebordFrame.size.height-5
        ;
    } completion:^(BOOL finished) {
        
    }];

}

- (void)keyboardWillHide:(NSNotification *)info
{
   
    [UIView animateWithDuration:0.3 animations:^{
         bgView.center = self.center;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)initCalculatorView {
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
    self.backgroundColor = rgb(1, 1, 1,0.4);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tap];
    [self createView];

}

- (void)createView {
    bgView = [[UIView alloc] initWithFrame:CGRectMake(15, 15, kDeviceWidth-30, (kDeviceWidth-30)*500/570)];
    bgView.userInteractionEnabled = YES;
    bgView.center = self.center;
    bgView.layer.cornerRadius = 5;
//    bgView.alpha = 0;
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    
//    bgView.top = -200;

    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapActions)];
    [bgView addGestureRecognizer:tap];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, bgView.width, bgView.height/570*90)];
    label.textColor = [YXBTool colorWithHexString:@"#323132"];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"计算红包";
    [bgView addSubview:label];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, bgView.height/570*90, bgView.width, 0.5f)];
    lineView.backgroundColor = [YXBTool colorWithHexString:@"#d7d6d7"];
    [bgView addSubview:lineView];
    
    UIImageView *bodView = [[UIImageView alloc] initWithFrame:CGRectMake(bgView.width/570*38, bgView.height/570*144, bgView.width/570*495, bgView.width/570*88)];
//    bodView.image = [UIImage imageNamed:@"js-input"];/
    bodView.layer.cornerRadius = 3;
    bodView.layer.borderWidth = 0.5f;
    bodView.layer.borderColor = [YXBTool colorWithHexString:@"#d7d6d7"].CGColor;
    bodView.userInteractionEnabled = YES;
    bodView.backgroundColor = [UIColor clearColor];
    [bgView addSubview:bodView];
    
    UILabel *tian = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30,20)];
    tian.textColor = [YXBTool colorWithHexString:@"#989496"];
    tian.font = [UIFont systemFontOfSize:15];
    tian.textAlignment = NSTextAlignmentCenter;
    tian.text = @"元";
    UILabel *tian1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30,20)];
    tian1.textColor = [YXBTool colorWithHexString:@"#989496"];
    tian1.font = [UIFont systemFontOfSize:15];
    tian1.textAlignment = NSTextAlignmentCenter;
    tian1.text = @"天";

    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 18)];
    img.image = [UIImage imageNamed:@"bzq-money-icon"];
    img.contentMode = UIViewContentModeScaleAspectFit;
    UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 18)];
    img1.image = [UIImage imageNamed:@"bzq-data-icon"];
    img1.contentMode = UIViewContentModeScaleAspectFit;
    
    _textFiled1 = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, bodView.width/495*295, bodView.height)];
//    _textFiled1.backgroundColor = [UIColor redColor];
    _textFiled1.tag = 10010;
    _textFiled1.delegate = self;
    _textFiled1.textAlignment = NSTextAlignmentRight;
    _textFiled1.keyboardType = UIKeyboardTypeNumberPad;
    _textFiled1.font = [UIFont systemFontOfSize:18];
    _textFiled1.textColor = [YXBTool colorWithHexString:@"#323232"];
    [bodView addSubview:_textFiled1];
    _textFiled1.rightViewMode = UITextFieldViewModeAlways;
    _textFiled1.rightView = tian;
    _textFiled1.leftViewMode = UITextFieldViewModeAlways;
    _textFiled1.leftView = img;
    [_textFiled1 becomeFirstResponder];
    
    _textFiled2 = [[UITextField alloc] initWithFrame:CGRectMake(_textFiled1.right, 0, bodView.width/490*200, bodView.height)];
//    _textFiled2.backgroundColor = [UIColor grayColor];
    _textFiled2.tag = 10086;
    _textFiled2.delegate = self;
    _textFiled2.textAlignment = NSTextAlignmentRight;
    _textFiled2.font = [UIFont systemFontOfSize:18];
    _textFiled2.textColor = [YXBTool colorWithHexString:@"#323232"];
    _textFiled2.keyboardType = UIKeyboardTypeNumberPad;
    [bodView addSubview:_textFiled2];
    _textFiled2.rightViewMode = UITextFieldViewModeAlways;
    _textFiled2.rightView = tian1;
    _textFiled2.leftViewMode = UITextFieldViewModeAlways;
    _textFiled2.leftView = img1;
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake( bodView.width/495*295, 5, 0.4f, bodView.height-10)];
    lineView2.backgroundColor = [UIColor lightGrayColor];
    [bodView addSubview:lineView2];
    
    UILabel *kehuode = [[UILabel alloc] initWithFrame:CGRectMake(bgView.width/570*44, bgView.width/570*250, bgView.width, bgView.height/570*63)];
    kehuode.textColor = [YXBTool colorWithHexString:@"#b1b1b1"];
    kehuode.font = [UIFont systemFontOfSize:15];
    kehuode.textAlignment = NSTextAlignmentLeft;
    kehuode.text = @"可获得红包";
    [bgView addSubview:kehuode];
    
    
    UILabel *yuan = [[UILabel alloc] initWithFrame:CGRectMake(bgView.width/570*44, bgView.width/570*250, 20, bgView.height/570*63)];
    yuan.right = bodView.right;
    yuan.textColor = [YXBTool colorWithHexString:@"#b1b1b1"];
    yuan.font = [UIFont systemFontOfSize:15];
    yuan.textAlignment = NSTextAlignmentRight;
    yuan.text = @"元";
    [bgView addSubview:yuan];
    
    money = [[UILabel alloc] initWithFrame:CGRectMake(bgView.width/570*44, bgView.width/570*254, bgView.width, bgView.height/570*63)];
    money.right = yuan.left;
    money.textColor = [YXBTool colorWithHexString:@"#fd6138"];
    money.font = [UIFont systemFontOfSize:17];
    money.textAlignment = NSTextAlignmentRight;
    [bgView addSubview:money];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(bodView.left, bgView.width/570*317, bgView.width/570*495, bgView.width/570*85)];
    button.layer.cornerRadius = 3;
    [button setBackgroundImage:[UIImage imageNamed:@"jisuan-but"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:button];
    
    
    UILabel *labelbot = [[UILabel alloc] initWithFrame:CGRectMake(bodView.left, bgView.width/570*420, bgView.width/570*482, bgView.width/570*85)];
    labelbot.userInteractionEnabled = YES;
    labelbot.textAlignment = NSTextAlignmentRight;
    labelbot.textColor = [YXBTool colorWithHexString:@"#54b1f4"];
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:@"给无忧借条钱包充值>>"];
    NSRange contentRange = {0, [content length]};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    labelbot.attributedText = content;
    [bgView addSubview:labelbot];
    
    UITapGestureRecognizer *tapchong = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chongzhiTap)];
    [labelbot addGestureRecognizer:tapchong];
//
//    UIDynamicAnimator* animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
//    UIGravityBehavior* gravityBeahvior = [[UIGravityBehavior alloc] initWithItems:@[bgView]];
//    [animator addBehavior:gravityBeahvior];
//    
//    UICollisionBehavior* collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[bgView]];
//    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
//    [animator addBehavior:collisionBehavior];
//    collisionBehavior.collisionDelegate = self;
//    
//    _animator = animator;

//    bgView.transform = CGAffineTransformMakeScale(1.4, 1.4);
//    bgView.alpha = 0;
//    [UIView animateWithDuration:0.2 animations:^{
//        bgView.alpha = 1;
//        bgView.transform = CGAffineTransformIdentity;
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.1 animations:^{
//            bgView.transform = CGAffineTransformMakeScale(1.1, 1.1);
//        } completion:^(BOOL finished) {
//            bgView.transform = CGAffineTransformIdentity;
//        }];
//    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 10010) {
        if (range.location >= 8)
            return NO; // return NO to not change text
        return YES;
    }else if (textField.tag == 10086){
        if (range.location >= 4)
            return NO; // return NO to not change text
        return YES;
    }
    return NO;
}
- (void)buttonAction {
    money.text = [NSString stringWithFormat:@"%.2f",floor([_textFiled1.text floatValue]*[_textFiled2.text floatValue]*[self.lilv floatValue]*100) / 100 ];
    
}

- (void)chongzhiTap {
    if([self.delegate respondsToSelector:@selector(pushChongzhiWebView)]){
        [self.delegate pushChongzhiWebView];
    };
    [self removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)tapActions {
    [self endEditing:YES];
}


- (void)tapAction {
    [self removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)drawRect:(CGRect)rect {

}


@end
