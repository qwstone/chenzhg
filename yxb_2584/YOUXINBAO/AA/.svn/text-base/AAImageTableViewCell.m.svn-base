//
//  AAImageTableViewCell.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/3/30.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AAImageTableViewCell.h"
#import "UIImageView+WebCache.h"

#define TOPMARGIN 8.0f
#define LEFTMARGIN 8.0f

@implementation AAImageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _iamgeView = [[UIImageView alloc] initWithFrame:frame];
        [self addSubview:_iamgeView];
    }
    
    return self;
}

-(void)setImageWithURL:(NSURL *)imageUrl{
    
    [_iamgeView sd_setImageWithURL:imageUrl];
    
}

-(void)setImage:(UIImage *)image{
    
    _iamgeView.image = image;
}

-(void)relayoutViews{
    float originX = 0.0f;
    float originY = 0.0f;
    float width = 0.0f;
    float height = 0.0f;
    
    originY = TOPMARGIN;
    height = CGRectGetHeight(self.frame) - TOPMARGIN;
    if (self.indexPath.column == 0) {
        
        originX = LEFTMARGIN;
        width = CGRectGetWidth(self.frame) - LEFTMARGIN - 1/2.0*LEFTMARGIN;
    }else if (self.indexPath.column < self.columnCount - 1){
        
        originX = LEFTMARGIN/2.0;
        width = CGRectGetWidth(self.frame) - LEFTMARGIN;
    }else{
        
        originX = LEFTMARGIN/2.0;
        width = CGRectGetWidth(self.frame) - LEFTMARGIN - 1/2.0*LEFTMARGIN;
    }
    _iamgeView.frame = CGRectMake( originX, originY,width, height);

    
}

@end

@implementation IndexPath

+(IndexPath *)initWithRow:(NSInteger)indexRow withColumn:(NSInteger)indexColumn{
    
    IndexPath *indexPath = [[IndexPath alloc] init];
    indexPath.row = indexRow;
    indexPath.column = indexColumn;
    return indexPath; 
}

@end
