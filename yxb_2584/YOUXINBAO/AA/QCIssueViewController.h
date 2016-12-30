//
//  QCIssueViewController.h
//  YOUXINBAO
//
//  Created by CH10 on 15/5/9.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

typedef enum {
    // 利用构造函数传参
    
    /**
     * 全部可见
     */
    AAShowTypePublic = 0, // 0
    
    /**
     * 好友可见
     */
    AAShowTypeFriend, // 1
    
    /**
     * 秘密邀请
     */
    AAShowTypeSecret // 2
    
}AAShowType;

/**
 * field 支付方式  1 免费; 2 预付费; 3 后付费
 */
typedef enum {
    /**
     * 免费
     */
    AAPayTypeFree = 1,
    /**
     * 预付费
     */
    AAPayTypePrepaid = 2,
    
    /**
     * 后付费
     */
    AAPayTypeThen = 3
    
}AAPayType;

/**
 * 活动分类-筛(附近活动/好友活动)
 0->全部;1->其他;2->吃喝聚会;3->K歌娱乐;4->体育运动;5->交友派对;6->学习分享;7->户外旅游
 */
typedef enum {
    // 利用构造函数传参
    
    /**
     * 全部
     */
    AAFilterOtherCategoryAll = 0,  // 0
    
    /**
     * 其他
     */
    AAFilterOtherCategoryOther,    // 1
    
    /**
     * 吃喝聚会
     */
    AAFilterOtherCategoryDinner, // 2
    
    /**
     * K歌娱乐
     */
    AAFilterOtherCategoryKTV,    // 3
    
    /**
     * 体育运动
     */
    AAFilterOtherCategorySport,  // 4
    
    /**
     * 交友派对
     */
    AAFilterOtherCategoryDating, // 5
    
    /**
     * 学习分享
     */
    AAFilterOtherCategoryStudy,  // 6
    
    /**
     * 户外旅游
     */
    AAFilterOtherCategoryOutdoor    // 7
    
}AAFilterOtherCategory;


#import "QCBaseViewController.h"
#import "AAActivity.h"
#import "HttpOperator.h"
#import "QCLoginOneViewController.h"
#import "AuthenticationViewController.h"

@interface QCIssueViewController : QCBaseViewController

@property (nonatomic,strong) AAActivity *activity;

@property (nonatomic,assign) AAFilterOtherCategory category;

@property (strong, nonatomic) HttpOperator* iHttpOperator;

@property (nonatomic,assign) BOOL isFailed; //是否是审核失败

@end


//
@interface AACreateButton : UIButton

- (id)initWithFrame:(CGRect)frame andRightImage:(NSString *)image;

@property (nonatomic,strong)UILabel *textLabel;

@end

@protocol QCIssueAlterDelegate <NSObject>
@optional
- (void)QCIssueAlterSureButtonDidClicked;
@end
@interface QCIssueAlter : UIView

@property (nonatomic,assign) id<QCIssueAlterDelegate> delegate;

@end