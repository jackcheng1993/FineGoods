//
//  TopTableViewCell.m
//  FineGoods
//
//  Created by qianfeng on 16/1/12.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "TopTableViewCell.h"

#import "Define.h"

@implementation TopTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createCustomViews];
    }
    return self;
}

- (void)createCustomViews {

    
}






- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
