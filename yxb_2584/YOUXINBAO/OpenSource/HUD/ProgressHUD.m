//
//  ProgressHUD.m
//
//  Created by Sam Vermette on 27.03.11.
//  Copyright 2011 Sam Vermette. All rights reserved.
//

#import "ProgressHUD.h"
#import "ReloadActivityView.h"
#import <QuartzCore/QuartzCore.h>

#define KLabelHeight 50

#ifdef PROGRESSHUD_DISABLE_NETWORK_INDICATOR
#define ProgressHUDShowNetworkIndicator 1
#else
#define ProgressHUDShowNetworkIndicator 0
#endif

@interface ProgressHUD ()

@property (nonatomic, readwrite) ProgressHUDMaskType maskType;
@property (nonatomic, readwrite) ProgressHUDTipsType tipsType;
@property (nonatomic, readwrite) BOOL showNetworkIndicator;
@property (nonatomic, retain) NSTimer *fadeOutTimer;
@property (nonatomic, readonly) UIView *hudView;
@property (nonatomic, readonly) UILabel *stringLabel;
@property (nonatomic, readonly) UIImageView *imageView;
@property (nonatomic, readonly) ReloadActivityView *spinnerView;
@property (nonatomic, assign) UIWindow *previousKeyWindow;
@property (nonatomic, readonly) CGFloat visibleKeyboardHeight;

- (void)showWithStatus:(NSString*)string maskType:(ProgressHUDMaskType)hudMaskType tipsType:(ProgressHUDTipsType)hudTipsType networkIndicator:(BOOL)show;
- (void)setStatus:(NSString*)string;
- (void)registerNotifications;
- (void)moveToPoint:(CGPoint)newCenter rotateAngle:(CGFloat)angle;
- (void)positionHUD:(NSNotification*)notification;

- (void)dismiss;
- (void)dismissAfterDelay:(NSTimeInterval)seconds;
- (void)dismissWithStatus:(NSString*)string error:(BOOL)error;
- (void)dismissWithStatus:(NSString*)string error:(BOOL)error afterDelay:(NSTimeInterval)seconds;

- (void)memoryWarning:(NSNotification*)notification;

@end


@implementation ProgressHUD

@synthesize hudView, maskType, tipsType, showNetworkIndicator, fadeOutTimer, stringLabel, imageView, spinnerView, previousKeyWindow, visibleKeyboardHeight;

static ProgressHUD *sharedView = nil;

- (void)dealloc {
	
	if(fadeOutTimer != nil)
		[fadeOutTimer invalidate], [fadeOutTimer release], fadeOutTimer = nil;
	
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [hudView release];
    [stringLabel release];
    [imageView release];
    [spinnerView release];
    
    [super dealloc];
}

- (void)memoryWarning:(NSNotification *)notification {
	
//    if (sharedView.superview == nil) {
//        [[NSNotificationCenter defaultCenter] removeObserver:self];
//        [sharedView release], sharedView = nil;
//        [hudView release], hudView = nil;
//        [stringLabel release], stringLabel = nil;
//        [imageView release], imageView = nil;
//        [spinnerView release], spinnerView = nil;
//    }
}


+ (ProgressHUD*)sharedView {
	
	if(sharedView == nil)
		sharedView = [[ProgressHUD alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	return sharedView;
}

+ (BOOL)isShow {
    return [ProgressHUD sharedView].alpha == 1;
}

+ (void)setStatus:(NSString *)string {
	[[ProgressHUD sharedView] setStatus:string];
}

#pragma mark - Show Methods

+ (void)show {
	[ProgressHUD showWithStatus:nil networkIndicator:ProgressHUDShowNetworkIndicator];
}

+ (void)showWithStatus:(NSString *)status {
    [ProgressHUD showWithStatus:status networkIndicator:ProgressHUDShowNetworkIndicator];
}

+ (void)showWithMaskType:(ProgressHUDMaskType)maskType {
    [ProgressHUD showWithStatus:nil maskType:maskType tipsType:ProgressHUDTipsTypeNone networkIndicator:ProgressHUDShowNetworkIndicator];
}

+ (void)showWithStatus:(NSString*)status maskType:(ProgressHUDMaskType)maskType tipsType:(ProgressHUDTipsType)tipsType{
    [ProgressHUD showWithStatus:status maskType:maskType tipsType:tipsType networkIndicator:ProgressHUDShowNetworkIndicator];
}

+ (void)showWithStatus:(NSString *)status networkIndicator:(BOOL)show {
    [ProgressHUD showWithStatus:status maskType:ProgressHUDMaskTypeNone tipsType:ProgressHUDTipsTypeNone networkIndicator:show];
}

+ (void)showWithMaskType:(ProgressHUDMaskType)maskType networkIndicator:(BOOL)show {
    [ProgressHUD showWithStatus:nil maskType:maskType tipsType:ProgressHUDTipsTypeNone networkIndicator:show];
}

+ (void)showWithStatus:(NSString*)status maskType:(ProgressHUDMaskType)maskType tipsType:(ProgressHUDTipsType)tipsType networkIndicator:(BOOL)show {
    [[ProgressHUD sharedView] showWithStatus:status maskType:maskType tipsType:tipsType networkIndicator:show];
}

+ (void)showSuccessWithStatus:(NSString *)string {
//    [ProgressHUD show];
//    [ProgressHUD dismissWithSuccess:string afterDelay:0.8f];
    [ProgressHUD showWithStatus:string maskType:ProgressHUDMaskTypeNone tipsType:ProgressHUDTipsTypeBottom networkIndicator:YES];
}

+ (void)showErrorWithStatus:(NSString *)string {
//    [ProgressHUD show];
//    [ProgressHUD dismissWithError:string afterDelay:0.8f];
    [ProgressHUD showWithStatus:string maskType:ProgressHUDMaskTypeNone tipsType:ProgressHUDTipsTypeBottom networkIndicator:YES];
}

#pragma mark - Deprecated show methods

+ (void)showInView:(UIView*)view {
    [ProgressHUD showWithStatus:nil maskType:ProgressHUDMaskTypeNone tipsType:ProgressHUDTipsTypeNone networkIndicator:ProgressHUDShowNetworkIndicator];
}

+ (void)showInView:(UIView*)view status:(NSString*)string {
    [ProgressHUD showWithStatus:string maskType:ProgressHUDMaskTypeNone tipsType:ProgressHUDTipsTypeNone networkIndicator:ProgressHUDShowNetworkIndicator];
}

+ (void)showInView:(UIView*)view status:(NSString*)string networkIndicator:(BOOL)show {
    [ProgressHUD showWithStatus:string maskType:ProgressHUDMaskTypeNone tipsType:ProgressHUDTipsTypeNone  networkIndicator:show];
}

+ (void)showInView:(UIView*)view status:(NSString*)string networkIndicator:(BOOL)show posY:(CGFloat)posY {
    [ProgressHUD showWithStatus:string maskType:ProgressHUDMaskTypeNone tipsType:ProgressHUDTipsTypeNone networkIndicator:show];
}

+ (void)showInView:(UIView*)view status:(NSString*)string networkIndicator:(BOOL)show posY:(CGFloat)posY maskType:(ProgressHUDMaskType)hudMaskType {
    [ProgressHUD showWithStatus:string maskType:hudMaskType tipsType:ProgressHUDTipsTypeNone networkIndicator:show];
}

#pragma mark - Dismiss Methods

+ (void)dismiss {
	[[ProgressHUD sharedView] dismiss];
}

+ (void)dismissAfterDelay:(NSTimeInterval)seconds {
    [[ProgressHUD sharedView] dismissAfterDelay:seconds];
}

+ (void)dismissWithSuccess:(NSString*)successString {
	[[ProgressHUD sharedView] dismissWithStatus:successString error:NO];
}

+ (void)dismissWithSuccess:(NSString *)successString afterDelay:(NSTimeInterval)seconds {
    [[ProgressHUD sharedView] dismissWithStatus:successString error:NO afterDelay:seconds];
}

+ (void)dismissWithError:(NSString*)errorString {
	[[ProgressHUD sharedView] dismissWithStatus:errorString error:YES];
}

+ (void)dismissWithError:(NSString *)errorString afterDelay:(NSTimeInterval)seconds {
    [[ProgressHUD sharedView] dismissWithStatus:errorString error:YES afterDelay:seconds];
}


#pragma mark - Instance Methods

- (id)initWithFrame:(CGRect)frame {
	
    if ((self = [super initWithFrame:frame])) {
		self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
		self.alpha = 0;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
	
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    switch (self.maskType) {
            
        case ProgressHUDMaskTypeBlack: {
            [[UIColor colorWithWhite:0 alpha:0.5] set];
            CGContextFillRect(context, self.bounds);
            break;
        }
            
        case ProgressHUDMaskTypeGradient: {
            
            size_t locationsCount = 2;
            CGFloat locations[2] = {0.0f, 1.0f};
            CGFloat colors[8] = {0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.75f}; 
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, locations, locationsCount);
            CGColorSpaceRelease(colorSpace);
            
            CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
            float radius = MIN(self.bounds.size.width , self.bounds.size.height) ;
            CGContextDrawRadialGradient (context, gradient, center, 0, center, radius, kCGGradientDrawsAfterEndLocation);
            CGGradientRelease(gradient);
            
            break;
        }
    }
}

- (void)setStatus:(NSString *)string {
    
    if (!string) {
        self.spinnerView.center = CGPointMake(ceil(CGRectGetWidth(self.hudView.bounds)/2)+0.5, ceil(self.hudView.bounds.size.height/2)+0.5);
        return;
    }
	
    CGFloat hudWidth = 100;
    CGFloat hudHeight = 100;
    CGFloat stringWidth = 0;
    CGFloat stringHeight = 0;
    CGRect labelRect = CGRectZero;
    
    if(string) {
        if (self.tipsType == ProgressHUDTipsTypeBottom || self.tipsType == ProgressHUDTipsTypeNone) {
            self.stringLabel.font = [UIFont boldSystemFontOfSize:17];
        }else {
            self.stringLabel.font = [UIFont boldSystemFontOfSize:16];
        }

//        CGSize stringSize = [string sizeWithFont:self.stringLabel.font constrainedToSize:CGSizeMake(300, 300)];
        
        CGSize stringSize = [string boundingRectWithSize:CGSizeMake(300, 300) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.stringLabel.font} context:nil].size;
        stringWidth = stringSize.width;
        stringHeight = stringSize.height;
        hudView.layer.cornerRadius = 2.5;
        hudHeight = 80+stringHeight;
        
        if(stringWidth > hudWidth)
            hudWidth = ceil(stringWidth/2)*2;
        
        if(hudHeight > 100) {
            labelRect = CGRectMake(12, 66, hudWidth, stringHeight);
            hudWidth+=24;
        } else {
            hudWidth+=24;  
            labelRect = CGRectMake(0, 66, hudWidth, stringHeight);   
        }
    }
	
	self.hudView.bounds = CGRectMake(0, 0, hudWidth, hudHeight);
    
	self.imageView.center = CGPointMake(CGRectGetWidth(self.hudView.bounds)/2, 36);
	
	self.stringLabel.hidden = NO;
	self.stringLabel.text = string;
    if (self.tipsType == ProgressHUDTipsTypeBottom || self.tipsType == ProgressHUDTipsTypeNone) {
        labelRect = CGRectMake(0 , 0, stringWidth+20, KLabelHeight);
    }else {
        labelRect = CGRectMake(0, 0, hudWidth, hudHeight);
    }
    
	self.stringLabel.frame = labelRect;
	
	if(string)
		self.spinnerView.center = CGPointMake(ceil(CGRectGetWidth(self.hudView.bounds)/2)+0.5, 40.5);
	else
		self.spinnerView.center = CGPointMake(ceil(CGRectGetWidth(self.hudView.bounds)/2)+0.5, ceil(self.hudView.bounds.size.height/2)+0.5);
}


- (void)showWithStatus:(NSString*)string maskType:(ProgressHUDMaskType)hudMaskType tipsType:(ProgressHUDTipsType)hudTipsType networkIndicator:(BOOL)show {
    BOOL    ISProgressHUDTipsTypeLongBottom = NO;
    
    if (hudTipsType == ProgressHUDTipsTypeLongBottom) {
        ISProgressHUDTipsTypeLongBottom = YES;
        hudTipsType = ProgressHUDTipsTypeBottom;
    }
	if(fadeOutTimer != nil)
		[fadeOutTimer invalidate], [fadeOutTimer release], fadeOutTimer = nil;
	
    self.showNetworkIndicator = show;
    
    if(self.showNetworkIndicator)
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
	self.imageView.hidden = YES;
    self.maskType = hudMaskType;
    self.tipsType = hudTipsType;
	
	[self setStatus:string];
	[self.spinnerView startAnimating];
    
    if ((self.tipsType == ProgressHUDTipsTypeBottom || self.tipsType == ProgressHUDTipsTypeNone) && ISProgressHUDTipsTypeLongBottom == NO) {
        [ProgressHUD dismissAfterDelay:2.0];    //自定义加载提示框，单独处理。
    }
    
    if(self.maskType != ProgressHUDMaskTypeNone)
        self.userInteractionEnabled = YES;
    else
        self.userInteractionEnabled = NO;
    
    
    if(![self isKeyWindow]) {
        
        [[UIApplication sharedApplication].windows enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIWindow *window = (UIWindow*)obj;
            if(window.windowLevel == UIWindowLevelNormal && ![[window class] isEqual:[ProgressHUD class]]) {
                self.previousKeyWindow = window;
                *stop = YES;
            }
        }];
         
        [self makeKeyAndVisible];
    }
    
    
    
    [self positionHUD:nil];
    
	if(self.alpha != 1) {
        [self registerNotifications];
		self.hudView.transform = CGAffineTransformScale(self.hudView.transform, 1.3, 1.3);
		
		[UIView animateWithDuration:0.15
							  delay:0
							options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
						 animations:^{	
							 self.hudView.transform = CGAffineTransformScale(self.hudView.transform, 1/1.3, 1/1.3);
                             self.alpha = 1;
						 }
						 completion:NULL];
	}
    
    [self setNeedsDisplay];
}


- (void)registerNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(positionHUD:) 
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification 
                                               object:nil];  
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(memoryWarning:) 
                                                 name:UIApplicationDidReceiveMemoryWarningNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(positionHUD:) 
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(positionHUD:) 
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(positionHUD:) 
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(positionHUD:) 
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
}


- (void)positionHUD:(NSNotification*)notification {
    
    CGFloat keyboardHeight;
    double animationDuration = 0.0;
    
    if(notification) {
        NSDictionary* keyboardInfo = [notification userInfo];
        CGRect keyboardFrame = [[keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
        animationDuration = [[keyboardInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        if(notification.name == UIKeyboardWillShowNotification)
            keyboardHeight = keyboardFrame.size.height;
        else
            keyboardHeight = 0;
    } else {
        keyboardHeight = self.visibleKeyboardHeight;
    }
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGRect orientationFrame = [UIScreen mainScreen].bounds;
    
    if(UIInterfaceOrientationIsLandscape(orientation)) {
        float temp = orientationFrame.size.width;
        orientationFrame.size.width = orientationFrame.size.height;
        orientationFrame.size.height = temp;
    }
    
    CGFloat activeHeight = orientationFrame.size.height;
    
    if(keyboardHeight > 0)
        activeHeight += [UIApplication sharedApplication].statusBarFrame.size.height*2;
    
    activeHeight -= keyboardHeight;
    CGFloat posY = floor(activeHeight*0.45);
    CGFloat posX = orientationFrame.size.width/2;
    
    CGPoint newCenter;
    CGFloat rotateAngle;
    
    switch (orientation) { 
        case UIInterfaceOrientationPortraitUpsideDown:
            rotateAngle = M_PI; 
            newCenter = CGPointMake(posX, orientationFrame.size.height-posY);
            break;
        case UIInterfaceOrientationLandscapeLeft:
            rotateAngle = -M_PI/2.0f;
            newCenter = CGPointMake(posY, posX);
            break;
        case UIInterfaceOrientationLandscapeRight:
            rotateAngle = M_PI/2.0f;
            newCenter = CGPointMake(orientationFrame.size.height-posY, posX);
            break;
        default: // as UIInterfaceOrientationPortrait
            rotateAngle = 0.0;
            newCenter = CGPointMake(posX, posY);
            break;
    } 
    
    if(notification) {
        [UIView animateWithDuration:animationDuration
                              delay:0 
                            options:UIViewAnimationOptionAllowUserInteraction 
                         animations:^{
                             [self moveToPoint:newCenter rotateAngle:rotateAngle];
                         } completion:NULL];
    } 
    
    else {
        [self moveToPoint:newCenter rotateAngle:rotateAngle];
    }
    
}

- (void)moveToPoint:(CGPoint)newCenter rotateAngle:(CGFloat)angle {
    self.hudView.transform = CGAffineTransformMakeRotation(angle); 
    self.hudView.center = newCenter;
    
    if (self.tipsType == ProgressHUDTipsTypeBottom) {
        float width = self.stringLabel.width;
        self.hudView.frame = CGRectMake((kDeviceWidth-width)/2, kDeviceHeight-44-KLabelHeight*2, width, self.stringLabel.height);
        
    }else if (self.tipsType == ProgressHUDTipsTypeNone) {
        float width = self.stringLabel.width;
        self.hudView.frame = CGRectMake((kDeviceWidth-width)/2, (kDeviceHeight-self.stringLabel.height)/2, width, self.stringLabel.height);
    }
}

- (void)dismissAfterDelay:(NSTimeInterval)seconds {
    if(self.showNetworkIndicator)
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
	self.imageView.hidden = NO;

	[self.spinnerView stopAnimating];
    
	if(fadeOutTimer != nil)
		[fadeOutTimer invalidate], [fadeOutTimer release], fadeOutTimer = nil;
	
	fadeOutTimer = [[NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(dismiss) userInfo:nil repeats:NO] retain];
}

- (void)dismissWithStatus:(NSString*)string error:(BOOL)error {
	[self dismissWithStatus:string error:error afterDelay:0.9];
}


- (void)dismissWithStatus:(NSString *)string error:(BOOL)error afterDelay:(NSTimeInterval)seconds {
    
//    if(self.alpha != 1)
//        return;
    
    if(self.showNetworkIndicator)
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
	if(error)
		self.imageView.image = [UIImage imageNamed:@"ProgressHUD.bundle/error.png"];
	else
		self.imageView.image = [UIImage imageNamed:@"ProgressHUD.bundle/success.png"];
	
	self.imageView.hidden = NO;
	
	[self setStatus:string];
	
	[self.spinnerView stopAnimating];
    
	if(fadeOutTimer != nil)
		[fadeOutTimer invalidate], [fadeOutTimer release], fadeOutTimer = nil;
	
	fadeOutTimer = [[NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(dismiss) userInfo:nil repeats:NO] retain];
}

- (void)dismiss {
	
    if(self.showNetworkIndicator)
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

	[UIView animateWithDuration:0.15
						  delay:0
						options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
					 animations:^{	
						 sharedView.hudView.transform = CGAffineTransformScale(sharedView.hudView.transform, 0.8, 0.8);
						 sharedView.alpha = 0;
					 }
					 completion:^(BOOL finished){ 
                         if(sharedView.alpha == 0) {
                             [[NSNotificationCenter defaultCenter] removeObserver:sharedView];
                             [sharedView.previousKeyWindow makeKeyWindow];
                             [sharedView release], sharedView = nil;
                             
                             // uncomment to make sure UIWindow is gone from app.windows
                             //NSLog(@"%@", [UIApplication sharedApplication].windows);
                         }
                     }];
}

#pragma mark - Getters

- (UIView *)hudView {
    
    if(!hudView) {
        hudView = [[UIView alloc] initWithFrame:CGRectZero];
        hudView.layer.cornerRadius = 10;
		hudView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
        hudView.autoresizingMask = (UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin |
                                    UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin);
        
        [self addSubview:hudView];
    }
    
    return hudView;
}

- (UILabel *)stringLabel {
    
    if (stringLabel == nil) {
        stringLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		stringLabel.textColor = [UIColor whiteColor];
		stringLabel.backgroundColor = [UIColor clearColor];
		stringLabel.adjustsFontSizeToFitWidth = YES;
//		stringLabel.textAlignment = UITextAlignmentCenter;
        //add by PengCheng
        stringLabel.textAlignment = NSTextAlignmentCenter;
		stringLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
		stringLabel.font = [UIFont boldSystemFontOfSize:16];
		stringLabel.shadowColor = [UIColor blackColor];
		stringLabel.shadowOffset = CGSizeMake(0, -1);
        stringLabel.numberOfLines = 0;
		[self.hudView addSubview:stringLabel];
    }
    
    return stringLabel;
}

- (UIImageView *)imageView {
    
    if (imageView == nil) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
		[self.hudView addSubview:imageView];
    }
    
    return imageView;
}

- (ReloadActivityView *)spinnerView {
    
    if (spinnerView == nil) {
        spinnerView = [[ReloadActivityView alloc] init];
		spinnerView.hidesWhenStopped = YES;
		spinnerView.bounds = CGRectMake(0, 0, 28, 28);
		[self.hudView addSubview:spinnerView];
    }
    
    return spinnerView;
}

- (CGFloat)visibleKeyboardHeight {
    
    NSAutoreleasePool *autoreleasePool = [[NSAutoreleasePool alloc] init];
    
    UIWindow *keyboardWindow = nil;
    for (UIWindow *testWindow in [[UIApplication sharedApplication] windows]) {
        if(![[testWindow class] isEqual:[UIWindow class]] && ![[testWindow class] isEqual:[ProgressHUD class]]) {
            keyboardWindow = testWindow;
            break;
        }
    }

    // Locate UIKeyboard.  
    UIView *foundKeyboard = nil;
    for (UIView *possibleKeyboard in [keyboardWindow subviews]) {
        
        // iOS 4 sticks the UIKeyboard inside a UIPeripheralHostView.
        if ([[possibleKeyboard description] hasPrefix:@"<UIPeripheralHostView"]) {
            possibleKeyboard = [[possibleKeyboard subviews] objectAtIndex:0];
        }                                                                                
        
        if ([[possibleKeyboard description] hasPrefix:@"<UIKeyboard"]) {
            foundKeyboard = possibleKeyboard;
            break;
        }
    }
    
    [autoreleasePool release];
        
    if(foundKeyboard && foundKeyboard.bounds.size.height > 100)
        return foundKeyboard.bounds.size.height;
    
    return 0;
}

@end