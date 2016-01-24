//
//  InToCellCell.h
//  FineGoods
//
//  Created by qianfeng on 16/1/23.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellModel.h"

typedef void(^BuyClickedBlock)(NSString *url);

@interface InToCellCell : UITableViewCell

@property (nonatomic, strong) PostModel *modelpost;


@property (nonatomic, copy) BuyClickedBlock BuyClickedBlock;


@end
