//
//  ShixinScrollView.h
//  YOUXINBAO
//
//  Created by zjp on 15/11/17.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreditMapData.h"
#import "CreditProviceMapData.h"
#import "YXBTool.h"
@interface ShixinScrollView : UIScrollView<UIScrollViewDelegate>{
    UIImageView *img;
    UIImageView *imgs;
}
@property(nonatomic,strong)NSArray              *dataAll;
@property(nonatomic,strong)CreditProviceMapData *dataOne;

@end
