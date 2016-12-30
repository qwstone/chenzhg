//
//  AAFiltrateView.h
//  YOUXINBAO
//
//  Created by CH10 on 15/3/6.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCFiltrateButton.h"
@class AAFiltrateView;

/**
 * 活动分类-筛(我的活动)
 * @param categoryType
 *            0->全部;1->其他;2->吃喝聚会;3->K歌娱乐;4->体育运动;5->交友派对;6->学习分享;7->户外旅游
 *            活动状态 520->审核中; 490->审核失败; 500->活动未开始; 600->活动进行中; 400->活动取消;
 *            300->活动结束
 */
typedef enum {
    filtrateTypeAll = 0,
    filtrateTypeElse,
    filtrateTypeEat,
    filtrateTypeKTV,
    filtrateTypeSports,
    filtrateTypeFriend,
    filtrateTypeStudy,
    filtrateTypeTravel,
    filtrateTypeChecking = 520,
    filtrateTypeRejected = 490,
    filtrateTypePassed = 500,
    filtrateTypeStarted = 600,
    filtrateTypeCanceled = 400,
    filtrateTypeFinished = 300
} FiltrateType;

typedef enum {
    filtrateTimeAll = 0,
    filtrateTimeToday,
    filtrateTimeTomorrow,
    filtrateTimeWeekend
} FiltrateTime;

//* @param payType
//*            0 全部 1我参与的 2受邀请 3被拒绝 4 我发起
typedef enum {
    // 利用构造函数传参
    
    /**
     * 全部
     */
    FilterMyCategoryAll = 0,  // 0
    
    /**
     * 我发起
     *
     */
    FilterMyCategoryCreated = 4, // 4
    
    /**
     * 我参与
     */
    FilterMyCategoryJoined = 1, // 1
    
    /**
     * 受邀请
     */
    FilterMyCategoryBeinvited = 2, // 2
    
    /**
     * 被拒绝
     */
    FilterMyCategoryRejected = 3 // 3
    
}FilterMyCategory;


//* @param costType
//*            0 免费 1 付费 2全部
typedef enum {
    filtrateCostAll = 2,
    filtrateCostFree = 0,
    filtrateCostExpend =1
} FiltrateCost;


@protocol AAFiltrateViewDelegate <NSObject>
@optional
- (void)sureButtonDidTouch:(AAFiltrateView *)filtrateView;
@end

@interface AAFiltrateView : UIView<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *nearbyView;
@property (weak, nonatomic) IBOutlet UIView *mineView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet QCFiltrateButton *typeAll;
@property (weak, nonatomic) IBOutlet QCFiltrateButton *typeEat;
@property (weak, nonatomic) IBOutlet QCFiltrateButton *typeKTV;
@property (weak, nonatomic) IBOutlet QCFiltrateButton *typeSports;
@property (weak, nonatomic) IBOutlet QCFiltrateButton *typeFriend;
@property (weak, nonatomic) IBOutlet QCFiltrateButton *typeStudy;
@property (weak, nonatomic) IBOutlet QCFiltrateButton *typeTravel;
@property (weak, nonatomic) IBOutlet QCFiltrateButton *typeElse;
@property (weak, nonatomic) IBOutlet QCFiltrateButton *timeAll;
@property (weak, nonatomic) IBOutlet QCFiltrateButton *timeToday;
@property (weak, nonatomic) IBOutlet QCFiltrateButton *timeTomorrow;
@property (weak, nonatomic) IBOutlet QCFiltrateButton *timeWeekend;
@property (weak, nonatomic) IBOutlet QCFiltrateButton *mineAll;
@property (weak, nonatomic) IBOutlet QCFiltrateButton *mineParticipate;
@property (weak, nonatomic) IBOutlet QCFiltrateButton *mineInvite;
@property (weak, nonatomic) IBOutlet QCFiltrateButton *mineLaunch;
@property (weak, nonatomic) IBOutlet QCFiltrateButton *berefuse;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet QCFiltrateButton *costAll;
@property (weak, nonatomic) IBOutlet QCFiltrateButton *costExpend;
@property (weak, nonatomic) IBOutlet QCFiltrateButton *costFree;
@property (weak, nonatomic) IBOutlet QCFiltrateButton *activityChecking;
@property (weak, nonatomic) IBOutlet QCFiltrateButton *activityRejected;
@property (weak, nonatomic) IBOutlet QCFiltrateButton *activityPassed;
@property (weak, nonatomic) IBOutlet QCFiltrateButton *activityStarted;
@property (weak, nonatomic) IBOutlet QCFiltrateButton *activityCanceled;
@property (weak, nonatomic) IBOutlet QCFiltrateButton *activityFinished;
@property (weak, nonatomic) IBOutlet QCFiltrateButton *activityAll;

@property (nonatomic,weak) id<AAFiltrateViewDelegate> delegate;
@property (nonatomic,assign) FiltrateType type;
@property (nonatomic,assign) FiltrateTime time;
@property (nonatomic,assign) FilterMyCategory mine;
@property (nonatomic,assign) FiltrateCost cost;
@property (nonatomic,copy) NSString *text;
@end
