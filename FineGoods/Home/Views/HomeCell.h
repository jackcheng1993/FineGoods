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

- (void)UpdateWithModel:(FAppTopicModel *)topicModel index:(NSInteger)index;
@end
