//
//  CTPhotoModel.h
//  HandicapWin
//
//  Created by Zhl on 16/5/25.
//  Copyright © 2016年 赢盘. All rights reserved.
//
/*
 略缩图img
 大图img
 略缩图url
 大图url
 type：用于区分是 网址类 图片 还是 image类 图片
 **/
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CTPhotoModel : NSObject
/**
 type: 0-url 1-image
 */
@property(nonatomic,assign)NSString *type;
/**略缩图网址*/
@property(nonatomic,copy)NSString *thumbnailImgUrl;
/**大图网址*/
@property(nonatomic,copy)NSString *largeImgUrl;
/**略缩图*/
@property(nonatomic)UIImage *thumbnailImage;
/**大图*/
@property(nonatomic)UIImage *largeImage;
/**是否隐藏删除按钮*/
@property(nonatomic,assign)BOOL deleteBtnHidden;

@end
