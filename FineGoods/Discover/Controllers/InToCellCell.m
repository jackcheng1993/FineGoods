//
//  InToCellCell.m
//  FineGoods
//
//  Created by qianfeng on 16/1/23.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "InToCellCell.h"
#import "Define.h"

@implementation InToCellCell{
    NSString *_url;
    
    UIImageView *_bigImage;
    UILabel *_content;
    
    UIImageView *_buyImage;
    UILabel *_buyName;
    UIButton *_buyButton;
    
    NSMutableArray *_buyPicsArray;
    
    NSMutableArray *_picArray;
    NSMutableArray *_nameArray;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createCustomViews];
    }
    return self;
}

- (void)createCustomViews{
    _bigImage = [UIImageView new];
    _content = [UILabel new];
    
    _buyImage = [UIImageView new];
    _buyName = [UILabel new];
    _buyButton = [UIButton new];
    
    _picArray = [NSMutableArray new];
    _buyPicsArray = [NSMutableArray new];


    
    [self.contentView addSubview:_bigImage];
    [self.contentView addSubview:_content];
    
    
    [self.contentView addSubview:_buyImage];
    [self.contentView addSubview:_buyName];
    [self.contentView addSubview:_buyButton];
}

- (void)setModelpost:(PostModel *)modelpost
{
    _content.text = modelpost.content;
    _picArray = modelpost.pics;
    PicsMModel *picsModel = _picArray[0];
    [_bigImage sd_setImageWithURL:[NSURL URLWithString:picsModel.url]];
    
    _buyPicsArray = modelpost.product;
    if (_buyPicsArray.count == 1) {
        PProductModel *producsModel = _buyPicsArray[0];
        [_buyImage sd_setImageWithURL:[NSURL URLWithString:producsModel.pic]];
        _url = producsModel.url;
        
        [_buyButton addTarget:self action:@selector(buyClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _buyName.text = producsModel.title;
   }

    
    
}

- (void)buyClick:(UIButton *)buyBtn {
    if (self.BuyClickedBlock) {
        self.BuyClickedBlock(_url);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat pading = 5;
    
    _bigImage.frame = CGRectMake(pading, pading,  FScreenWidth-2 * pading, FScreenWidth - 2 * pading);
    _content.frame = CGRectMake(pading, FScreenWidth-pading, FScreenWidth-2*pading, FScreenWidth/5);
    
    
    _buyImage.frame = CGRectMake(pading, FScreenWidth + FScreenWidth/5, FScreenWidth/7 , FScreenWidth/7 );
    
    
    _buyName.frame = CGRectMake(2*pading + FScreenWidth/7 ,FScreenWidth - pading + FScreenWidth/5,FScreenWidth/5*2,FScreenWidth/7 );
    
    _buyButton.frame = CGRectMake(FScreenWidth/9*7.5, FScreenWidth + FScreenWidth/5, FScreenWidth/9, FScreenWidth/9);
    
    _content.numberOfLines = 0;
    _content.textAlignment = NSTextAlignmentLeft;
    _content.textColor = [UIColor grayColor];
    
    _buyName.numberOfLines = 0;
    _buyName.font = [UIFont systemFontOfSize:13];
    _buyName.textColor = [UIColor grayColor];
    _buyName.adjustsFontSizeToFitWidth = YES;
    _buyName.textAlignment = NSTextAlignmentCenter;
    
    _buyButton.layer.cornerRadius = FScreenWidth/9/2;
    _buyButton.layer.masksToBounds = YES;
    _buyButton.backgroundColor = FBaseColor;;
    [_buyButton setTitle:@"BUY" forState:UIControlStateNormal];
    
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
