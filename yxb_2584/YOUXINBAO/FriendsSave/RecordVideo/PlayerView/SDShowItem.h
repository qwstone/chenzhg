//
//  SDShowItem.h
//  YOUXINBAO
//
//  Created by Cher on 16/2/3.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDShowItem : NSObject

+ (id)instanceShow;
/**
 *  显示上传视图
 */
- (void)showView;
/**
 *  设置上传进度
 *
 *  @param progress 上传进度值
 */
- (void)progressValue:(CGFloat)progress;
/**
 *  手动隐藏视图 （服务器异常  各种失败  请手动调用该方法）
 */
- (void)hiddenShowView;

@end
