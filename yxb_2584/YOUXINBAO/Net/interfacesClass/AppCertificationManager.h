//
//  AppCertificationManager.h
//  YOUXINBAO
//
//  Created by Walice on 15/6/4.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSSkyArray.h"
#import "TResultSet.h"
#import "StudentCerInfo.h"
#import "WhiteCollarCerInfo.h"
#import "StudentCerInfoV2.h"

@interface AppCertificationManager : NSObject
- (NSSkyArray *)getStudentProvince:(NSString *)userToken;
- (NSSkyArray *)getStudentCity:(NSString *)provinceType;
- (NSSkyArray *)getStudentDistrict:(NSString *)provinceType cityType:(NSString *)cityType;
- (NSSkyArray *)getStudentSchool:(NSString *)provinceType cityType:(NSString *)cityType districtType:(NSString *)districtType;
-(TResultSet *) getStudentSubmit_V2_1:(NSString *)userToken realName:(NSString *)realName idCardNo:(NSString *)idCardNo schoolName:(NSString *)schoolName stuIdCardNo:(NSString *)stuIdCardNo degree:(NSString *)degree graduationDate:(NSString *)graduationDate channelId:(NSString *)channelId;
-(TResultSet *) getStudentSubmit_V3:(NSString *)userToken realName:(NSString *)realName idCardNo:(NSString *)idCardNo schoolName:(NSString *)schoolName stuIdCardNo:(NSString *)stuIdCardNo degree:(NSString *)degree graduationDate:(NSString *)graduationDate imgUrl:(NSString *)imgUrl channelId:(NSString *)channelId;

- (StudentCerInfo *)getStudentCerInfo:(NSString *)userToken;



/**
 * 获取省份列表 - 白领
 *
 * @param userToken 用户token
 * @return
 */
- (NSSkyArray *)getWhiteCollarProvince:(NSString *)userToken;

/**
 * 获取对应省份的城市列 - 白领
 *
 * @param provinceType
 * @return
 */
- (NSSkyArray *)getWhiteCollarCity:(NSString *)provinceType;


/**
 * 获取对应的区 - 白领
 *
 * @param provinceType
 * @return
 */
- (NSSkyArray *)getWhiteCollarDistrict:(NSString *)provinceType cityType:(NSString *)cityType;

/*
 * 获取商圈列表 - 白领
 *
 * @param provinceType
 * @param cityType
 * @param districtType
 * @return
 */

- (NSSkyArray *)getWhiteCollarBusinessArea:(NSString *)provinceType cityType :(NSString *)cityType districtType:(NSString *)districtType;

/**
 * 获取写字楼列表 - 白领
 *
 * @param provinceType 省
 * @param cityType
 * @param districtType
 * @return
 */
- (NSSkyArray *)getWhiteCollarOfficeBuilding:(NSString *)provinceType cityType :(NSString *)cityType districtType:(NSString *)districtType businessArea:(NSString *)businessArea;

/**
 * 提交 - 白领
 *
 * @param officeBuildingName 写字楼名称
 * @param officeBuildingId   写字楼id
 * @param companyName        公司名称
 * @param businessAreaName   商圈名称
 * @param companyPhone       公司联系方式
 * @param userToken          用户token
 * @return
 */
- (TResultSet*)getWhiteCollarSubmit:(NSString *)officeBuildingName officeBuildingId:(NSString *)officeBuildingId businessAreaName:(NSString *)businessAreaName companyName:(NSString *)companyName companyPhone:(NSString *)companyPhone userToken:(NSString *)userToken;

/**
 * 获取已经发认证信息  - 白领
 *
 * @param userToken 用户token
 * @return
 */
- (WhiteCollarCerInfo *)getWhiteCollarCerInfo:(NSString *)userToken;

/**
 * V2版 获取学生信息详情
 *
 * @param userToken
 * @return
 */
-(StudentCerInfoV2*) getStudentCerInfo_V2:(NSString *)userToken;

/**
 * V2版 更新学生信息详情
 *
 * @param realName       真实姓名
 * @param idCardNo       身份证号
 * @param schoolName     所在学校
 * @param stuIdCardNo    学生证号
 * @param degree         当前学历
 * @param graduationDate 毕业时间
 * @param userToken      用户token
 * @return
 */
-(TResultSet *) getStudentSubmit_V2:(NSString *)realName idCardNo:(NSString *)idCardNo schoolName:(NSString *)schoolName stuIdCardNo:(NSString *)stuIdCardNo degree:(NSString *)degree graduationDate:(NSString *)graduationDate userToken:(NSString *)userToken;

@end
