//
//  YXBJieHuanKuanSheZhiBaseController.m
//  YOUXINBAO
//
//  Created by Feili on 16/1/28.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "YXBJieHuanKuanSheZhiBaseController.h"

@interface YXBJieHuanKuanSheZhiBaseController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *topBg;
}
@end

@implementation YXBJieHuanKuanSheZhiBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kRGB(239, 239, 239);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setViewFrame:(CGRect)viewFrame
{
    self.view.frame = viewFrame;
    CGFloat x = 15, y = 0, w = self.view.width - 2 * x, h = viewFrame.size.height;
    
    //    UIImage* img = [UIImage imageNamed:@"JieKuanbgcon.png"];
    //    UIImageView *topBg = [[UIImageView alloc]initWithImage:img];
    //    topBg.frame = ccr(x, y, w, h);
    //    topBg.userInteractionEnabled = YES;
    //    [self.view addSubview:topBg];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:ccr(x, y, w, h)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
//    UILabel *label = [[UILabel alloc] initWithFrame:ccr(0, 0, kDeviceWidth, 60)];
//
//    _tableView.tableFooterView = label;
//    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
//        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 15)];
//        
//    }
//    
//    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
//        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 15, 0, 15)];
//    }
    UIImage* img = [UIImage imageNamed:@"JieKuanbgcon.png"];
//    img = [img stretchableImageWithLeftCapWidth:img.size.width/2 topCapHeight:img.size.height/2];
    topBg = [[UIImageView alloc]initWithImage:img];
    [_tableView addSubview:topBg];
    {
        CGRect r = topBg.frame;
        r.size.height = 0;
        r.size.width = _tableView.width;
        topBg.frame = r;
    }
    

    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID  =@"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == Nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    return cell;
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint p = scrollView.contentOffset;
    if( p.y < 0 ){
        CGRect r = topBg.frame;
        r.size.height = -p.y;
        r.origin.y = p.y;
        topBg.frame = r;
    }

}

@end
