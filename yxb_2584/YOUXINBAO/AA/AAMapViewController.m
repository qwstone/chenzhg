//
//  AAMapViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 15/3/26.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AAMapViewController.h"
#import "QCLocalLocation.h"

@interface AAMapViewController () {
    BMKLocationService *_locService;
    BMKGeoCodeSearch *_geoSearcher;
    BMKPoiSearch *_poiSearcher;
    
//    NSMutableArray *_annotationArr;     //标注数组
    NSMutableArray *_searchResultArr;   //搜索结果
    
    NSInteger _currentPage; //当前搜索页
    NSString *_searchText;   //搜索关键字
    
    NSIndexPath *_selectedIndex;    //选中列
    
    BOOL _isDragging;   //是否拖拽地图
    
    BMKPoiInfo *_selectedInfo;  //选中位置信息
}

@property (nonatomic,strong) NSArray *nearbyInfo;

@end

@implementation AAMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    //确认
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 60, 30);
    [btn addTarget:self action:@selector(sureClicked) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    UIBarButtonItem *createItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = createItem;
    
    [self setTitle:@"标记活动地点"];
    
    //初始化
//    _annotationArr = [NSMutableArray new];
    _selectedInfo = [[BMKPoiInfo alloc] init];
    _isDragging = YES;
    _searchResultArr = [NSMutableArray new];
    _selectedIndex = [NSIndexPath indexPathForRow:0 inSection:0];
    
    //设置定位精确度，默认：kCLLocationAccuracyBest
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyBest];
    //指定最小距离更新(米)，默认：kCLDistanceFilterNone
    [BMKLocationService setLocationDistanceFilter:1000.f];
    
    _mapView.showsUserLocation = YES;//显示定位图层
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
    //初始化检索对象
    _poiSearcher =[[BMKPoiSearch alloc]init];
    _poiSearcher.delegate = self;
    
    _geoSearcher =[[BMKGeoCodeSearch alloc]init];
    _geoSearcher.delegate = self;

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    imageView.center = CGPointMake(_mapView.center.x, _mapView.center.y-10);
    NSString *filePath = [[NSBundle mainBundle].bundlePath stringByAppendingString:@"/RongCloud.bundle/map_annotation.png"];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:filePath];
    imageView.image = image;
    [self.view addSubview:imageView];
    [self.view insertSubview:imageView belowSubview:_alphaView];
    
    UIControl *control = [[UIControl alloc] initWithFrame:_alphaView.bounds];
    control.backgroundColor = [UIColor clearColor];
    [control addTarget:self action:@selector(alphaControl:) forControlEvents:UIControlEventTouchUpInside];
    [_alphaView addSubview:control];
    [_alphaView insertSubview:control belowSubview:_searchResult];
}

- (void)searchByPage:(NSInteger)page {
    _currentPage = page;
    
    //发起检索
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
    option.pageIndex = (int)page;
    option.location = _mapView.region.center;
    option.keyword = _searchText;
    BOOL flag = [_poiSearcher poiSearchNearBy:option];
    if(flag)
    {
        NSLog(@"周边检索发送成功");
    }
    else
    {
        NSLog(@"周边检索发送失败");
    }
    

}

#pragma mark - BMKLocationServiceDelegate
//监听地图上的滑动手势
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    //    发起反向地理编码检索
    if (_isDragging) {
        CLLocationCoordinate2D pt = (CLLocationCoordinate2D){_mapView.getMapStatus.targetGeoPt.latitude, _mapView.getMapStatus.targetGeoPt.longitude};
        BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
        reverseGeoCodeSearchOption.reverseGeoPoint = pt;
        BOOL flag = [_geoSearcher reverseGeoCode:reverseGeoCodeSearchOption];
        if(flag)
        {
            NSLog(@"反geo检索发送成功");
        }
        else
        {
            NSLog(@"反geo检索发送失败");
        }
        
    }
    
    [_tableView reloadData];
    _isDragging = YES;

}

//接收反向地理编码结果
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:
(BMKReverseGeoCodeResult *)result
                        errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        //      在此处理正常结果
        self.nearbyInfo = result.poiList;
        _selectedInfo = result.poiList.firstObject;
        _selectedIndex = [NSIndexPath indexPathForRow:0 inSection:0];
        [_tableView reloadData];
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}
//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
    BMKCoordinateRegion region;
    region.center.latitude  = userLocation.location.coordinate.latitude;
    region.center.longitude = userLocation.location.coordinate.longitude;
    region.span.latitudeDelta  = 0.2;
    region.span.longitudeDelta = 0.2;
    if (_mapView)
    {
        _mapView.region = region;
        _mapView.zoomLevel = 15;
        NSLog(@"当前的坐标是: %f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
        
        //    发起反向地理编码检索
        CLLocationCoordinate2D pt = (CLLocationCoordinate2D){region.center.latitude, region.center.longitude};
        BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
        reverseGeoCodeSearchOption.reverseGeoPoint = pt;
        BOOL flag = [_geoSearcher reverseGeoCode:reverseGeoCodeSearchOption];
        if(flag)
        {
            NSLog(@"反geo检索发送成功");
        }
        else
        {
            NSLog(@"反geo检索发送失败");
        }

    }
}

//点击地图空白处
//- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate
//
//{
//    
////    NSLog(@"onClickedMapBlank-latitude==%f,longitude==%f",coordinate.latitude,coordinate.longitude);
////    
////    NSString* showmeg = [NSString stringWithFormat:@"您点击了地图空白处(blank click).\r\n当前经度:%f,当前纬度:%f,\r\nZoomLevel=%d;RotateAngle=%d;OverlookAngle=%d", coordinate.longitude,coordinate.latitude,
////                         
////                         (int)_mapView.zoomLevel,_mapView.rotation,_mapView.overlooking];
////    
////    _showMsgLabel.text = showmeg;
//    
//}

#pragma mark - UISearchBar delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    _alphaView.hidden = NO;
    _alphaView.backgroundColor = rgb(255, 255, 255, .6);
    _searchResult.hidden = YES;
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchBar.text.length != 0) {
        _alphaView.backgroundColor = [UIColor whiteColor];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
//    [_mapView removeAnnotations:_annotationArr];
//    [_annotationArr removeAllObjects];
    
    _searchText = searchBar.text;
    
    [self searchByPage:0];
    
    [searchBar resignFirstResponder];
}


#pragma mark - BMKPoiSearchDelegate

//实现PoiSearchDeleage处理回调结果
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
//    if (_currentPage < poiResultList.pageNum-1 && _currentPage < 10) {
//        [self searchByPage:_currentPage+1];
//    }
    
    if (error == BMK_SEARCH_NO_ERROR) {
        /*标注视图
        //在此处理正常结果
        for (BMKPoiInfo *info in poiResultList.poiInfoList) {
            NSLog(@"%@",info);
            // 添加一个PointAnnotation
            BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
            annotation.coordinate = info.pt;
            annotation.title = info.name;
//            [_annotationArr addObject:annotation];
        }
        
//        [_mapView addAnnotations:_annotationArr];
        */
        //在此处理正常结果
        _searchResult.hidden = NO;
//        [_searchResultArr addObjectsFromArray:poiResultList.poiInfoList];
        _searchResultArr = [NSMutableArray arrayWithArray:poiResultList.poiInfoList];
        [_searchResult reloadData];
    
    }else if (error == BMK_SEARCH_RESULT_NOT_FOUND) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"查询结果为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
    } else {
        NSLog(@"抱歉，未找到结果");
    }
}

///**
// *当点击annotation view弹出的泡泡时，调用此接口
// *@param mapView 地图View
// *@param view 泡泡所属的annotation view
// */
//- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view {
//    CLLocationCoordinate2D coordinate =  view.annotation.coordinate;
//    NSString *title = view.annotation.title;
//    
//    [self.navigationController popViewControllerAnimated:YES];
//    
//    if ([self.delegate respondsToSelector:@selector(annotationViewForBubbleDidTouchForTitle:coordinate:)]) {
//        [self.delegate annotationViewForBubbleDidTouchForTitle:title coordinate:coordinate];
//    }
//}

#pragma mark - UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:_tableView]) {
        //附近
        return _nearbyInfo.count;
        
    }else {
        //查询结果
        return _searchResultArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_tableView]) {
        static NSString *identifier = @"nearbyCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            
        }
        if (indexPath.row == _selectedIndex.row) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        BMKPoiInfo *info = [_nearbyInfo objectAtIndex:indexPath.row];
        cell.textLabel.text = info.name;
        cell.detailTextLabel.text = info.address;
        
        return cell;
    }else {
        static NSString *identifier = @"searchCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            
        }
        BMKPoiInfo *info = [_searchResultArr objectAtIndex:indexPath.row];
        cell.textLabel.text = info.name;
        cell.detailTextLabel.text = info.address;
        
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_tableView]) {
        _isDragging = NO;
        _selectedIndex = indexPath;
        
        BMKPoiInfo *info = [_nearbyInfo objectAtIndex:indexPath.row];
        _selectedInfo = info;
        
        BMKCoordinateRegion region;
        region.center.latitude  = info.pt.latitude;
        region.center.longitude = info.pt.longitude;
        //    region.span.latitudeDelta  = 0.2;
        //    region.span.longitudeDelta = 0.2;
        if (_mapView) {
            _mapView.region = region;
        }
        
    }else {
        _alphaView.hidden = YES;
        
        
        BMKPoiInfo *info = [_searchResultArr objectAtIndex:indexPath.row];
        _selectedInfo = info;
        
        BMKCoordinateRegion region;
        region.center.latitude  = info.pt.latitude;
        region.center.longitude = info.pt.longitude;
        //    region.span.latitudeDelta  = 0.2;
        //    region.span.longitudeDelta = 0.2;
        if (_mapView) {
            _mapView.region = region;
        }

    }

}

- (void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _geoSearcher.delegate = nil;
    _poiSearcher.delegate = nil;
    _locService.delegate = nil;
}

- (void)alphaControl:(UIControl *)control {
    _alphaView.hidden = YES;
    [_searchBar resignFirstResponder];
}

//确定
- (void)sureClicked {
    [self.navigationController popViewControllerAnimated:YES];
    
    if ([self.delegate respondsToSelector:@selector(AAMapViewLocationDidTouchForTitle:coordinate:)]) {
        [self.delegate AAMapViewLocationDidTouchForTitle:_selectedInfo.name coordinate:_selectedInfo.pt];
    }
    if ([self.delegate respondsToSelector:@selector(AAMapViewLocationDidTouchForTitle:coordinate:image:)]) {
        [self.delegate AAMapViewLocationDidTouchForTitle:_selectedInfo.name coordinate:_selectedInfo.pt image:[self mapViewScreenShot]];
    }
}

- (void)leftClicked
{
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (UIImage*)mapViewScreenShot {
    UIImage *mapScreenShot = [self.mapView takeSnapshot];
    UIGraphicsBeginImageContextWithOptions(self.mapView.frame.size, NO, 0.0);
    CGAffineTransform flipVertical = CGAffineTransformMake(
                                                           1, 0, 0, -1, 0, mapScreenShot.size.height
                                                           );
    CGContextConcatCTM(UIGraphicsGetCurrentContext(), flipVertical);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, mapScreenShot.size.width, mapScreenShot.size.height), mapScreenShot.CGImage);
    
    NSString *filePath = [[NSBundle mainBundle].bundlePath stringByAppendingString:@"/RongCloud.bundle/map_annotation.png"];
    UIImage *imageAnnotation = [[UIImage alloc] initWithContentsOfFile:filePath];
    CGRect imageAnnotationFrame = CGRectMake(0, 0, 32, 32);
    imageAnnotationFrame.origin.y = mapScreenShot.size.height / 2;
    imageAnnotationFrame.origin.x = mapScreenShot.size.width / 2 - 16;
    CGContextDrawImage(UIGraphicsGetCurrentContext(), imageAnnotationFrame, imageAnnotation.CGImage);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGRect rect;
    rect.origin = CGPointZero;
    rect.size = image.size;
    rect.size.height *= image.scale;
    rect.size.width *= image.scale;
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
    image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return image;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
