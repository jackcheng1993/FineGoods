//
//  ProductListCell.h
//  FineGoods
//
//  Created by qianfeng on 16/1/20.
//  Copyright © 2016年 Aili. All rights reserved.Lkkl
//

#import <UIKit/UIKit.h>
#import "FHomeDetailModel.h"
#import "Define.h"

@interface ProductListCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) FHomeDetailProductModel *productModel;

- (void)setProductModel:(FHomeDetailProductModel *)productModel index:(NSInteger)index;

+ (CGFloat)cellHeightWithObj:(id)obj;

@end
