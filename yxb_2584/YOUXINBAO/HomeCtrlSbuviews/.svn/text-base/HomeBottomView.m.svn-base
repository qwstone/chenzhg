//
//  HomeBottomView.m
//  YOUXINBAO
//
//  Created by zjp on 15/5/20.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "HomeBottomView.h"
#import "AAActivitiesListViewController.h"
#import "HomeBottomTablecell.h"
#import "MsgCenterMgr+Public.h"
@implementation HomeBottomView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)setBottomViewMuArray:(NSMutableArray *)bottomViewMuArray {
    if (_bottomViewMuArray != bottomViewMuArray) {
        _bottomViewMuArray = bottomViewMuArray;
        [_HomeLiseTableView reloadData];
    }
}

- (void)setIsNoData:(BOOL)isNoData {
    if (_isNoData != isNoData) {
        _isNoData = isNoData;
        if (_isNoData == YES) {
            _HomeLiseTableView.hidden = YES;
            [self noDataView];
        }else if (_isNoData == NO){
            _HomeLiseTableView.hidden = NO;
            if (self.noLoanimg != nil) {
                [self.noLoanimg removeFromSuperview];
            }
            if (self.noLoanTextLabel != nil) {
                [self.noLoanTextLabel removeFromSuperview];
            }
        }
    }
}

- (void)noDataView {
    
    self.noLoanimg = [[UIImageView alloc] initWithFrame:CGRectMake((_HomeLiseTableView.frame.size.width-40)/2, 20, 40, 40)];
    self.noLoanimg.center = _HomeLiseTableView.center;
    [self.noLoanimg setImage:[UIImage imageNamed:@"smile-gray-icon"]];
    [self addSubview:self.noLoanimg];
    self.noLoanTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, self.noLoanimg.bottom, _HomeLiseTableView.frame.size.width-10, 50)];
    self.noLoanTextLabel.textAlignment = NSTextAlignmentCenter;
    self.noLoanTextLabel.numberOfLines = 0;
    self.noLoanTextLabel.textColor = [UIColor lightGrayColor];
    self.noLoanTextLabel.text = @"请求失败，请查看网路";
    [self addSubview:self.noLoanTextLabel];
}

- (void)createView {
    
    //滑动列表
    _HomeLiseTableView = [[UITableView alloc] initWithFrame:CGRectMake(8, 7.5f, 248, 186) style:UITableViewStylePlain];
    if (kDeviceHeight == 480) {
        _HomeLiseTableView.frame = CGRectMake(5, 5, 213, 152);
    }else if (kDeviceHeight == 568){
        _HomeLiseTableView.frame = CGRectMake(5, 7.5f, 213, 152);
    }else if (kDeviceWidth > 375){
        _HomeLiseTableView.frame = CGRectMake(8, 7.5f, 275, 197);
    }
    _HomeLiseTableView.delegate = self;
    _HomeLiseTableView.dataSource = self;
    _HomeLiseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _HomeLiseTableView.backgroundColor = [UIColor clearColor];
    [self addSubview:_HomeLiseTableView];
    

    
    NSArray *imgarr = @[@"index-nav44",@"index-setnews",@"index-hygn"];
    for (int i = 0; i < imgarr.count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(_HomeLiseTableView.right+7.5, 8+i*7.5+86, 105, 90)];
        button.tag = i+1000;
        if (i == 0) {
            if (kDeviceHeight == 480) {
                button.frame = CGRectMake(_HomeLiseTableView.right+7.5, i*78+5, 90, 73);
            }else if (kDeviceHeight == 568){
                button.frame = CGRectMake(_HomeLiseTableView.right+7.5, i*78+7.5f, 90, 73);
            }else if (kDeviceWidth > 375){
                button.frame = CGRectMake(_HomeLiseTableView.right+8, 7.5+i*7.5+i*94.5f, 115, 95);
            }else if (kDeviceWidth == 375){
                button.frame = CGRectMake(_HomeLiseTableView.right+7.5, 8+i*7.5, 105, 90);
            }
        }else{
            if (kDeviceHeight == 480) {
                button.frame = CGRectMake(_HomeLiseTableView.right+7.5, (i-1)*74/2+78+5, 90, 70/2);
            }else if (kDeviceHeight == 568){
                button.frame = CGRectMake(_HomeLiseTableView.right+7.5, (i-1)*78/2+78+7.5f, 90, 70/2);
            }else if (kDeviceWidth > 375){
                button.frame = CGRectMake(_HomeLiseTableView.right+8, 7.5+i*7.5+(i-1)*84/2+94.5f, 115, 90/2);
            }else if (kDeviceWidth == 375){
                button.frame = CGRectMake(_HomeLiseTableView.right+7.5, 8+i*7.5+(i-1)*78/2+88, 105, 84/2);
            }

        }
        if (i == 2) {
            
            self.hasNewfbut = [[UIButton alloc] initWithFrame:button.bounds];
            self.hasNewfbut.userInteractionEnabled = NO;
            [self.hasNewfbut setBackgroundImage:[UIImage imageNamed:@"index-hygnnew"] forState:UIControlStateNormal];
            [button addSubview:self.hasNewfbut];
        }
//        button.backgroundColor = [UIColor redColor];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:[UIImage imageNamed:imgarr[i]] forState:UIControlStateNormal];
        [self addSubview:button];
    }
    
    UIButton *tableViewBut = [[UIButton alloc] initWithFrame:_HomeLiseTableView.frame];
    tableViewBut.tag = 10012;
    [tableViewBut addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:tableViewBut];

}

- (void)buttonAction:(UIButton *)sender {

        if ([self.delegate respondsToSelector:@selector(HomeBottomViewAction:)]) {
            [self.delegate HomeBottomViewAction:sender.tag];
        }


}

#pragma mark --- tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return _HomeLiseTableView.height/2+0.1f;//淡入效果防止提前创建
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _bottomViewMuArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString * cellID  =@"cellIDd";
    HomeBottomTablecell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[HomeBottomTablecell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.widths  = _HomeLiseTableView.width;
        cell.heights = _HomeLiseTableView.height/2;
    }
    cell.index = indexPath.row;
    cell.model = _bottomViewMuArray[indexPath.row];
//    cell.contentView.alpha = 0;
//    if (indexPath.row >=2) {
//        cell.contentView.alpha = 0;
//        [UIView animateWithDuration:0.5 animations:^{
//            cell.contentView.alpha = 1;
//        } completion:^(BOOL finished) {
//            
//        }];
//    }

    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row >= 2) {
//        
//        //旋转
////        CATransform3D rotation;
////        rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
////        rotation.m34 = 1.0/ -600;
////        
////        cell.layer.shadowColor = [[UIColor blackColor]CGColor];
////        cell.layer.shadowOffset = CGSizeMake(10, 10);
////        cell.alpha = 0;
////        cell.layer.transform = rotation;
//////        cell.layer.anchorPoint = CGPointMake(0, 0.5);
////        
////        
////        [UIView beginAnimations:@"rotation" context:NULL];
////        [UIView setAnimationDuration:0.8];
////        cell.layer.transform = CATransform3DIdentity;
////        cell.alpha = 1;
////        cell.layer.shadowOffset = CGSizeMake(0, 0);
////        [UIView commitAnimations];
////
//        //淡入
////        cell.alpha = 0;
////        [UIView animateWithDuration:0.3 animations:^{
////            cell.alpha = 1;
////        } completion:^(BOOL finished) {
////            cell.alpha = 1;
////        }];
//        
//        
//        //淡入淡出
//        cell.alpha = 0;
//        cell.transform = CGAffineTransformMakeScale(1.5, 1.5);
//                [UIView animateWithDuration:0.3 animations:^{
//                    cell.transform = CGAffineTransformMakeScale(1, 1);
//                    cell.alpha = 1;
//                } completion:^(BOOL finished) {
//                    cell.alpha = 1;
//                    cell.transform = CGAffineTransformIdentity;
//                }];
//    }
//
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    cell.alpha = 1;
    cell.transform = CGAffineTransformIdentity;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
