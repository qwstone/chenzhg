/*
 * Created on 2005-8-30
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */






/**
 * code maker 
 *@author mamingguo
 *@msn : yufan19810205@hotmail.com
 *@ java CodeGenerator
 */
#import <Foundation/Foundation.h>
@class NSSkyArray;

@class TFriendRelation;
@class TResultSet;

@interface TFriendRelationManager : NSObject


-(TFriendRelation*) loadById:(NSInteger) id ;

-(TFriendRelation*) getTFriendRelationByUserInfoFriendInfo:(NSString *)user_info :(NSString *)friend_info :(NSInteger)query_type;

//获取好友通讯录状态
-(NSSkyArray*) getTFriendRelationByPhoneBook:(NSString *)userName withPhoneArr:(NSString *)phoneNumbs;

//获取好友列表
-(NSSkyArray*) getTFriendRelationByUserIdAndQueryType:(NSInteger)user_id withType:(NSInteger)query_type;

//接受好友请求
-(TResultSet*) acceptTFriendRelationRequest:(NSInteger)user_id withFriendId:(NSInteger)friend_id;

//添加好友
-(TResultSet*) addTFriendRelationByMobile:(NSString *)user_info withFriendName:(NSString *)friend_name withNote:(NSString *)note;

////邀请好友
//-(TResultSet*) inviteTFriendRelationByMobile:(NSString *)friend_name;

//删除好友
-(TResultSet*) deleteTFriendRelation:(NSInteger)user_id withFriendId:(NSInteger)friend_id;

//删除好友信息
-(TResultSet*) deleteTFriendRelationNotice:(NSInteger)friend_id;

//未知好友请求设置为已读
-(TResultSet*) setAllUnReadFlagToReadByUserId:(NSInteger)user_id;
- (NSSkyArray *)getTFriendRelationByPhoneBookStore:(NSString *)username phonelist:(NSString *)phonelist;
/**
 * 获取通讯录里好友状态(自动添加好友)
 * @param phonelist(username) 通讯录列表,用","分割
 * @return Tlist
 */
-(NSSkyArray *)getTFriendRelationByPhoneBookAutoAddFriend:(NSString *)username phonelist:(NSString *)phonelist;

-(NSSkyArray*) getTFriendRelationByPhoneBookStoreV2:(NSString *)userName withPhoneArr:(NSString *)phoneNumbs;

-(NSSkyArray *)getTFriendRelationByPhoneBookAutoAddFriendV2:(NSString *)username phonelist:(NSString *)phonelist;

@end