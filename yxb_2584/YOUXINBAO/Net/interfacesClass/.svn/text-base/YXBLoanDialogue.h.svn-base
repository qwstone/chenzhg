#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface YXBLoanDialogue : BaseData


/**
* 对话框类型 1文字语言对话框; 2图片; 3申请延期 5 输入会话
*/

@property (nonatomic, strong) NSString* dialogueMode;

/**
* 时间
*/

@property (nonatomic, strong) NSString* time;

/**
* 头像地址
*/

@property (nonatomic, strong) NSString* imgUrl;

/**
* 姓名
*/

@property (nonatomic, strong) NSString* name;

/**
* 位置显示 1左侧; 2右侧
*/

@property (nonatomic, strong) NSString* displayMode;

/**
* 如果dialogueMode为1（文字对话框）,那么代表文字对话框的文字
* 如果dialogueMode为2（图片对话框）, 那么代表服务器返回的对应图片编码
* 如果dialogueMode为3（申请延期）, 那么代表待还金额
* 如果dialogueMode为4（利息协商）, 那么var1代表原利息 var2代表修改后利息

 * 如果dialogueMode为6（部分还款） var1 应还本金 var2 利息&补偿金 var3部分还款金额 var4补偿金 var5还款时间
 */

@property (nonatomic, strong) NSString* var1;

/**
* 如果dialogueMode为3（申请延期）, 那么代表延期补偿金额
*/

@property (nonatomic, strong) NSString* var2;

/**
* 如果dialogueMode为3（申请延期）, 那么代表延至时间
*/

@property (nonatomic, strong) NSString* var3;
/**
 * 如果dialogueMode为3（申请延期）, 那么代表应还总额
 */

@property (nonatomic, strong) NSString* var4;
/**
 * 如果dialogueMode为3（申请延期）, 那么代表应还本金
 */

@property (nonatomic, strong) NSString* var5;


/**
 * 如果dialogueMode为3（申请延期）, 那么代表利息&补偿金
 */

@property (nonatomic, strong) NSString* var6;



@end
