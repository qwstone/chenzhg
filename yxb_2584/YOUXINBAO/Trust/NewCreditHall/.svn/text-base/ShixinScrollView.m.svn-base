//
//  ShixinScrollView.m
//  YOUXINBAO
//
//  Created by zjp on 15/11/17.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "ShixinScrollView.h"

@implementation ShixinScrollView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.delegate = self;
        self.maximumZoomScale = 5;
        self.minimumZoomScale = 1;
        
        img = [[UIImageView alloc] initWithFrame:CGRectMake(0,80, kDeviceWidth, kDeviceWidth/605*500)];
        UIImage *imm = [UIImage imageNamed:@"dituColor"];
        img.hidden = YES;
        img.image = imm;
        [self addSubview:img];
        
        
        
        imgs = [[UIImageView alloc] initWithFrame:CGRectMake(0,80, kDeviceWidth, kDeviceWidth/605*500)];
        imgs.tag = 100;
        //        imgs.contentMode = UIViewContentModeScaleAspectFit;
        //        imgs.image = imm;
        [self addSubview:imgs];
        self.contentSize = CGSizeMake(imgs.size.width*20, imgs.size.height*20);
        //        imgs.size;
    }
    return self;
}

- (void)setDataAll:(NSArray *)dataAll {
    if (_dataAll != dataAll) {
        _dataAll = dataAll;
    }
    
    [self imageBlackToTransparent:img.image];
}


#pragma mark --- scorllviewdelegate
//返回需要放大缩小的子视图
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    //    UIView *imgView = [scrollView viewWithTag:100];
    return imgs;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSArray *touchArray = [touches allObjects];
    
    //1.取得两个触摸对象
    UITouch *touch1 = touchArray[0];
    //2.取得两个触摸坐标点, locationInView 是获取到移动之后的坐标点
    CGPoint p1 = [touch1 locationInView:imgs];
    CGPoint point = CGPointMake(p1.x, p1.y);
    UIColor *colorss = [self colorAtPixel:point];
    NSInteger r=0,g=0,b=0,a=0;
    const CGFloat *components = CGColorGetComponents(colorss.CGColor);
    if (components != nil) {
        r = components[0]*255;
        g = components[1]*255;
        b = components[2]*255;
        a = components[3]*255;
    }
    NSString *name = [self NameGetColorWithR:r G:g B:b];
    if (![name isEqualToString:@""]) {
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:name message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [view show];
    }
}

#pragma mark - --- 颜色操作
void ProviderReleaseData (void *info, const void *data, size_t size)
{
    free((void*)data);
}

- (UIImage*) imageBlackToTransparent:(UIImage*) image
{
    // 分配内存
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    
    // 创建context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    
    //    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //    //    dispatch_queue_t queue = dispatch_queue_create("tk.bourne.testQueue", DISPATCH_QUEUE_CONCURRENT);
    //    dispatch_async(queue, ^{
    //
    //    });
    //    int pixelNum = imageWidth * imageHeight;
    //    uint32_t* pCurPtr = rgbImageBuf;
    //    // 遍历像素
    //    for (int i = 0; i < pixelNum; i++, pCurPtr++)
    //    {
    //        if ((*pCurPtr & 0xFFFFFF00) == 0xffffff00)    // 将白色变成透明
    //        {
    //            uint8_t* ptr = (uint8_t*)pCurPtr;
    //            ptr[0] = 0;
    //        }
    //        else
    //        {
    //            // 改成下面的代码，会将图片转成想要的颜色
    //            uint8_t* ptr = (uint8_t*)pCurPtr;
    //            if (ptr[3] <= 25 && ptr[2] <= 25 && ptr[1] <= 25) {
    //
    //            }else {
    //                NSString *flag = [self flagGetNameWith:[self NameGetColorWithR:ptr[3] G:ptr[2] B:ptr[1]]];
    //                if ([flag isEqualToString:@"1"]) {
    //                    ptr[3] = 255; //0~255
    //                    ptr[2] = 255;
    //                    ptr[1] = 255;
    //                }
    //                if ([flag isEqualToString:@"2"]) {
    //                    ptr[3] = 0; //0~255
    //                    ptr[2] = 255;
    //                    ptr[1] = 255;
    //                }
    //                if ([flag isEqualToString:@"3"]) {
    //                    ptr[3] = 0; //0~255
    //                    ptr[2] = 0;
    //                    ptr[1] = 255;
    //                }
    //                if ([flag isEqualToString:@"0"]) {
    //                    ptr[3] = 0; //0~255
    //                    ptr[2] = 0;
    //                    ptr[1] = 0;
    //                }
    //
    //            }
    //
    //        }
    //
    //    }
    //    // 将内存转成image
    //    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    //    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
    //                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
    //                                        NULL, true, kCGRenderingIntentDefault);
    //    CGDataProviderRelease(dataProvider);
    //
    //    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    //
    //    // 释放
    //    CGImageRelease(imageRef);
    //    CGContextRelease(context);
    //    CGColorSpaceRelease(colorSpace);
    // free(rgbImageBuf) 创建dataProvider时已提供释放函数，这里不用free
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 1);
    //    dispatch_queue_t queue = dispatch_queue_create("tk.bourne.testQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        int pixelNum = imageWidth * imageHeight;
        uint32_t* pCurPtr = rgbImageBuf;
        // 遍历像素
        for (int i = 0; i < pixelNum; i++, pCurPtr++)
        {
            if ((*pCurPtr & 0xFFFFFF00) == 0xffffff00)    // 将白色变成透明
            {
                uint8_t* ptr = (uint8_t*)pCurPtr;
                ptr[0] = 0;
            }
            else
            {
                // 改成下面的代码，会将图片转成想要的颜色
                uint8_t* ptr = (uint8_t*)pCurPtr;
                if (ptr[3] <= 25 && ptr[2] <= 25 && ptr[1] <= 25) {
                    
                }else {
                    NSString *flag = [self flagGetNameWith:[self NameGetColorWithR:ptr[3] G:ptr[2] B:ptr[1]]];
                    if ([flag isEqualToString:@"1"]) {
                        ptr[3] = 0; //0~255
                        ptr[2] = 0;
                        ptr[1] = 0;
                    }
                    if ([flag isEqualToString:@"2"]) {
                        ptr[3] = 100; //0~255
                        ptr[2] = 100;
                        ptr[1] = 100;
                    }
                    if ([flag isEqualToString:@"3"]) {
                        ptr[3] = 255; //0~255
                        ptr[2] = 255;
                        ptr[1] = 255;
                    }
                    //                    if ([flag isEqualToString:@"0"]) {
                    //                        ptr[3] = 0; //0~255
                    //                        ptr[2] = 0;
                    //                        ptr[1] = 0;
                    //                    }
                    
                }
                
            }
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            // 将内存转成image
            CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
            CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                                kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                                NULL, true, kCGRenderingIntentDefault);
            CGDataProviderRelease(dataProvider);
            
            UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
            
            // 释放
            CGImageRelease(imageRef);
            CGContextRelease(context);
            CGColorSpaceRelease(colorSpace);
            // free(rgbImageBuf) 创建dataProvider时已提供释放函数，这里不用free
            imgs.image = resultUIImage;
        });
        
        
    });
    return nil;
}

/*
 dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
 //    dispatch_queue_t queue = dispatch_queue_create("tk.bourne.testQueue", DISPATCH_QUEUE_CONCURRENT);
 dispatch_async(queue, ^{
 int pixelNum = imageWidth * imageHeight;
 uint32_t* pCurPtr = rgbImageBuf;
 // 遍历像素
 for (int i = 0; i < pixelNum; i++, pCurPtr++)
 {
 if ((*pCurPtr & 0xFFFFFF00) == 0xffffff00)    // 将白色变成透明
 {
 uint8_t* ptr = (uint8_t*)pCurPtr;
 ptr[0] = 0;
 }
 else
 {
 // 改成下面的代码，会将图片转成想要的颜色
 uint8_t* ptr = (uint8_t*)pCurPtr;
 if (ptr[3] <= 25 && ptr[2] <= 25 && ptr[1] <= 25) {
 
 }else {
 NSString *flag = [self flagGetNameWith:[self NameGetColorWithR:ptr[3] G:ptr[2] B:ptr[1]]];
 if ([flag isEqualToString:@"1"]) {
 ptr[3] = 255; //0~255
 ptr[2] = 255;
 ptr[1] = 255;
 }
 if ([flag isEqualToString:@"2"]) {
 ptr[3] = 0; //0~255
 ptr[2] = 255;
 ptr[1] = 255;
 }
 if ([flag isEqualToString:@"3"]) {
 ptr[3] = 0; //0~255
 ptr[2] = 0;
 ptr[1] = 255;
 }
 //                    if ([flag isEqualToString:@"0"]) {
 //                        ptr[3] = 0; //0~255
 //                        ptr[2] = 0;
 //                        ptr[1] = 0;
 //                    }
 
 }
 
 }
 
 }
 
 dispatch_async(dispatch_get_main_queue(), ^{
 
 
 // 将内存转成image
 CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
 CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
 kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
 NULL, true, kCGRenderingIntentDefault);
 CGDataProviderRelease(dataProvider);
 
 UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
 
 // 释放
 CGImageRelease(imageRef);
 CGContextRelease(context);
 CGColorSpaceRelease(colorSpace);
 // free(rgbImageBuf) 创建dataProvider时已提供释放函数，这里不用free
 imgs.image = resultUIImage;
 });
 
 
 });
 
 */
- (UIColor *)colorAtPixel:(CGPoint)point {
    // Cancel if point is outside image coordinates
    if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, img.bounds.size.width, img.bounds.size.height), point)) {
        return nil;
    }
    
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage = img.image.CGImage;
    NSUInteger width = img.bounds.size.width;
    NSUInteger height = img.bounds.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = { 0, 0, 0, 0 };
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 1,
                                                 1,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    // Draw the pixel we are interested in onto the bitmap context
    CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);
    
    // Convert color values [0..255] to floats [0.0..1.0]
    CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    //    NSArray *arr = @[[NSString stringWithFormat:@"%f",red],[NSString stringWithFormat:@"%f",green],[NSString stringWithFormat:@"%f",blue]];
    //    return arr;
}


/**
 *  获取UIColor对象的rgb值。
 *
 *  @param originColor
 *
 *  @return
 */
- (NSString *)getHexStringByColor:(UIColor *)originColor
{
    NSDictionary *colorDic
    = [self getRGBDictionaryByColor:originColor];
    int r = [colorDic[@"R"] floatValue] * 255;
    int g = [colorDic[@"G"] floatValue] * 255;
    int b = [colorDic[@"B"] floatValue] * 255;
    NSString *red = [NSString stringWithFormat:@"%02x", r];
    NSString *green = [NSString stringWithFormat:@"%02x", g];
    NSString *blue = [NSString stringWithFormat:@"%02x", b];
    //    return @[[NSString stringWithFormat:@"%d",r],[NSString stringWithFormat:@"%d",g],[NSString stringWithFormat:@"%d",b]];
    return [NSString stringWithFormat:@"#%@%@%@", red, green, blue];
}

- (NSDictionary *)getRGBDictionaryByColor:(UIColor *)originColor
{
    CGFloat r=0,g=0,b=0,a=0;
    if ([self respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [originColor getRed:&r green:&g blue:&b alpha:&a];
    }
    else {
        const CGFloat *components = CGColorGetComponents(originColor.CGColor);
        if (components != nil) {
            r = components[0];
            g = components[1];
            b = components[2];
            a = components[3];
            
        }
    }
    
    return @{@"R":@(r),
             @"G":@(g),
             @"B":@(b),
             @"A":@(a)};
}



- (NSString *)NameGetColorWithR:(NSInteger)r G:(NSInteger)g B:(NSInteger)b {
    NSString *name = @"";
    if (r == 0 && g == 245 && b == 163) {
        name = @"新疆";
    }
    if (r == 153 && g == 252 && b == 167) {
        name = @"西藏";
    }
    if (r == 0 && g == 209 && b == 211) {
        name = @"青海";
    }
    if (r == 103 && g == 185 && b == 186) {//4
        name = @"甘肃";
    }
    if (r == 80 && g == 177 && b == 253) {//5
        name = @"云南";
    }
    if (r == 255 && g == 206 && b == 229) {//6
        name = @"四川";
    }
    if (r == 95 && g == 97 && b == 252) {//7
        name = @"贵州";
    }
    if (r == 135 && g == 135 && b == 195) {//8
        name = @"广西";
    }
    if (r == 193 && g == 253 && b == 200) {//9
        name = @"广东";
    }
    if (r == 0 && g == 252 && b == 255) {//10
        name = @"海南";
    }
    if (r == 226 && g == 193 && b == 192) {//11
        name = @"台湾";
    }
    if (r == 41 && g == 89 && b == 90) {//12
        name = @"香港";
    }
    if (r == 67 && g == 113 && b == 10) {//13
        name = @"澳门";
    }
    if (r == 180 && g == 252 && b == 228) {//14
        name = @"福建";
    }
    if (r == 142 && g == 202 && b == 203) {//15
        name = @"湖南";
    }
    if (r == 255 && g == 163 && b == 110) {//16
        name = @"江西";
    }
    if (r == 134 && g == 253 && b == 255) {//17
        name = @"浙江";
    }
    if (r == 255 && g == 145 && b == 252) {//18
        name = @"重庆";
    }
    if (r == 196 && g == 196 && b == 137) {//19
        name = @"湖北";
    }
    if (r == 255 && g == 189 && b == 118) {//20
        name = @"安徽";
    }
    if (r == 0 && g == 131 && b == 226) {//21
        name = @"上海";
    }
    if (r == 146 && g == 204 && b == 254) {//22
        name = @"江苏";
    }
    if (r == 255 && g == 229 && b == 108) {//23
        name = @"河南";
    }
    if (r == 210 && g == 154 && b == 153) {//24
        name = @"陕西";
    }
    if (r == 192 && g == 110 && b == 177) {//25
        name = @"宁夏";
    }
    if (r == 254 && g == 254 && b == 167) {//26
        name = @"山西";
    }
    if (r == 127 && g == 129 && b == 252) {//27
        name = @"山东";
    }
    if (r == 222 && g == 181 && b == 253) {//28
        name = @"河北";
    }
    if (r == 245 && g == 39 && b == 5) {//29
        name = @"北京";
    }
    if (r == 0 && g == 226 && b == 229) {//30
        name = @"天津";
    }
    if (r == 226 && g == 253 && b == 189) {//31
        name = @"内蒙古";
    }
    if (r == 255 && g == 185 && b == 253) {//32
        name = @"辽宁";
    }
    if (r == 255 && g == 169 && b == 210) {//33
        name = @"吉林";
    }
    if (r == 255 && g == 107 && b == 100) {//34
        name = @"黑龙江";
    }
    
    return name;
}


- (NSString *)flagGetNameWith:(NSString *)name {
    if ([name isEqualToString:@""] || name == nil) {
        return @"0";
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"proviceName = %@",name];
    NSArray *filterArray = [self.dataAll filteredArrayUsingPredicate:predicate];
    if (filterArray.count <= 0) {
        return @"0";
    }
    CreditProviceMapData *model = filterArray[0];
    NSString *flag = model.averageFlag;
    return flag;
}

@end
