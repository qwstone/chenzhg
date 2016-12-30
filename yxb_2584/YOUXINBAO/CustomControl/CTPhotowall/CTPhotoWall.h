//
//  CTPhotoWall.h
//  HandicapWin
//
//  Created by CH10 on 16/5/9.
//  Copyright © 2016年 赢盘. All rights reserved.
//
/**
 *  浏览大图
 *  1、cell中的默认图片需要自己设定
 */
#import <UIKit/UIKit.h>
#import "CTPhotoModel.h"
@interface CTPhotoWall : UIView
/**
 *  处理成CTPhotoModel的实例进行展示
 *
 *  @param dataArr
 *  @param index 被点击的图片的index
 */
+(void)photoWallShowWithImgModelDataArr:(NSArray<CTPhotoModel*>*)dataArr Index:(NSInteger)index;
+(void)photoWallShowWithImgUrlDataArr:(NSArray<NSString *> *)dataArr Index:(NSInteger)index;
@end
