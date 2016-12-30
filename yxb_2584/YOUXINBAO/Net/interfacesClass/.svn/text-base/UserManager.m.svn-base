/*
 * Created on 2005-8-30
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */





#import "UserManager.h"
//#import "User.h"

@implementation UserManager



///////////////
-(NSSkyArray*) getAllTUser: (NSInteger) from :(NSInteger) size {
    return nil;
}


//-(User*) userLogin:(NSString*) username pass:(NSString*) pass {
//    return [[User alloc] init];
//}

//登录
-(User*) userLoginWithFraudmetrix:(NSString*) username pwd:(NSString*) pwd fraudmetrixToken:(NSString *)fraudmetrixToken {
    return [[User alloc] init];
}

-(User*)refreshUserByToken:(NSString *)yxbToken timestamp:(NSString *)timestamp cookie:(NSString *)cookie{
    return [[User alloc] init];
}

-(User*) loadById:(NSInteger) idaaa  {

    return [[User alloc] init];
}

-(User*) loadById:(NSInteger) idaaa  aaa:(NSString*) a {
    return [[User alloc] init];
}


/////////////

//获取验证码
- (TResultSet *)getVerifyCode:(NSString *)username request_type:(NSInteger)request_type
{
    return [[TResultSet alloc]init];
}
//新获取验证码
- (TResultSet *)getAlterPsdVerifyCode:(NSString *)username{
    return [[TResultSet alloc]init];

}
-(TResultSet*)getVerifyCodeV2:(NSString*)mobile deviceToken:(NSString *)deviceToken imageVCode:(NSString *)imageVCode{
    return [[TResultSet alloc]init];
    
}
//注册用户

//- (TResultSet *)userReg:(NSString *)username verifyCode:(NSString *)verifyCode pwd:(NSString *)pwd{
//    return [[TResultSet alloc]init];
//}
- (TResultSet *)userReg:(NSString *)username verifyCode:(NSString *)verifyCode pwd:(NSString *)pwd phoneType:(NSString *)phoneType channeId:(NSInteger)channelId {
    return [[TResultSet alloc] init];
}

/** 新
 * 注册用户
 *
 * @param username   用户名
 * @param verifyCode 验证码
 * @param pwd        密码
 * @param phoneType  设备类型
 * @param channelId  渠道id
 @param fraudmetrixToken  同盾token
 * @return tResultSet
 */
- (TResultSet *)userRegWithFraudmetrix:(NSString *)username verifyCode:(NSString *)verifyCode pwd:(NSString *)pwd phoneType:(NSString *)phoneType channelId:(NSInteger) channelId fraudmetrixToken:(NSString *) fraudmetrixToken{
    return [[TResultSet alloc] init];
}
//重置密码
- (TResultSet *) resetPwd:(NSString *)username verifyCode:(NSString *)verifyCode newPwd:(NSString *)newPwd{
    return [[TResultSet  alloc]init];
}

//身份验证
- (TResultSet *)uploadIdCardPhotoByUsername:(NSString *)username realname:(NSString *)realname idCardNo:(NSString *)idCardNo idCardFaceAddr:(NSString *)idCardFaceAddr idCardBackAddr:(NSString *)idCardBackAddr idCardBareheadedAddr:(NSString *)idCardBareheadedAddr
{
    return [[TResultSet alloc]init];
}
//上传头像
- (TResultSet *)uploadIconByUsername:(NSString *)username iconAddr:(NSString *)iconAddr
{
    return [[TResultSet alloc]init];
}
//获取用户状态
- (TResultSet *) getAccountStatusByUsername:(NSString *)userName
{
    return [[TResultSet alloc]init];
}

- (TUnreadFlagCount *)getUnreadNoticeFlagByUserInfo:(NSString *)user_info last_query_date:(NSString *)last_query_date
{
    return [[TUnreadFlagCount alloc]init];
}

//刷新用户信息
- (User *)getTUserByUsername:(NSString *)userName
{
    return [[User alloc]init];
}

- (TResultSet*) loadByResultId:(NSInteger) id{
    
    return [[TResultSet alloc] init];
}


- (TResultSet *)getLoanAuthority:(NSString *)user_info
{
    return [[TResultSet alloc]init];
}

///新注册
- (TResultSet*)checkVerifyCode:(NSString*)username verifyCode:(NSString *)verifyCode requestType:(NSInteger)requestType {
    return [[TResultSet alloc]init];
}

//- (void)dealloc
//{
//    [super dealloc];
//}


/**
 * 搜索好友（手机号/友信宝id）
 *
 * @param friendInfo
 * @return
 */
-(User *)searchFriend:(NSString *)friendInfo
{
    return [[User alloc] init];
}


//支付
- (TResultSet*)alipay_recharge:(NSString *)userToken money:(NSString *)money {
    return [[TResultSet alloc] init];
}

//连连支付
- (TResultSet*)lianlian_recharge:(NSString *)userToken money:(NSString *)money {
    return [[TResultSet alloc] init];
}

//银联支付
-(TResultSet *)gainUnionPayTn:(NSString *)userToken money:(NSString *)money
{
    return [[TResultSet alloc] init];
}

/**
 * 易支付
 * 手机控件商户号|订单号
 * @param userId
 * @return
 */
-(TResultSet *)gainPayEaseString:(NSString *)userToken  money:(NSString *)money {
    return [[TResultSet alloc] init];
}

/**
 * 微付通 微信支付
 *
 * @param userToken
 * @return
 */
-(TResultSet *)gainWeicaiPayTn:(NSString *)userToken  money:(NSString *)money{

    return [[TResultSet alloc] init];
}

//修改密码
- (TResultSet*)resetPwdNew:(NSString *)username oldPwd:(NSString *)oldPwd newPwd:(NSString *)newPwd{
    return [[TResultSet alloc] init];
}

/***
 *
 * @param userToken
 * @param mode
 *            表示资金是进帐还是出帐 0进账 1出账 2全部
 * @param pageNum
 *            从1开始
 * @return
 */
-(NSSkyArray *)getFundDetail:(NSString *)userToken mode:(NSInteger)mode pageNum:(NSInteger) pageNum
{
    return [[NSSkyArray alloc] init];
}

/***
 *
 * 获取冻结资金明细
 *
 * @param userToken
 * @param mode
 *            表示资金是进帐还是出帐 0进账 1出账 2全部
 * @param pageNum
 *            从1开始
 * @return
 */
-(NSSkyArray *)getFrozenDetail:(NSString *)userToken mode:(NSInteger)mode pageNum:(NSInteger) pageNum
{
    return [[NSSkyArray alloc] init];

}


/**
 获取催收服务费资金明细
 
 @param usertoken usertoken
 @param mode int类型资金类型, 0进账 1出账 2全部
 @param pageNum  页码
 @return
 */
-(NSSkyArray *)getUrgeFundDetail:(NSString *)usertoken mode:(NSInteger)mode pageNum:(NSInteger) pageNum{
    return [[NSSkyArray alloc] init];
}


/**
 获取法院诉讼服务费资金明细
 
 @param usertoken usertoken
 @param mode int类型资金类型, 0进账 1出账 2全部
 @param pageNum  页码
 @return
 */
-(NSSkyArray *)getLawsuitFundDetail:(NSString *)usertoken mode:(NSInteger)mode pageNum:(NSInteger) pageNum{
    return [[NSSkyArray alloc] init];
    
}









/**
 * 扫描二维码查询二维码用户建议信息
 *
 * @param userToken
 *            登录用户token
 * @param searchYXBId
 *            被扫描人的友信宝id
 * @return
 *
 * @author SKY
 * @date 2015年8月4日
 */
- (UserBriefInfo *)getUserBriefInfo:(NSString *)userToken searchYXBId:(NSString *)searchYXBId {
    return [[UserBriefInfo alloc] init];
}


//校验用户支付密码
/**
 * @param Paw 密码
 * @userToken Paw 用户Token
 * @return
 * @date 2016年5月26日
 */
- (TResultSet *) checkPayPwdWithRedis:(NSString *)userToken pwd:(NSString *)pwd
{
    return [[TResultSet alloc] init];
}
//获取修改支付密码验证码
/**
 * @param username 用户名（手机号）
 * @return
 * @date 2016年5月26日
 */
- (TResultSet *) getModifyPayPwdVerifyCode:(NSString *)username{
    return [[TResultSet alloc] init];
}

//校验修改支付密码验证码
/**
 * @param username 用户token
 * @param verifyCode 验证码
 * @return
 * @date 2016年5月26日
 */
-(TResultSet *) checkPayPwdVerifyCode:(NSString *)userToken verifyCode:(NSString *)verifyCode{
    return [[TResultSet alloc] init];
    
}

//校验身份证号
/**
 * @param username 用户token
 * @param idCard 身份证号
 * @return
 * @date 2016年5月26日
 */
-(TResultSet *) checkUserIdCard:(NSString *)userToken idCard:(NSString *)idCard{
     return [[TResultSet alloc] init];
}
//重置密码
/**
 * @param username 用户token
 * @param setPaw 新密码
 * @return
 * @date 2016年5月26日
 */
-(TResultSet *) setUserPayPwd:(NSString *)userToken setPaw:(NSString *)setPaw{
    return [[TResultSet alloc] init];
    
}

/***
 * 获取理财资金明细
 * @param userToken
 * @param mode
 *            表示资金是进帐还是出帐 0进账 1出账 2全部
 * @param pageNum
 *            从1开始
 * @return
 */
-(NSSkyArray*)getFinanceFundDetail:(NSString*)userToken mode:(NSInteger)mode pageNum:(NSInteger)pageNum{
    return [[NSSkyArray alloc] init];
}

@end
