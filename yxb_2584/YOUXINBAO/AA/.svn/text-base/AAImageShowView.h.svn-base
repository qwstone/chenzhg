//
//  AAImageShowView.h
//  YOUXINBAO
//
//  Created by CH10 on 15/4/24.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AAImageShowView : UIView<UIActionSheetDelegate,UIScrollViewDelegate> {
    NSInteger _longPressTag;
}

- (id)initWithFrame:(CGRect)frame withUrlArr:(NSArray *)array withIndex:(NSInteger)index;

@property (nonatomic,strong) NSArray *urlArray;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UILabel *countLabel;       //底部label

@property (nonatomic,assign)NSInteger index;    //选中图片位置

@end
