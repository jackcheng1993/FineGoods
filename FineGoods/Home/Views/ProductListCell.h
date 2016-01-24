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

typedef void(^BuyBtnClickedBlock)(FHomeDetailProductModel *productModel);
typedef void(^LikeBtnClickedBlock)(FHomeDetailProductModel *productModel);

@interface ProductListCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) FHomeDetailProductModel *productModel;
@property (nonatomic, copy) BuyBtnClickedBlock buyBtnClickedBlock;
@property (nonatomic, copy) LikeBtnClickedBlock likeBtnClickedBlock;

- (void)setProductModel:(FHomeDetailProductModel *)productModel index:(NSInteger)index;

+ (CGFloat)cellHeightWithObj:(id)obj;

@end
