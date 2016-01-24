//
//  ButtonTableViewCell.h
//  FineGoods
//
//  Created by qianfeng on 16/1/12.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DiscoverModel.h"

@interface ButtonTableViewCell : UITableViewCell

//@property (nonatomic, strong) ElementsModel *model;

-(void)updateWithModel:(NSArray *)buttonSource;

@end
