//
//  CTPhotoWall.m
//  HandicapWin
//
//  Created by CH10 on 16/5/9.
//  Copyright © 2016年 赢盘. All rights reserved.
//

#import "CTPhotoWall.h"
#import "UIImageView+WebCache.h"
#import "CTPWCollectionViewCell.h"
@interface CTPhotoWall ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UILabel *_titleLabel;
    NSInteger _pageNum;
}
@property (nonatomic,strong)UIView *titleView;
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)UIView *contentView;
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@end


@implementation CTPhotoWall

+(void)photoWallShowWithImgModelDataArr:(NSArray<CTPhotoModel *> *)dataArr Index:(NSInteger)index{
    CTPhotoWall *photoWall = [[CTPhotoWall alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
    [photoWall createContentViewWithDataArr:dataArr index:index];
    
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:photoWall.bgView];
    [[UIApplication sharedApplication].keyWindow addSubview:photoWall];
}
+(void)photoWallShowWithImgUrlDataArr:(NSArray<NSString *> *)dataArr Index:(NSInteger)index{
    NSMutableArray <CTPhotoModel*>*arr = [[NSMutableArray alloc] init];
    for (NSString *imgUrlStr in dataArr) {
        CTPhotoModel *model = [[CTPhotoModel alloc] init];
        model.type = @"0";
        model.largeImgUrl = imgUrlStr;
        [arr addObject:model];
    }
    [CTPhotoWall photoWallShowWithImgModelDataArr:arr Index:index];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.alpha = 0.9;
        self.bgView = bgView;
        
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
        [self addSubview:contentView];
        self.contentView = contentView;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self.contentView addGestureRecognizer:tap];
        
    }
    return self;
}
-(void)tapAction{
    [self.bgView removeFromSuperview];
    [self removeFromSuperview];
}
-(void)createContentViewWithDataArr:(NSArray*)dataArr index:(NSInteger)index{
    
    _dataArr = [[NSMutableArray alloc] initWithArray:dataArr];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setItemSize:CGSizeMake(kDeviceWidth, kDeviceHeight)];
    layout.minimumLineSpacing = 0.0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight) collectionViewLayout:layout];
    [collection setContentOffset:CGPointMake(index*kDeviceWidth, 0)];
    collection.delegate =self;
    collection.pagingEnabled = YES;
    collection.bounces = NO;
    collection.dataSource = self;
    [collection registerClass:[CTPWCollectionViewCell class] forCellWithReuseIdentifier:@"photoWallID"];
    [self.contentView addSubview:collection];    
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 64)];
    self.titleView = titleView;
    [self.contentView addSubview:_titleView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, titleView.height)];
    _titleLabel.text = [NSString stringWithFormat:@"%ld/%ld",(long)(index+1),(long)dataArr.count];
     NSMutableAttributedString *attText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld/%ld",(long)(index+1),(long)dataArr.count] attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20],NSForegroundColorAttributeName :[UIColor whiteColor],NSStrokeColorAttributeName:[UIColor blackColor],NSStrokeWidthAttributeName:@-3}];
    _titleLabel.attributedText =attText;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_titleView addSubview:_titleLabel];
    
}
-(CGFloat)countHeightWithImage:(UIImage *)img{
    CGFloat w = img.size.width,h=img.size.height;
    
    CGFloat xishu = kDeviceWidth/w;
    h*=xishu;
    return h;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offSet = scrollView.contentOffset;
    _pageNum = offSet.x/kDeviceWidth;

    NSMutableAttributedString *attText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld/%ld",(long)(_pageNum+1),(long)_dataArr.count] attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20],NSForegroundColorAttributeName :[UIColor whiteColor],NSStrokeColorAttributeName:[UIColor blackColor],NSStrokeWidthAttributeName:@-3}];
    _titleLabel.attributedText =attText;

}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArr.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CTPWCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoWallID" forIndexPath:indexPath];
    if (_dataArr.count) {
        CTPhotoModel *model = [_dataArr objectAtIndex:indexPath.row];
        cell.model = model;
    }
    
    return cell;
}

@end
