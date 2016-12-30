//
//  QCBaseTableView.m
//  YOUXINBAO
//
//  Created by CH10 on 15/4/30.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseTableView.h"


@implementation QCBaseTableView {
    MJRefreshHeaderView *_header;
    MJRefreshHeaderView *_footer;
}

-(void)dealloc
{
    
    
}

- (void)awakeFromNib {
    self.backgroundColor = [UIColor clearColor];
    
    _header = [MJRefreshHeaderView header];
    _header.scrollView = self;
    _header.delegate = self;
    
    _footer = [MJRefreshFooterView footer];
    
    _footer.delegate = self;
    
    self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _header = [MJRefreshHeaderView header];
        _header.scrollView = self;
        _header.delegate = self;
        
        _footer = [MJRefreshFooterView footer];
        
        _footer.delegate = self;
        
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style refreshFooter:(BOOL)yesOrNo {
    self = [self initWithFrame:frame style:style];
    if (self) {
        
        self.hasFooter = yesOrNo;
        
    }
    
    return self;
}

- (void)setHasFooter:(BOOL)hasFooter {
    _hasFooter = hasFooter;
    
    if (hasFooter) {
        if (_footer.superview == nil) {
            _footer.scrollView = self;
            
        }else {
            _footer.hidden = NO;
        }
        
    }else {
        if (_footer.superview != nil) {
            _footer.hidden = YES;
            
        }
    }
}

- (void)setRefreshDelegate:(id<QCBaseTableViewDelegate>)refreshDelegate {
    _refreshDelegate = refreshDelegate;
    
    [_header beginRefreshing];
}

#pragma mark  --------------------------- refresh
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    
    if (refreshView == _header && !_isRefresh) {
        if ([self.refreshDelegate respondsToSelector:@selector(QCBaseTableViewDidPullDownRefreshed:)]) {
            [self.refreshDelegate QCBaseTableViewDidPullDownRefreshed:self];
        }
        
//        self.contentOffset = CGPointMake(0, 0);
        _isRefresh = YES;
    }
}

- (void)beginRefreshing {
    [_header beginRefreshing];
}

- (void)reloadDeals
{
    
    // 结束刷新状态
    [_header endRefreshing];
    _isRefresh = NO;
    [_footer endRefreshing];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
