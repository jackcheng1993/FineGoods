//
//  HomeCell.m
//  FineGoods
//
//  Created by qianfeng on 16/1/10.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "HomeCell.h"
#import "Define.h"

@interface HomeCell ()
@property (weak, nonatomic) IBOutlet UIImageView *tagImage;

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *loveLabel;

@end

@implementation HomeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)UpdateWithModel:(FAppTopicModel *)topicModel index:(NSInteger)index{
    if (index >= 5) self.tagImage.hidden = YES;
    
    //[self.iconImage sd_setImageWithURL:<#(NSURL *)#> placeholderImage:<#(UIImage *)#>]
        
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
