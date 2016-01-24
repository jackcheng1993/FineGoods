    //
//  HomeDetailViewController.m
//  FineGoods
//
//  Created by qianfeng on 16/1/14.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "Define.h"
#import "PushControllerTransition.h"
#import "ProductListCell.h"
#import "HomeProductViewController.h"
#import "NetWorkingManager.h"
#import "FHomeDetailModel.h"
#import "UIScrollView+SpringHeadView.h"

#define headContentFount [UIFont systemFontOfSize:15]
#define kPadding 10
#define KheadContentWidth FScreenWidth-kPadding*2

@interface HomeDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UIImageView *titleBackView;
@property (nonatomic, assign)BOOL isLiked;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UILabel *headTitleLabel;
@property (nonatomic, strong) UILabel *headContentLabel;
@property (nonatomic, strong) FHomeDetailModel *detailModel;
@end

@implementation HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //解决 左滑返回手势消失
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    self.view.backgroundColor = [UIColor whiteColor];
    self.iconView.image = self.image;
   
    [self setUpTableView];
    [self setUpHeadView];
    [self fetchDataFromNet];
    [self setUpButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [self performSelector:@selector(hiddenNaviBar) withObject:self afterDelay:0.1];
}

- (void)viewDidAppear:(BOOL)animated {
    //self.navigationController.navigationBarHidden = YES;
}

- (void)hiddenNaviBar {
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.alpha = self.naviAlpha;
}

- (UIImageView *)iconView {
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, FScreenWidth, 200)];
        //self.iconView.contentMode = UIViewContentModeScaleAspectFill;
        [self.view addSubview:_iconView];
    }
    return _iconView;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, FScreenHeight, FScreenWidth, FScreenHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor =  [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (void)setUpButton {
    self.titleBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, FScreenWidth, 64)];
    self.titleBackView.image = [UIImage imageNamed:@"titleBack"];
    [self.view addSubview:self.titleBackView];
    
    //返回按钮
    self.navigationItem.hidesBackButton = YES;
    NSArray *normalImages = @[@"back",@"favorite",@"share"];
    for (NSInteger idx = 0; idx<normalImages.count; idx++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 30, 30)];
        //button.backgroundColor = [UIColor blackColor];
      // self.tableView.transform = CGAffineTransformMakeTranslation(0, 200);
         button.imageEdgeInsets = UIEdgeInsetsMake(8, 10, 8, 10);
        UIImage *image = [UIImage imageNamed:normalImages[idx]];
        //image.
        [button setImage:image forState:UIControlStateNormal];
        button.tag = 200+idx;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        if (idx == 0) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view).with.offset(10);
                make.size.mas_equalTo(CGSizeMake(30, 30));
                make.top.equalTo(self.view).with.offset(20);
            }];
        }else if (idx == 1) {
            [button  mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.view).with.offset(-60);
                make.size.mas_equalTo(CGSizeMake(30, 30));
                make.top.equalTo(self.view).with.offset(20);
            }];
            button.hidden = YES;
        }else if (idx == 2) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.view).with.offset(-10);
                make.size.mas_equalTo(CGSizeMake(30, 30));
                make.top.equalTo(self.view).with.offset(20);
            }];
            button.hidden = YES;
        }
    }
    
    
}

- (void)buttonAction:(UIButton *)button {
    switch (button.tag) {
        case 200:
            [self.navigationController popViewControllerAnimated:YES];
            break;
            case 201:
            [self setLikeButtonSelected:button];
            break;
            case 202:
            NSLog(@"分享");
            break;
        default:
            break;
    }
}

- (void)setLikeButtonSelected:(UIButton *)button {
    if (self.isLiked) {
        UIAlertController *alertContr = [UIAlertController alertControllerWithTitle:@"取消收藏" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertContr addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertContr addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        self.isLiked = !self.isLiked;
        [button setImage:[UIImage imageNamed:@"favorited"] forState:UIControlStateNormal];
    }else {
        [button setImage:[UIImage imageNamed:@"favorite"] forState:UIControlStateNormal];
        self.isLiked = !self.isLiked;
    }
}

- (void)setUpTableView {
    //self.tableView.tableHeaderView = self.headView;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, FScreenWidth, 21)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor grayColor];
    label.text = @"没有更多内容啦";
    self.tableView.tableFooterView = label;
}

- (void)fetchDataFromNet {
    NSString *urlString = [NSString stringWithFormat:FHomeDetailUrl,self.newsInfoId];
    
   [NetWorkingManager getRequestWithUrl:urlString parameters:nil pageType:nil successBlock:^(id object) {

       FHomeDetailModel *detailModel = [[FHomeDetailModel alloc]initWithDictionary:object error:nil];
       self.detailModel = detailModel;
       [self.dataArray addObjectsFromArray:detailModel.data.product];
       [self.tableView reloadData];
       
//      [UIView animateWithDuration:0.5 delay:0.1 usingSpringWithDamping:0.55 initialSpringVelocity:1/0.55 options:UIViewAnimationOptionLayoutSubviews animations:^{
//           self.tableView.transform = CGAffineTransformMakeTranslation(0, -(FScreenHeight+20));
//       } completion:nil];
       
//       [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionLayoutSubviews animations:^{
//            self.tableView.transform = CGAffineTransformMakeTranslation(0, -(FScreenHeight+20));
//       } completion:NULL];
       
       [UIView animateWithDuration:0.5  animations:^{
           
           self.tableView.transform = CGAffineTransformMakeTranslation(0, -(FScreenHeight));
           self.tableView.mj_offsetY = -200;
       } completion:^(BOOL finished) {
           
           self.tableView.tableHeaderView = self.iconView;
          
//           [UIView animateWithDuration:0.2 animations:^{
//             self.tableView.mj_offsetY = -200;
//           }];
        
       }];
       
       
   } failBlock:^(NSError *error) {
       NSLog(@"detail data error :%@",error.localizedDescription);
   }];
}

- (void)setUpHeadView {
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, FScreenWidth, 100)];
    self.headView.backgroundColor = [UIColor whiteColor];
    
    self.headTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, FScreenWidth-20, 20)];
    [self.headView addSubview:self.headTitleLabel];
    
    self.headContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.headTitleLabel.frame)+10, KheadContentWidth, 50)];
    self.headContentLabel.textColor = [UIColor darkGrayColor];
    self.headContentLabel.numberOfLines = 0;
    self.headContentLabel.font = headContentFount;
    [self.headView addSubview:self.headContentLabel];
}

- (void)updateFirstCell {
    if (self.detailModel) {
        self.headTitleLabel.text = self.detailModel.data.title;
        
        CGFloat contentHeight = [self contentHeight:self.detailModel.data.desc];
        self.headContentLabel.mj_h = contentHeight;
        self.headContentLabel.text = self.detailModel.data.desc;
        
        self.headView.mj_h = CGRectGetMaxY(self.headTitleLabel.frame)+kPadding+contentHeight;
    }
}

- (CGFloat)contentHeight:(NSString *)content {
    CGSize contentSize = [content boundingRectWithSize:CGSizeMake(KheadContentWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:headContentFount} context:nil].size;
    CGFloat contentHeight = contentSize.height;
    
    return contentHeight;
}

#pragma mark - 购买按钮
- (void)buyBtnClicked:(FHomeDetailProductModel *)productModel {
    HomeProductViewController *productVC = [[HomeProductViewController alloc]initWithUrlString:productModel.url];
    [self.navigationController pushViewController:productVC animated:YES];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FHomeDetailProductModel *produtModel = self.dataArray[indexPath.row];
    
    if (indexPath.row == 0) {
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cellOne"];
        if (cell1 == nil) {
            cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellOne"];
            [cell1.contentView addSubview:self.headView];
        }
        [self updateFirstCell];
        return cell1;
    }
    
    ProductListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[ProductListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell setProductModel:produtModel index:indexPath.row];
    cell.buyBtnClickedBlock = ^(FHomeDetailProductModel *productModel){
        [self buyBtnClicked:productModel];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return self.headView.mj_h + kPadding;
    }
    
    CGFloat productCellHeight = [ProductListCell cellHeightWithObj:self.dataArray[indexPath.row]];
    if (indexPath.row < (_dataArray.count-1)) {
        productCellHeight += kPadding;
    }
    return productCellHeight;
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//       return label;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 21;
//}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat offsetY = scrollView.contentOffset.y;
//    NSLog(@"offsetY %lf",offsetY);
//    CGFloat tableY = self.tableView.mj_y;
//    NSLog(@"trableY %lf",tableY);
//    if (offsetY > 0 ) {
//        self.iconView.mj_y -= offsetY;
//        self.tableView.mj_y -=offsetY;
//    }else {
//        CGFloat scale = 1.0*FScreenWidth/200;
//        self.iconView.mj_h += -offsetY*0.2;
//        self.iconView.mj_w = self.iconView.mj_h * scale;
//        //self.iconView.mj_size = CGSizeMake(imageW, imageH);
//    }
}
#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (([toVC isKindOfClass:[self class]]&&[fromVC isKindOfClass:NSClassFromString(@"HomeViewController")])||([fromVC isKindOfClass:[self class]]&&[toVC isKindOfClass:NSClassFromString(@"HomeViewController")])) {
        if (operation == UINavigationControllerOperationPush) {
            return [PushControllerTransition transitionWithType:FControllerTransitionTypePush duration:0.5];
        } else {
            return [PushControllerTransition transitionWithType:FControllerTransitionTypePop duration:0.5];
        }
    }
    
    return nil;
}


//移除分类中注册的观察者
//- (void)dealloc {
//    [self.tableView removeObserver:self.tableView forKeyPath:@"contentOffset"];
//}

#pragma mark - HomeDetailCellDelegate
//- (void)homeDetailCell:(HomeDetailCell *)homedetailCell pageUrlString:(NSString *)urlString {
//    HomeProductViewController *productContr = [[HomeProductViewController alloc]initWithUrlString:urlString];
//    [self.navigationController pushViewController:productContr animated:YES];
//}

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
