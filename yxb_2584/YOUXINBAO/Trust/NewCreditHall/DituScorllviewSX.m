//
//  DituScorllviewSX.m
//  YOUXINBAO
//
//  Created by zjp on 15/11/17.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "DituScorllviewSX.h"


@implementation DituScorllviewSX



- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        imgs.image = [UIImage imageNamed:@"mapdu2"];

    }
    return self;
}
#pragma mark - --- 颜色操作
void ProviderReleaseDatas (void *info, const void *data, size_t size)
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

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
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
                NSString *flag = [self flagGetNameWithTurn:[self NameGetColorWithR:ptr[3] G:ptr[2] B:ptr[1]]];
                if ([flag isEqualToString:@"1"]) {
                    ptr[3] = 191; //0~255
                    ptr[2] = 192;
                    ptr[1] = 192;
                }
                if ([flag isEqualToString:@"2"]) {
                    ptr[3] = 159; //0~255
                    ptr[2] = 160;
                    ptr[1] = 160;
                }
                if ([flag isEqualToString:@"3"]) {
                    ptr[3] = 89; //0~255
                    ptr[2] = 86;
                    ptr[1] = 86;
                }
                if ([flag isEqualToString:@"0"]) {
                    ptr[3] = 0; //0~255
                    ptr[2] = 0;
                    ptr[1] = 0;
//                    ptr[0] = 0;
                }
                
            }
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            // 将内存转成image
            CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseDatas);
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
            self.isOver = YES;
        });
        
        
    });
    return nil;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (self.isOver == YES) {
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
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"proviceName = %@",name];
        NSArray *filterArray = [self.dataAll.loseConfidenceProviceList filteredArrayUsingPredicate:predicate];
        if (filterArray.count <= 0) {
            return;
        }
        CreditProviceMapData *model = filterArray[0];
        if ((![name isEqualToString:@""]) && (model != nil) && (model.proviceName.length > 0)) {
            MapPopView *popv = [[MapPopView alloc] initWithFrame:model type:2];
            [popv show];
            //        UIAlertView *view = [[UIAlertView alloc] initWithTitle:name message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            //        [view show];
        }
    }
}

- (NSString *)flagGetNameWithTurn:(NSString *)name {
    if ([name isEqualToString:@""] || name == nil) {
        return @"0";
    }
    NSMutableDictionary *dic = self.dataAll.flagDicSX;
    NSString *flag = dic[name];
    if ([flag isEqualToString:@""] || flag == nil) {
        return @"0";
    }
    return flag;
}
@end
