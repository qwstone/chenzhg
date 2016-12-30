//
//  IOUDetailsHeaderView.h
//  YOUXINBAO
//
//  Created by zjp on 16/1/30.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoanCertificate.h"

@protocol IOUDetailHeaderViewDelegate <NSObject>

- (void)buttonDidClick;

@end

@interface IOUDetailsHeaderView : UIView



@property(nonatomic,strong)LoanCertificate *model;







@property (strong, nonatomic) IBOutlet UIButton *qugongzheng;
@property (strong, nonatomic) IBOutlet UILabel *danjubianhao;
@property (strong, nonatomic) IBOutlet UILabel *jiekuanren;
@property (strong, nonatomic) IBOutlet UILabel *jiekuanrenCall;
@property (strong, nonatomic) IBOutlet UILabel *shenfenID;
@property (strong, nonatomic) IBOutlet UILabel *fangkuanren;
@property (strong, nonatomic) IBOutlet UILabel *fangkuanrenCall;
@property (strong, nonatomic) IBOutlet UILabel *fangkuanrenID;
@property (strong, nonatomic) IBOutlet UILabel *jiekuanjine;
@property (strong, nonatomic) IBOutlet UILabel *lixi;
@property (strong, nonatomic) IBOutlet UILabel *shenqingshijian;
@property (strong, nonatomic) IBOutlet UILabel *dakuanshijian;
@property (strong, nonatomic) IBOutlet UILabel *huankuanfangshi;
@property (strong, nonatomic) IBOutlet UILabel *yanqibuchang;
@property (strong, nonatomic) IBOutlet UILabel *huankuanshijian;
- (IBAction)qugongzheng:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *miding;
@property (strong, nonatomic) IBOutlet UIImageView *botimg;
@property (nonatomic, strong) id<IOUDetailHeaderViewDelegate> delegate;
@end
