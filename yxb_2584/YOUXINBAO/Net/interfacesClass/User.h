#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface User : BaseData


/**
* identifier field
*/

@property (nonatomic, assign) NSInteger t_id;

/**
* field 错误编号
*/

@property (nonatomic, assign) NSInteger errCode;

/**
* field 错误提示
*/

@property (nonatomic, strong) NSString* errString;

/**
* 用户名
*/

@property (nonatomic, strong) NSString* username;

/**
* 昵称
*/

@property (nonatomic, strong) NSString* nickname;

/**
 * 昨日收益
 */

@property (nonatomic, strong) NSString* yestodayMoney;

/**
* 个性签名
*/

@property (nonatomic, strong) NSString* signature;

/**
* 密码
*/

@property (nonatomic, strong) NSString* pwd;

/**
* 姓名
*/

@property (nonatomic, strong) NSString* realname;

/**
* 姓名拼音
*/

@property (nonatomic, strong) NSString* nameSpell;

/**
* 账号金额 初始值为0
*/

@property (nonatomic, strong) NSString* remainMoney;

/**
* 身份证号
*/

@property (nonatomic, strong) NSString* idCardNo;

/**
* 头像地址
*/

@property (nonatomic, strong) NSString* iconAddr;

/**
     * 账户状态  0->已注册; 1->照片已提交，待审核; 2->审核通过; 3->审核失败;4->实名信息已提交
 */
@property (nonatomic, assign) NSInteger accountStatus;

/**
 * 学生认证状态  0->已注册; 1->已提交，待审核; 2->审核通过; 3->审核失败;
 */

@property (nonatomic, assign) NSInteger studentStatus;

/**
 * 白领认证状态  0->已注册; 1->已提交，待审核; 2->审核通过; 3->审核失败;
 */
@property(nonatomic,assign)NSInteger whiteCollarStatus;

/**
* 是否为0-普通用户; 1-信用黑名单用户; 2-禁用用户
*/

@property (nonatomic, assign) NSInteger userStatus;

/**
* 注册时间
*/

@property (nonatomic, strong) NSString* regTime;

/**
* 友信宝用户token操作用唯一标示
*/

@property (nonatomic, strong) NSString* yxbToken;

/**
* 友信宝用户id(操作用)
*/

@property (nonatomic, strong) NSString* yxbId;

/**
 * 友信宝用户yxbCookie(操作用)
 */

@property (nonatomic, strong) NSString* yxbCookie;

/**
* 融云聊天用户id
*/

@property (nonatomic, strong) NSString* ryId;

/**
* 融云聊天用户token
*/

@property (nonatomic, strong) NSString* ryToken;

/**
 * field  综合等级
 */

@property (nonatomic,assign) NSInteger comprehensiveLevel;

/**
 * 红包收益
 */
@property (nonatomic,strong) NSString * redbag;

/**
 * 账户总额
 */
@property (nonatomic,strong) NSString * totalMoney;

/**
 * 账户总额
 */
@property (nonatomic,assign) NSInteger gender;


/**
 * field  土豪榜 ->  等级描述
 */

@property (nonatomic,copy) NSString  *lendMoneyLevelDesc;

/**
 * field  社会影响力榜 -> 等级描述
 */

@property (nonatomic,copy) NSString  *friendInviteLevelDesc;

/**
 * field  义气榜 -> 等级描述
 */

@property (nonatomic,copy) NSString  *lendTimesLevelDesc;

/**
 * field  活跃度 -> 等级描述
 */

@property (nonatomic,copy) NSString *participateLevelDesc;

/**
 * field  人脉榜 -> 等级描述
 */

@property (nonatomic,copy) NSString *friendsSumLevelDesc;

/**
 * 信誉评级
 */
@property (nonatomic,copy) NSString *creditLevelDesc;

/**
 * 冻结金额
 */
@property (nonatomic,copy) NSString *freezenMoney;
/**
 * 理财金额
 */
@property (nonatomic,copy) NSString *financefreezenMoney;

//返回 等级格式化字符串
-(NSString *)levelFormatWithDesc;


@end
