//
//  YXBProtocolView.h
//  YOUXINBAO
//
//  Created by zjp on 15/7/17.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>


//class
typedef NS_ENUM(NSInteger, TYPE)
{
    /**
     *   @author zjp
     *
     *   做土豪
     */
    TYPE_TO_TUHAO_CREATE = 1,
    
    /**
     *   @author zjp
     *
     *   土豪借款
     */
    TYPE_TO_TUHAO_LOAN = 2,
    
    /**
     *   @author zjp
     *
     *   我的信用等级
     */
    TYPE_TO_CREDIT_RATING = 3,
    
    /**
     *   @author zjp
     *
     *   4.用户注册协议
     */
    TYPE_TO_USER_REGIN_PROTOCOL = 4,
    
    /**
     *   @author zjp
     *
     *   5.	信分期分期商品服务协议
     */
    TYPE_TO_Commodity_service_agreement = 5,
    
    /**
     *   @author zjp
     *
     *   6.	宝赚钱服务协议及右上角的说明
     */
    TYPE_TO_Treasure_Money_Service = 6,
    
    /**
     *   @author zjp
     *
     *   7.	AA活动发起服务协议
     */
    TYPE_TO_AA_CREATE = 7,
    
    /**
     *   @author zjp
     *
     *   8.	AA活动参与服务协议
     */
    TYPE_TO_AA_INTO = 8,
    
    /**
     *   @author zjp
     *
     *   9.	逾期违约说明
     */
    TYPE_TO_WEIYUE = 9,
    
    /**
     *   @author zjp
     *
     *   10.	微笑催款协议
     */
    TYPE_TO_SMILE = 10,
    
    /**
     *   @author zjp
     *
     *   11.	好友借入协议
     */
    TYPE_TO_HAOYOU_JIERU = 11,
    
    /**
     *   @author zjp
     *
     *   12.	闪电借出协议
     */
    TYPE_TO_SHANDIAN_JIECHU = 12,
    
    /**
     *   @author zjp
     *
     *   高级借出协议
     */
    TYPE_TO_HIGH_JIECHU = 13,
    
    /**
     *   @author zjp
     *
     *   14.	首页说明
     */
    TYPE_TO_HOME_SHUOMING = 14,
    
    
    /**
     *   @author zjp
     *
     *   15.	个人中心说明
     */
    TYPE_TO_GERENSHUOMING = 15,
    
    /**
     *   @author zjp
     *
     *   16.	其他理财（文案
     */
    TYPE_TO_QITALICAI = 16,
    

    
};


//class
typedef NS_ENUM(NSInteger, HORIZONTALALIGNMENT)
{
    VIEWAlignmentLeft      = 0,    // Visually left aligned
    VIEWAlignmentCenter    = 1,    // Visually centered
    VIEWAlignmentRight     = 2
};

@protocol YXBProtocolViewtDelegate <NSObject>
@optional
- (void)checkButton:(UIButton *)sender;
- (void)protocolButton:(UIButton *)sender;
@end


@interface YXBProtocolView : UIView

/**
 *   @author zjp
 *
 *   <#Description#>
 */
@property(nonatomic,assign) NSInteger   type;
@property(nonatomic,assign) NSInteger   location;
@property(nonatomic,assign) id <YXBProtocolViewtDelegate> delegate;

@property (nonatomic, copy) NSString *urlStr;//协议网址
@property (nonatomic, copy) NSString *webTitle;//
@property (nonatomic, copy) NSString *buttonTitle;//buttontitle

@property(nonatomic,strong)UIButton     *tongyi;
@property(nonatomic,assign)BOOL         tongyibutHidden;//是否隐藏 选择框

@property(nonatomic,strong)UILabel      *tiaokuan;
@property(nonatomic,assign)BOOL         tiaokuanbutHidden;//是否影藏  我同意  三个字

@property(nonatomic,strong)UIButton     *tongyitiaokuan;

@property(nonatomic,strong)UIButton     *bigbut;


- (CGFloat)getYXBProtocolViewWidth;


- (id)initWithType:(TYPE)type Frame:(CGRect)frame location:(HORIZONTALALIGNMENT)location;
@end
