//
//  MessageViewController.m
//  FineGoods
//
//  Created by qianfeng on 16/1/10.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "MessageViewController.h"
#import "NewPushViewController.h"
#import "LoveHomeViewController.h"
#import "Define.h"
#import "MessageCell.h"
#import "MessageModel.h"
#import "NetWorkingManager.h"
@interface MessageViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    NSArray *_array;
    NSMutableArray *_elementArray;
    NSInteger _isFirst;
}

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _array = @[@"新的粉丝",@"新的评论",@"新的奖励",@"新的通知",@"新的喜欢"];
    _elementArray = [NSMutableArray new];
    _dataArray = [NSMutableArray new];
    [_dataArray addObject:_array];
    _isFirst = 0;
    [self setUINavigationBar];
    
    [self fetNetWork];
}
//导航栏设置
- (void)setUINavigationBar {
    }
//请求网络数据
- (void)fetNetWork {
    NSString *urlString = @"http://open3.bantangapp.com/users/notice/redSpot?";
    NSDictionary *dic = @{@"app_installtime":@"1452331892.334167",@"app_versions":@"5.3",@"channel_name":@"appStore",@"client_id":@"bt_app_ios",@"client_secret":@"9c1e6634ce1c5098e056628cd66a17a5",@"device_token":@"fcd81a592076bcf8880783024f734f690128cf6722f1f54883a256273364722d",@"oauth_token":@"c63d2a3db13582fd2674d71641c56a06",@"os_versions":@"9.2",@"screensize":@"750",@"track_device_info":@"iPhone7%2C2",@"track_deviceid":@"B884FCB9-2C81-448D-82F4-A28AC8CE7034",@"track_user_id":@"1769058",@"type":@"1",@"v":@"10"};
    [NetWorkingManager postRequestWithUrl:urlString parameters:dic pageType:nil successBlock:^(id object) {
        
        NSDictionary *dict = (NSDictionary *)object;
        NSArray *eleArray = dict[@"data"][@"element"];
        for (NSDictionary *dic in eleArray) {
          MessageModel *model = [[MessageModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
            [_elementArray addObject:model];
            
        }
        
        
        [_dataArray addObject:_elementArray];
        [self createTableView];
        
    } failBlock:^(NSError *error) {
        
        
    }];

}
//创建UITableView
- (void)createTableView{
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.separatorColor = [UIColor whiteColor];
        [self.view addSubview:_tableView];
    }
    
    
}
#define  mark-UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray[section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        static NSString *identifier=@"imagecellID";
   
    if (indexPath.section == 0) {
        identifier = @"cellID";
    }else {
        identifier=@"imagecellID";
    }
    MessageCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[MessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier index:indexPath.section];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 1) {
      MessageModel *model = _dataArray[indexPath.section][indexPath.row];
    
    [cell setModel:model];  
        
    }else if (indexPath.section == 0){
        
      //  cell.textLabel.text = _dataArray[indexPath.section][indexPath.row];
        [cell setLabelName:_dataArray[indexPath.section][indexPath.row]];
    }
    
    
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 44;
    if (1 == indexPath.section) {
        
        height = 180;
    }
    return height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        NewPushViewController *nVC = [NewPushViewController new];
        nVC.Ntitle = _dataArray[indexPath.section][indexPath.row];
        [self.navigationController pushViewController:nVC animated:YES];
        //[self presentViewController:nVC animated:YES completion:nil];
    }else if (1 == indexPath.section){
        MessageModel *model = _dataArray[indexPath.section][indexPath.row];
        if ([model.extend isEqualToString:@"835"]) {
            
            LoveHomeViewController *lHVC = [LoveHomeViewController new];
            lHVC.tag_id = model.extend;
            [self.navigationController pushViewController:lHVC animated:YES];
            //[self presentViewController:lHVC animated:YES completion:nil];
        }else{
            
            
        }
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
