
//
//  TopicTypeCCell.m
//  FineGoods
//
//  Created by qianfeng on 16/1/22.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "TopicTypeCCell.h"
#define Product_Cell_Item_Spacing 10
#define Product_Cell_Line_Spacing 4

@implementation TopicTypeCCell

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.backgroundColor = [UIColor whiteColor];
    CGFloat itemW = FScreenWidth;
    CGFloat avaterImgViewW = itemW;
    CGFloat avaterImgViewH = 200;
    _avaterImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, avaterImgViewW, avaterImgViewH)];
    [self.contentView addSubview:_avaterImgView];
    
    CGFloat nameLabelW = itemW;
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_avaterImgView.frame)+Product_Cell_Line_Spacing, nameLabelW, 17)];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_nameLabel];
    
    CGFloat likeNumLabelW = 100;
    CGFloat likeNumLabelY = CGRectGetMaxY(_nameLabel.frame)+Product_Cell_Line_Spacing;
    CGFloat likeNumLabelH = 16;
    CGFloat likeNumLabelX =FScreenWidth/2;
    
    _likeImgView = [[UIImageView alloc]initWithFrame:CGRectMake(likeNumLabelX-likeNumLabelH-6, likeNumLabelY, likeNumLabelH , likeNumLabelH)];
    _likeImgView.image =[UIImage imageNamed:@"homedetaillike"];
    [self.contentView addSubview:_likeImgView];

    _likeNumLabel  = [[UILabel alloc]initWithFrame:CGRectMake(likeNumLabelX, likeNumLabelY, likeNumLabelW , likeNumLabelH)];
    _likeNumLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_likeNumLabel];
    
}

- (void)setDataModel:(FHomeBannerDataModel *)dataModel {
    [self layoutIfNeeded];
    _dataModel = dataModel;
    [_avaterImgView sd_setImageWithURL:[NSURL URLWithString:_dataModel.pic] placeholderImage:[UIImage imageNamed:@"Fplaceholder"]];
    _nameLabel.text = _dataModel.title;
    
    _likeNumLabel.text = _dataModel.likes;
}

+ (CGFloat)cellHeight {
    CGFloat cellHeight = 0;
    cellHeight += 200;//avaterImgViewH
    cellHeight += Product_Cell_Line_Spacing;
    cellHeight += 16;//likeNumLabelH
    cellHeight += Product_Cell_Item_Spacing*2;
    return cellHeight;
}
@end