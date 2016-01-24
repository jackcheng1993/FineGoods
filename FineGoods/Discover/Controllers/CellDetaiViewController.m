//
//  CellDetaiViewController.m
//  FineGoods
//
//  Created by qianfeng on 16/1/23.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "CellDetaiViewController.h"
#import "Define.h"
#import "CellModel.h"
#import "InToCellCell.h"

#import "HomeProductViewController.h"

@interface CellDetaiViewController ()<UITableViewDataSource, UITableViewDelegate>{
    UITableView *_btntableView;
    NSMutableArray *_btndataSource;
}
@end

@implementation CellDetaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _btndataSource = [[NSMutableArray alloc] init];
    
    self.view.backgroundColor = FBaseColor;
    
    [self createTableView];
    [self loadDataFromNet];
}

- (void)loadDataFromNet {
    
    NSString *url = [NSString stringWithFormat:@"http://open3.bantangapp.com/community/group/info?app_installtime=1452331670.387572&app_versions=5.3&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&device_token=41faf6db27adcbd27abc963e50f13304760b75fd273c84cf2fbced5258dbc7df&group_id=%@&oauth_token=43ca676f448530c8081801e04c024d65&os_versions=9.2&pagesize=10&screensize=750&track_deviceid=B884FCB9-2C81-448D-82F4-A28AC8CE7034&track_user_id=1813948&type_id=1&v=10",_groupid];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        CellModel *_model = [[CellModel alloc] initWithDictionary:dict error:nil];

        _btndataSource = _model.data.post_list;
        
        //[_btndataSource addObjectsFromArray:_btndataSource];
        
        [_btntableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)createTableView {
    _btntableView =  [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-FNavigationHeight) style:UITableViewStylePlain];
    _btntableView.delegate = self;
    _btntableView.dataSource = self;
    _btntableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:_btntableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _btndataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

      return  ( FScreenWidth - 2 * 5 + FScreenWidth/5 +FScreenWidth/7 + 18);
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier4 = @"Cellcell";
    InToCellCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier4];
    if (cell == nil) {
        cell = [[InToCellCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier4];
    }
    
    cell.BuyClickedBlock = ^(NSString *url){
        HomeProductViewController *hpcvc = [[HomeProductViewController alloc] initWithUrlString:url];
        [self.navigationController pushViewController:hpcvc animated:YES];
    };
    
    cell.modelpost = _btndataSource[indexPath.row];
    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",indexPath.row);
    
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
