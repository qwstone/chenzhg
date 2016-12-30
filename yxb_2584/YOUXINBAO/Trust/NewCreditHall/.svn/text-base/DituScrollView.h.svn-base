//
//  DituScrollView.h
//  YOUXINBAO
//
//  Created by zjp on 15/11/16.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreditMapData.h"
#import "CreditProviceMapData.h"
#import "YXBTool.h"
#import "MapPopView.h"
@interface DituScrollView : UIScrollView<UIScrollViewDelegate>{
    UIImageView *img;
    UIImageView *imgs;
}
//@property(nonatomic,assign)CGFloat  scela;

@property(nonatomic,strong)CreditMapData              *dataAll;


@property(nonatomic,assign)BOOL                 isOver;

- (NSString *)NameGetColorWithR:(NSInteger)r G:(NSInteger)g B:(NSInteger)b;
- (UIImage*) imageBlackToTransparent:(UIImage*) image;
- (UIColor *)colorAtPixel:(CGPoint)point;
- (NSString *)flagGetNameWithTurn:(NSString *)name;
@end
