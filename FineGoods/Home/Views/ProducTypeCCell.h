//
//  ProducTypeCCell.h
//  FineGoods
//
//  Created by qianfeng on 16/1/22.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BannerProductModel.h"
#import "Define.h"
@interface ProducTypeCCell : UICollectionViewCell
@property (nonatomic, strong)BannerDataModel *dataModel;

+ (CGFloat)cellHeight;
@end
