#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface MessageCenterItem : BaseData

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* subTitle;
@property (nonatomic, strong) NSString* des;
@property (nonatomic, strong) NSString* jumpUrl;

/**
* 消息是否已经被读取过 1已读， 0未读
*/

@property (nonatomic, strong) NSString* hasRead;

/**
* 消息id
*/

@property (nonatomic, strong) NSString* messageID;

/**
* 消息详情的跳转类型
*/

@property (nonatomic, strong) NSString* type;

/**
* 对应icon图标下载地址
*/

@property (nonatomic, strong) NSString* imageUrl;

/**
* 消息详情的跳转类型对应的val值
*/

@property (nonatomic, strong) NSString* val;

@end
