//
//  ProductMediaItemCell.m
//  FineGoods
//
//  Created by qianfeng on 16/1/20.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "ProductMediaItemCell.h"
#define kPadding 10.0
#define kproductListCell_ContentWidth FScreenWidth - (kPadding *2)

@interface ProductMediaItemCell ()
@property (nonatomic, strong) UIImageView *imgView;

@end
@implementation ProductMediaItemCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setPicModel:(FHomeDetailPicModel *)picModel {
    if (!_imgView) {
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kproductListCell_ContentWidth,kproductListCell_ContentWidth)];
        [self.contentView addSubview:_imgView];
    }
    NSString *urlString = [NSString stringWithFormat:FHomeDetailImageUrl,picModel.p];
    [_imgView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"Fplaceholder"]];

}

- (void)layoutSubviews{
    [super layoutSubviews];
}
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end
