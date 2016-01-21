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
    [self setUpButton];
    [self setUpTableView];
    [self fetchDataFromNet];
    
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
        [self.view addSubview:_iconView];
    }
    return _iconView;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, FScreenHeight, FScreenWidth, FScreenHeight-200)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor =  [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
      //  _tableView.estimatedRowHeight = 200;
      //  _tableView.rowHeight = UITableViewAutomaticDimension;
        //[_tableView registerNib:[ProductListCell class] bundle:nil] forCellReuseIdentifier:@"cell"];
       // [_tableView registerClass:[ProductListCell class] forCellReuseIdentifier:@"cell"];
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
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
        //button.backgroundColor = [UIColor blackColor];
      // self.tableView.transform = CGAffineTransformMakeTranslation(0, 200);
         button.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        UIImage *image = [UIImage imageNamed:normalImages[idx]];
        //image.
        [button setImage:image forState:UIControlStateNormal];
        button.tag = 200+idx;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        if (idx == 0) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view).with.offset(10);
                make.size.mas_equalTo(CGSizeMake(44, 44));
                make.top.equalTo(self.view).with.offset(20);
            }];
        }else if (idx == 1) {
            [button  mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.view).with.offset(-60);
                make.size.mas_equalTo(CGSizeMake(44, 44));
                make.top.equalTo(self.view).with.offset(20);
            }];
        }else if (idx == 2) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.view).with.offset(-10);
                make.size.mas_equalTo(CGSizeMake(44, 44));
                make.top.equalTo(self.view).with.offset(20);
            }];
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
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, FScreenWidth, 100)];
    self.headView.backgroundColor = [UIColor whiteColor];
    
    self.headTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, FScreenWidth-20, 20)];
    [self.headView addSubview:self.headTitleLabel];
    
    self.headContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.headTitleLabel.frame)+10, KheadContentWidth, 50)];
    self.headContentLabel.textColor = [UIColor darkGrayColor];
    self.headContentLabel.numberOfLines = 0;
    self.headContentLabel.font = headContentFount;
    [self.headView addSubview:self.headContentLabel];
    
    self.tableView.tableHeaderView = self.headView;
}

- (void)fetchDataFromNet {
    NSString *urlString = [NSString stringWithFormat:FHomeDetailUrl,self.newsInfoId];
    
   [NetWorkingManager getRequestWithUrl:urlString parameters:nil pageType:nil successBlock:^(id object) {

       FHomeDetailModel *detailModel = [[FHomeDetailModel alloc]initWithDictionary:object error:nil];
       self.detailModel = detailModel;
       [self updateHeadView];
       [self.dataArray addObjectsFromArray:detailModel.data.product];
       [self.tableView reloadData];
       
      [UIView animateWithDuration:0.5 delay:0.1 usingSpringWithDamping:0.55 initialSpringVelocity:1/0.55 options:UIViewAnimationOptionLayoutSubviews animations:^{
           self.tableView.transform = CGAffineTransformMakeTranslation(0, -(FScreenHeight-200));
       } completion:nil];
       
       
   } failBlock:^(NSError *error) {
       NSLog(@"detail data error :%@",error.localizedDescription);
   }];
}

- (void)updateHeadView {
    self.headTitleLabel.text = self.detailModel.data.title;
    
    CGSize contentSize = [self.detailModel.data.desc boundingRectWithSize:CGSizeMake(KheadContentWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:headContentFount} context:nil].size;
    CGFloat contentHeight = contentSize.height;
    self.headContentLabel.mj_h = contentHeight;
    self.headContentLabel.text = self.detailModel.data.desc;
//    [self.headContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(contentSize.height);
//    }];
    self.headView.mj_h = CGRectGetMaxY(self.headTitleLabel.frame)+kPadding+contentHeight;

//    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(30+contentSize.height);
//    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[ProductListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    //cell.delegate = self;
    //[cell UpdateWithModel:self.dataArray[indexPath.row] index:indexPath.row];
    [cell setProductModel:self.dataArray[indexPath.row] index:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat productCellHeight = [ProductListCell cellHeightWithObj:self.dataArray[indexPath.row]];
    if (indexPath.row < (_dataArray.count-1)) {
        productCellHeight += kPadding;
    }
    return productCellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, FScreenWidth, 21)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor grayColor];
    label.text = @"没有更多内容啦";
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 21;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}
#pragma mark - UINavigationControllerDelegate
//- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
//    return nil;
//}
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        return [PushControllerTransition transitionWithType:FControllerTransitionTypePush duration:0.75];
    } else {
        return [PushControllerTransition transitionWithType:FControllerTransitionTypePop duration:0.75];
    }
}



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
