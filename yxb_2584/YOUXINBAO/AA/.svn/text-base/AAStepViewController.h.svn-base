//
//  AAStepViewController.h
//  YOUXINBAO
//
//  Created by CH10 on 15/3/23.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AABaseViewController.h"
//#import "AAMapViewController.h"
#import "AATextField.h"
#import "HttpOperator.h"
#import "AAActivitiesListViewController.h"
#import "TActivity.h"
#import "QCIssueViewController.h"
///**
// * 活动分类-筛(附近活动/好友活动)
//  0->全部;1->其他;2->吃喝聚会;3->K歌娱乐;4->体育运动;5->交友派对;6->学习分享;7->户外旅游
// */
//typedef enum {
//    // 利用构造函数传参
//    
//    /**
//     * 全部
//     */
//    AAFilterOtherCategoryAll = 0,  // 0
//    
//    /**
//     * 其他
//     */
//    AAFilterOtherCategoryOther,    // 1
//    
//    /**
//     * 吃喝聚会
//     */
//    AAFilterOtherCategoryDinner, // 2
//    
//    /**
//     * K歌娱乐
//     */
//    AAFilterOtherCategoryKTV,    // 3
//    
//    /**
//     * 体育运动
//     */
//    AAFilterOtherCategorySport,  // 4
//    
//    /**
//     * 交友派对
//     */
//    AAFilterOtherCategoryDating, // 5
//    
//    /**
//     * 学习分享
//     */
//    AAFilterOtherCategoryStudy,  // 6
//    
//    /**
//     * 户外旅游
//     */
//    AAFilterOtherCategoryOutdoor    // 7
//    
//}AAFilterOtherCategory;

///**
// * 活动显示类型
// */
//typedef enum {
//    // 利用构造函数传参
//    
//    /**
//     * 全部可见
//     */
//    AAShowTypePublic = 0, // 0
//    
//    /**
//     * 好友可见
//     */
//    AAShowTypeFriend, // 1
//    
//    /**
//     * 秘密邀请
//     */
//    AAShowTypeSecret // 2
//    
//}AAShowType;
//
///**
// * 活动付费方式
// */
//typedef enum {
//    
//    /**
//     * 预付费
//     */
//    AAPayTypePrepaid = 0, // 0
//    
//    /**
//     * 后付费
//     */
//    AAPayTypePostpaid,    // 1
//    
//    /**
//     * 全部免费
//     */
//    AAPayTypeFreeForAll // 2
//    
//}AAPayType;

/**
 * 女生费用
 */
typedef enum {
    
    /**
     * 女生收费
     */
    AAFemaleFeePaid = 0, // 0
    
    /**
     * 女生免费
     */
    AAFemaleFeeFree    // 1
    
}AAFemaleFee;

@interface AAStepViewController : AABaseViewController<UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,QCBaseTextFieldDelegate,UIActionSheetDelegate,UITextFieldDelegate>

@property (nonatomic,assign) AAFilterOtherCategory createType;
@property (nonatomic,strong) AAActivitiesListViewController *listVC;

@property (strong, nonatomic) HttpOperator* iHttpOperator;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (nonatomic,retain) TActivity * activity;
@end
