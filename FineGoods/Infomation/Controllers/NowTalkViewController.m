//
//  NowTalkViewController.m
//  FineGoods
//
//  Created by qianfeng on 16/1/12.
//  Copyright © 2016年 Aili. All rights reserved.
//


#import "NowTalkViewController.h"
#import "Define.h"
#import "NetWorkingManager.h"
@interface NowTalkViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UILabel *joinCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImaheView;
@property (weak, nonatomic) IBOutlet UILabel *timelabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation NowTalkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    NSString *url_info = @"http://open3.bantangapp.com/community/subject/info?";
    NSDictionary *dic = @{@"app_installtime":@"1452331892.334167",@"app_versions":@"5.3",@"channel_name":@"appStore",@"client_id":@"bt_app_ios",@"client_secret":@"9c1e6634ce1c5098e056628cd66a17a5",@"device_token":@"fcd81a592076bcf8880783024f734f690128cf6722f1f54883a256273364722d",@"oauth_token":@"c63d2a3db13582fd2674d71641c56a06",@"os_versions":@"9.2",@"screensize":@"750",@"subject_id":self.extend,@"track_device_info":@"iPhone7%2C2",@"track_deviceid":@"B884FCB9-2C81-448D-82F4-A28AC8CE7034",@"track_user_id":@"1769058",@"v":@"10"};
    [NetWorkingManager postRequestWithUrl:url_info parameters:dic pageType:nil successBlock:^(id object) {
        
        NSDictionary *dict = (NSDictionary*)object;
        
        [_topImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"data"][@"subject"][@"pic2"]]];
        _joinCountLabel.text = [NSString stringWithFormat:@"%@人参加",dict[@"data"][@"subject"][@"dynamic"][@"part_in_num"]];
        [_iconImaheView sd_setImageWithURL:[NSURL URLWithString:dict[@"data"][@"subject"][@"author"][@"avatar"]]];
        _timelabel.text = dict[@"data"][@"subject"][@"datestr"];
        _contentLabel.text = dict[@"data"][@"subject"][@"description"] ;
    } failBlock:^(NSError *error) {
        
        
    }];
    
    
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
