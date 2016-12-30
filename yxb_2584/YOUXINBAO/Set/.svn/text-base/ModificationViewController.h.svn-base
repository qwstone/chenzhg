//
//  ModificationViewController.h
//  YOUXINBAO
//
//  Created by 张淼 on 15/4/17.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "SetBaseViewController.h"
#import "HttpOperator.h"
#import "UIImageView+WebCache.h"
#import "QCBaseViewController.h"
@protocol ModificationViewControllerDelegate <NSObject>

- (void)setModificationValue:(NSString *)value withIndexPath:(NSIndexPath *)indexPath;

@end

@interface ModificationViewController : QCBaseViewController<UITextFieldDelegate,UIScrollViewDelegate>

@property (nonatomic,retain)HttpOperator * iHttpOperator;

@property (nonatomic,assign)id<ModificationViewControllerDelegate>delegate;
@property (nonatomic,strong)NSIndexPath * pushIndexPath;

@property (nonatomic,retain)UITextField * textField;

@property (nonatomic,retain)UIButton *sureBtn;

@property (nonatomic,retain) UILabel * nameLabel;

@property(nonatomic,assign)BOOL         isRegisterLogen;//是否是注册成功时进来的

@property(nonatomic,strong)UIImageView  *userInfoImgbg;
@property(nonatomic,strong)UIImageView  *userInfoImg;
@property(nonatomic,strong)UILabel      *userName;

@property(nonatomic,strong)UIScrollView     *bgScrollView;


@property(nonatomic,copy)NSString     *textfiledtext;


@property(nonatomic,copy)NSString       *indexUser;
@end
