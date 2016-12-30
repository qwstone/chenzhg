//
//  LoanDetailsInstallmentView.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/4/9.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanDetailsInstallmentView.h"
#import "InstallmentButton.h"
#import "TInstallmentLoan.h"

#define LoanDetailsInstallmentViewBtnTagStart 2000

@implementation LoanDetailsInstallmentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selecedArray = [NSMutableArray array];
        
    }
    return self;
}

-(void)setInstallmentStatus:(InstallmentStatus)installmentStatus
{
    if (installmentStatus == DoNotChoose) {
        self.userInteractionEnabled = NO;
    }
    else
    {
        self.userInteractionEnabled = YES;
    }
}


- (void)refreshWith:(LoanPeriod)loanPeriod
{
    if (_selecedArray != nil && [_selecedArray count] > 0) {
        [_selecedArray removeAllObjects];
    }
    else
    {
        self.selecedArray = [NSMutableArray array];
    }
    int numberOfPeriods = loanPeriod- LoanPeriod_MONTH_2+2;

    NSLog(@"ttt = %d",numberOfPeriods);
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    //repayType 是判断分期全额
//    if (/*numberOfPeriods>1 && _array.count>1 */ _model.repayType == 1 && _array.count>1)
    if (/*numberOfPeriods>1 && _array.count>1 */ _array.count>=1)
    {
        if (_model.repayType == 0) {
            numberOfPeriods = 1;
        }
        for (NSInteger i = 0; i < [self.array count] ; i++) {
            UIImage * imageOver = [UIImage imageNamed:@"fenqi-over.png"];
            UIImage * imageIn = [UIImage imageNamed:@"fenqi-in.png"];
            UIImage * imageChecked = [UIImage imageNamed:@"fenqi-checked.png"];
            
            InstallmentButton *btn = [[InstallmentButton alloc]initWithFrame:CGRectMake(20+i%3*(imageIn.size.width+(kDeviceWidth-40-3*imageIn.size.width)/2),20+ i/3*(imageIn.size.height+20), imageIn.size.width, imageIn.size.height)];
            btn.clipsToBounds = YES;
            btn.tag = LoanDetailsInstallmentViewBtnTagStart + i;
            [btn setTitle:[NSString stringWithFormat:@"第%ld期",(long)i+1] forState:UIControlStateNormal];
//            btn.backgroundColor = [UIColor redColor];
            btn.nperLabel.text = [NSString stringWithFormat:@"%ld",(long)i+1];
            [btn setImage:imageIn forState:UIControlStateNormal];
            [btn setImage:imageChecked forState:UIControlStateSelected];
            [btn setImage:imageOver forState:UIControlStateDisabled];
            
            TInstallmentLoan * installmentLoan = self.array[i];
            
            if ((installmentLoan.status == REPAYED_ONTIME) || (installmentLoan.status == REPAYED_DELAY)) {
                btn.enabled = NO;
                
            }
            
            if (installmentLoan.status == NEEDREPAY_DELAY ||
                installmentLoan.status == REPAYED_DELAY )
            {
                //添加逾期还款图像
                
                [btn showYuqiImage:YES];
            }
            else
            {
                //隐藏逾期还款图像
                [btn showYuqiImage:NO];
                
            }


            /*
            btn.moneyLabel.text = [NSString stringWithFormat:@"%ld",(long)[installmentLoan.money integerValue]];
            if (i == numberOfPeriods - 1) {
                btn.moneyLabel.text = [NSString stringWithFormat:@"%ld",(long)[installmentLoan.money integerValue]];

            }
             */
            
            //金额转换成整数
            btn.moneyLabel.text = installmentLoan.money;

            btn.timeLabel.text = installmentLoan.expectRepayDate;
            [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            self.frame = CGRectMake(self.origin.x, self.origin.y, self.size.width,btn.origin.y+btn.size.height+20 );
            
            
        }
        
    }else{
        self.frame = CGRectMake(self.origin.x, self.origin.y, kDeviceWidth, 0);
    }
   
    
  }


/**
 *  @author chenglibin
 *
 *  借条跳转而来
 *
 *  @param loanPeriod <#loanPeriod description#>
 */
- (void)refreshFromReceiptWith:(LoanPeriod)loanPeriod
{
    if (_selecedArray != nil && [_selecedArray count] > 0) {
        [_selecedArray removeAllObjects];
    }
    else
    {
        self.selecedArray = [NSMutableArray array];
    }
    int numberOfPeriods = loanPeriod- LoanPeriod_MONTH_2+2;
    
    NSLog(@"ttt = %d",numberOfPeriods);
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    //repayType 是判断分期定期
    //    if (/*numberOfPeriods>1 && _array.count>1 */ _model.repayType == 1 && _array.count>1)
    if (/*numberOfPeriods>1 && _array.count>1 */ _array.count>=1)
    {
        if (_array.count == 1) {
            numberOfPeriods = 1;
        }
        for (NSInteger i = 0; i < [self.array count] ; i++) {
            UIImage * imageOver = [UIImage imageNamed:@"fenqi-over.png"];
            UIImage * imageIn = [UIImage imageNamed:@"fenqi-in.png"];
            UIImage * imageChecked = [UIImage imageNamed:@"fenqi-checked.png"];
            
            InstallmentButton *btn = [[InstallmentButton alloc]initWithFrame:CGRectMake(20+i%3*(imageIn.size.width+(kDeviceWidth-40-3*imageIn.size.width)/2),20+ i/3*(imageIn.size.height+20), imageIn.size.width, imageIn.size.height)];
            btn.clipsToBounds = YES;
            btn.tag = LoanDetailsInstallmentViewBtnTagStart + i;
            [btn setTitle:[NSString stringWithFormat:@"第%ld期",(long)i+1] forState:UIControlStateNormal];
            //            btn.backgroundColor = [UIColor redColor];
            btn.nperLabel.text = [NSString stringWithFormat:@"%ld",(long)i+1];
            [btn setImage:imageIn forState:UIControlStateNormal];
            [btn setImage:imageChecked forState:UIControlStateSelected];
            [btn setImage:imageOver forState:UIControlStateDisabled];
            
            TInstallmentLoan * installmentLoan = self.array[i];
            
            if ((installmentLoan.status == REPAYED_ONTIME) || (installmentLoan.status == REPAYED_DELAY)) {
                btn.enabled = NO;
                
            }
            
            if (installmentLoan.status == NEEDREPAY_DELAY ||
                installmentLoan.status == REPAYED_DELAY )
            {
                //添加逾期还款图像
                
                [btn showYuqiImage:YES];
            }
            else
            {
                //隐藏逾期还款图像
                [btn showYuqiImage:NO];
                
            }

            
            btn.moneyLabel.text = [NSString stringWithFormat:@"%ld",(long)[installmentLoan.money integerValue]];
            if (i == numberOfPeriods - 1) {
                btn.moneyLabel.text = [NSString stringWithFormat:@"%ld",(long)[installmentLoan.money integerValue]];
                
            }
            btn.timeLabel.text = installmentLoan.expectRepayDate;
            [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            self.frame = CGRectMake(self.origin.x, self.origin.y, self.size.width,btn.origin.y+btn.size.height+20 );
            
            
        }
        
    }else{
        self.frame = CGRectMake(self.origin.x, self.origin.y, kDeviceWidth, 0);
    }
    
    
}




- (void)buttonAction:(InstallmentButton *)sender
{
    NSInteger index = sender.tag - LoanDetailsInstallmentViewBtnTagStart;
    TInstallmentLoan * installmentLoan = self.array[index];
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        [_selecedArray addObject:installmentLoan];
        sender.timeLabel.textColor = [UIColor blackColor];
    }else{
        [_selecedArray removeObject:installmentLoan];
        sender.timeLabel.textColor = [UIColor grayColor];
    }
    sender.nperLabel.hidden = sender.selected;
    
    [self.delegate InstallmentViewButtonAction:sender];
    if ((_delegate != nil) && [_delegate respondsToSelector:@selector(selectedArrayInstallmentView:)]) {
        [_delegate selectedArrayInstallmentView:_selecedArray];
    }

    
//    for (UIButton * btn in self.subviews) {
//        if ([btn isKindOfClass:[UIButton class]]) {
//            if (btn == sender) {
//                btn.selected = !btn.selected;
//            }else{
//                btn.selected = NO;
//            }
//        }
//    }
}

+ (NSArray *)installmentArrayWithMoney:(NSString *)money withInterest:(NSString *)interest withUserTime:(NSString *)userTime withTimeLong:(LoanPeriod)loanPeriod kouxifangshi:(InterestType)kouxifangshi
{
    int timeLong = loanPeriod- LoanPeriod_MONTH_2+2;

    NSMutableArray * array = [[NSMutableArray alloc]init];
    if ([money isEqualToString:@""]) {
        money = @"0";
    }else if ([interest isEqualToString:@""]){
        interest = @"0";
    }
    float moneyF = [money floatValue]/timeLong;
    if (kouxifangshi == POST_INTEREST) {
        //如果是先息
        moneyF = ([money integerValue] - [interest integerValue])/timeLong;
    }
    NSString * year = [userTime substringWithRange:NSMakeRange(0, 4)];
    NSString * month = [userTime substringWithRange:NSMakeRange(5, 2)];
    NSString * day = [userTime substringWithRange:NSMakeRange(8, 2)];
    NSInteger newYear = [year integerValue];
//    NSInteger newMonth = [month integerValue]+timeLong;
    NSInteger newMonth = [month integerValue];

    NSInteger newDay = [day integerValue];
    for (NSInteger i = 1; i <= timeLong; i++) {
        TInstallmentLoan * installMentLoan = [[TInstallmentLoan alloc]init];
      
        if (i == 1) {
            installMentLoan.money = [NSString stringWithFormat:@"%0.2ld",(long)(moneyF + [interest integerValue])];
        }else{
            if (i != timeLong) {
                installMentLoan.money = [NSString stringWithFormat:@"%0.2ld",(long)moneyF];

            }
            else
            {
                NSInteger lastMoney = [self moneyWithTotalMoney:([money integerValue] + [interest integerValue]) array:array];
                if (kouxifangshi == POST_INTEREST) {
                    //如果是先息
                    lastMoney = [self moneyWithTotalMoney:[money integerValue] array:array];
                }
//                installMentLoan.money = [NSString stringWithFormat:@"%0.2ld",(NSInteger)moneyF];
                installMentLoan.money = [NSString stringWithFormat:@"%ld",(long)lastMoney];

            }
        }
        installMentLoan.periodNo = i;
      
        newMonth  += 1;
        if (newMonth>12) {
            newYear += 1;
            newMonth = 1;
        }
        NSString * expextRepayTime = [NSString  stringWithFormat:@"%ld-%ld-%ld",(long)newYear,(long)newMonth,(long)newDay];
        installMentLoan.expectRepayDate = expextRepayTime;

        [array addObject:installMentLoan];
        
    }
    
    return array;
}

/**
 *  @author chenglibin
 *
 *  计算全额时候的显示，数组里只有一个元素
 *

 */
+ (NSArray *)installmentArrayWithMoney:(NSString *)money withInterest:(NSString *)interest withUserTime:(NSString *)userTime withTimeLong:(LoanPeriod)loanPeriod repayType:(NSInteger)repayType kouxifangshi:(InterestType)kouxifangshi
{
    NSInteger timeLong = loanPeriod- LoanPeriod_MONTH_2+2;

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//    [dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
//    [dateFormat setLocale:[NSLocale currentLocale]];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    [dateFormat setFormatterBehavior:NSDateFormatterBehaviorDefault];
    
    NSDate *date = [dateFormat dateFromString:userTime];

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    if (loanPeriod >= LoanPeriod_MONTH_1) {
        //按月份
        [adcomps setYear:0];
        
        [adcomps setMonth:+timeLong];
        
        [adcomps setDay:1];

    }
    else if ((loanPeriod >= LoanPeriod_WEEK_1) && (loanPeriod <= LoanPeriod_WEEK_3))
    {
        //按星期
        [adcomps setYear:0];
        
        [adcomps setMonth:0];
        
        [adcomps setDay:1+(loanPeriod-5) * 7];

    }
    else
    {
        //按天
        [adcomps setYear:0];
        
        [adcomps setMonth:0];
        
        [adcomps setDay:loanPeriod+2];

    }
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    NSString *newdateStr = [NSString stringWithFormat:@"%@",[[newdate description] substringToIndex:10]];
    TInstallmentLoan * installMentLoan = [[TInstallmentLoan alloc]init];
    if (kouxifangshi == PRE_INTEREST) {
        installMentLoan.money = [NSString stringWithFormat:@"%ld",(long)([money integerValue] + [interest integerValue])];

    }
    else
    {
        installMentLoan.money = [NSString stringWithFormat:@"%ld",(long)[money integerValue]];

    }
    installMentLoan.periodNo = 1;
    installMentLoan.expectRepayDate = newdateStr;
    
    NSArray *array = [NSArray arrayWithObject:installMentLoan];
    
    return array;
}



+(NSInteger)moneyWithTotalMoney:(NSInteger)totalMoney array:(NSMutableArray *)array
{
    
//    最后一期的钱数等于总钱数减掉 前面所有期的钱数和 
    NSInteger subMoney = 0;
    NSInteger remainMoney = 0;
    TInstallmentLoan * installMentLoan = array[0];
    subMoney = subMoney + [installMentLoan.money integerValue];
    
    for (int i = 1; i < [array count]; i ++) {
        TInstallmentLoan * installMentLoan = array[i];
        subMoney = subMoney + [installMentLoan.money integerValue];
    }
    
    remainMoney = totalMoney - subMoney;
    
    return remainMoney;
    
}


@end
