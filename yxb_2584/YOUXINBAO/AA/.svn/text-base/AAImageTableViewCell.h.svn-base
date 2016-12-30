//
//  AAImageTableViewCell.h
//  YOUXINBAO
//
//  Created by 张淼 on 15/3/30.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IndexPath;

@interface AAImageTableViewCell : UIView

@property (nonatomic,assign) NSInteger columnCount;
@property (nonatomic, retain) IndexPath *indexPath;

@property (nonatomic,retain)UIImageView * iamgeView;

-(void)relayoutViews;

//加载网络图片
-(void)setImageWithURL:(NSURL *)imageUrl;
//加载本地图片
-(void)setImage:(UIImage *)image;


@end

@interface IndexPath : NSObject

@property(nonatomic,assign) NSInteger row;
@property(nonatomic,assign) NSInteger column;

+(IndexPath *)initWithRow:(NSInteger)indexRow withColumn:(NSInteger)indexColumn;

@end
