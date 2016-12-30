//
//  YXBTool.h
//  YOUXINBAO
//
//  Created by Feili on 15/5/11.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AADetailsViewController.h"
#import "DebtDetailNewViewController.h"
#import "YXBWebNavViewController.h"
#import "YXBWebViewController.h"
#import "DebtListViewController.h"
#import "MyOrderScheduleViewController.h"
#import "QCCheckDetailViewController.h"
#import "AmortizationProduceDetailViewController.h"
@interface YXBTool : NSObject


/**
 *  @author zhangjinpeng
 *  @param
 *  @return 获取同盾 字符串
 */
+ (NSString *) getFMString;
/**
 *  @author zhangjinpeng
 *  @param
 *  @return 是否登录
 */

+ (BOOL)getLoginYesOrNo;


//如果没登陆 去登陆 弹出登陆页面
+ (void)isNoLoginTologin;


+(UIColor *)generateRandomColor;
/**
 *  @author zhangjinpeng
 *
 *  十六进制颜色转换成
 *
 *  @param 类型 信息（链接） 当前控制器类
 
 *
 *  @return url条状目标
 */
+ (void)typeToJump:(NSString *)type info:(NSString *)info;


/**
 *  支付专用
 *
 *  跳转内部浏览器
 *
 *  @param url       url
 *  @param hasTopBar 是否显示导航栏
 */
+(void)jumpInnerSafaryWithUrl:(NSString *)url hasTopBar:(BOOL)hasTopBar titleName:(NSString *)titleName type:(NSInteger)type;
/**
 *  @author zhangjinpeng
 *
 *
 *  @param 钱 年 月
 
 *
 *  @return 利息
 */
+(NSString *)setMoney:(NSString *)money yearRate:(NSString *)yearRate repaymentMonth:(NSInteger)repaymentMonth;
/**
 *  @author chenglibin
 *
 *  产生颜色图片
 *
 *  @param color uicolor
 *
 *  @return uiimage
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  @author chenglibin
 *
 *  十六进制颜色转换成
 *
 *  @param stringToConvert // 例如： @"#123456"
 
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

+(void)showAlertViewWithString:(NSString *)string;

+(CGSize)getFontSizeWithString:(NSString *)words font:(UIFont *)font constrainSize:(CGSize)cSize;
/**
 *  @author chenglibin
 *
 *  MD5加密
 *
 *  @param stamp 时间戳
 *  @param token userToken
 *
 *  @return 加密后的串
 */
+(NSString *)getMD5StringWithStamp:(NSString *)stamp token:(NSMutableString *)token;
+ (NSString *)getURL:(NSString*)url params:(NSString *)params;

/**
 *  @author chenglibin
 *
 *  跳转浏览器
 *
 *  @param url url
 */
+(void) jumpSafariWithUrl:(NSString*) url;

/**
 *  @author chenglibin
 *
 *  跳转内部浏览器
 *
 *  @param url       url
 *  @param hasTopBar 是否显示导航栏
 */

+(void)jumpInnerSafaryWithUrl:(NSString *)url hasTopBar:(BOOL)hasTopBar titleName:(NSString *)titleName;

/**
 *  @author pengcheng
 *
 *  跳转内部浏览器
 *
 *  @param url       url
 *  @param hasTopBar 是否显示导航栏
 */
+(void)jumpInnerSafaryWithUrl:(NSString *)url hasTopBar:(BOOL)hasTopBar titleName:(NSString *)titleName view:(UIView *)view;

//是否包含指定字符
+(BOOL)containString:(NSString *)str sourceString:(NSString *)sourceString;

//计算label高度
+(CGFloat)countLabelHeightWithText:(NSString *)text font:(UIFont *)font labelWidth:(CGFloat)width;

//生成新尺寸图片
+(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size;

/**
 *  @author chenglibin
 *
 *  支付统一跳转
 *
 *  @param buyJson 由 cgLoan等生成的 串
 *  @param money   总钱数
 */
+(void)jumpToInnerPayDetailWithJson:(NSString *)buyJson money:(CGFloat)money;


/**
 *  @author chenglibin
 *
 *  通过NSDictionary 生成 json串
 *
 *  @param prettyPrint
 *  @param dic
 *
 *  @return 字符串
 */
+(NSString*)jsonStringWithPrettyPrint:(BOOL) prettyPrint dic:(NSDictionary *)dic;

/**
 *  @author chenglibin
 *
 *  通过字典生成 带等号的字符串
 *
 *  @param dic dic
 *
 *  @return 转换后的串
 */
+(NSString *)jsonEqualWithDic:(NSDictionary *)dic;


+ (NSString *)countNumAndChangeformat:(NSString *)nums;

//呼叫电话
+ (void)callTelphoneWithNum:(NSString *)num;
+(void)sendMessageWithNum:(NSString *)num;



+(NSString*)getDocumentPath;
+(NSString*) jsonSaveGetStrWithDic:(NSDictionary*) dic key:(NSString*) key;
//=======
/**
 *  @author chenglibin
 *
 *  根据登录状态返回token
 *
 *  @return yxbToken
 */
+(NSString *)getUserToken;



//根据时间字符串返回与当前时间的时间差
+ (double)intervalSinceNow:(NSString *)theDate;

+(UINavigationController *)getCurrentNav;

/**
 *  @author zhangjinpeng
 *
 *  type 1灰色  2  3  4 反色
 *
 *  @param anImage需要置灰的image
 *
 *  @return 图片置灰
 */
+(UIImage*) grayscale:(UIImage*)anImage type:(char)type;

//微信好友分享
+ (void)shareToWeixinSessionContent:(NSString *)content imgName:(UIImage *)imgName url:(NSString *)url title:(NSString *)title callBackBlock:(ShareCallBackBlock)callBack;

//分享给微信朋友圈
+ (void)shareToWeixinTimelineContent:(NSString *)content imgName:(UIImage *)imgName url:(NSString *)url title:(NSString *)title callBackBlock:(ShareCallBackBlock)callBack;


//判断当前网络连接状态

+(BOOL)isConnectionAvailable;

//获取时间戳
+(NSString *)getStamp;

/**
 *  @author zhangjinpeng
 *
 *  根据登录状态返回Cookie
 *
 *  @return Cookie
 */

+(NSString *)getYxbCookie;

//判断余额 跳转充值

+(void)jumpToPayVC;

//保存所有系统变量的方法
+(void)SaveSysConfig;


//获取IDFA
+(NSString*) getIdfa;

//两个日期之间相差的天数
+(NSInteger)numberOfDaysBetween:(NSString *)start and:(NSString *)end;

//获取当前时间
+(NSString *)getCurrentTime;

//替换用户  cookie
+(void)replaceUserYXBCookieWithCookie:(NSString *)cookie;

+(NSString*) getClearWebUrl;

//通过事件响应者链获取视图的控制器
+ (UIViewController *)getViewControllerWithView:(UIView *)view;

//跳转登录
+(void)toLoginYXB;

+(NSString *)replaceBRString:(NSString *)url;

+(void)setGesturePassWord:(NSString *)ps;

//手机号码验证
+(BOOL)validateMobile:(NSString *)mobile;

//获取Documents目录
+(NSString *)dirDoc;

//汉字转拼音
+(NSString *)pinyinWithText:(NSString *)hanziText;

//判断输入字符是否在26个字母里

+(BOOL)isAlphabetContainsChar:(NSString *)str;

//返回格式化字符串
+(NSString *)decodeFromPercentEscapeString:(NSString *)input;


//获取字母表数组
+(NSArray *)getAlphaBetNumbers;

//计算两个日期相差的天数  endDay是字符串
+(NSInteger)daysBetweenTwoDaysWithEndDayStr:(NSString *)endDay;

//计算利息
+(NSInteger)lixiWithMoney:(NSInteger)money timeInterval:(NSInteger)days yearRate:(CGFloat )yearRate;

//计算利率
+(CGFloat)lilvWithMoney:(NSInteger)money timeInterval:(NSInteger)days lixi:(NSInteger)lixi;

//计算期次
+(NSInteger)getAmortizationNumWithEndDate:(NSString *)endDateStr;

+(NSString *)dateWithCurrentDateWithPeriodMonths:(NSInteger)month;

+(NSInteger)yearBetweenTwoDateFromNowTo:(NSString *)endDay;

+(CGFloat)heightWithSize:(CGSize)size width:(CGFloat)width;

+(CGFloat)getSquareHeight;

//base64 字符串
+(NSString *)base64EncodedWithString:(NSString *)sourceString;

@end
