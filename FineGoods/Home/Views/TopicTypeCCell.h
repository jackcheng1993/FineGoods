//
//  TopicTypeCCell.h
//  FineGoods
//
//  Created by qianfeng on 16/1/22.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHomeBannerModel.h"
#import "Define.h"


@interface TopicTypeCCell : UICollectionViewCell

@property (nonatomic, strong)FHomeBannerDataModel *dataModel;
@property (strong, nonatomic) UIImageView *avaterImgView,*likeImgView;
@property (strong, nonatomic) UILabel *nameLabel,*likeNumLabel;

+ (CGFloat)cellHeight;

@end
