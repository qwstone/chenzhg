//
//  AppBlankNoteManager.h
//  YOUXINBAO
//
//  Created by zjp on 15/5/6.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CreateBlankNote.h"
#import "TResultSet.h"
#import "NSSkyArray.h"
#import "RepaymentNoteData.h"
#import "BlankNoteData.h"
@interface AppBlankNoteManager : NSObject


/**
 * 创建新白条 最新
 * @param noteList
 * @return
 */
-(TResultSet*) __yxb__createBlankNote:(CreateBlankNote*) noteList;

/**
 * 获取所有土豪白条列表
 *
 * @param pageNum
 *            页面索引，从1开始
 * @return
 */
- (NSSkyArray*)getNoteListData:(NSString *)userToken pageNum:(NSInteger)pageNum;

/**
 * 获取某用户发起的白条
 *
 * @param userToken
 *            用户token
 * @param pageNum
 *            页面索引，从1开始
 * @return
 */
- (NSSkyArray*)getAllNotesByToken:(NSString *)userToken pageNum:(NSInteger)pageNum;

/**
 * 获取某用户认领的白条
 *
 * @param userToken
 *            用户token
 * @param pageNum
 *            页面索引，从1开始
 * @return
 */
- (NSSkyArray*)getClaimNotesByToken:(NSString *)userToken pageNum:(NSInteger)pageNum;

/**
 * 取消剩余白条
 *
 * @param userToken
 *            取消用户的token
 * @return
 *
 * @author SKY
 * @date 2015年5月6日
 */
-(TResultSet*)cancelRemainNote:(NSString *)userToken noteId:(NSInteger)noteId;

/**
 * 认领白条
 *
 * @param userToken
 *            认领用户的token
 * @param noteID
 *            白条id
 * @return
 *
 * @author SKY
 * @date 2015年5月6日
 */
-(TResultSet*)claimNote:(NSString *)userToken noteID:(NSInteger)noteID;

/**
 * 获取某个学生用户申请的白条的详情
 * @param token
 * @param repaymentNoteDataID
 * @return
 *
 * @author SKY
 * @date   2015年5月6日
 */
-(RepaymentNoteData*)getRepaymentNoteData:(NSString *)token repaymentNoteDataID:(NSInteger) repaymentNoteDataID;

/**
 * 获取土豪白条设置详情
 *
 * @param token
 * @param blankNoteDataID
 * @return
 *
 * @author SKY
 * @date 2015年5月7日
 */
- (BlankNoteData*)getNoteSetting:(NSString *)token blankNoteDataID:(NSInteger)blankNoteDataID;

/**
 * 判断用户是否可以发起白条
 * @param userToken
 * @return
 */
-(TResultSet*)checkUserCreateBlankNote:(NSString *)userToken;
@end
