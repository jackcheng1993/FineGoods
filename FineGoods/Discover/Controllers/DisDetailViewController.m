//
//  DisDetailViewController.m
//  FineGoods
//
//  Created by qianfeng on 16/1/22.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "DisDetailViewController.h"
#import "Define.h"
#import "ButtonModel.h"
#import "ButtonClickCell.h"
#import "HomeProductViewController.h"


@interface DisDetailViewController ()<UITableViewDataSource, UITableViewDelegate>{
    UITableView *_btntableView;
    NSMutableArray *_btndataSource;
}
@end

@implementation DisDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     _btndataSource = [[NSMutableArray alloc] init];
    
    self.view.backgroundColor = FBaseColor;

    
    UIButton *backButton = [[UIButton alloc] init];
    
    
    
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(buttonClickBack)];

    self.navigationItem.leftBarButtonItem = button;
    
    
    
    
    [self createTableView];
    [self loadDataFromNet];
    
}

- (void)buttonClickBack {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)loadDataFromNet {

    
    if ([_IntoType isEqual: @"post_list_element"]) {
        NSString *url = [NSString stringWithFormat:@"http://open3.bantangapp.com/community/post/elementPost?app_installtime=1452331670.387572&app_versions=5.3&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&device_token=41faf6db27adcbd27abc963e50f13304760b75fd273c84cf2fbced5258dbc7df&element_id=%@&oauth_token=43ca676f448530c8081801e04c024d65&os_versions=9.2&page=0&pagesize=10&screensize=750&track_deviceid=B884FCB9-2C81-448D-82F4-A28AC8CE7034&track_user_id=1813948&v=10",_elementID];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            ButtonModel *_model = [[ButtonModel alloc] initWithDictionary:dict error:nil];
            
            _btndataSource = _model.data.list;
            
            //[_btndataSource addObjectsFromArray:_btndataSource];
            
            [_btntableView reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
    }

    if ([_IntoType  isEqual: @"post_list_tag"]){
        NSString *url = [NSString stringWithFormat:@"http://open3.bantangapp.com/community/post/listByTag?app_installtime=1452331670.387572&app_versions=5.3.1&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&device_token=41faf6db27adcbd27abc963e50f13304760b75fd273c84cf2fbced5258dbc7df&oauth_token=43ca676f448530c8081801e04c024d65&os_versions=9.2.1&page=0&pagesize=10&screensize=750&tag_id=%@&track_deviceid=B884FCB9-2C81-448D-82F4-A28AC8CE7034&track_user_id=1813948&type_id=1&v=10",_tagID];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            ButtonModel *_model = [[ButtonModel alloc] initWithDictionary:dict error:nil];
            
            _btndataSource = _model.data.list;
            
            //[_btndataSource addObjectsFromArray:_btndataSource];
            
            [_btntableView reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];

    }
    
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
    static NSString *identifier3 = @"cellIDButton";
    ButtonClickCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier3];
    if (cell == nil) {
        cell = [[ButtonClickCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier3];
    }
    
    cell.BuyClickedBlock = ^(NSString *url){
        HomeProductViewController *hpcvc = [[HomeProductViewController alloc] initWithUrlString:url];
        [self.navigationController pushViewController:hpcvc animated:YES];
    };

    
    
    cell.modelbtn = _btndataSource[indexPath.row];
    
    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",indexPath.row);

    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
