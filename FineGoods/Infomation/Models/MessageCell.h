//
//  MessageCell.h
//  FineGoods
//
//  Created by qianfeng on 16/1/11.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"
@interface MessageCell : UITableViewCell
@property (nonatomic, copy) MessageModel *model;

- (void)setModel:(MessageModel *)model;

- (void)setLabelName:(NSString *)textName;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier index:(NSInteger)index;
@end
