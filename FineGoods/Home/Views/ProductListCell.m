//
//  ProductListCell.m
//  FineGoods
//
//  Created by qianfeng on 16/1/20.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "ProductListCell.h"
#import "ProductMediaItemCell.h"
#define kPadding 10.0
#define kproductListCell_ContentFont [UIFont systemFontOfSize:14]
#define kproductListCell_ContentWidth FScreenWidth - (kPadding *2)

@interface ProductListCell ()
@property (nonatomic, strong) UIImageView *tagImgView;
@property (nonatomic, strong) UILabel *titleLabel, *contentLabel,  *priceLabel, *likeCountLabel;
@property (nonatomic, strong) UICollectionView *mediaView;
@property (nonatomic, strong) UIButton *likeBtn, *buyBtn;
@end

@implementation ProductListCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        if (!self.tagImgView) {
            self.tagImgView = [[UIImageView alloc]initWithFrame:CGRectMake(kPadding, kPadding, 15, 22)];
            [self.contentView addSubview:self.tagImgView];
        }
        
        if (!self.titleLabel) {
            CGFloat titleLabelX = CGRectGetMaxX(self.tagImgView.frame)+kPadding;
            CGFloat titleLabelW = FScreenWidth-(CGRectGetMaxX(self.tagImgView.frame)+kPadding*2);
            self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabelX, kPadding, titleLabelW, 21)];
            [self.contentView addSubview:self.titleLabel];
        }
        
        if (!self.contentLabel) {
            CGFloat contentLabelY = CGRectGetMaxY(self.tagImgView.frame)+kPadding;
            CGFloat contentLabelW = FScreenWidth - (kPadding *2);
            self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(kPadding, contentLabelY, contentLabelW, 20)];
            self.contentLabel.textColor = [UIColor darkGrayColor];
            self.contentLabel.numberOfLines = 0;
            self.contentLabel.font = kproductListCell_ContentFont;
            [self.contentView addSubview:self.contentLabel];
        }
       
        if (!self.mediaView) {
            UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
            self.mediaView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FScreenWidth, 80) collectionViewLayout:layout];
            self.mediaView.scrollEnabled = NO;
            self.mediaView.backgroundColor = [UIColor whiteColor];
            [self.mediaView registerClass:[ProductMediaItemCell class] forCellWithReuseIdentifier:kcellIdentifier_ProductMediaItem];
            self.mediaView.delegate = self;
            self.mediaView.dataSource = self;
            [self.contentView addSubview:self.mediaView];
        }
        
        if (!self.priceLabel) {
            self.priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(kPadding, 0, kproductListCell_ContentWidth, 21)];
            self.priceLabel.font = kproductListCell_ContentFont;
            self.priceLabel.textAlignment = NSTextAlignmentRight;
            self.priceLabel.textColor = FBaseColor;
            [self.contentView addSubview:self.priceLabel];
        }
        
        if (!self.likeBtn) {
            self.likeBtn = [[UIButton alloc]initWithFrame:CGRectMake(kPadding, 0, 24, 20)];
           // [self.likeBtn setImage:[UIImage imageNamed:@"love"] forState:UIControlStateNormal];
            [self.likeBtn addTarget:self action:@selector(likeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:self.likeBtn];
        }
        
        if (!self.likeCountLabel) {
            self.likeCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.likeBtn.frame) + kPadding, 0, 168, 20)];
            self.likeCountLabel.font = [UIFont systemFontOfSize:15];
            self.likeCountLabel.textColor = [UIColor darkGrayColor];
            [self.contentView addSubview:self.likeCountLabel];
        }
        
        if (!self.buyBtn) {
            CGFloat buyBtnW = 70;
            self.buyBtn = [[UIButton alloc]initWithFrame:CGRectMake(FScreenWidth-buyBtnW-kPadding, 0, buyBtnW, 24)];
            [self.buyBtn addTarget:self action:@selector(buyBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:self.buyBtn];
        }
    }
    return self;
}

- (void)likeBtnClicked:(UIButton *)btn {
    if (self.likeBtnClickedBlock) {
        self.likeBtnClickedBlock(self.productModel);
    }
}

- (void)buyBtnClicked:(UIButton *)btn {
    if (self.buyBtnClickedBlock) {
        self.buyBtnClickedBlock(self.productModel);
    }
}

- (void)setProductModel:(FHomeDetailProductModel *)productModel index:(NSInteger)index {
    _productModel = productModel;
    if (!_productModel) {
        return;
    }
    
    NSString *tapImgName = [NSString stringWithFormat:@"tg%ld",(long)index];
   // NSString *tapImgName = @"tg13";
    self.tagImgView.image = [UIImage imageNamed:tapImgName];
    
    self.titleLabel.text = _productModel.title;
    
    CGFloat buttomY = CGRectGetMaxY(self.tagImgView.frame)+kPadding;
    
    CGFloat contentLabelH = [ProductListCell contentLabelHeightWithDes:_productModel.desc];
    self.contentLabel.frame = CGRectMake(kPadding, buttomY, kproductListCell_ContentWidth, contentLabelH);
    self.contentLabel.text = _productModel.desc;
    
    buttomY += contentLabelH+kPadding;
    
    if (_productModel.pic.count > 0) {
        CGFloat mediaHeight = [ProductListCell contentMediaHeightWithPicArray:_productModel.pic];
        self.mediaView.frame = CGRectMake(0, buttomY, FScreenWidth, mediaHeight);
        buttomY += mediaHeight+kPadding;
        self.mediaView.hidden = NO;
        [self.mediaView reloadData];
    }else {
        self.mediaView.hidden = YES;
    }
    
    self.priceLabel.mj_y = buttomY;
    self.priceLabel.text = [NSString stringWithFormat:@"参考价：¥%@",_productModel.price];
    
    buttomY += CGRectGetHeight(self.priceLabel.frame)+kPadding;

    self.likeBtn.mj_y = buttomY;
    _productModel.islike?[self.likeBtn setImage:[UIImage imageNamed:@"liked"] forState:UIControlStateNormal]:[self.likeBtn setImage:[UIImage imageNamed:@"homedetaillike"] forState:UIControlStateNormal];
    
    self.likeCountLabel.mj_y = buttomY;
    _productModel.islike?(self.likeCountLabel.text = @"已加入心愿清单"):(self.likeCountLabel.text = _productModel.likes);
    
    self.buyBtn.mj_y = buttomY;
    [_buyBtn setImage:[UIImage imageNamed:@"buy"] forState:UIControlStateNormal];
}

+ (CGFloat)cellHeightWithObj:(id)obj {
    FHomeDetailProductModel *productModel = (FHomeDetailProductModel *)obj;
    CGFloat cellHeight = 0;
    cellHeight += 22;//tagImgView H
    cellHeight += kPadding;
    cellHeight += [ProductListCell contentLabelHeightWithDes:productModel.desc];
    cellHeight += kPadding;
    cellHeight += [ProductListCell contentMediaHeightWithPicArray:productModel.pic];
    cellHeight += kPadding;
    cellHeight += 21; //priceLabel H
    cellHeight += kPadding;
    cellHeight += 24; //buyBtn H
    cellHeight += kPadding;
    return cellHeight;
}


+ (CGFloat)contentMediaHeightWithPicArray:(NSArray *)picArray {
    CGFloat contentMediaHeight = 0;
    NSUInteger mediaCount = picArray.count;
    if (mediaCount > 0) {
        contentMediaHeight = FScreenWidth*mediaCount;
    }
    return contentMediaHeight;
}

+ (CGFloat)contentLabelHeightWithDes:(NSString *)desc {
    CGFloat contentLabelHeight = 0;
    if (desc.length > 0) {
        CGSize contentLabelFrame = [desc boundingRectWithSize:CGSizeMake(kproductListCell_ContentWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kproductListCell_ContentFont} context:nil].size;
        contentLabelHeight = contentLabelFrame.height;
    }
    return contentLabelHeight;
}

#pragma mark - collection delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.productModel.pic.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductMediaItemCell *mediaItemCell = [collectionView dequeueReusableCellWithReuseIdentifier:kcellIdentifier_ProductMediaItem forIndexPath:indexPath];
    mediaItemCell.picModel = self.productModel.pic[indexPath.row];
    return mediaItemCell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kproductListCell_ContentWidth, kproductListCell_ContentWidth);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
   return  UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
