//
//  MyLoanListDialogBgView.m
//  YOUXINBAO
//
//  Created by CH10 on 16/2/16.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "MyLoanListDialogBgView.h"
#import "YXBLoanChat.h"
#define sWidth self.frame.size.width
#define sHeight self.frame.size.height
#define toBottomHeight 30.0
#define tableViewWidth 265.0
#define UItextView_Placeholder  @"请选择不同模板语境"

@interface MyLoanListDialogBgView ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate>
{
    UIView *_bgView;
}

@property (nonatomic,assign)NSInteger index;
@property (nonatomic,weak)UIImageView *imgTop;
@property (nonatomic,weak)UIImageView *imgCon;




@property (nonatomic, assign) CGFloat inputHeight;



//@property (nonatomic,weak)UIImageView *imgFooter;
@end

@implementation MyLoanListDialogBgView


-(void)setIndex:(NSInteger)index{
    if (_index !=index) {
        _index = index;
      
    }
}
-(void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    [_myTableView reloadData];
}
-(void)updateRectViewWithFrame:(CGRect)frame{
    CGFloat sw = frame.size.width;
    CGFloat sh = frame.size.height;
    _imgTop.frame = CGRectMake(0, 0, sw, 9);
    _imgCon.frame = CGRectMake(0, 9, sw, sh-9-57/2.0);
    _dialogBtn.frame = CGRectMake(0, 0, 75, 57.0/2);
    _rectView.frame = CGRectMake(0, sh-57.0/2, sw, 57.0/2);
    _sendBtn.frame = CGRectMake(sw-62, 0, 62, 57.0/2);
    _bgView.frame = CGRectMake(2, self.height-toBottomHeight+2, tableViewWidth, 0);
    _myTableView.frame = CGRectMake(2, self.height-toBottomHeight+2, tableViewWidth, 0);
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //注册键盘通知
        [self registerForKeyboardNotifications];
        _chatType = 1;
        _caninput = 3;
        _inputHeight = 30.5;
        _myTableViewHidd = YES;
        _dataArray = [[NSMutableArray alloc] init];
        _index = 0;
        //创建背景图片
        UIImageView *imgtop = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, sWidth, 9)];
        imgtop.image = [UIImage imageNamed:@"qrbgtop"];
        self.imgTop = imgtop;
        [self addSubview:imgtop];
        
        UIImageView *imgCon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 9, sWidth, sHeight-9-57/2.0)];
        imgCon.image = [UIImage imageNamed:@"qrbgcon"];
        self.imgCon = imgCon;
        [self addSubview:imgCon];
        
        
        UIView *rectView = [[UIView alloc] initWithFrame:CGRectMake(0, sHeight-57.0/2, sWidth, 57.0/2)];
        rectView.layer.borderColor = rgb(215, 215, 215, 1).CGColor;
//        rectView.layer.borderWidth = 1;
        self.rectView = rectView;
        [self addSubview:rectView];
        
        UIButton *dialogBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        dialogBtn.frame = CGRectMake(0, 0, 75, 57.0/2);
        [dialogBtn setBackgroundImage:[UIImage imageNamed:@"MyLoanList_dialog"] forState:UIControlStateNormal];
        [dialogBtn addTarget:self action:@selector(dialogBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.dialogBtn = dialogBtn;
        [self.rectView addSubview:dialogBtn];
        
        UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sendBtn.frame = CGRectMake(sWidth-62, 0, 62, 57.0/2);
        [sendBtn setBackgroundImage:[UIImage imageNamed:@"myLoanList_sending"] forState:UIControlStateNormal];
        [sendBtn addTarget:self action:@selector(sendBtnClick) forControlEvents:UIControlEventTouchUpInside];
        self.sendBtn = sendBtn;
        [self.rectView addSubview:sendBtn];
        
        UITextView *inputTextview = [[UITextView alloc] initWithFrame:CGRectMake(dialogBtn.right-2, 0, sWidth-dialogBtn.width-sendBtn.width+2, 57.0/2)];
        inputTextview.font = [UIFont systemFontOfSize:23.91/2];
        inputTextview.keyboardType = UIKeyboardTypeDefault;
        inputTextview.returnKeyType = UIReturnKeySend;
        inputTextview.delegate = self;
        inputTextview.layer.borderWidth = 1;
        inputTextview.layer.borderColor = rgb(215, 215, 215, 1).CGColor;
        _inputTextview.textColor = [UIColor blackColor];
        _inputTextview.userInteractionEnabled = YES;
        self.inputTextview = inputTextview;
        [self.rectView addSubview:inputTextview];
        
        

        UIView *dialogBgView = [[UIView alloc] initWithFrame:CGRectMake(2, self.height-toBottomHeight+2, tableViewWidth, 0)];
        dialogBgView.alpha = 0.7;
        _bgView = dialogBgView;
        dialogBgView.backgroundColor = [UIColor blackColor];
        [self addSubview:dialogBgView];
        
        UITableView *dialogView = [[UITableView alloc] initWithFrame:CGRectMake(2, self.height-toBottomHeight+2, tableViewWidth, 0) style:UITableViewStylePlain];
        dialogView.backgroundColor = [UIColor clearColor];
        dialogView.delegate = self;
        dialogView.dataSource = self;
        self.myTableView = dialogView;
        [self addSubview:dialogView];
    }
    return self;
}

-(void)setCaninput:(NSInteger)caninput
{
    //只进行一次赋值
    if (_caninput != 3) {
        return;
    }
    _caninput = caninput;
    //关闭聊天  textview不可编辑  点击弹出tableview
    //开启聊天  textview课编辑    无点击效果
    if (!caninput) {
        _inputTextview.text = UItextView_Placeholder;
        _inputTextview.textColor = [UIColor grayColor];
        _inputTextview.userInteractionEnabled = NO;
        
        UIButton *textBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        textBtn.backgroundColor = [UIColor clearColor];
        textBtn.frame = _inputTextview.frame;
        [textBtn addTarget:self action:@selector(textBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.rectView addSubview:textBtn];
    }

}


-(void)dialogBtnClick:(UIButton *)btn{

    [self bringSubviewToFront:_bgView];
    [self bringSubviewToFront:_myTableView];
    _myTableViewHidd = !_myTableViewHidd;
    [self myTableViewHidden:_myTableViewHidd];

}

-(void)textBtnClick:(UIButton *)btn{
    _myTableViewHidd = !_myTableViewHidd;
    [self myTableViewHidden:_myTableViewHidd];
}
-(void)myTableViewHidden:(BOOL)hidden{
    [self bringSubviewToFront:_bgView];
    [self bringSubviewToFront:_myTableView];
    [UIView animateWithDuration:0.5 animations:^{
        CGFloat height =7*33;
        CGFloat y = self.height-28-height;
        CGFloat y2 = y;
        CGFloat h2 = height;
        if(height>self.height-32){//适配4,5
            
            h2 = self.height-30;
            y2 = 2;
        }
        if ((!hidden) == YES) {
            _bgView.frame = CGRectMake(2, y2, tableViewWidth, h2);
            _myTableView.frame = CGRectMake(2, y2, tableViewWidth, h2);
            
        }else{
            _bgView.frame = CGRectMake(2, self.height-toBottomHeight+2, tableViewWidth, 0);
            _myTableView.frame = CGRectMake(2, self.height-toBottomHeight+2, tableViewWidth,0);
        }
    }];
}
-(void)sendBtnClick{
    
    if (_inputTextview.text.length > 0  && ![_inputTextview.text isEqualToString:UItextView_Placeholder]) {
        //发送会话
        if (_caninput == 0) {
            
            _myTableViewHidd = YES;
            [self myTableViewHidden:YES];
            _chatType = 1;
            //固定会话
            [self.delegate sendBtnWasClickedWithChatType:_chatType content:[NSString stringWithFormat:@"%ld",(long)_index]];
            
        }
        else{
            //输入会话
            _chatType = 2;
            [self.delegate sendBtnWasClickedWithChatType:_chatType content:self.inputTextview.text];
        }

    }
    else{
        [ProgressHUD showErrorWithStatus:@"消息不能为空!"];
    }
    
}



#pragma mark - NotificationKeyboard
//移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)registerForKeyboardNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void) keyboardShown:(NSNotification *) notif{
    
    NSDictionary *info = [notif userInfo];
    //获取键盘高度
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    //获取键盘收起时间  同步
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    //加入动画
//    [UIView beginAnimations:@"keyboard1" context:nil];
//    [UIView setAnimationDuration:animationDuration + 0.1];
    self.superview.frame = CGRectMake(0, 64 - keyboardSize.height, kDeviceWidth, kDeviceHeight);
//    [UIView commitAnimations];
}
- (void) keyboardHidden:(NSNotification *) notif{
    
    //获取键盘收起时间  同步
    NSDictionary *info = [notif userInfo];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    //加入动画
//    [UIView beginAnimations:@"keyboard1" context:nil];
//    [UIView setAnimationDuration:animationDuration];
    self.superview.frame = CGRectMake(0, 64, kDeviceWidth, kDeviceHeight - 64);
//    [UIView commitAnimations];
}



#pragma mark - UITextViewDelegate
//输入框行数是否随着输入文字的数量而发生变化  暂无此需求
-(void)textViewDidChange:(UITextView *)textView
{
//    CGSize textViewSize = [textView sizeThatFits:CGSizeMake(textView.frame.size.width, FLT_MAX)];
//    CGFloat height = textViewSize.height;
//    if (height > 59)
//    {
//        height = 59;
//        [textView setScrollEnabled:YES];
//        [textView setShowsVerticalScrollIndicator:YES];
//    }
//    else
//    {
//        [textView setScrollEnabled:NO ];
//        [textView setShowsVerticalScrollIndicator:NO];
//    }
//    //判断高度是否发生变化
//    if (_inputHeight != height) {
//        _inputHeight = height;
//        [UIView animateWithDuration:0.5f animations:^{
//            [self.rectView setFrame:CGRectMake(0, sHeight-height, sWidth, height)];
//            [self.inputTextview setFrame:CGRectMake(_dialogBtn.right-2, 0, sWidth-_dialogBtn.width-_sendBtn.width+2, height)];
//            _sendBtn.frame = CGRectMake(sWidth-62, height - 57.0/2, 62, 57.0/2);
//            _dialogBtn.frame = CGRectMake(0, height - 57.0/2, 75, 57.0/2);
//        }];
//        [self.delegate inputTextViewChangedHeight:_inputHeight];
//    }
}



-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    //点击return
    if ([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
        //调用发送事件  发送成功后清空textview
        _chatType = 2;
        if (_inputTextview.text.length > 0) {
            [self.delegate sendBtnWasClickedWithChatType:_chatType content:_inputTextview.text];
        }
        return NO;
    }
    
    //暂时不需要限制输入字数
    return YES;
}





#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellName";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        UIView *view = [[UIView alloc] initWithFrame:cell.bounds];
        view.backgroundColor = [UIColor blackColor];
        cell.selectedBackgroundView = view;
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    if (_dataArray.count) {
        YXBLoanChat *model = [_dataArray objectAtIndex:indexPath.row];
        cell.textLabel.text = model.text;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 33.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _myTableViewHidd = YES;
    _index = indexPath.row;
    [self myTableViewHidden:_myTableViewHidd];
    [self.delegate dialogTextDidSelectedAtIndex:indexPath.row];
}
@end
