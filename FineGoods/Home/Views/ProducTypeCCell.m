//
//  ProducTypeCCell.m
//  FineGoods
//
//  Created by qianfeng on 16/1/22.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "ProducTypeCCell.h"
#define Product_Cell_Item_Spacing 10
#define Product_Cell_Line_Spacing 8

@interface ProducTypeCCell ()
@property (strong, nonatomic) UIImageView *avaterImgView,*likeImgView;
@property (strong, nonatomic) UILabel *nameLabel,*priceLabel,*likeNumLabel;

@end

@implementation ProducTypeCCell

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    CGFloat itemW = (FScreenWidth - 3*Product_Cell_Item_Spacing)/2;
    CGFloat avaterImgViewW = itemW;
    CGFloat avaterImgViewH = avaterImgViewW;
    if (_avaterImgView == nil) {
        _avaterImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, avaterImgViewW, avaterImgViewH)];
        [self.contentView addSubview:_avaterImgView];
    }
   
    CGFloat nameLabelW = itemW - 2*Product_Cell_Item_Spacing;
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(Product_Cell_Item_Spacing, CGRectGetMaxY(_avaterImgView.frame)+Product_Cell_Line_Spacing, nameLabelW, 21)];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_nameLabel];
    }
 
    CGFloat priceLabelY = CGRectGetMaxY(_nameLabel.frame)+Product_Cell_Line_Spacing;
    CGFloat priceLabelW = 50;
    CGFloat priceLabelH = 21;
    if (_priceLabel == nil) {
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(Product_Cell_Item_Spacing, priceLabelY, priceLabelW, priceLabelH)];
        _priceLabel.font = [UIFont systemFontOfSize:14];
        _priceLabel.textColor = [UIColor colorWithRed:252/255.0 green:129/255.0 blue:0 alpha:1.0];
        [self.contentView addSubview:_priceLabel];

    }
    
    if (_likeNumLabel == nil) {
        _likeNumLabel  = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, priceLabelW, priceLabelH)];
        _likeNumLabel.font = [UIFont systemFontOfSize:14];
        _likeNumLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_likeNumLabel];
        [_likeNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.contentView).with.offset(0);
            //make.top.equalTo(self.contentView).with.offset(priceLabelY);
            make.centerY.equalTo(_priceLabel);
            make.width.mas_equalTo(priceLabelW);
            make.height.mas_equalTo(priceLabelH);
        }];
    }
  
    if (_likeImgView == nil) {
        _likeImgView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _likeImgView.image =[UIImage imageNamed:@"homedetaillike"];
        [self.contentView addSubview:_likeImgView];
        [_likeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(_likeNumLabel).with.offset(-54);
            make.centerY.equalTo(_likeNumLabel);
            make.width.mas_equalTo(priceLabelH);
            make.height.mas_equalTo(priceLabelH);
        }];
    }
}

- (void)setDataModel:(BannerDataModel *)dataModel {
    [self layoutIfNeeded];
    _dataModel = dataModel;
    [_avaterImgView sd_setImageWithURL:[NSURL URLWithString:_dataModel.pic] placeholderImage:[UIImage imageNamed:@"Fplaceholder"]];
    _nameLabel.text = _dataModel.title;
    
    _priceLabel.text = [NSString stringWithFormat:@"¥%@",_dataModel.price];
    
    _likeNumLabel.text = _dataModel.likes;
}

+ (CGFloat)cellHeight {
    CGFloat cellHeight = 0;
    cellHeight += (FScreenWidth - 3*Product_Cell_Item_Spacing)/2;
    cellHeight += Product_Cell_Line_Spacing;
    cellHeight += 21;//nameH
    cellHeight += Product_Cell_Line_Spacing;
    cellHeight += 21;//priceH
   // cellHeight += Product_Cell_Line_Spacing;
    
    return  cellHeight;
}
@end
