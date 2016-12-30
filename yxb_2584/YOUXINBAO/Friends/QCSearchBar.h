//
//  QCSearchBar.h
//  YOUXINBAO
//
//  Created by CH10 on 14-4-30.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QCSearchBar;

@protocol QCSearchBarDelegate <NSObject>

@optional

- (void)QCSearchBarDidBeginEditing:(QCSearchBar *)searchBar;
- (void)QCSearchBarDidEndEditing:(QCSearchBar *)searchBar;
- (void)QCSearchBarshouldChangeCharacters:(QCSearchBar *)searchBar;
- (void)QCSearchBarShouldClear:(QCSearchBar *)searchBar;
- (void)QCSearchBarDidSearch:(QCSearchBar *)searchBar;

@end

@interface QCSearchBar : UIView<UITextFieldDelegate>

@property (nonatomic,assign) id<QCSearchBarDelegate> delegate;
@property (nonatomic,retain) UITextField *textField;
@property (nonatomic,copy) NSString *text;
@property (nonatomic,assign) BOOL isVisible;

- (void)resignFirstResponder;

@end
