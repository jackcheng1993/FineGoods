//
//  HomeCell.h
//  FineGoods
//
//  Created by qianfeng on 16/1/10.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAppModel.h"

@interface HomeCell : UITableViewCell
@property (nonatomic, strong) FAppTopicModel *topicModel;

@property (weak, nonatomic) IBOutlet UIImageView *tagImage;

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *loveLabel;

- (void)UpdateWithModel:(FAppTopicModel *)topicModel index:(NSInteger)index;
@end
