//
//  ProductMediaItemCell.h
//  FineGoods
//
//  Created by qianfeng on 16/1/20.
//  Copyright © 2016年 Aili. All rights reserved.
//

#define kcellIdentifier_ProductMediaItem @"ProductMediaItemCell"

#import <UIKit/UIKit.h>
#import "FHomeDetailModel.h"
#import "Define.h"
@interface ProductMediaItemCell : UICollectionViewCell

@property (nonatomic, strong) FHomeDetailPicModel *picModel;

@end
