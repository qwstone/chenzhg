//
//  GongGaoView.m
//  YOUXINBAO
//
//  Created by zjp on 16/2/17.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "GongGaoView.h"
#import "BillDetailViewController.h"
@implementation GongGaoView
{
NSMutableArray   *_nutableArray;

}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView {

    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/750*35, kDeviceWidth/750*12, kDeviceWidth/750*36, kDeviceWidth/750*32)];
    img.image = [UIImage imageNamed:@"VOLUME 2"];
    
    //滑动列表
    _HomeLiseTableView = [[UITableView alloc] initWithFrame:CGRectMake(img.right+kDeviceWidth/750*10, 0, kDeviceWidth/750*500, kDeviceWidth/750*60) style:UITableViewStylePlain];
    _HomeLiseTableView.delegate = self;
    _HomeLiseTableView.dataSource = self;
    _HomeLiseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _HomeLiseTableView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:img];
    [self addSubview:_HomeLiseTableView];
}

-(void)setDataArray:(NSMutableArray *)DataArray{
    if (_DataArray != DataArray) {
        _DataArray = DataArray;
        _nutableArray = [[NSMutableArray alloc]initWithArray:_DataArray];
        
        int i = (int)[_nutableArray count];
        
        while(--i > 0) {
            int j = rand() % (i+1);
            [_nutableArray exchangeObjectAtIndex:i withObjectAtIndex:j];
            
        }
        [_nutableArray addObject:_nutableArray[0]];
        [_HomeLiseTableView reloadData];
        
    }
}

#pragma mark --- tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return kDeviceWidth/750*60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _nutableArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellID  =@"cellIDdd";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    
    NSMutableDictionary *dic = _nutableArray[indexPath.row];
    NSString *string = [NSString stringWithFormat:@"%@ ",[dic objectForKey:@"content"]];
        
    cell.textLabel.font = [UIFont boldSystemFontOfSize:kDeviceWidth/750*26];
    [cell.textLabel setAdjustsFontSizeToFitWidth:YES];
    cell.textLabel.textColor = [YXBTool colorWithHexString:@"#FFFFFF"];
    cell.textLabel.text = string;
   
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *heroSelected=[_nutableArray objectAtIndex:indexPath.row];
    if([[heroSelected objectForKey:@"loanmark"] intValue]==1){
        NSLog(@"共有多少人参与");
            }
    else{
        BillDetailViewController * bill = [[BillDetailViewController alloc] init];
        bill.isHideInfo = YES;
        bill.encryptionID = [NSString stringWithFormat:@"%@",[_nutableArray[indexPath.row] objectForKey:@"loanmark"]];;
        bill.hidesBottomBarWhenPushed = YES;
        [[YXBTool getCurrentNav] pushViewController:bill animated:YES];
        

    }
}

@end
