//
//  HomeBannerViewController.m
//  FineGoods
//
//  Created by qianfeng on 16/1/22.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "HomeBannerViewController.h"
#import "TopicTypeCCell.h"
#import "ProducTypeCCell.h"
#import "NetWorkingManager.h"
#import "Define.h"
#import "FHomeBannerModel.h"
#import "BannerProductModel.h"
#import "HomeBannerProductDetailVC.h"
#import "HomeDetailViewController.h"
#define Topic_List_cell @"topic_list"
#define Product_List_cell @"product_list"
#define Product_Cell_Item_Spacing 10
#define Product_Cell_Line_Spacing 8
#define Produce_Cell_Item_Width (FScreenWidth - 3*Product_Cell_Item_Spacing)/2

@interface HomeBannerViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIImageView *titleBackView;

@end

@implementation HomeBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.alpha = 1.0;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpTitleBackView];
    [self fetchDataFromNet];
}

//- (void)viewWillAppear:(BOOL)animated {
//    self.navigationController.navigationBarHidden = YES;
//    self.navigationController.navigationBar.alpha = 1.0;
//}

//- (void)viewWillDisappear:(BOOL)animated {
//    self.navigationController.navigationBar.alpha = 0.0;
//}

- (instancetype)initWithType:(NSString *)type {
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor =  [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[TopicTypeCCell class] forCellWithReuseIdentifier:Topic_List_cell];
        [_collectionView registerClass:[ProducTypeCCell class] forCellWithReuseIdentifier:Product_List_cell];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (void)setUpTitleBackView {
    self.titleBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, FScreenWidth, 64)];
    self.titleBackView.image = [UIImage imageNamed:@"titleBack"];
    [self.view addSubview:self.titleBackView];
    
    CGFloat btnW = 30;
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, btnW, btnW)];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(8, 10, 8, 10);
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
}

- (void)backClicked {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)fetchDataFromNet {
    NSString *urlString = nil;
    if ([self.type isEqualToString:Topic_List_cell]) {
       urlString = [NSString stringWithFormat:FHomeBannerTopicUrl,self.extends];
        [NetWorkingManager getRequestWithUrl:urlString parameters:nil pageType:nil successBlock:^(id object) {
            FHomeBannerModel *bannerModel = [[FHomeBannerModel alloc]initWithDictionary:object error:nil];
            [self.dataArray addObjectsFromArray:bannerModel.data];
            [self.collectionView reloadData];
        } failBlock:^(NSError *error) {
            NSLog(@"banner detail data error %@",error.localizedDescription);
        }];
    }
    if ([self.type isEqualToString:Product_List_cell]) {
        urlString = [NSString stringWithFormat:FHomeBannerProductUrl,self.extends];
        [NetWorkingManager postRequestWithUrl:urlString parameters:nil pageType:nil successBlock:^(id object) {
            BannerProductModel *productModel = [[BannerProductModel alloc]initWithDictionary:object error:nil];
            [self.dataArray addObjectsFromArray:productModel.data];
            [self.collectionView reloadData];
        } failBlock:^(NSError *error) {
            NSLog(@"banner product data error %@",error.localizedDescription);
        }];
    }
    
}
   
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.type isEqualToString:Topic_List_cell]) {
        TopicTypeCCell *topicCCell = [collectionView dequeueReusableCellWithReuseIdentifier:Topic_List_cell forIndexPath:indexPath];
        topicCCell.dataModel = self.dataArray[indexPath.item];
        
        return topicCCell;
    }
    if ([self.type isEqualToString:Product_List_cell]) {
        ProducTypeCCell *productCCell = [collectionView dequeueReusableCellWithReuseIdentifier:Product_List_cell forIndexPath:indexPath];
        productCCell.dataModel = self.dataArray[indexPath.item];
        return productCCell;
    }
    return nil;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 10, 10,10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return Product_Cell_Line_Spacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return  Product_Cell_Item_Spacing;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeMake(0, 0);
    if ([self.type isEqualToString:Topic_List_cell]) {
        itemSize = CGSizeMake(FScreenWidth, [TopicTypeCCell cellHeight]+10);
    }
    if ([self.type isEqualToString:Product_List_cell]) {
        itemSize = CGSizeMake(Produce_Cell_Item_Width, [ProducTypeCCell cellHeight]+10);
    }
    
    return itemSize;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.type isEqualToString:Product_List_cell]) {
        BannerDataModel *dataModel = self.dataArray[indexPath.item];
        HomeBannerProductDetailVC *productDetailVC = [[HomeBannerProductDetailVC alloc]initWithNewID:dataModel.id];
        [self.navigationController pushViewController:productDetailVC animated:YES];
    }
    if ([self.type isEqualToString:Topic_List_cell]) {
        TopicTypeCCell *topicCell =(TopicTypeCCell *)[collectionView cellForItemAtIndexPath:indexPath];
        FHomeBannerDataModel *dataModel = self.dataArray[indexPath.item];
        self.iconImageView = topicCell.avaterImgView;
        HomeDetailViewController *detailContr = [[HomeDetailViewController alloc]init];
        detailContr.image = self.iconImageView.image;
        detailContr.newsInfoId = dataModel.id;
        
        detailContr.naviAlpha = self.navigationController.navigationBar.alpha;
        
        self.navigationController.delegate = detailContr;
        detailContr.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:detailContr animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
