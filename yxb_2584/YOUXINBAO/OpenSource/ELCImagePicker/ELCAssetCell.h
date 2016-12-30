//
//  AssetCell.h
//
//  Created by ELC on 2/15/11.
//  Copyright 2011 ELC Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ELCAssetCellBetweenSpace 4

@interface ELCAssetCell : UITableViewCell

@property (nonatomic, assign) BOOL alignmentLeft;

- (void)setAssets:(NSArray *)assets;

@end
