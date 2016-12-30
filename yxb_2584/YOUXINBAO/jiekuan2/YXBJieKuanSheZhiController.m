//
//  YXBJieKuanSheZhiController.m
//  YOUXINBAO
//
//  Created by Feili on 16/1/26.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "YXBJieKuanSheZhiController.h"
#import "JieKuanJinECell.h"
#import "HuanKuanShiJianCell.h"
#import "JieKuanYongTuCell.h"
#import "AATimePickerView.h"
#import "YXBTool.h"
#import "AACreatePickerView.h"

@interface YXBJieKuanSheZhiController ()<JieKuanCellDelegate>
{
    UIImageView *topBg;
}

@end

@implementation YXBJieKuanSheZhiController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化视图
-(void)initViews
{


}

-(void)setViewFrame:(CGRect)viewFrame
{
    [super setViewFrame:viewFrame];
    
    //设置 footerView
    
    NSInteger labelHeight = 50;

    UIView *footerView = [[UIView alloc] initWithFrame:ccr(0, 0, self.tableView.width, labelHeight + 20)];
    footerView.backgroundColor = [UIColor clearColor];
    
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:ccr(0, 0, kDeviceWidth-30, labelHeight)];
    UIImage *img1 = [UIImage imageNamed:@"JieKuanbgcon.png"];
//    img1 = [img1 stretchableImageWithLeftCapWidth:img1.size.width/2 topCapHeight:img1.size.height/2];
//    bgImage.height = [YXBTool heightWithSize:img1.size width:bgImage.width];
    bgImage.image = img1;
    [footerView addSubview:bgImage];
    
    UILabel *tintLabel = [[UILabel alloc] initWithFrame:ccr(0, 5, bgImage.width, labelHeight)];
    tintLabel.text = @"信用来之不易,借款量力而行";
    tintLabel.textColor = kRGB(225, 39, 39);
    tintLabel.font = [UIFont systemFontOfSize:14.0];
    tintLabel.textAlignment = NSTextAlignmentCenter;
    [bgImage addSubview:tintLabel];
    
    UIImageView *footerImage = [[UIImageView alloc] initWithFrame:ccr(0, bgImage.bottom, kDeviceWidth - 30, 20)];
    UIImage *img = [UIImage imageNamed:@"jiekuanbgfoot.png"];
//    img = [img stretchableImageWithLeftCapWidth:img.size.width/2 topCapHeight:img.size.height/2];

    footerImage.image = img;
//    footerView.contentMode = UIViewContentModeScaleToFill;
    [footerView addSubview:footerImage];

    self.tableView.tableFooterView = footerView;


}



#pragma -mark UITableView Datasource & delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXBJieKuanBaseCell *cell = nil;
    //借款金额
    if (indexPath.row == 0) {
        NSString *cellIdentifier = @"jine";//金额
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
//            cell = [[JieKuanJinECell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell = [[JieKuanJinECell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier width:self.tableView.width height:44];

            
        }

    }
    else if (indexPath.row == 1)
    {
        //还款时间
        NSString *cellIdentifier = @"time";//金额
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
//            cell = [[HuanKuanShiJianCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            CGFloat height = 44 + 100;

            cell = [[HuanKuanShiJianCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier width:self.tableView.width height:height];

            
        }

    }
    else if (indexPath.row == 2)
    {
        //借款用途
        NSString *cellIdentifier = @"yongtu";//金额
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[JieKuanYongTuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier width:self.tableView.width height:144];
            
        }
        
    }

    YXBLoan *loan = [JieKuanInstance shareInstance].yxbLoan;
    if (loan != nil) {
        cell.loan = loan;
    }
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXBLoan *loan = [JieKuanInstance shareInstance].yxbLoan;

    CGFloat height = 44;
    
    if (indexPath.row == 1) {
        NSInteger durationHeight = 0;
        if ([loan.duration integerValue] > 0) {
            durationHeight = 12;
        }
        height = 34 + [YXBTool getSquareHeight] + durationHeight;
    }
    return height;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self jiekuanEndEdit];
    UIWindow *mWindow = [[[UIApplication sharedApplication] delegate] window];
    
    for (AATimePickerView *view in mWindow.subviews) {
        if ([view isKindOfClass:[AATimePickerView class]]) {
            ;
            if(view.isShow == YES)
            {
                [view showPickerView];
            }
        }
        if ([view isKindOfClass:[UIPickerView class]]) {
            ;
            [view removeFromSuperview];
        }
        
    }

    [super scrollViewDidScroll:scrollView];
    


}

-(void)jiekuanBeginEditIsMoveKeyBoard:(BOOL)isMove
{
    [self hidePickerView];
}


-(void)jiekuanEndEdit
{
    [self.view endEditing:YES];
    
    [self hidePickerView];
    

}

-(BOOL)isMoneyCellEdit
{
    JieKuanJinECell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    return [cell.textField isFirstResponder];
}

-(void)hidePickerView
{
    UIWindow *mWindow = [[[UIApplication sharedApplication] delegate] window];
    for (AATimePickerView *view in mWindow.subviews) {
        if ([view isKindOfClass:[AATimePickerView class]]) {
            ;
            if(view.isShow == YES)
            {
                [view showPickerView];
            }
        }
        if ([view isKindOfClass:[AACreatePickerView class]]) {
            ;
            if(view.isShow == YES)
            {
                [view showPickerView];

            }
        }
        
    }

}

#pragma -mark Jiekuancelldelegate

-(void)updateJieKuanJinEWithMoney:(NSString *)money
{
    JieKuanInstance *loanInstance = [JieKuanInstance shareInstance];

    loanInstance.yxbLoan.money = money;
}

-(void)updateHuanKuanShiJian:(NSString *)time
{
    JieKuanInstance *loanInstance = [JieKuanInstance shareInstance];

    loanInstance.yxbLoan.backTime = time;
    NSInteger fenqishu = [YXBTool getAmortizationNumWithEndDate:loanInstance.yxbLoan.backTime];
    if (fenqishu > 1 && loanInstance.yxbLoan.repayType == YXBRepayTypeFenQi)
    {
        
    }
    else
    {
        loanInstance.yxbLoan.repayType = YXBRepayTypeQuanE;
        
    }

//    loanInstance.yxbLoan.repayType = YXBRepayTypeQuanE;

    NSInteger day = [YXBTool daysBetweenTwoDaysWithEndDayStr:time];
    loanInstance.yxbLoan.duration = [NSString stringWithFormat:@"%ld",(long)day];
    [self.tableView reloadData];
}

-(void)updateJieKuanYongTu:(JieKuanYongTu)yongtu
{
    JieKuanInstance *loanInstance = [JieKuanInstance shareInstance];

    loanInstance.yxbLoan.purpose = [NSString stringWithFormat:@"%ld",(long)yongtu + 1];

}


@end
