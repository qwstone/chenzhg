//
//  ScannerViewController.h
//  ScannerTest
//
//  Created by xiatian on 14/10/22.
//  Copyright (c) 2014年 xiatian. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "ZXingObjC.h"
#import "HttpOperator.h"
@protocol ScannerViewControllerDelegate <NSObject>

-(void)backAction:(NSString *)resultStr;

@end
@interface ScannerViewController : UIViewController<ZXCaptureDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIView *scannerView;
}
@property (nonatomic, strong) ZXCapture *capture;
@property(nonatomic,strong)HttpOperator *iHttpOperator;
@property (nonatomic,assign) id<ScannerViewControllerDelegate> delegate;
@end
