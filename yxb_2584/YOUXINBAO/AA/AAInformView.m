//
//  AAInformView.m
//  YOUXINBAO
//
//  Created by CH10 on 15/5/21.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AAInformView.h"
#import "ActivityComplaint.h"

#define kTableViewWidth kDeviceWidth-50
#define kBackViewHeight 300
#define kCellHeight 35

@implementation AAInformView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = rgb(0, 0, 0, 0.6);
        [self initViews];
    }
    
    return self;
}

- (void)initViews {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kTableViewWidth, kBackViewHeight)];
    backView.center = CGPointMake(kDeviceWidth/2, kDeviceHeight/2);
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 5;
    backView.layer.masksToBounds = YES;
    [self addSubview:backView];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, kBackViewHeight-45, kTableViewWidth, 45)];
    [btn setTitle:@"关  闭" forState:UIControlStateNormal];
    [btn setTitleColor:rgb(62, 163, 255, 1) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderColor = rgb(197, 197, 197, 1).CGColor;
    btn.layer.borderWidth = 0.5;
    [backView addSubview:btn];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 5, kTableViewWidth, backView.height-50) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [backView addSubview:tableView];
    
    UIView *tableHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 50)];
    tableView.tableHeaderView = tableHeader;
    
    UILabel *label1= [[UILabel alloc] initWithFrame:CGRectMake(20, (tableHeader.height-20)/2, 80, 20)];
    label1.backgroundColor = [UIColor clearColor];
    label1.text = @"投诉人";
    label1.font = [UIFont systemFontOfSize:16];
    [tableHeader addSubview:label1];
    
    UILabel *label2= [[UILabel alloc] initWithFrame:CGRectMake(120, (tableHeader.height-20)/2, 80, 20)];
    label2.backgroundColor = [UIColor clearColor];
//    label2.center = CGPointMake(kTableViewWidth/2, 10);
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = @"时间";
    label2.font = [UIFont systemFontOfSize:16];
    [tableHeader addSubview:label2];
    
    UILabel *label3= [[UILabel alloc] initWithFrame:CGRectMake(kTableViewWidth-60, (tableHeader.height-20)/2, 60, 20)];
    label3.backgroundColor = [UIColor clearColor];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.text = @"进度";
    label3.font = [UIFont systemFontOfSize:16];
    [tableHeader addSubview:label3];
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    [self removeFromSuperview];
}

- (void)btnAction {
    [self removeFromSuperview];
}

#pragma mark - UITableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"informCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        UILabel *label1= [[UILabel alloc] initWithFrame:CGRectMake(20, (kCellHeight-20)/2, 80, 20)];
        label1.backgroundColor = [UIColor clearColor];
//        label1.text = @"投诉人";
        label1.tag = 10000;
        label1.font = [UIFont systemFontOfSize:16];
        [cell.contentView addSubview:label1];
        
        UILabel *label2= [[UILabel alloc] initWithFrame:CGRectMake(120, (kCellHeight-20)/2, 80, 20)];
        label2.backgroundColor = [UIColor clearColor];
        //    label2.center = CGPointMake(kTableViewWidth/2, 10);
        label2.textAlignment = NSTextAlignmentCenter;
//        label2.text = @"时间";
        label2.tag = 10001;
        label2.textColor = rgb(197, 197, 197, 1);
        label2.font = [UIFont systemFontOfSize:13];
        [cell.contentView addSubview:label2];
        
        UILabel *label3= [[UILabel alloc] initWithFrame:CGRectMake(kTableViewWidth-60, (kCellHeight-20)/2, 60, 20)];
        label3.backgroundColor = [UIColor clearColor];
        label3.textAlignment = NSTextAlignmentCenter;
        label3.textColor = rgb(197, 197, 197, 1);
        label3.tag = 10002;
//        label3.text = @"进度";
        label3.font = [UIFont systemFontOfSize:13];
        [cell.contentView addSubview:label3];
    }
    
    ActivityComplaint *complaint = [_dataArray objectAtIndex:indexPath.row];
    
    for (int i = 10000; i<10003; i++) {
        UILabel *label = (UILabel *)[cell.contentView viewWithTag:i];
        if (i == 10000) {
            label.text = complaint.nickname;
        }else if (i == 10001) {
            NSRange range = NSMakeRange(0, 11);
            label.text = [complaint.complaintDate substringWithRange:range];
        }else if (i == 10002) {
            label.text = [self getHandleSchedule:complaint.status];
        }
    }
    
    return cell;
}

- (NSString *)getHandleSchedule:(NSInteger)status {
    /**
     * field 处理进度 1->处理中; 2->已处理; 3->处理失败; 4->处理成功;
     */
    NSString *str = nil;
    if (status == 1) {
        str = @"处理中";
    }else if (status == 2) {
        str = @"已处理";
    }else if (status == 3) {
        str = @"处理失败";
    }else if (status == 4) {
        str = @"处理成功";
    }
    
    return str;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
