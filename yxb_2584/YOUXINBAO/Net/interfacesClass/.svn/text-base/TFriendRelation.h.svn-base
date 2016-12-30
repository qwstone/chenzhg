
#import <Foundation/Foundation.h>
#import "BaseData.h"
#import "User.h"


@interface TFriendRelation : BaseData

@property (nonatomic,assign) NSInteger t_id;

@property (nonatomic,assign) NSInteger  userId;
@property (nonatomic,copy) NSString  *username;   //用户名
@property (nonatomic,assign) NSInteger  friendId;
@property (nonatomic,copy) NSString  *friendName;
@property (nonatomic,assign) NSInteger  relationType;
@property (nonatomic,assign) NSInteger  unreadFlag; //未读标志
@property (nonatomic,assign) NSInteger  showFlag;
@property (nonatomic,assign) NSInteger  delFlag;    //删除标志
@property (nonatomic,copy) NSString  *buildTime;  //创建时间
@property (nonatomic,assign) NSInteger errCode;
@property (nonatomic,copy) NSString *note;

@property (nonatomic,retain) User  *friendUser;    //用户信息

@property (nonatomic,copy) NSString *errString;

@end
