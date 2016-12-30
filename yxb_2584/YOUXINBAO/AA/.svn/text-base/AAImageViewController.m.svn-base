//
//  AAImageViewController.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/3/30.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AAImageViewController.h"
#import "DetailsHeaderView.h"
#import "AAImageTableViewCell.h"
#import "AAFlowView.h"
#import "AAImageTableViewCell.h"
#import "HttpOperator.h"
#import "AAFlowImageModel.h"
#import "TPictureManager.h"
#import "MJRefreshHeaderView.h"
#import "AAImageShowView.h"
#import "AAManager.h"
#import "ELCImagePickerController.h"
#import "ELCImagePickerHeader.h"
#import "ELCAlbumPickerController.h"
#import "UIImage+fixOrientation.h"


#define kTotalColumn 2

#define EnableMultiSelectImages @"1"  //1 支持多选图片

#define kSendButtonAction 30060

@interface AAImageViewController ()<AAFlowViewDelegate,AAFlowViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate,MJRefreshBaseViewDelegate,UIActionSheetDelegate,ELCImagePickerControllerDelegate>
{
 
    DetailsHeaderView * _headerView;
    MJRefreshHeaderView *_header;
    NSInteger _imgCount;//图片数量
    
    BOOL isRefresh;
    
    
}

@property (nonatomic,strong)AAFlowView *flowView;

@property (nonatomic,copy)NSMutableArray *imageData;

@property (nonatomic,retain)ELCImagePickerController *elcPicker;

@property (nonatomic, strong) ALAssetsLibrary *specialLibrary;


@property (nonatomic,retain)NSMutableArray *images;//待上传图片

@end

@implementation AAImageViewController
-(void)dealloc
{
    NSLog(@"AAImageViewController is dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.images = [NSMutableArray array];
    // Do any additional setup after loading the view.
    
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    [self setTitle:@"图片墙"];
    
    [self initView];
}


- (void)initView
{
    
    if (_imageData == nil) {
        _imageData = [NSMutableArray new];
    }
    
//    _headerView  = [[DetailsHeaderView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 140)];
//    [_headerView setImageButtonHidden:YES];
//    [_headerView setActivityModel:_activity];
    
    [self.view addSubview:_headerView];
    
    CGFloat sendH = 40;
    
    _flowView = [[AAFlowView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64-sendH)];
    _flowView.AAFlowViewDelegate = self;
    _flowView.AAFlowViewDatasource = self;
    _flowView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_flowView];
    
    [self refresh];

    UIButton *send = [[UIButton alloc] initWithFrame:CGRectMake(0, kDeviceHeight-64-40, kDeviceWidth, sendH)];
    send.layer.borderColor = rgb(191, 191, 191, 1).CGColor;
    send.layer.borderWidth = 0.5;
    send.tag = kSendButtonAction;
    [send setTitle:@"上传图片" forState:UIControlStateNormal];
    [send setTitleColor:rgb(62, 163, 255, 1) forState:UIControlStateNormal];
    [send addTarget:self action:@selector(sendImageAction:) forControlEvents:UIControlEventTouchUpInside];
//    [send addTarget:self action:@selector(createNewMultiImagePicker) forControlEvents:UIControlEventTouchUpInside];
//    [send addTarget:self action:@selector(launchSpecialController) forControlEvents:UIControlEventTouchUpInside];

    

    [self.view addSubview:send];
    
//    [self loadImageData];
}

- (void)setActivity:(AAActivity *)activity {
    _activity = activity;
    
    UIButton *send = (UIButton *)[self.view viewWithTag:kSendButtonAction];
    if (activity.type == M_CREATED || activity.type == M_REGISTERED || activity.type == M_CHECKIN || activity.type == M_BEINVITED) {
        send.hidden = NO;
    }else {
        send.hidden = YES;
    }
    
    [self setFlowViewImages:activity.postWallPics];
    
}

- (void)setFlowViewImages:(NSString *)pictures {
    NSString *imageJson = pictures;
    NSError *error;
    //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
    NSArray *images = [NSJSONSerialization JSONObjectWithData:[imageJson dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
    NSMutableArray *container = [NSMutableArray new];
    for (NSDictionary *dic in images) {
        AAFlowImageModel *model = [[AAFlowImageModel alloc] initWithDic:dic];
        //        if (model.status == 1) {
        [container addObject:model];
        
        //        }
    }
    self.imageData = container;
    [self.flowView reloadData];
}

#pragma mark - Http
//- (void)loadImageData {
////    [_imageData removeAllObjects];
//    
//    if (self.iHttpOperator == nil) {
//        self.iHttpOperator = [[HttpOperator alloc]init];
//        
//    }
//    [self.iHttpOperator cancel];
//    
//    __weak HttpOperator * assginHtttperator = _iHttpOperator;
//    __weak AAImageViewController *this = self;
//    [self.iHttpOperator connetStart:^(int d) {
//        
//    } cancel:^(int d) {
//        
//    } error:^(int d, THttpOperatorErrorCode error) {
//        
//        if (error == EHttp_Operator_Failed) {
//            //服务器挂了
//        }
//        
//    } param:^(NSString *s) {
//        
//        TPictureManager* _pictureM = (TPictureManager*)  [assginHtttperator getAopInstance:[TPictureManager class] returnValue:[NSSkyArray class]];
//        
//        [_pictureM getPostWallPics:this.activity.t_id];
//        
//    } complete:^(NSSkyArray* r, int taskid) {
//        //停止刷新
//        [this reloadDeals];
//        
//        if (r.errCode == 0) {
//            NSMutableArray *container = [NSMutableArray new];
//            for (NSDictionary *dic in r.iArray) {
//                AAFlowImageModel *model = [[AAFlowImageModel alloc] initWithDic:dic];
//                [container addObject:model];
//            }
//            this.imageData = container;
//            [_flowView reloadData];
//        }else{
//            NSLog(@"%@",r.errString);
//        }
//        
//    }];
//    [self.iHttpOperator connect];
//}

#pragma mark  --------------------------- refresh
- (void)refresh
{
    
    _header = [MJRefreshHeaderView header];
    _header.scrollView = _flowView;
    _header.delegate = self;
    [_header beginRefreshing];
    
}
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    
    if (refreshView == _header && !isRefresh) {
//        [self loadImageData];
        
//        [self httpDowload:@""];
        [self getPostWall];
    }
}

- (void)reloadDeals
{
    
    // 结束刷新状态
    [_header endRefreshing];
    isRefresh = NO;
    //    [_footer endRefreshing];
    
}

#pragma mark - AAFlowView delegate
/*
 返回每个cell的高度
 */
- (CGFloat)AAFlowView:(AAFlowView *)flowView heightForRowAtIndexPath:(IndexPath *)indexPath {
    
    NSInteger arrIndex = indexPath.row * flowView.columnCount + indexPath.column;
    AAFlowImageModel *imageModel = [_imageData objectAtIndex:arrIndex];
    
    float width = 0.0f;
    float height = 0.0f;
    if (imageModel != nil) {
        
        width = imageModel.width;
        height = imageModel.height;
    }
    
    return width == 0 ? 0:flowView.cellWidth * (height/width);
}


/*
 跟据参数indexPath的行列属性，定位哪行哪列被选中
 */
- (void)AAFlowView:(AAFlowView *)flowView didSelectRowAtIndexPath:(IndexPath *)indexPath {
    NSInteger sort = indexPath.column+indexPath.row*kTotalColumn;
    
    NSMutableArray *urlArr = [NSMutableArray new];
    for (AAFlowImageModel *model in self.imageData) {
        [urlArr addObject:model.url];
    }
    
    if (urlArr.count == 0) {
        
        return;
    }

    AAImageShowView *showView = [[AAImageShowView alloc] initWithFrame:[UIScreen mainScreen].bounds withUrlArr:urlArr withIndex:sort];
    
    UIWindow *mWindow = [[[UIApplication sharedApplication] delegate] window];
    if (!mWindow.isKeyWindow) {
        [mWindow makeKeyAndVisible];
        
    }
    [mWindow addSubview:showView];
    showView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        // animate it to the identity transform (100% scale)
        showView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished){
        // if you want to do something once the animation finishes, put it here
    }];
    

}

#pragma mark - AAFlowView dataSource

/*
 配置每个cell的子视图，添加返回的视图到cell上
 */

- (UIView *)AAFlowView:(AAFlowView *)flowView cellForRowAtIndexPath:(IndexPath *)indexPath {
    AAImageTableViewCell *view = [[AAImageTableViewCell alloc] init];
    return view;
}

/*
 将cell上的子视图传出，方便自定义子视图的样式，实现个性化定制
 */
-(void)AAFlowView:(AAFlowView *)flowView relayoutCellSubview:(UIView *)view withIndexPath:(IndexPath *)indexPath {
    //arrIndex是某个数据在总数组中的索引
    NSInteger arrIndex = indexPath.row * flowView.columnCount + indexPath.column;
    
    
    AAFlowImageModel *imageModel = [_imageData objectAtIndex:arrIndex];
    
    NSURL *URL = [NSURL URLWithString:imageModel.url];
    
    AAImageTableViewCell *imageViewCell = (AAImageTableViewCell *)view;
    imageViewCell.indexPath = indexPath;
    imageViewCell.columnCount = flowView.columnCount;
    [imageViewCell relayoutViews];
    [imageViewCell setImageWithURL:URL];

}


/*
 返回瀑布效果的列数
 */
- (NSInteger)numberOfColumsInAAFlowView:(AAFlowView *)flowView {
    return kTotalColumn;
}

/*
 返回cell的总数，每个cell的行号通过总数和列号来确定
 */
- (NSInteger)numberOfAllAAFlowView:(AAFlowView *)flowView {
    return _imageData.count;
}

- (void)sendImageAction:(UIButton *)button {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从本地相册上传", nil];
    [actionSheet showInView:self.view];
    
    
//    UIImagePickerController *picker=[[UIImagePickerController alloc] init];
//    picker.title = @"照片";
//    
//    picker.delegate = self;
//    picker.allowsEditing=YES;
//    
//    
//    picker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark -- actionSheet   delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *picker=[[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing=YES;
    if (buttonIndex==0) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"对不起，您的设备不支持拍照功能。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            return;
        }
        //        NSLog(@"0");
        picker.sourceType=UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }
    if (buttonIndex==1) {
        //        NSLog(@"1");
        if ([EnableMultiSelectImages integerValue] == 1) {
            //支持多选
            [self launchSpecialController];

        }
        else
        {
            picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:YES completion:nil];

        }
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
//
//    //删除原有图片
//    if (_imageData != nil) {
//        [_imageData removeAllObjects];
//        
//    }
    
    //上传图片
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
//    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];

    //调整坐标系方向
    image = [image fixOrientation];

    
    float compressionQuality = 1.0;
    
    //图片压缩至低于600K
    NSData *imgData;
    do {
        imgData = UIImageJPEGRepresentation(image, compressionQuality);
        compressionQuality -= 0.1;
    } while (imgData.length > 600000);
    
    //设置上传图片 不可点击
    UIView *view = [self.view viewWithTag:kSendButtonAction];
    view.userInteractionEnabled = NO;

    
//    NSString *Urlstring=[NSString stringWithFormat:@"%@uploadPhoto.jsp?type=6&id=%ld",YXB_IP_ADRESS,(long)self.activity.t_id];
    NSString *url1 = [NSString stringWithFormat:@"uploadBatchPhoto.jsp?type=6&id=%ld",(long)self.activity.t_id];
    NSString *Urlstring = [NSString stringWithFormat:@"%@%@",YXB_IP_ADRESS,url1];
    NSLog(@"图片Urlstring---%@",Urlstring);
    NSURL *url = [NSURL URLWithString:[Urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    __weak AAImageViewController *this = self;
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setAuthImageData:imgData forKey:@"image"];
    //    [request setContentLength:imgData.length];
    //    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d", [imgData length]]];
    //    NSLog(@"imdddd =%d",imgData.length);
    [request setFailedBlock:^{
        [ProgressHUD showSuccessWithStatus:@"图片上传失败"];
        UIView *view = [this.view viewWithTag:kSendButtonAction];
        view.userInteractionEnabled = YES;

        NSLog(@"failed");
    }];
    [request setCompletionBlock:^{
        [ProgressHUD showSuccessWithStatus:@"图片上传成功"];
        UIView *view = [this.view viewWithTag:kSendButtonAction];
        view.userInteractionEnabled = YES;

//        NSError *error;
//        NSData *data = [request responseData];
//        NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        [this httpDowload:request.responseString];
//        NSArray *value = [res objectForKey:@"value"];
//        NSMutableArray *container = [NSMutableArray new];
//        for (NSDictionary *dic in value) {
//            AAFlowImageModel *model = [[AAFlowImageModel alloc] initWithDic:dic];
//            [container addObject:model];
//        }
//        this.imageData = container;
//        [_flowView reloadData];
        
    }];
    [request startAsynchronous];
    [ProgressHUD showWithStatus:@"正在上传图片..." maskType:ProgressHUDMaskTypeNone tipsType:ProgressHUDTipsTypeLongBottom networkIndicator:YES];
    

    
    

}


#pragma mark - HTTP
- (void)getPostWall {
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak AAImageViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {

        [this httpLoadError:error];
    } param:^(NSString *s) {
        
        /*
         TActivityManager* _activityM = (TActivityManager*)  [assginHtttperator getAopInstance:[TActivityManager class] returnValue:[TActivity class]];
         QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
         [_activityM getTActivityById:userModel.user.t_id activityId:this.brief.t_id tagType:this.tagType];
         */
        
        [this getPostWallHttpLOadParams:s httpOperation:assginHtttperator];
    } complete:^(TResultSet* r, int taskid) {
        [this getPostWallHttpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
}
//上传参数
- (void)getPostWallHttpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    AAManager* _activityM = (AAManager*)  [httpOperation getAopInstance:[AAManager class] returnValue:[TResultSet class]];
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    [_activityM getPictureWall:userModel.user.yxbToken activityId:self.activity.t_id];
}
//请求完成
-(void)getPostWallHttpLoadComplete:(TResultSet*)r{
    [self reloadDeals];
    if (r.errCode == 0) {
        [self setFlowViewImages:r.resString];
        //            [this.flowView reloadData];
    }else {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:r.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
    }
}




- (void)httpDowload:(NSString *)url
{
    //去掉换行符
    NSMutableString *responseString = [NSMutableString stringWithString:url];
    NSString *search = @"\n";
    NSString *replace = @"";
    
    NSRange substr = [responseString rangeOfString:search];
    
    while (substr.location != NSNotFound) {
        [responseString replaceCharactersInRange:substr withString:replace];
        substr = [responseString rangeOfString:search];
    }

    url = responseString;
    
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak AAImageViewController *this = self;
//    __weak NSString *urlStr;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
    } param:^(NSString *s) {
        
        /*
         TActivityManager* _activityM = (TActivityManager*)  [assginHtttperator getAopInstance:[TActivityManager class] returnValue:[TActivity class]];
         QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
         [_activityM getTActivityById:userModel.user.t_id activityId:this.brief.t_id tagType:this.tagType];
         */
        
        [this httpLOadParams:s httpOperation:assginHtttperator url:url];
    } complete:^(AAActivity* r, int taskid) {
        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation url:(NSString *)url
{
    AAManager* _activityM = (AAManager*)  [httpOperation getAopInstance:[AAManager class] returnValue:[AAActivity class]];
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    [_activityM createPostWallPics:userModel.user.yxbToken url:url activityId:self.activity.t_id];

}
//请求完成
-(void)httpLoadComplete:(AAActivity *)r{
    [self reloadDeals];
    if (r.errCode == 0) {
        self.activity = r;
        //            [this.flowView reloadData];
    }else {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:r.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
    }
}
- (void)leftClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)launchSpecialController
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    self.specialLibrary = library;
    NSMutableArray *groups = [NSMutableArray array];
    [_specialLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            [groups addObject:group];
        } else {
            // this is the end
            [self displayPickerForGroup:[groups objectAtIndex:0]];
        }
    } failureBlock:^(NSError *error) {
//        self.chosenImages = nil;
//        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Album Error: %@ - %@", [error localizedDescription], [error localizedRecoverySuggestion]] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//        [alert show];
//        
        NSLog(@"A problem occured %@", [error description]);
        // an error here means that the asset groups were inaccessable.
        // Maybe the user or system preferences refused access.
    }];
}





//创建新的imagePicker

-(void)createNewMultiImagePicker
{
//    self.elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    self.elcPicker = [[ELCImagePickerController alloc] initImagePicker];

    _elcPicker.maximumImagesCount = 100; //Set the maximum number of images to select to 100
    _elcPicker.returnsOriginalImage = YES; //Only return the fullScreenImage, not the fullResolutionImage
    _elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
    _elcPicker.onOrder = YES; //For multiple image selection, display and return order of selected images
//    _elcPicker.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie]; //Supports image and movie types
    _elcPicker.mediaTypes = @[(NSString *)kUTTypeImage]; //Supports image  types

    _elcPicker.imagePickerDelegate = self;
    
    [self presentViewController:_elcPicker animated:YES completion:nil];

}

- (void)displayPickerForGroup:(ALAssetsGroup *)group
{
    ELCAssetTablePicker *tablePicker = [[ELCAssetTablePicker alloc] initWithStyle:UITableViewStylePlain];
    tablePicker.singleSelection = NO;
    tablePicker.immediateReturn = NO;
    
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initWithRootViewController:tablePicker];
    elcPicker.maximumImagesCount = 10;
    elcPicker.imagePickerDelegate = self;
    elcPicker.returnsOriginalImage = YES; //Only return the fullScreenImage, not the fullResolutionImage
    elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
    elcPicker.onOrder = NO; //For single image selection, do not display and return order of selected images
    tablePicker.parent = elcPicker;
    
    // Move me
    tablePicker.assetGroup = group;
    [tablePicker.assetGroup setAssetsFilter:[ALAssetsFilter allAssets]];
    
    [self.view.window.rootViewController presentViewController:elcPicker animated:YES completion:nil];
//    [self presentViewController:elcPicker animated:YES completion:nil];
}



#pragma mark ELCImagePickerControllerDelegate Methods

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];

    
    _imgCount = 0;
    if ([info count] == 0) {
        return;
    }
    [ProgressHUD showWithStatus:@"正在处理..." maskType:ProgressHUDMaskTypeNone tipsType:ProgressHUDTipsTypeLongBottom];

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
//        [ProgressHUD showWithStatus:@"正在处理..." maskType:ProgressHUDMaskTypeNone tipsType:ProgressHUDTipsTypeLongBottom];
        if (_images != nil) {
            [_images removeAllObjects];
        }
        for (NSDictionary *dict in info) {
            UIView *view = [self.view viewWithTag:kSendButtonAction];
            view.userInteractionEnabled = NO;

            if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto)
            {
                if ([dict objectForKey:UIImagePickerControllerOriginalImage])
                {
                    UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                    NSLog(@"image ori---%ld",(long)image.imageOrientation);
                    //调整坐标系方向
                    image = [image fixOrientation];
                    
                    NSData *imgData = [self getImageDataWithImage:image];
                    [_images addObject:imgData];
                }
                else
                {
                    NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
                }
            }
            else
            {
                NSLog(@"Uknown asset type");
            }
        }
        
        _imgCount = [_images count];
        

        dispatch_async(dispatch_get_main_queue(), ^{
            
            [ProgressHUD dismiss];
            [self uploadImages];

        });
        
    });
    

    
    
    
    
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [ProgressHUD dismiss];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//图片压缩
-(NSData *)getImageDataWithImage:(UIImage *)image
{
    float compressionQuality = 1.0;
    
    //图片压缩至低于600K
    NSData *imgData;
    do {
        imgData = UIImageJPEGRepresentation(image, compressionQuality);
        compressionQuality -= 0.1;
    } while (imgData.length > 600000);
    
    return imgData;

}

//上传图片

-(void)uploadImages
{
    NSString *url1 = [NSString stringWithFormat:@"uploadBatchPhoto.jsp?type=6&id=%ld",(long)self.activity.t_id];
    NSString *Urlstring = [NSString stringWithFormat:@"%@%@",YXB_IP_ADRESS,url1];
    NSLog(@"图片Urlstring---%@",Urlstring);
    NSURL *url = [NSURL URLWithString:[Urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    __weak AAImageViewController *this = self;
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    NSData * imgData = nil;
    if (_images != nil && [_images count] > 0) {
        imgData = _images[0];
        
        UIView *view = [self.view viewWithTag:kSendButtonAction];
        view.userInteractionEnabled = NO;

    }
    else
    {
        UIView *view = [self.view viewWithTag:kSendButtonAction];
        view.userInteractionEnabled = YES;
        return;
    }
    
    [request setAuthImageData:imgData forKey:@"image"];
    //    [request setContentLength:imgData.length];
    //    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d", [imgData length]]];
    //    NSLog(@"imdddd =%d",imgData.length);
    [request setFailedBlock:^{
        [ProgressHUD showSuccessWithStatus:@"图片上传失败"];
        UIView *view = [this.view viewWithTag:kSendButtonAction];
        view.userInteractionEnabled = YES;

//        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"上传图片失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alterView show];
        NSLog(@"failed");
    }];
    [request setCompletionBlock:^{
        [this.images removeObjectAtIndex:0];
        [ProgressHUD showSuccessWithStatus:@"图片上传成功"];
        NSLog(@"图片服务器返回地址--%@",request.responseString);
        [this httpDowload:request.responseString];
        if ([this.images count] > 0) {
            [this uploadImages];
        }
        else
        {
            UIView *view = [this.view viewWithTag:kSendButtonAction];
            view.userInteractionEnabled = YES;

        }

        
    }];
    [request startAsynchronous];
    [ProgressHUD showWithStatus:[NSString stringWithFormat:@"正在上传第%ld张,共%ld张",(long)(_imgCount - [this.images count] + 1),(long)_imgCount]  maskType:ProgressHUDMaskTypeNone tipsType:ProgressHUDTipsTypeLongBottom networkIndicator:YES];

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
