//
//  HomeViewController.m
//  FineGoods
//
//  Created by qianfeng on 16/1/10.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "HomeViewController.h"
#import "Define.h"
#import "HomeCell.h"
#import "NetWorkingManager.h"

#define identifity @"HomeCell"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate> {
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableView];
      // Do any additional setup after loading the view.
}

- (void)createTableView {
     self.automaticallyAdjustsScrollViewInsets = NO;
    CGRect tableViewFrame = CGRectMake(0, 0, FScreenWidth, FScreenHeight-FTabBarHeight);
    _tableView = [[UITableView alloc]initWithFrame:tableViewFrame];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    FNavigationController<ChangeNavigationBarDelegate> *fNavigation = (FNavigationController<ChangeNavigationBarDelegate> *)self.navigationController;
    _tableView.NDelegate = fNavigation;
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self fetchDataFromNet:NO];
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self fetchDataFromNet:YES];
    }];
    
    [_tableView.mj_header beginRefreshing];
}

- (void)fetchDataFromNet:(BOOL)isMore {
    
   
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifity];
    return cell;
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
