//
//  PicTableViewCell.m
//  FineGoods
//
//  Created by qianfeng on 16/1/12.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "PicTableViewCell.h"
#import "Define.h"

@implementation PicTableViewCell {
    UIImageView *_iconImageView;
    
    UIImageView *_titleBackImage;
    UILabel *_scanNumber;
    UILabel *_invitation;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createCustomViews];
    }
    return self;
}

- (void)createCustomViews {
    _iconImageView =[UIImageView new];
    
    _titleBackImage = [UIImageView new];
    _scanNumber = [UILabel new];
    _invitation = [UILabel new];
    
    [self.contentView addSubview:_iconImageView];
    
    [self.contentView addSubview:_titleBackImage];
    [self.contentView addSubview:_scanNumber];
    [self.contentView addSubview:_invitation];
    
}

- (void)setModel:(RecGroupsModel *)model {
    _model = model;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.pic2]];
    [_titleBackImage sd_setImageWithURL:[NSURL URLWithString:model.pic3]];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat pading = 5;
    
    _iconImageView.frame = CGRectMake(pading, pading, FScreenWidth-2*pading, FScreenWidth/2-pading);
    
    _titleBackImage.frame = CGRectMake(0, 0, FScreenWidth/2, FScreenWidth/2/5);
    _titleBackImage.center = self.contentView.center;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
