//
//  BuFenJieKuan.h
//  YOUXINBAO
//
//  Created by 密码是111 on 2016/12/22.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AATimePickerView.h"
#import "YXBLoanInfoDetails.h"
@protocol BuFenJieKuanDelegate <NSObject>

- (void)BuFenJieKuanConfirmClick;

@end



@interface BuFenJieKuan : UIView<UITextFieldDelegate,UITextViewDelegate>{
    
    UIView      *bgView;
    
    UITextField         *_textFiled2;
    CGRect kebordFrame;
    UILabel *label2;
    UILabel *LiXiLab2;
    
    
}
@property (nonatomic,strong)YXBLoanInfoDetails *Model;
@property(nonatomic,strong) NSString*HuanKuanTimestr;
@property(nonatomic,strong) NSString*DataTimestr;
@property(nonatomic,strong)UILabel *labelnew1;
@property(nonatomic,strong) UITextField *textFiled1;//补偿金
@property(nonatomic,strong) UITextField *textFiled2;//部分还款
@property(nonatomic,strong) NSString*changeStr;
@property(nonatomic,retain)UITableView *tableView;
@property (nonatomic,strong)AATimePickerView *timePicker;
@property(nonatomic,strong)UIButton *button5;
@property(nonatomic,assign)id<BuFenJieKuanDelegate>delegate;
@property(nonatomic,strong)UILabel *tit;
@property(nonatomic,strong)UIView *backview;
@property(nonatomic,strong)UIView *whiteView;
@property(nonatomic,strong)UIButton *Timebtn;
@property(nonatomic,assign)NSInteger UItag;//1.申请延期 2.部分还款


@end

