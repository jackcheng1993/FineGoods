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
#define LabelWidth 70

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate> {
    UITableView *_tableView;
    HYBLoopScrollView *_loopScrollView;
    UIScrollView *_sectionHeaderView;
    
    NSMutableArray *_dataArray;
    NSMutableArray *_headArray;
    NSArray *_titleArray;
    
    NSInteger _page;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initData];
    [self createTableView];
      // Do any additional setup after loading the view.
}

#pragma mark - 初始化数据
- (void)initData {
    _dataArray = [NSMutableArray new];
    _titleArray = @[@"文艺",@"礼物",@"指南",@"爱美",@"设计",@"吃货",@"格调",@"厨房",@"上班族",@"学生党",@"聚会",@"节日",@"宿舍"];
}

- (void)createTableView {
    //创建tableView
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGRect tableViewFrame = CGRectMake(0, 0, FScreenWidth, FScreenHeight-FTabBarHeight);
    _tableView = [[UITableView alloc]initWithFrame:tableViewFrame];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 204;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeCell class]) bundle:nil] forCellReuseIdentifier:identifity];
    
    //设置导航栏代理
    FNavigationController<ChangeNavigationBarDelegate> *fNavigation = (FNavigationController<ChangeNavigationBarDelegate> *)self.navigationController;
    _tableView.NDelegate = fNavigation;
    
    //创建头视图
    _headArray = [[NSMutableArray alloc]initWithObjects:@"Fplaceholder",@"Fplaceholder",nil];
    _loopScrollView = [HYBLoopScrollView loopScrollViewWithFrame:CGRectMake(0, 0, FScreenWidth, 200) imageUrls:_headArray timeInterval:5.0 didSelect:^(NSInteger atIndex, HYBLoadImageView *sender) {
        
    } didScroll:NULL];
    _loopScrollView.alignment = kPageControlAlignCenter;
    _tableView.tableHeaderView = _loopScrollView;
    
    //创建头视图
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self fetchDataFromNet:NO];
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self fetchDataFromNet:YES];
    }];
    
    [_tableView.mj_header beginRefreshing];
    [self.view addSubview:_tableView];
}

- (void)fetchDataFromNet:(BOOL)isMore {
    if (isMore) _page++;
    else _page = 0;
    NSString *urlString = [NSString stringWithFormat:FHomeUrl,_page];
    [NetWorkingManager getRequestWithUrl:urlString parameters:nil pageType:FHomePage successBlock:^(id object) {
        NSDictionary *dict = (NSDictionary *)object;
        FAppModel *appModel = [[FAppModel alloc]initWithDictionary:dict error:nil];
        if (!isMore) {
            [_dataArray removeAllObjects];
            [_tableView reloadData];
            [_headArray removeAllObjects];
            [_headArray addObjectsFromArray:appModel.data.banner];
            [self setImagesForLoopScrollView];
        }
        [_dataArray addObjectsFromArray:appModel.data.topic];
        [_tableView reloadData];
        
        isMore?[_tableView.mj_footer endRefreshing]:[_tableView.mj_header endRefreshing];
    } failBlock:^(NSError *error) {
        NSLog(@"%@",error);
         isMore?[_tableView.mj_footer endRefreshing]:[_tableView.mj_header endRefreshing];
    }];
   
}

- (void)setImagesForLoopScrollView {
    NSMutableArray *imageUrls = [NSMutableArray new];
    for (FAppBannerModel *bannerModel in _headArray) {
        [imageUrls addObject:bannerModel.photo];
    }
    _loopScrollView.imageUrls = imageUrls;
}

//- (UIView *)createSectionHeadView {
//    _sectionHeaderView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, FScreenWidth, 40)];
//    _sectionHeaderView.contentSize = CGSizeMake(LabelWidth*_titleArray.count, 40);
//    for (NSInteger i = 0; i< _titleArray.count; i++) {
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, LabelWidth* , LabelWidth, 40)];
//    }
//    return _sectionHeaderView;
//}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FAppTopicModel *topicModel = _dataArray[indexPath.row];
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifity];
    [cell UpdateWithModel:topicModel index:indexPath.row];
    return cell;
}
  
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    //return [self createSectionHeadView];
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
