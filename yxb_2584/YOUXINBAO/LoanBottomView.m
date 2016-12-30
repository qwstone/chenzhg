//
//  LoanBottomView.m
//  YOUXINBAO
//
//  Created by zjp on 15/6/23.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanBottomView.h"
#import "YXBTool.h"
@implementation LoanBottomView {
    UILabel *_label;
    NSMutableAttributedString   *strLabel;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView * bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, self.frame.size.height-20)];

        [self addSubview:bgview];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, bgview.frame.size.width, 35)];
        _label.backgroundColor = rgb(255, 71, 92, 1);
        _label.font = [UIFont boldSystemFontOfSize:14];
        _label.textAlignment = NSTextAlignmentLeft;
        [bgview addSubview:_label];
        //滑动列表
        _HomeLiseTableView = [[UITableView alloc] initWithFrame:CGRectMake(-1, _label.bottom, bgview.frame.size.width+2, bgview.height-_label.height) style:UITableViewStylePlain];
        _HomeLiseTableView.layer.borderColor = [YXBTool colorWithHexString:@"#d0d0d0"].CGColor;
        _HomeLiseTableView.layer.borderWidth = 0.5f;;
        _HomeLiseTableView.delegate = self;
        _HomeLiseTableView.dataSource = self;
        _HomeLiseTableView.userInteractionEnabled = NO;
        _HomeLiseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _HomeLiseTableView.backgroundColor = [UIColor clearColor];
        [bgview addSubview:_HomeLiseTableView];
    }
    return self;
}

- (void)setITLoanIndexPersonRank:(NSMutableArray *)iTLoanIndexPersonRank {
    if (_iTLoanIndexPersonRank != iTLoanIndexPersonRank) {
        _iTLoanIndexPersonRank = iTLoanIndexPersonRank;
        [_HomeLiseTableView reloadData];
    }
}

- (void)setParticipantsNum:(NSString *)participantsNum {
    if (_participantsNum != participantsNum) {
        _participantsNum = participantsNum;
        NSString *string = [NSString stringWithFormat:@"    共有 %@ 位用户使用了友信宝借款",_participantsNum];
        strLabel = [[NSMutableAttributedString alloc] initWithString:string];
        [strLabel addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#ffffff"] range:NSMakeRange(0,strLabel.length)];
        [strLabel addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#f2f850"]
                         range:[string rangeOfString:_participantsNum]];
        [strLabel addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18]
                         range:[string rangeOfString:_participantsNum]];
        _label.attributedText = strLabel;
    }
}
#pragma mark --- tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return _HomeLiseTableView.height/3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _iTLoanIndexPersonRank.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString * cellID  =@"cellIDdd";
    LoanBottomCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[LoanBottomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    cell.model = _iTLoanIndexPersonRank[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row >= 3) {
        cell.alpha = 0;
        cell.transform = CGAffineTransformMakeTranslation(-kDeviceWidth, 0);
        [UIView animateWithDuration:0.3 animations:^{
            cell.transform = CGAffineTransformIdentity;
            cell.alpha = 1;
        } completion:^(BOOL finished) {

        }];
    }
    
}


@end
