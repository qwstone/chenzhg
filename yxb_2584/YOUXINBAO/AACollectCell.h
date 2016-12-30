//
//  AACollectCell.h
//  YOUXINBAO
//
//  Created by Walice on 15/6/19.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AAcollectDelegate <NSObject>

- (void)AAcollectAction:(UITextView *)textView;

@end

@interface AACollectCell : UITableViewCell<UITextViewDelegate>

@property(nonatomic,strong)UILabel *leftLabel;
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UILabel *textViewplacehide;
@property(nonatomic,strong)id<AAcollectDelegate>delegate;
@end
