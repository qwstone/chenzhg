//
//  YXBTool.m
//  YOUXINBAO
//
//  Created by Feili on 15/5/11.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "YXBTool.h"
#import "YXBWebNavViewController.h"
#import "YXBWebViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "AppDelegate.h"
#import "Reachability.h"
#import "QCLoginOneViewController.h"
#import "PayHomeViewController.h"
#import "WXApi.h"
#import "QCMakeMoneyViewController.h"
#import "LoanOrRepayViewController.h"
#import "AmortizationHomeNewViewController.h"
#import <AdSupport/AdSupport.h>
#import "MyOrderListController.h"
#import "LoanOrRepayMessageViewController.h"
#import "AAReceivablesDetailViewController.h"
#import "QCBorrowManageViewController.h"
#import "AAReceiptViewController.h"
#import "TuhaoLoanSetViewController.h"
#import "QCMainLoanReceiptViewController.h"
#import "QCMoneyListViewController.h"
#import "DebtScheduleViewController.h"
#import "PayForanotherViewController.h"
#import "GuaranteeDaifuDetailViewController.h"
#import "AmorOrderDetailViewController.h"
#import "OverdueModel.h"
#import "FMDeviceManager.h"
#import "MyLoanViewController.h"
#import "DateFormatInstance.h"
#import "YXBLoanCenterViewController.h"
#import "ZhifuViewController.h"

@implementation YXBTool
#define GoodsDetailBaseUrl [NSString stringWithFormat:@"%@webView/goods/good.jsp?a=1",YXB_IP_ADRESS]
#define kImageQuality 0.75  //分享图片压缩比例




/**
 *  @author zhangjinpeng
 *  @param
 *  @return 获取同盾 字符串
 */
+ (NSString *) getFMString {
    FMDeviceManager_t *manager = [FMDeviceManager sharedManager];
    
    // 获取设备指纹黑盒数据，请确保在应用开启时已经对SDK进行初始化，切勿在get的时候才初始化
    NSString *blackBox = manager->getDeviceInfo();
    if (blackBox == nil) {
        blackBox = @"";
    }
    return blackBox;
}
+(UIColor *)generateRandomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
    return color;
    
}


/**
 *  @author zhangjinpeng
 *
 *
 *  @param
 
 *
 *  @return 是否登录
 */

+ (BOOL)getLoginYesOrNo {
    QCUserModel *model = [[QCUserManager sharedInstance] getLoginUser];
    if (model.isLogin == NO) {
        return NO;
    }
    return YES;
}

/**
 *  @author chenglibin
 *
 *  产生颜色图片
 *
 *  @param color uicolor
 *
 *  @return uiimage
 */
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 *  @author zhangjinpeng
 *
 *  十六 进制颜色转换成
 *
 *  @param 钱 年 月
 
 *
 *  @return 利息
 */
+(NSString *)setMoney:(NSString *)money yearRate:(NSString *)yearRate repaymentMonth:(NSInteger)repaymentMonth
{
    NSString *lixi = nil;
    NSString *yearRatestr = [yearRate substringWithRange:NSMakeRange(0,yearRate.length-1)];
    lixi = [NSString stringWithFormat:@"%.2f",([money floatValue] * ([yearRatestr floatValue]/100) * repaymentMonth)/12];
    return lixi;
}

/**
 *  @author chenglibin
 *
 *  十六进制颜色转换成
 *
 *  @param stringToConvert // 例如： @"#123456"

 *
 *  @return UIColor
 */


+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *noHashString = [stringToConvert stringByReplacingOccurrencesOfString:@"#" withString:@""]; // remove the #
    NSScanner *scanner = [NSScanner scannerWithString:noHashString];
    [scanner setCharactersToBeSkipped:[NSCharacterSet symbolCharacterSet]]; // remove + and $
    
    unsigned hex;
    if (![scanner scanHexInt:&hex]) return nil;
    NSInteger r = (hex >> 16) & 0xFF;
    NSInteger g = (hex >> 8) & 0xFF;
    NSInteger b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f];
}

//弹出提示对话框
+(void)showAlertViewWithString:(NSString *)string
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:string delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];

}

/**
 *  @author zhangjinpeng
 *
 *
 *  @param 类型 信息（链接） 当前控制器类
 
 *
 *  @return url条转目标
 */
+ (void)typeToJump:(NSString *)type info:(NSString *)info {

    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];

    if ([type isEqualToString:@"AA"]) {
        if (!userModel.isLogin) {
            [self toLoginYXB];
            return;
        }
        AADetailsViewController * detailsViewController = [[AADetailsViewController alloc]init];
        detailsViewController.activityId = [info integerValue];
        detailsViewController.hidesBottomBarWhenPushed = YES;
        [[self getCurrentNav] pushViewController:detailsViewController animated:YES];
    }else if ([type isEqualToString:@"TuHao"]){
        if (!userModel.isLogin) {
            [self toLoginYXB];
            return;
        }
//        DebtDetailNewViewController *controller = [[DebtDetailNewViewController alloc] init];
//        controller.model.blankNoteID = [info integerValue];
//        [classes pushViewController:controller animated:YES];
        DebtListViewController *vc = [[DebtListViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [[self getCurrentNav] pushViewController:vc animated:YES];
    }else if ([type isEqualToString:@"TuHao2"]){//土豪白条详情
        if (!userModel.isLogin) {
            [self toLoginYXB];
            return;
        }
        DebtDetailNewViewController *controller = [[DebtDetailNewViewController alloc] init];
        controller.model.blankNoteID = [info integerValue];
        controller.hidesBottomBarWhenPushed = YES;
        [[self getCurrentNav] pushViewController:controller animated:YES];
    }else if ([type isEqualToString:@"TuHao3"]){//土豪白条设置
        if (!userModel.isLogin) {
            [self toLoginYXB];
            return;
        }
        NoteSummary *model = [[NoteSummary alloc] init];
        model.repaymentNoteID = [info integerValue];
        DebtScheduleViewController *detail = [[DebtScheduleViewController alloc] init];
        detail.noteSummary = model;
        detail.hidesBottomBarWhenPushed = YES;
        [[self getCurrentNav] pushViewController:detail animated:YES];
    }else if ([type isEqualToString:@"Neiqian1"]){//带导航栏
        [YXBTool jumpInnerSafaryWithUrl:[self getURL:info params:nil] hasTopBar:YES titleName:@"无忧借条"];
    }else if ([type isEqualToString:@"Neiqian2"]){//不带导航栏
        [YXBTool jumpInnerSafaryWithUrl:[self getURL:info params:nil] hasTopBar:NO titleName:@"无忧借条"];
    }else if ([type isEqualToString:@"Web"]){//web浏览器
        [self jumpSafariWithUrl:[self getURL:info params:nil]];
    }else if ([type isEqualToString:@"MyOrder"]){//我的订单详情
        if (!userModel.isLogin) {
            [self toLoginYXB];
            return;
        }
        
        MyOrderListController *orderListController=[[MyOrderListController alloc]init];
        orderListController.hidesBottomBarWhenPushed = YES;
        [[self getCurrentNav] pushViewController:orderListController animated:YES];

    }else if ([type isEqualToString:@"GoodsDetail"]){//商品详情
        NSString *pidStr = [NSString stringWithFormat:@"pid=%@",info];
        NSString *url = [YXBTool getURL:GoodsDetailBaseUrl params:pidStr];
        [self jumpInnerSafaryWithUrl:url hasTopBar:NO titleName:@"商品详情"];
    }else if ([type isEqualToString:@"FundDetail"]){//资金明细 详情
        QCMoneyListViewController *checkVC = [[QCMoneyListViewController alloc] init];
        checkVC.hidesBottomBarWhenPushed = YES;
        [[self getCurrentNav] pushViewController:checkVC animated:YES];
    }else if ([type isEqualToString:@"Mall"]){//信分期首页
        AmortizationHomeNewViewController *amortization = [[AmortizationHomeNewViewController alloc] init];
        amortization.hidesBottomBarWhenPushed = YES;
        [[self getCurrentNav] pushViewController:amortization animated:YES];
    }else if ([type isEqualToString:@"Earning"]){//宝赚钱首页
        if (!userModel.isLogin) {
            [self toLoginYXB];
            return;
        }
        QCMakeMoneyViewController *treasure = [[QCMakeMoneyViewController alloc] init];
        treasure.hidesBottomBarWhenPushed = YES;
        [[self getCurrentNav] pushViewController:treasure animated:YES];
    }else if ([type isEqualToString:@"Loan"]){//友借款首页
        LoanOrRepayViewController * loanViewController = [[LoanOrRepayViewController alloc]init];
        loanViewController.hidesBottomBarWhenPushed = YES;
        [[self getCurrentNav] pushViewController:loanViewController animated:YES];
    }else if ([type isEqualToString:@"Credit"]){//信用大厅首页
        NSString *creditUrl = @"webView/user/credit-hall.jsp";
        [YXBTool jumpInnerSafaryWithUrl:[YXBTool getURL:creditUrl params:nil] hasTopBar:YES titleName:@"信用大厅"];
    }else if ([type isEqualToString:@"order"]){//订单详情页面
        if (!userModel.isLogin) {
            [self toLoginYXB];
            return;
        }
        /*
        MyOrderScheduleViewController *controller = [[MyOrderScheduleViewController alloc] init];
        controller.orderId = [info integerValue];
        [[self getCurrentNav] pushViewController:controller animated:YES];
        
        */
        AmorOrderDetailViewController *controller=[[AmorOrderDetailViewController alloc]init];
        controller.orderId = [info integerValue];
        [[self getCurrentNav] pushViewController:controller animated:YES];

        
    }else if ([type isEqualToString:@"loan2"]){//借条详情页面
        
        QCMainLoanReceiptViewController* con = [[QCMainLoanReceiptViewController alloc] init];
        con.brief.loanId=[info integerValue];
        con.hidesBottomBarWhenPushed = YES;
        [[self getCurrentNav] pushViewController:con animated:YES];
       
    }else if ([type isEqualToString:@"myLoan"]){//我的拮据首页 。
        //0显示借入， 1显示借出， 2显示借条，  3显示AA借条   4 显示
        /*  旧的借条中心 20160304
        OverdueModel *overdueModel = [OverdueModel shareOverdueModel];
        NSInteger index=[info integerValue];
        LoanCenterViewController *loan=[[LoanCenterViewController alloc]init];
        loan.selectedIndex=index;
        loan.HighLightID = overdueModel.HighLightID;
        [[self getCurrentNav] pushViewController:loan animated:YES];
        */
        //新的借条中心
        YXBLoanCenterViewController *loanCenterVC = [[YXBLoanCenterViewController alloc] init];
        loanCenterVC.loanType = 2;
        loanCenterVC.hidesBottomBarWhenPushed = YES;
        [[YXBTool getCurrentNav] pushViewController:loanCenterVC animated:YES];

        
    }else if ([type isEqualToString:@"aaPay"]){//aa收款详情页面
        AAReceivablesDetailViewController *controller = [[AAReceivablesDetailViewController alloc] init];
        controller.record = [info integerValue];
        [[self getCurrentNav] pushViewController:controller animated:YES];
        
        
    }else if ([type isEqualToString:@"aaLoan"]){//跳转到aa借条详情页面
        // 参数1：是发起者还是参与者1为发起者2为参与者
        //参数2：代表AA借条id
        NSArray *array = [info componentsSeparatedByString:@"&"];
        if (array.count != 2) {
            return;
        }
        NSString *can1 = array[0];// 参数1: 1普通 2闪电;
        NSString *can2 = array[1];// 参数2: 是否为放款人  1是，0不是;
        
        if ([can1 integerValue]==1) {
            QCBorrowManageViewController *manage=[[QCBorrowManageViewController alloc]init];
            manage.AALoanId=[can2 integerValue];
            [[self getCurrentNav] pushViewController:manage animated:YES];
          
        }
        else if ([can1 integerValue]==2){
            AAReceiptViewController *receipt=[[AAReceiptViewController alloc]init];
            receipt.loanId=[can2 integerValue];
            [[self getCurrentNav] pushViewController:receipt animated:YES];
            
        }
  
        
    }else if ([type isEqualToString:@"loanDetail"]){//友借友还详情页面

        Loan *loan = [[Loan alloc] init];
        LoanOrRepayMessageViewController * messageViewController =  [[LoanOrRepayMessageViewController alloc]init];
        NSArray *array = [info componentsSeparatedByString:@"&"];
        if (array.count != 4) {
            return;
        }
        NSString *can1 = array[0];// 参数1: 1普通 2闪电;
        NSString *can2 = array[1];// 参数2: 是否为放款人  1是，0不是;
        NSString *can3 = array[2];// 参数3：借款单ID;
        NSString *can4 = array[3];// 参数4 : 借款单类型 1位普通借款单，2通信录好友，3微信好友;

        if ([can2 isEqualToString:@"0"]) {
            messageViewController.bOrL = BORROWER;
        }else if ([can2 isEqualToString:@"1"]){
            messageViewController.bOrL =LENDERS ;
        }
        loan.t_id = [can3 integerValue];
        loan.loanType = [can1 integerValue];
        loan.loanFriendType = [can4 integerValue];
        messageViewController.loan = loan;
        [[self getCurrentNav] pushViewController:messageViewController animated:YES];
    }else if ([type isEqualToString:@"agentPay"]){//信分期代付页面
        PayForanotherViewController *ctr = [[PayForanotherViewController alloc] init];
        ctr.helpID = [info integerValue];
        ctr.hidesBottomBarWhenPushed = YES;
        [[self getCurrentNav] pushViewController:ctr animated:YES];
    }else if ([type isEqualToString:@"guaranteePay"]){//信分期好友担保详情页面
        GuaranteeDaifuDetailViewController *ctr = [[GuaranteeDaifuDetailViewController alloc] init];
        ctr.guaranteeID = [info integerValue];
        ctr.hidesBottomBarWhenPushed = YES;
        [[self getCurrentNav] pushViewController:ctr animated:YES];
    }else if ([type isEqualToString:@"loanV2"]){//结局详情
        MyLoanViewController *ctr = [[MyLoanViewController alloc] init];
        ctr.loanID = [info integerValue];
        ctr.hidesBottomBarWhenPushed = YES;
        [[self getCurrentNav] pushViewController:ctr animated:YES];
    }
    
}
+ (void)isNoLoginTologin { //如果没登陆 去登陆
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    if (!userModel.isLogin) {
        [self toLoginYXB];
        return;
    }
}


+ (NSString *)getURL:(NSString*)url params:(NSString *)params
{   NSString *string;
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    
    //        if (style == L_myList) {
    NSString *userToken = userModel.user.yxbToken;
    if (userToken == nil)
    {
        userToken = @"";
    }
    
    if (![url hasPrefix:@"https"]) {
        url = [NSString stringWithFormat:@"%@%@",YXB_IP_ADRESS,url];
    }
    
//    NSString *locationString = [self getStamp];
    NSString *b = [url substringFromIndex:url.length-1];
    if ([b isEqualToString:@"/"]) {
        url = [url substringToIndex:[url length] - 1];
    }
    
    if ([self containString:@"?" sourceString:url]) {
        if (params==nil) {
            string=[NSString stringWithFormat:@"%@&data=%@",url,[self getClearWebUrl]];
        }
        
        else{
            string=[NSString stringWithFormat:@"%@&data=%@&%@",url,[self getClearWebUrl],params];
        }
        
    }
    else
    {
        if (params==nil) {
            string=[NSString stringWithFormat:@"%@?data=%@",url,[self getClearWebUrl]];
        }
        
        else{
            string=[NSString stringWithFormat:@"%@?data=%@&%@",url,[self getClearWebUrl],params];
        }
        
    }

    
    NSLog(@"url == %@",string);
    
    return string;
    
}


+(CGSize)getFontSizeWithString:(NSString *)words font:(UIFont *)font constrainSize:(CGSize)cSize
{
    CGSize size = CGSizeMake(0, 0);
    if (words != nil) {
        if ([self isIOS7OrLater]) {
            
            size = [words boundingRectWithSize:CGSizeMake(cSize.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
            //        /**
            //         *   @author zjp
            //         *
            //         *   7.0之后用
            //         */
            //        NSDictionary *attribute = @{NSFontAttributeName: font};
            //        size = [words boundingRectWithSize:CGSizeMake(cSize.width, CGFLOAT_MAX) options:\
            //                               NSStringDrawingTruncatesLastVisibleLine |
            //                               NSStringDrawingUsesLineFragmentOrigin |
            //                               NSStringDrawingUsesFontLeading
            //                                                         attributes:attribute context:nil].size;
            
        }
        else
        {
            
            size = [words boundingRectWithSize:CGSizeMake(cSize.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
            
        }

    }
    
    return size;
    
}



+(BOOL)isIOS7OrLater
{
    BOOL isIOS7 = NO;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        isIOS7 = YES;
    }
    
    //#ifndef __CPBao_OS_SDK_V7__
    //    isIOS7 = NO;
    //#endif
    
    return isIOS7;
}



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
+(NSString *)getMD5StringWithStamp:(NSString *)stamp token:(NSMutableString *)token
{
    if (stamp == nil) {
        NSDate *date = [NSDate date];
        NSDateFormatter *dataformatter=[[NSDateFormatter alloc]init];
        [dataformatter setDateFormat:@"yyyyMMddHHmmss"];
        stamp = [dataformatter stringFromDate:date];
    }
    NSMutableString *md5String = [[NSMutableString alloc] init];
    [md5String appendString:token];
    //创建数字与串之间的对应关系
    NSArray *numArray = [NSArray arrayWithObjects:@"#:",@":@",@"@~",@"~-",@"-%",@"%&",@"&*",@"*<",@"<>",@">#", nil];
    
    //获取时间戳的倒数第三位
    NSString *key = nil;
    if (stamp != nil && [stamp length] == 14) {
        key = [stamp substringWithRange:NSMakeRange([stamp length] - 3, 1)];
    }
    
    //token拼接倒数第三位对应的串
    [md5String appendString:numArray[[key integerValue]]];
    
    //针对这个字符串   做stamp 后两位次数再加20次的md5循环

    
    NSInteger times = 20 + [[stamp substringWithRange:NSMakeRange([stamp length] - 2, 2)] integerValue];
    
    for (int i = 0; i < times; i ++) {
        md5String = (NSMutableString *)[self md5:md5String];
    }
    
    return md5String;
}

+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];

//    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    //    return (NSString *)result;
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ]; 
}

/**
 *  @author chenglibin
 *
 *  跳转浏览器
 *
 *  @param url url
 */
+(void) jumpSafariWithUrl:(NSString*) url
{
    NSLog(@"url = %@", url);
//    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSString* textURL = [url stringByReplacingOccurrencesOfString:@"%0A" withString:@""];
    NSLog(@"jumpSafariWithUrl = %@", url);
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"jumpSafariWithUrl en === %@", url);

    NSURL *cleanURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",url]];
    [[UIApplication sharedApplication] openURL:cleanURL];
}

/**
 *  @author chenglibin
 *
 *  跳转内部浏览器
 *
 *  @param url       url
 *  @param hasTopBar 是否显示导航栏
 */
+(void)jumpInnerSafaryWithUrl:(NSString *)url hasTopBar:(BOOL)hasTopBar titleName:(NSString *)titleName
{
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    QCBaseViewController *baseVC;;
    if (hasTopBar) {
        baseVC = [[YXBWebNavViewController alloc] initWithURL:url];
        ((YXBWebNavViewController *)baseVC).titleName = titleName;
    }
    else
    {
        baseVC = [[YXBWebViewController alloc] initWithURL:url];
    }
    baseVC.hidesBottomBarWhenPushed = YES;
    [[self getCurrentNav] pushViewController:baseVC animated:YES];

}


/**
 *  支付专用
 *
 *  跳转内部浏览器
 *
 *  @param url       url
 *  @param hasTopBar 是否显示导航栏
 */
+(void)jumpInnerSafaryWithUrl:(NSString *)url hasTopBar:(BOOL)hasTopBar titleName:(NSString *)titleName type:(NSInteger)type //type //1.付款 2.放款 3.我的借条 4.视频审核 5.图片点击播放视频
{
//    if (type == 0) {
//        [self jumpInnerSafaryWithUrl:url hasTopBar:hasTopBar titleName:titleName];
//        return;
//    }
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    ZhifuViewController   *baseVC = [[ZhifuViewController alloc] initWithURL:url];
    baseVC.hidesBottomBarWhenPushed = YES;
    baseVC.title = titleName;
    baseVC.type = type;
    [[YXBTool getCurrentNav] pushViewController:baseVC animated:YES];
    
}



/**
 *  @author pengcheng
 *
 *  跳转内部浏览器
 *
 *  @param url       url
 *  @param hasTopBar 是否显示导航栏
 */
+(void)jumpInnerSafaryWithUrl:(NSString *)url hasTopBar:(BOOL)hasTopBar titleName:(NSString *)titleName view:(UIView *)view
{
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    QCBaseViewController *baseVC;;
    if (hasTopBar) {
        baseVC = [[YXBWebNavViewController alloc] initWithURL:url];
        ((YXBWebNavViewController *)baseVC).titleName = titleName;
    }
    else
    {
        baseVC = [[YXBWebViewController alloc] initWithURL:url];
    }
    
    UIViewController *vc = [self getViewControllerWithView:view];
    if (vc.navigationController != nil) {
        [vc.navigationController pushViewController:baseVC animated:YES];
    }
    
}

//是否包含指定字符
+(BOOL)containString:(NSString *)str sourceString:(NSString *)sourceString
{
    BOOL isContain = NO;
    if ((sourceString != nil) && (str != nil)) {
        if (!([sourceString rangeOfString:str].location == NSNotFound)) {
            isContain = YES;
        }
    }
    
    return isContain;
}

//计算label高度
+(CGFloat)countLabelHeightWithText:(NSString *)text font:(UIFont *)font labelWidth:(CGFloat)width {
    CGSize size = CGSizeMake(width, MAXFLOAT);
    if (KDeviceOSVersion >= 7.0)
    {
        NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
        
        size =[text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    }
    else
    {

//        size = [text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
        size = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
    }
    
    return size.height;

}

//生成新尺寸图片
+(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}


/**
 *  @author chenglibin
 *
 *  支付统一跳转
 *
 *  @param buyJson 由 cgLoan等生成的 串
 *  @param money   总钱数
 */
+(void)jumpToInnerPayDetailWithJson:(NSString *)buyJson money:(CGFloat)money
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    [dic setObject:buyJson forKey:@"json"];
    [dic setObject:[NSString stringWithFormat:@"%.2f",money] forKey:@"money"];
    NSString *jsonStr = [self jsonEqualWithDic:dic];

//    NSString *url = [self getURL:@"http://60.195.254.33:8083/charge/alipay.jsp?" params:jsonStr];
    NSString *str=[NSString stringWithFormat:@"%@charge/alipay.jsp?",YXB_IP_ADRESS];
    NSString *url=[self getURL:str params:jsonStr];
    [self jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"支付确认"];
    
}

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
+(NSString*)jsonStringWithPrettyPrint:(BOOL) prettyPrint dic:(NSDictionary *)dic
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:(NSJSONWritingOptions)    (prettyPrint ? NSJSONWritingPrettyPrinted : 0)
                                                         error:&error];
    
    if (!jsonData) {
        NSLog(@"bv_jsonStringWithPrettyPrint: error: %@", error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

/**
 *  @author chenglibin
 *
 *  通过字典生成 带等号的字符串
 *
 *  @param dic dic
 *
 *  @return 转换后的串
 */
+(NSString *)jsonEqualWithDic:(NSDictionary *)dic
{
    NSArray *array = [dic allKeys];
    NSMutableString *jsonStr = [[NSMutableString alloc] init];
    
    for (NSString *key in array) {
        NSString *value = dic[key];
        [jsonStr appendFormat:@"%@=%@&",key,value];
    }
    
    [jsonStr deleteCharactersInRange:NSMakeRange([jsonStr length] - 1, 1)];
    return jsonStr;
}



//三位一个，加逗号
+ (NSString *)countNumAndChangeformat:(NSString *)nums{
    NSString *num = [NSString stringWithFormat:@"%.2f",[nums doubleValue]];
    NSRange range = [num rangeOfString:@"."];
    NSString *str1 = [num substringFromIndex:range.location];
    NSString *str = [num substringToIndex:range.location];
    NSMutableString *string = [NSMutableString stringWithString:str];
    NSMutableString *newstring = [NSMutableString stringWithString:str];
    int x = ([newstring length] % 3);
    int j = 0;
    for(int i =0; i < [newstring length]; i++)
    {
        if (i != 0) {
            
            if ((x == 0) & (i % 3 == 0)) {
                [string insertString:@"," atIndex:j];
                j++;
            }
            if ((x == 1) & (i % 3 == 1)) {
                [string insertString:@"," atIndex:j];
                j++;
            }
            if ((x == 2) & (i % 3 == 2)) {
                [string insertString:@"," atIndex:j];
                j++;
            }
        }
        j++;
    }
    return [NSString stringWithFormat:@"%@%@",string,str1];
    //    return string;
}


//呼叫电话
+ (void)callTelphoneWithNum:(NSString *)num {
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",num];
    //            NSLog(@"str======%@",str);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
+(void)sendMessageWithNum:(NSString *)num{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"sms://%@",num];
    //            NSLog(@"str======%@",str);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
    
}

+(NSString*)getDocumentPath {
    //Creates a list of directory search paths.-- 创建搜索路径目录列表。
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    //常量NSDocumentDirectory表面我们正在查找的Document目录路径，
    //常量NSUserDomainmask表明我们希望将搜索限制于我们应用程序的沙盒中。
    return [paths objectAtIndex:0];
    //这样我们就可以得到该数组的第一值，也仅此一值，因为每一个应用程序只有一个Document文件夹。
}

+(NSString*) jsonSaveGetStrWithDic:(NSDictionary*) dic key:(NSString*) key {
    id obj = [dic objectForKey:key];
    if (obj != nil &&  [obj isKindOfClass:[NSString class]]) {
        NSString* res = (NSString*) obj;
        return res;
    }
    return nil;
}


/**
 *  @author chenglibin
 *
 *  白条学生还款详情 状态码对应字符串名称
 *
 *  @param statusCode <#statusCode description#>
 *
 *  @return <#return value description#>
 */
//+(NSString *)getStatusWithStatusCode:(NSInteger)statusCode
//{
//    if()
//}

/**
 *  @author chenglibin
 *
 *  根据登录状态返回token
 *
 *  @return yxbToken
 */

+(NSString *)getUserToken
{
    NSString *token = nil;
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    if (userModel != nil && userModel.isLogin == YES) {
        token = userModel.user.yxbToken;
    }
    else
    {
        token = @"";
    }
    
    
    return token;
}


//根据时间字符串返回与当前时间的时间差
+ (double)intervalSinceNow:(NSString *)theDate
{
    NSDateFormatter *date = [[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d = [date dateFromString:theDate];
    
    NSTimeInterval late = [d timeIntervalSince1970];
    
    NSDate *nowDate = [NSDate date];
    NSTimeInterval now = [nowDate timeIntervalSince1970];
    
    NSTimeInterval cha = late-now;
    
    return cha;
}

+(UINavigationController *)getCurrentNav
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return appDelegate.rootNav;

}


/**
 *  @author zhangjinpeng
 *
 *  1灰色  2  3  4 反色
 *
 *  @param 
 *
 *  @return 图片置灰
 */
+(UIImage*) grayscale:(UIImage*)anImage type:(char)type {
    CGImageRef  imageRef;
    imageRef = anImage.CGImage;
    
    size_t width  = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    

    size_t                  bitsPerComponent;
    bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
    

    size_t                  bitsPerPixel;
    bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
    

    size_t                  bytesPerRow;
    bytesPerRow = CGImageGetBytesPerRow(imageRef);
    

    CGColorSpaceRef         colorSpace;
    colorSpace = CGImageGetColorSpace(imageRef);
    

    CGBitmapInfo            bitmapInfo;
    bitmapInfo = CGImageGetBitmapInfo(imageRef);
    

    bool                    shouldInterpolate;
    shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
    

    CGColorRenderingIntent  intent;
    intent = CGImageGetRenderingIntent(imageRef);
    

    CGDataProviderRef   dataProvider;
    dataProvider = CGImageGetDataProvider(imageRef);
    

    CFDataRef   data;
    UInt8*      buffer;
    data = CGDataProviderCopyData(dataProvider);
    buffer = (UInt8*)CFDataGetBytePtr(data);
    

    NSUInteger  x, y;
    for (y = 0; y < height; y++) {
        for (x = 0; x < width; x++) {
            UInt8*  tmp;
            tmp = buffer + y * bytesPerRow + x * 4;
            UInt8 red,green,blue;
            red = *(tmp + 0);
            green = *(tmp + 1);
            blue = *(tmp + 2);
            
            UInt8 brightness;
            
            switch (type) {
                case 1:
                    brightness = (77 * red + 28 * green + 151 * blue) / 256;
                    
                    *(tmp + 0) = brightness;
                    *(tmp + 1) = brightness;
                    *(tmp + 2) = brightness;
                    break;
                    
                case 2://
                    *(tmp + 0) = red;
                    *(tmp + 1) = green * 0.7;
                    *(tmp + 2) = blue * 0.4;
                    break;
                    
                case 3://
                    *(tmp + 0) = 255 - red;
                    *(tmp + 1) = 255 - green;
                    *(tmp + 2) = 255 - blue;
                    break;
                    
                default:
                    *(tmp + 0) = red;
                    *(tmp + 1) = green;
                    *(tmp + 2) = blue;
                    break;
            }
            
        }
    }
    

    CFDataRef   effectedData;
    effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
    CGDataProviderRef   effectedDataProvider;
    effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
    CGImageRef  effectedCgImage;
    UIImage*    effectedImage;
    effectedCgImage = CGImageCreate(
                                    width, height,
                                    bitsPerComponent, bitsPerPixel, bytesPerRow,
                                    colorSpace, bitmapInfo, effectedDataProvider,
                                    NULL, shouldInterpolate, intent);
    effectedImage = [[UIImage alloc] initWithCGImage:effectedCgImage];
    CGImageRelease(effectedCgImage);
    CFRelease(effectedDataProvider);
    CFRelease(effectedData);
    CFRelease(data);
    
    return effectedImage;
}


/**
 *  @author zhangjinpeng
 *
 *  根据登录状态返回Cookie
 *
 *  @return Cookie
 */

+(NSString *)getYxbCookie
{
    NSString *Cookie = nil;
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    if (userModel.user.yxbCookie != nil) {
        Cookie = userModel.user.yxbCookie;
    }else {
        Cookie = @"";
    }
    
//    Cookie = @"";
    return Cookie;
}

//微信好友分享
+ (void)shareToWeixinSessionContent:(NSString *)content imgName:(UIImage *)imgName url:(NSString *)url title:(NSString *)title callBackBlock:(ShareCallBackBlock)callBack
{
    if (![WXApi isWXAppInstalled]) {
        [ProgressHUD showErrorWithStatus:@"请安装微信后重试！"];
        return;
    }
    
    if (imgName == nil) {
        imgName = [UIImage imageNamed:@"shareImg"];
    }
    
    if (url != nil) {
//        url = [YXBTool getURL:url params:nil];
        
    }
    //1、创建分享参数
    NSArray* imageArray= @[imgName];
    NSURL *urls=[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"imageArray1 : %@",imageArray);
    
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:content
                                         images:imageArray
                                            url:urls
                                          title:title
                                           type:SSDKContentTypeAuto];
        //进行分享
        [ShareSDK share:SSDKPlatformSubTypeWechatSession //传入分享的平台类型
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) { // 回调处理....}];
             switch (state) {
                 case SSDKResponseStateSuccess:
                 {
                     [KVNProgress showSuccessWithStatus:@"分享成功"];
                     break;
                 }
                 case SSDKResponseStateCancel:
                 {
                     [KVNProgress showErrorWithStatus:@"取消分享"];
                     break;
                 }
                 case SSDKResponseStateFail:
                 {
                     [KVNProgress showErrorWithStatus:@"分享失败"];
                     break;
                 }
                 default:
                     break;
             }
             
         }];
    }
    

//    //创建分享内容
//    id<ISSContent> publishContent = [ShareSDK content:content
//                                       defaultContent:@""
//                                                image:[ShareSDK jpegImageWithImage:imgName quality:kImageQuality]
//                                                title:title
//                                                  url:url
//                                          description:nil
//                                            mediaType:SSPublishContentMediaTypeNews];
//    
//    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
//                                                         allowCallback:YES
//                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
//                                                          viewDelegate:nil
//                                               authManagerViewDelegate:nil];
//    
//    
//    //显示分享菜单
//    [ShareSDK showShareViewWithType:ShareTypeWeixiSession
//                          container:nil
//                            content:publishContent
//                      statusBarTips:YES
//                        authOptions:authOptions
//                       shareOptions:[ShareSDK defaultShareOptionsWithTitle:nil
//                                                           oneKeyShareList:[NSArray defaultOneKeyShareList]
//                                                            qqButtonHidden:YES
//                                                     wxSessionButtonHidden:NO
//                                                    wxTimelineButtonHidden:YES
//                                                      showKeyboardOnAppear:NO
//                                                         shareViewDelegate:nil
//                                                       friendsViewDelegate:nil
//                                                     picViewerViewDelegate:nil]
//                             result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//                                 
//                                 if (state == SSResponseStateBegan) {
//                                     NSLog(@"分享开始");
//                                 }
//                                 else if (state == SSResponseStateSuccess)
//                                 {
//                                     callBack();
//                                 }
//                                 else if (state == SSResponseStateFail)
//                                 {
//                                     UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:[error errorDescription] delegate:self
//                                                                           cancelButtonTitle:@"确定"otherButtonTitles:nil, nil];
//                                     [alter show];
//                                     NSLog(@"分享失败,错误码:%ld,错误描述:%@", (long)[error errorCode], [error errorDescription]);
//                                 } else if (state == SSResponseStateCancel) {
//                                     NSLog(@"分享取消");
//                                 }
//                             }];
}

//分享给微信朋友圈
+ (void)shareToWeixinTimelineContent:(NSString *)content imgName:(UIImage *)imgName url:(NSString *)url title:(NSString *)title callBackBlock:(ShareCallBackBlock)callBack
{
    if (![WXApi isWXAppInstalled]) {
        [ProgressHUD showErrorWithStatus:@"请安装微信后重试！"];
        return;
    }
    
    if (imgName == nil) {
        imgName = [UIImage imageNamed:@"shareImg"];
    }
    
    if (url != nil) {
        url = [YXBTool getURL:url params:nil];
        
    }
    NSURL *urls=[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //1、创建分享参数
    NSArray* imageArray =@[imgName];

    NSLog(@"imageArray2 : %@",imageArray);
    
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:content
                                         images:imageArray
                                            url:urls
                                          title:title
                                           type:SSDKContentTypeAuto];
        //进行分享
        [ShareSDK share:SSDKPlatformSubTypeWechatTimeline //传入分享的平台类型
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) { // 回调处理....}];
             switch (state) {
                 case SSDKResponseStateSuccess:
                 {
                     [KVNProgress showSuccessWithStatus:@"分享成功"];
                     break;
                 }
                 case SSDKResponseStateCancel:
                 {
                     [KVNProgress showErrorWithStatus:@"取消分享"];
                     break;
                 }
                 case SSDKResponseStateFail:
                 {
                     [KVNProgress showErrorWithStatus:@"分享失败"];
                     break;
                 }
                 default:
                     break;
             }
             
         }];
        
    }

//    //创建分享内容
//    id<ISSContent> publishContent = [ShareSDK content:content
//                                       defaultContent:@""
//                                                image:[ShareSDK jpegImageWithImage:imgName quality:kImageQuality]
//                                                title:title
//                                                  url:url
//                                          description:nil
//                                            mediaType:SSPublishContentMediaTypeNews];
//    
//    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
//                                                         allowCallback:YES
//                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
//                                                          viewDelegate:nil
//                                               authManagerViewDelegate:nil];
//    
//    //显示分享菜单
//    [ShareSDK showShareViewWithType:ShareTypeWeixiTimeline
//                          container:nil
//                            content:publishContent
//                      statusBarTips:YES
//                        authOptions:authOptions
//                       shareOptions:[ShareSDK defaultShareOptionsWithTitle:nil
//                                                           oneKeyShareList:[NSArray defaultOneKeyShareList]
//                                                            qqButtonHidden:YES
//                                                     wxSessionButtonHidden:YES
//                                                    wxTimelineButtonHidden:NO
//                                                      showKeyboardOnAppear:NO
//                                                         shareViewDelegate:nil
//                                                       friendsViewDelegate:nil
//                                                     picViewerViewDelegate:nil]
//                             result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//                                 
//                                 if (state == SSResponseStateBegan) {
//                                     NSLog(@"分享开始");
//                                 }
//                                 else if (state == SSResponseStateSuccess)
//                                 {
//                                     [ProgressHUD showSuccessWithStatus:@"分享成功"];
//                                     NSLog(@"分享成功");
////                                     shareNum++;
////                                     if (shareNum >= 100) {
////                                         shareNum = 0;
////                                     }
//                                     callBack();
//                                 }
//                                 else if (state == SSResponseStateFail)
//                                 {
////                                     [ProgressHUD showErrorWithStatus:[error errorDescription]];
//                                     UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:[error errorDescription] delegate:self
//                                                           cancelButtonTitle:@"确定"otherButtonTitles:nil, nil];
//                                     [alter show];
//                                     NSLog(@"分享失败,错误码:%ld,错误描述:%@", (long)[error errorCode], [error errorDescription]);
//                                 } else if (state == SSResponseStateCancel) {
//                                     NSLog(@"分享取消");
//                                 }
//                             }];
}

//判断当前网络连接状态

+(BOOL)isConnectionAvailable
{
    Reachability *r = [Reachability reachabilityWithHostName:@"www.51jt.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            // 没有网络连接
            break;
        case ReachableViaWWAN:
            // 使用3G网络
            break;
        case ReachableViaWiFi:
            // 使用WiFi网络
            break;
    }
    if ([r currentReachabilityStatus] == NotReachable) {
        return NO;
    }else{
        return YES;
    }
}

//获取时间戳
+(NSString *)getStamp
{
    NSDate *date = [NSDate date];
    NSDateFormatter *dataformatter=[[NSDateFormatter alloc]init];
    [dataformatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *locationString=[dataformatter stringFromDate:date];
    return locationString;

}


//判断余额 跳转充值

+(void)jumpToPayVC
{
    
    PayHomeViewController *pay = [[PayHomeViewController alloc] init];
    
    [[self getCurrentNav] pushViewController:pay animated:YES];
    
}

//保存所有系统变量的方法
+(void)SaveSysConfig{
    
    @synchronized(self) {
        NSString *err = nil;
        NSString *file = [[YXBTool getDocumentPath ] stringByAppendingPathComponent:CONFIG_FILE_PATH];
        //
        NSMutableDictionary *saveConfig = [[NSMutableDictionary alloc] init];
        //
        id key;
        NSEnumerator *enumerator = [yxbSysConfig keyEnumerator];
        while (key = [enumerator nextObject]) {
            
            if([[key substringToIndex:1] isEqualToString:@"_"] )
            {
                [saveConfig setObject:[yxbSysConfig valueForKey:key] forKey:key];
                //	NSLog(@"saveconfigkey=%@,%@",key,[saveConfig valueForKey:key]);
            }
            
        }
        //NSLog(saveConfig);
        
        //
        NSData *pd = [NSPropertyListSerialization dataFromPropertyList:saveConfig format:NSPropertyListXMLFormat_v1_0 errorDescription:&err];
        if(nil == err)
            [pd writeToFile:file atomically:YES];
    }
}

//获取IDFA
+(NSString*) getIdfa {
    if (KDeviceOSVersion >= 6.0) {
        NSString *adId =[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        
        
        NSLog(@"getIdfa = %@", adId);
        return adId;
    }
    else
    return nil;
}



//两个日期之间相差的天数
+(NSInteger)numberOfDaysBetween:(NSString *)start and:(NSString *)end
{
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
//    [f setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [f setDateFormat:@"yyyy-MM-dd"];

    //只计算日  不计算时分秒
    NSDate *startDate = [f dateFromString:[start substringToIndex:10]];
    NSDate *endDate = [f dateFromString:[end substringToIndex:10]];
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:startDate
                                                          toDate:endDate
                                                         options:NSCalendarWrapComponents];

    return [components day];
}

//获取当前时间
+(NSString *)getCurrentTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

//替换用户  cookie
+(void)replaceUserYXBCookieWithCookie:(NSString *)cookie
{
    NSLog(@"新 cookie---%@",cookie);
    NSString *oldCookie = [self getYxbCookie];
    NSLog(@"旧 oldCookie---%@",oldCookie);

    if (cookie != nil && ![oldCookie isEqualToString:cookie] && [cookie length] > 2) {
        QCUserModel *model = [[QCUserManager sharedInstance] getLoginUser];
        model.user.yxbCookie = cookie;
        [[QCUserManager sharedInstance] setLoginUser:model];
        

    }
}

+(NSString*)getClearWebUrl
{
    
    /*
     * 参数data={"cookie": ,"token": ,"v": ,"pt": ,"tmp": ,"encToken": ,"other": {}}
     */
    
    NSMutableDictionary* json = [[NSMutableDictionary alloc] init];
    NSString *cookie = [YXBTool getYxbCookie];
    [json setObject:cookie forKey:@"cookie"];
    
    NSString *token = [YXBTool getUserToken];
    if (token == nil) {
        token = @"";
    }
    [json setObject:token forKey:@"token"];
    
    [json setObject:YXB_VERSION_CODE forKey:@"v"];
    [json setObject:@"ios" forKey:@"pt"];
    [json setObject:[YXBTool getStamp] forKey:@"tmp"];
    NSString *encToken= [YXBTool getMD5StringWithStamp:[YXBTool getStamp] token:[NSMutableString stringWithString:token]];
    if (encToken == nil) {
        encToken = @"";
    }
    [json setObject:encToken forKey:@"encToken"];
    NSError *error;
    NSData* jsonDate = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString* paramsString = [[NSString alloc] initWithData:jsonDate encoding:NSUTF8StringEncoding];
    
//    return [paramsString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return paramsString;
}
//通过事件响应者链获取视图的控制器
+ (UIViewController *)getViewControllerWithView:(UIView *)view {
    UIResponder *next = view.nextResponder;
    
    do {
        
        //判断响应者是否为视图控制器
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        
        next = next.nextResponder;
        
    } while (next != nil);
    
    return nil;
}


//跳转登录
+(void)toLoginYXB
{
    QCLoginOneViewController * loginView = [[QCLoginOneViewController alloc]init];
    UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginView];
    [[YXBTool getCurrentNav] presentViewController:loginNav animated:YES completion:nil ];
}


//去掉换行符

+(NSString *)replaceBRString:(NSString *)url
{
    NSMutableString *responseString = [NSMutableString stringWithString:url];
    NSString *search = @"\n";
    NSString *replace = @"";
    
    NSRange substr = [responseString rangeOfString:search];
    
    while (substr.location != NSNotFound) {
        [responseString replaceCharactersInRange:substr withString:replace];
        substr = [responseString rangeOfString:search];
    }
    
    return responseString;
}

+(void)setGesturePassWord:(NSString *)ps
{
    [[NSUserDefaults standardUserDefaults] setObject:ps forKey:@"gesturePassword"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

//手机号码验证
+(BOOL)validateMobile:(NSString *)mobile
{
    
    
     //手机号以13， 15，18开头，八个 \d 数字字符
     NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(17[0,0-9])|(18[0,0-9]))\\d{8}$";
     NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
     NSLog(@"%d",[phoneTest evaluateWithObject:mobile]);
     
     //    if ([phoneTest evaluateWithObject:mobile] == NO) {
     //        UIAlertView * alerView = [[UIAlertView alloc]initWithTitle:@"警告" message:@"请输入正确的手机号码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
     //        [alerView show];
     //    }
     
     
//     return [phoneTest evaluateWithObject:mobile];
    
    if (mobile != nil && [mobile length] == 11) {
        return YES;

    }
    return NO;
}


//获取Documents目录
+(NSString *)dirDoc
{
    //[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"app_home_doc: %@",documentsDirectory);
    return documentsDirectory;
}

//汉字转拼音
+(NSString *)pinyinWithText:(NSString *)hanziText
{
    NSMutableString *ms = [[NSMutableString alloc] initWithString:@""];

    if ([hanziText length]) {
        ms = [[NSMutableString alloc] initWithString:hanziText];
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
        }
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
        }
    }
    [ms replaceOccurrencesOfString:@" " withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, ms.length)];
    return [ms lowercaseString];
}

//判断输入字符是否在26个字母里

+(BOOL)isAlphabetContainsChar:(NSString *)str
{
    
    if (str != nil && str.length == 1) {
        NSArray *alphabetArray = [NSArray arrayWithObjects:                         @"a",@"b",@"c",@"d",@"e",@"f",@"g",
            @"h",@"i",@"j",@"k",@"l",@"m",@"n",
            @"o",@"p",@"q",@"r",@"s",@"t",
            @"u",@"v",@"w",@"x",@"y",@"z",nil];
        if ([alphabetArray containsObject:str]) {
            return YES;
        }
    }
    
    return NO;
}

+(NSString *)decodeFromPercentEscapeString:(NSString *) input
{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    [outputStr replaceOccurrencesOfString:@"\n"
                               withString:@""
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

//获取字母表数组
+(NSArray *)getAlphaBetNumbers
{
    NSArray *array=@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"#"];
    return array;

}

//计算两个日期相差的天数  endDay是字符串
+(NSInteger)daysBetweenTwoDaysWithEndDayStr:(NSString *)endDay
{
    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSDateFormatter *dateFormatter = [DateFormatInstance shareInstance].dateFormat;

//    NSDate *endDate = [dateFormatter dateFromString:endDay];
    NSDate *endDate = [self dateWithString:endDay];
    NSDate *nowDate = [self getCurrentDate];
    nowDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:nowDate]];


//    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
//    NSDate *nowDate = [NSDate date];
//    nowDate =  [dateFormatter dateFromString:[dateFormatter stringFromDate:nowDate]] ;
//    NSInteger days = [endDate timeIntervalSinceDate:nowDate];
//    days = days/(3600*24);
    
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit fromDate:nowDate toDate:endDate options:0];
    NSInteger day = [components day] + 1;
    return day;
    
}


+(NSString *)dateWithCurrentDateWithPeriodMonths:(NSInteger)month
{
    NSDate *newDate = nil;
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSDateFormatter *dateFormatter = [DateFormatInstance shareInstance].dateFormat;

    NSDate *nowDate = [self getCurrentDate];
    nowDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:nowDate]];

    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];

    NSCalendar *calendar = [NSCalendar currentCalendar];
    if (month == 7 || month == 14) {
        //月份当成天数使用 一周  两周
        [dateComponents setMonth:0];
        [dateComponents setDay:(month -1)];
        newDate = [calendar dateByAddingComponents:dateComponents toDate:nowDate options:0];
    }
    else
    {
        //设置月份
        [dateComponents setMonth:month];
        [dateComponents setDay:-1];
        newDate = [calendar dateByAddingComponents:dateComponents toDate:nowDate options:0];

    }

    return [dateFormatter stringFromDate:newDate];

}

+(NSDate *)getCurrentDate
{
    NSDate *date = [NSDate date];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: date];
    
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    return localeDate;
}

//计算利息
+(NSInteger)lixiWithMoney:(NSInteger)money timeInterval:(NSInteger)days yearRate:(CGFloat )yearRate
{
    NSInteger lixi = 0;
    
    CGFloat aLizi = 0.01 * days * (money * yearRate)/360;
    lixi = ceil(aLizi);//向上取整
    return lixi;
}

//计算利率
+(CGFloat)lilvWithMoney:(NSInteger)money timeInterval:(NSInteger)days lixi:(NSInteger)lixi
{
    
    CGFloat lilv = 0;
    if (money > 0 && days > 1) {
        lilv = 100 * (CGFloat)lixi/(CGFloat)money/days*360;

    }
    
    return lilv;
}
//计算期次
//+(NSInteger)getAmortizationNum:(NSInteger)days{
//    NSInteger amortizationNum = (days%30>0)?(days/30+1):days/30;
//    return amortizationNum;
//}

+(NSInteger)getAmortizationNumWithEndDate:(NSString *)endDateStr
{
    if (endDateStr == nil || ![endDateStr isKindOfClass:[NSString class]]) {
    return 0;
    }
    NSInteger month = 0;
    NSInteger day = 0;
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDateFormatter *dateFormatter = [DateFormatInstance shareInstance].dateFormat;
    NSDate *endDate = [dateFormatter dateFromString:endDateStr];

    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //还款日期加一天
    [dateComponents setMonth:0];
    [dateComponents setDay:1];
    endDate = [calendar dateByAddingComponents:dateComponents toDate:endDate options:0];
    
    
    NSDate *nowDate = [self getCurrentDate];
    nowDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:nowDate]];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSMonthCalendarUnit|NSDayCalendarUnit fromDate:nowDate toDate:endDate options:0];
    
    month = [components month];
    day = [components day];
    if (day > 0) {
        month ++;
    }
    return month;

    
}

+(NSDate *)dateWithString:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSDate *endDate = [dateFormatter dateFromString:dateString];

    return endDate;
}

+(NSInteger)yearBetweenTwoDateFromNowTo:(NSString *)endDay
{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSDateFormatter *dateFormatter = [DateFormatInstance shareInstance].dateFormat;

    //    NSDate *endDate = [dateFormatter dateFromString:endDay];
    NSDate *endDate = [self dateWithString:endDay];
    NSDate *nowDate = [self getCurrentDate];
    nowDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:nowDate]];    
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSDayCalendarUnit|NSMonthCalendarUnit fromDate:nowDate toDate:endDate options:0];
    NSInteger year = [components year];
    NSInteger day = [components day];
    NSInteger month = [components month];
    if (day > 0 || month > 0) {
        year = year + 1;
    }
    return year;
}

+(CGFloat)heightWithSize:(CGSize)size width:(CGFloat)width
{
    CGFloat height = (size.height * width)/size.width;
    return height;

}

+(CGFloat)getSquareHeight
{
    NSString *stringNameSelected = @"timesquareS";
    UIImage *sizeImage =[UIImage imageNamed:stringNameSelected];
    CGFloat imageWidth = 80;
    CGFloat h = [YXBTool heightWithSize:sizeImage.size width:imageWidth];
    CGFloat squareViewHeight = 2 * 10 + 2 * h + 10;
    return squareViewHeight;
}

//base64 字符串
+(NSString *)base64EncodedWithString:(NSString *)sourceString
{
    NSString *base64Encoded = @"";
    if(sourceString != nil)
    {
        NSData *nsdata = [sourceString dataUsingEncoding:NSUTF8StringEncoding];
        
        // Get NSString from NSData object in Base64
        base64Encoded = [nsdata base64EncodedStringWithOptions:0];

    }
    return base64Encoded;
    
}


@end
