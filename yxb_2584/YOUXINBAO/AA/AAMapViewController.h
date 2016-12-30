//
//  AAMapViewController.h
//  YOUXINBAO
//
//  Created by CH10 on 15/3/26.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AABaseViewController.h"
#import "BMapKit.h"

@protocol AAMapViewDelegate <NSObject>
@optional
- (void)AAMapViewLocationDidTouchForTitle:(NSString *)title coordinate:(CLLocationCoordinate2D)coordinate;
- (void)AAMapViewLocationDidTouchForTitle:(NSString *)title coordinate:(CLLocationCoordinate2D)coordinate image:(UIImage *)image;

@end

@interface AAMapViewController :AABaseViewController <BMKMapViewDelegate,BMKLocationServiceDelegate,UISearchBarDelegate,BMKPoiSearchDelegate,BMKGeoCodeSearchDelegate,UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *alphaView;
@property (weak, nonatomic) IBOutlet UITableView *searchResult;

@property (nonatomic,assign) id<AAMapViewDelegate> delegate;

@end
