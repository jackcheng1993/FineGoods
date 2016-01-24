//
//  HomePageViewController.m
//  FineGoods
//
//  Created by qianfeng on 16/1/12.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomeCell.h"
#import "NetWorkingManager.h"
#import "FAppModel.h"
#import "FHomeModel.h"
#import "HomeViewController.h"
#import "HomeDetailViewController.h"

#define identifity @"HomeCell"
#define LabelWidth 70

@interface HomePageViewController () {
     NSInteger _page;
}

@property (nonatomic , strong) NSMutableArray *dataArray;


@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //定制TableView
    [self customTableView];
    //初始时请求数据
    //[self fetchDataFromNet:NO withRefreshHeader:nil];
}

//- (instancetype)init {
//}

- (void)customTableView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.rowHeight = 204;
    self.tableView.bounces = NO;
   // self.tableView.frame = CGRectMake(0, 0, FScreenWidth, FScreenHeight-64);
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, FScreenWidth, 244)];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeCell class]) bundle:nil] forCellReuseIdentifier:identifity];
    //设置导航栏代理
    FNavigationController<ChangeNavigationBarDelegate> *fNavigation = (FNavigationController<ChangeNavigationBarDelegate> *)self.navigationController;
    self.tableView.NDelegate = fNavigation;
    fNavigation.scrollView = self.tableView;
    //设置刷新视图
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self fetchDataFromNet:NO withRefreshHeader:nil];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self fetchDataFromNet:YES withRefreshHeader:nil];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if (self.delegate) {
        [self.delegate changeTitleScllorViewY:self.tableView.mj_offsetY];
    }
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

//&page=0&pagesize=20&
- (void)fetchDataFromNet:(BOOL)isMore withRefreshHeader:(MJRefreshHeader *)refreshHeader {
    if (isMore) _page++;
    else _page = 0;
    self.tableView.bounces=YES;
    if ([self.title isEqualToString:@"最新"]) {
        NSString *urlString = [NSString stringWithFormat:FHomeUrl,(long)_page];
        [NetWorkingManager getRequestWithUrl:urlString parameters:nil pageType:FHomePage successBlock:^(id object) {
            NSDictionary *dict = (NSDictionary *)object;
            FAppModel *appModel = [[FAppModel alloc]initWithDictionary:dict error:nil];
            if (!isMore) {
                [self.dataArray removeAllObjects];
                [self.tableView reloadData];

                HomeViewController *homeContr = (HomeViewController *)self.parentViewController;
                [homeContr updateLoopData:appModel.data.banner];
            }
            [_dataArray addObjectsFromArray:appModel.data.topic];
            [self.tableView reloadData];
            
            isMore?[self.tableView.mj_footer endRefreshing]:[self.tableView.mj_header endRefreshing];
        } failBlock:^(NSError *error) {
            NSLog(@"%@",error);
            isMore?[self.tableView.mj_footer endRefreshing]:[self.tableView.mj_header endRefreshing];
        }];
    }
    else {
        NSDictionary *parameters = @{@"page":@(_page),@"pagesize":@(20)};
        NSString *urlString = [NSString stringWithFormat:FHomeCommonUrl,_sence];
        [NetWorkingManager postRequestWithUrl:urlString parameters:parameters pageType:nil successBlock:^(id object) {
          //  NSLog(@"dict %@",object);
            FHomeModel *homeModel = [[FHomeModel alloc]initWithDictionary:object error:nil];
          //NSLog(@"appmodel :%@",homeModel);
            if (!isMore) {
                [self.dataArray removeAllObjects];
                [self.tableView reloadData];
            }
            
            [self.dataArray addObjectsFromArray:homeModel.data];
            [self.tableView reloadData];
            isMore?[self.tableView.mj_footer endRefreshing]:[self.tableView.mj_header endRefreshing];
            
        } failBlock:^(NSError *error) {
            NSLog(@"%@",error.localizedDescription);
            isMore?[self.tableView.mj_footer endRefreshing]:[self.tableView.mj_header endRefreshing];
        }];
    }
    
    
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FAppTopicModel *topicModel = _dataArray[indexPath.row];
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifity];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell UpdateWithModel:topicModel index:indexPath.row];
    return cell;
}

-(void)dealloc {
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
