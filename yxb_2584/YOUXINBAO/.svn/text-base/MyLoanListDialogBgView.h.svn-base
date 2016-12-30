//
//  MyLoanListDialogBgView.h
//  YOUXINBAO
//
//  Created by CH10 on 16/2/16.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyLoanListDialogBgViewDelegate <NSObject>


-(void)sendBtnWasClickedWithChatType:(NSInteger)chatType content:(NSString *)content;

-(void)sendBtnWasClickedWithSelectedIndex:(NSInteger)index;
//-(void)dialogBtnWasClicked;
-(void)dialogTextDidSelectedAtIndex:(NSInteger)index;

-(void)inputTextViewChangedHeight:(CGFloat)height;

@end



@interface MyLoanListDialogBgView : UIView

@property (nonatomic,assign)id<MyLoanListDialogBgViewDelegate>delegate;
@property (nonatomic,weak)UITableView *myTableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,assign)BOOL myTableViewHidd;
@property (nonatomic, weak)UITextView * inputTextview;
@property (nonatomic,weak)UIButton *dialogBtn;
@property (nonatomic,weak)UIButton *sendBtn;
@property (nonatomic,weak)UIView *rectView;


@property (nonatomic, assign) NSInteger caninput;//是否可以输入文字聊天0.不可以1.可以
@property (nonatomic, assign) NSInteger chatType;//会话类型1 固定对话 2 输入对话



-(void)myTableViewHidden:(BOOL)hidden;
-(void)updateRectViewWithFrame:(CGRect)frame;
@end
