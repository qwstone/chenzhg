#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface StudentCerSelect : BaseData


/**
* 省市区对应的服务器数据库id
*/

@property (nonatomic, strong) NSString* selectTypeID;

/**
* 选择框显示的文字
*/

@property (nonatomic, strong) NSString* selectDisplayStr;

@end
