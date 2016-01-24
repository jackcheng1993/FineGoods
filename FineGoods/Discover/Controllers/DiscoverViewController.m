//
//  DiscoverViewController.m
//  FineGoods
//
//  Created by qianfeng on 16/1/10.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "DiscoverViewController.h"
#import "Define.h"

#import "ButtonTableViewCell.h"
#import "PicTableViewCell.h"

#import "ButtonClickCell.h"
#import "CellDetaiViewController.h"

#import "DisDetailViewController.h"

#import "DiscoverModel.h"

@interface DiscoverViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate> {
    UITableView *_tableView;
   
    //下方cell的数据源
    NSMutableArray *_dataSource;
    
    //button的数据源
    NSMutableArray *_buttonSource;
    
    
    
}

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UILabel *_title123 = [[UILabel alloc] init];
    _title123.text = @"广场";
    _title123.textColor = [UIColor whiteColor];
    _title123.frame = CGRectMake(30, 30, 30, 30);
    self.navigationItem.titleView = _title123;
    
    
    _dataSource = [[NSMutableArray alloc] init];
    self.view.backgroundColor = FBaseColor;

    
    [self createTableView];
    [self loadDataFromNet];
}

- (void)loadDataFromNet {

    NSString *url = [NSString stringWithFormat:@"http://open3.bantangapp.com/community/post/communityHome?app_installtime=1452331892.334167&app_versions=5.3&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&device_token=fcd81a592076bcf8880783024f734f690128cf6722f1f54883a256273364722d&oauth_token=363cac3679a227d4dbad03f828aefa2b&os_versions=9.2&screensize=750&track_deviceid=B884FCB9-2C81-448D-82F4-A28AC8CE7034&track_user_id=1769058&v=10"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        DiscoverModel *_model = [[DiscoverModel alloc] initWithDictionary:dict error:nil];
        
        _dataSource = _model.data.rec_groups;
        _buttonSource = _model.data.module_elements;
        
        [_tableView reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
    
}


- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-FNavigationHeight-FTabBarHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:_tableView];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return FScreenWidth/2+50;
    }else{
    return FScreenWidth/2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row == 0 ){
        static NSString *identifier = @"cellID";
        ButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[ButtonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
    
        cell.BtnClickedBlock = ^(NSString *btnid, NSString *btnType, NSString *tagid){
            DisDetailViewController *ddvc = [DisDetailViewController new];
            ddvc.elementID = btnid;
            ddvc.IntoType = btnType;
            ddvc.tagID = tagid;
            [self.navigationController pushViewController:ddvc animated:YES];
            self.hidesBottomBarWhenPushed;
        };
        
        [cell updateWithModel:_buttonSource];
        return cell;
    }
   
    if(indexPath.row != 0 ){
        static NSString *identifier1 = @"cellID1";
        PicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (cell == nil) {
            cell = [[PicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
        }
        
        cell.model = _dataSource[indexPath.row];
    
        
        return cell;
    }
    
    
    static NSString *identifier2 = @"cellID2";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier2];
    }
    return cell;
}
//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSLog(@"点击了%ld",(long)indexPath.row);
    
//   DisDetailViewController *ddvc = [[DisDetailViewController alloc] init];  
//   [self.navigationController pushViewController:ddvc animated:YES];
    
    CellDetaiViewController *cdvc = [[CellDetaiViewController alloc] init];
    cdvc.hidesBottomBarWhenPushed = YES;
    
    RecGroupsModel *model1234 = _dataSource[indexPath.row];
    
    cdvc.groupid = model1234.id;
    
   
    [self.navigationController pushViewController:cdvc animated:YES];
         self.hidesBottomBarWhenPushed;
    
    
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
