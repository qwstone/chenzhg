//
//  QCConst.h
//  YOUXINBAO
//
//  Created by ZHANGMIAO on 14-3-4.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "YXBTool.h"

//百度统计渠道号
#define CHANDLE_AK_ID @"378006" //appstore

//
#define CPB_AK_NUM @"ios"


#define YXB_APP_NAME @"无忧借条"

//系统版本号
#define YXB_VERSION_CODE @"3.13"

//正式环境   宏定义，  如果要测试，测试环境，需要把这个宏注释
//#define __OFFICIAL_SERVER_DEBUG__

//同盾 XCODE 调试环境， (如果需要上线，需要把这个宏注打开),(如果不上线，需要注释掉这个宏，否则调试xcode闪退)
//#define __TONGDUN_XCODE_DEBUG__

//切换系统推送或者小米推送(注掉，为系统推送)
#define __xiaomi_or_system_push__
//-------------------------------------------------------------------------------------------------------


#define YXBCompanyTelephoneNO @"4006688658"

//存储系统变量的动态数组
#define CONFIG_FILE_PATH                            @"CaiPiaoBao_Sys_Config.xml"


////无忧借条网址 webview
#define YXB_IP_address_web                          @"https://www.51jt.com/"
////无忧借条网址 分享
#define YXB_IP_address_share                         @"https://www.51jt.com/"

#define YXB_IP_ADRESS [QCConfigTool getHostUrl]
//调用AppDelegate
#define SHAREDAPP ((AppDelegate *)[UIApplication sharedApplication].delegate)
//获取设备屏幕宽
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
//获取设备屏幕高
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
//获取设备系统版本
#define KDeviceOSVersion [[[UIDevice currentDevice] systemVersion] floatValue]
//三色值
#define rgb(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

//背景色值
#define kCustomBackground rgb(255,244,238,1)
//线条色值
//#define kLineColor rgb(255,221,202,1) (242, 241, 239, 1)
#define kLineColor rgb(242, 241, 239, 1)
#define kRGB(r, g, b) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1.f]

//视图色值
#define kViewBackground rgb(255,251,249,1)
//安全释放
#define Release(obj) [obj release];obj = nil;
//textfeild height
#define kTextFieldHeight (kDeviceWidth-30)/6
#define ccr(x,y,w,h) CGRectMake(x,y,w,h)

//MD5 string
#define Md5String @"cpbao.com_友信宝"

//融云appKey
//#define RongCloudAppKey @"vnroth0krcnfo" 
//融云 新key
#define RongCloudAppKey @"m7ua80gbuf7nm"

//ShareSDK AppKey&AppSecret  (彩票宝的)
#define kShareSDKAppKey @"74a1bef396a0"
#define kShareSDKAppSecret @"4daacc8d5118b5946a264f64c83dd205"

//ShareSDK AppKey&AppSecret  (友信宝的)
#define YXBShareSDKAppKey @"850dbd1f2f68"
#define YXBShareSDKAppSecret @"5103743996c18c95f836d960594bbc90"


//新浪AppKey&AppSecret
#define kSinaAppKey @"1677619258"
#define kSinaAppSecret @"05900130cff44882306a9e450bd69356"
#define kSinaRedirectUri @"https://cpbao.com"

//微信支付 彩票宝的
#define WeChatAppKey           @"wxa5cbd2fbb78ec842"
#define WeChatAppSecret        @"b25c6d99f935383cd4a8ac3b719f2e17"

//微信登录  有信宝的
#define YXBWeChatLoginKey       @"wx2706a830942a7d33"
#define YXBWeChatLoginSecret    @"365644c249b52a1c40f1ea0ef8a135f2"

//微信第三方支付  有信宝的
#define YXBWeChatPayKey       @"wx63dac5ca8fdd1828"
#define YXBWeChatPayKeySecret  @"126605cbaaa0e6ecf53d4b69d5fa5e5b"

//商户号，填写商户对应参数
#define MCH_ID          @"1251909201"
//商户API密钥，填写相应参数
#define PARTNER_ID      @"WJsoho1807bjwjsohoyxinbaocom1235"
//支付结果回调页面
#define NOTIFY_URL      @"https://wxpay.weixin.qq.com/pub_v2/pay/notify.v2.php"
//获取服务器端支付数据地址（商户自定义）
#define SP_URL          @"https://wxpay.weixin.qq.com/pub_v2/app/app_pay.php"



//#define __isGestureOpen         @"__isGestureOpen"

//老 key（faith）  cHBkhimqH9j65IaGGxvXfdQa
//新 key (06.12)   QjXed9yVK8fil3AQnVZ5In7T
//#define YXBBaiduMapKey             @"QjXed9yVK8fil3AQnVZ5In7T" // (299美元证书)
#define YXBBaiduMapKey             @"N2feV5KgVQNORhAtBxvcdGNl"   //友信宝证书
//退出登录通知键
#define kLocalSignOutNotification @"localSignOutNotification"

//好友未读数变化通知键
#define kNewFriendChangeNotification @"kNewFriendChangeNotification"

//土豪贷发白条页面返回刷新标记
#define DebtLoanCreateBlankNoteNeedRefresh @"DebtLoadCreateBlankNoteNeedRefresh"

#define RegisterToAutoLoginFlag @"RegisterToAutoLoginFlag"

static NSMutableDictionary *yxbSysConfig;

//手机push token/
#define PUSH_DEVICE_TOKEN_SYSVAR_NAME @"_devicetoken"

#define SYS_IDFA_SYSVAR_NAME @"_IDFA"

#define MAC_ADDRESS_MD5_SYSVAR_NAME @"_macaddressmd5"

#define TestIpAddressKey @"__IPKEY"

#define TestIpPortKey @"__PORTKEY"

#define YXBToLoginKey @"-9999"

//默认土豪白条id
#define DebtDetailID @"827"

//通讯录本地保存标示
#define DBAddressBookModelName @"AddressBookModel"

//手机通讯录数据库存储表示
#define hasSavedAddressBook @"SavedAddressBook"

//好友保存到本地标示
#define DBFriendModelName @"QCFriendModel"

//好友列表数据库标识
#define hasSavedFriendDB @"DBManager"
//返回-8888 去实名认证
#define Authentication @"-8888"
//借款银行参考利息
#define YXBBankRate @"4.3"

//借款最低金额
#define YXBJieKuanMinMoney @"100"
//借款最高金额
#define YXBJieKuanMaxMoney @"1000000"
//借款最高年限
#define YXBJieKuanMaxYear @"2"
