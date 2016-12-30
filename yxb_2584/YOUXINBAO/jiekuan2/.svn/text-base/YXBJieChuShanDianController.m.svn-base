//
//  YXBJieChuShanDianController.m
//  YOUXINBAO
//
//  Created by Feili on 16/2/17.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "YXBJieChuShanDianController.h"
#import "YXBJieKuanBaseCell.h"
#import "JieKuanJinECell.h"
#import "YXBTool.h"

@interface YXBJieChuShanDianController ()<JieKuanCellDelegate>
{
    UILabel *tintLabel;//下部提示文字
    
}
@end

@implementation YXBJieChuShanDianController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loan = [[YXBLoan alloc] init];
    _loan.loanType = YXBLoanTypeKuaiShanDianJieKuan;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setViewFrame:(CGRect)viewFrame
{
    [super setViewFrame:viewFrame];
    
    //设置 footerView
    //设置 footerView
    NSString *labelText = @"闪电借款说明:\n1) 默认借款时长7天(无息),还款日为支付成功后第6天。(例：10月24日支付,10月30日还款)。\n2) 成功借出后,有效期为24小时,若对方未在有限期内确认收款,则该借款单自动关闭。";

    CGSize tintSize = [YXBTool getFontSizeWithString:labelText font:[UIFont systemFontOfSize:15.0] constrainSize:CGSizeMake(kDeviceWidth - 60, NSIntegerMax)];
    CGFloat height = tintSize.height + 55 + 20;
    
    UIView *footerView = [[UIView alloc] initWithFrame:ccr(0, 0, kDeviceWidth, height)];
    footerView.backgroundColor = [UIColor clearColor];
    
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:ccr(0, 0, kDeviceWidth-30, height - 20)];
    UIImage *img1 = [UIImage imageNamed:@"JieKuanbgcon.png"];
    bgImage.image = img1;
    [footerView addSubview:bgImage];
    
    tintLabel = [[UILabel alloc] initWithFrame:ccr(15, 0, bgImage.width - 30, bgImage.height)];
    tintLabel.numberOfLines = 0;
    tintLabel.lineBreakMode = NSLineBreakByCharWrapping;
    tintLabel.textColor = [YXBTool colorWithHexString:@"#666666"];
    tintLabel.textAlignment = NSTextAlignmentLeft;
    NSMutableAttributedString *aText = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.lineSpacing = 10;  //设置文字行间距
    [aText addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#333333"] range:NSMakeRange(0, 8)];
    [aText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 8)];
    [aText addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, 8)];


    [aText addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#666666"] range:NSMakeRange(8, labelText.length - 8)];
    [aText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(8, labelText.length - 8)];
    NSMutableParagraphStyle *style2 = [[NSMutableParagraphStyle alloc]init];
    style2.lineSpacing = 5;  //设置文字行间距
    [aText addAttribute:NSParagraphStyleAttributeName value:style2 range:NSMakeRange(8, labelText.length - 8)];
    
    tintLabel.attributedText = aText;
    [bgImage addSubview:tintLabel];
    
    UIImageView *footerImage = [[UIImageView alloc] initWithFrame:ccr(0, footerView.height - 20, kDeviceWidth - 30, 20)];
    UIImage *img = [UIImage imageNamed:@"jiekuanbgfoot.png"];
    
    footerImage.image = img;

    [footerView addSubview:footerImage];
    
    self.tableView.tableFooterView = footerView;
//    [self refreshBottom];
    
    
}



#pragma -mark UITableView Datasource & delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
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
    
    YXBLoan *loan = self.loan;
    if (loan != nil) {
        cell.loan = loan;
    }
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma -mark Jiekuancelldelegate

-(void)updateJieKuanJinEWithMoney:(NSString *)money
{

    self.loan = [[YXBLoan alloc] init];
    _loan.money = money;
    
}


-(BOOL)isMoneyCellEdit
{
    JieKuanJinECell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    return [cell.textField isFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];

    [super viewWillDisappear:YES];
}


@end
