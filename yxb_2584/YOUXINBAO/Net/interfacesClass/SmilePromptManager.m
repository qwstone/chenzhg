//
//  SmilePromptManager.m
//  YOUXINBAO
//
//  Created by Walice on 15/7/7.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "SmilePromptManager.h"

@implementation SmilePromptManager

/**
 * 获取短信模板列表
 *
 * @param pageNum
 * @param type
 *            短信模板类型 1商务. 2领导. 3同事. 4下属. 5好友. 6普通朋友. 7同学. 8长辈. 9同辈. 10晚辈.
 * @return
 *
 * @author SKY
 * @date 2015年7月7日
 */
-(NSSkyArray *)getSmilePromptItem:(NSInteger)pageNum type:(NSInteger)type{


    return [[NSSkyArray alloc]init];
}
- (TResultSet *)submitMessage:(NSString *)userToken promptID:(NSInteger)promptID messageContent:(NSString *)messageContent cellNumber:(NSString *)cellNumber name:(NSString *)name{

    return [[TResultSet alloc]init];
}

@end
