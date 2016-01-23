//
//  NowTalkViewController.m
//  FineGoods
//
//  Created by qianfeng on 16/1/12.
//  Copyright © 2016年 Aili. All rights reserved.
//


#import "NowTalkViewController.h"
#import "MyTableViewCell.h"
#import "Define.h"
#import "NowTalkViewModel.h"
#import "TabelViewModel.h"
//#import "NowTalkModel.h"
#import "NetWorkingManager.h"
@interface NowTalkViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UILabel *joinCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImaheView;
@property (weak, nonatomic) IBOutlet UILabel *timelabel;
@property (weak, nonatomic) IBOutlet UIView *rank_listView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UITableView *tabelView;
@property (nonatomic, copy) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UIImageView *firstIconView;

@property (nonatomic, copy) NSArray *rank_ListmodelArray;
@end

@implementation NowTalkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    _dataArray = [NSMutableArray new];
    _rank_ListmodelArray = [NSArray new];
    _tabelView.dataSource = self;
    _tabelView.delegate =self;
    [self setUIWithNet];
    [self setTabelViewWithNet];
    
}
- (void)setTabelViewWithNet {
    NSString *url_info = @"http://open3.bantangapp.com/community/subject/listPost?";
    NSDictionary *dic = @{@"app_installtime":@"1452331892.334167",@"app_versions":@"5.3",@"channel_name":@"appStore",@"client_id":@"bt_app_ios",@"client_secret":@"9c1e6634ce1c5098e056628cd66a17a5",@"device_token":@"fcd81a592076bcf8880783024f734f690128cf6722f1f54883a256273364722d",@"oauth_token":@"c63d2a3db13582fd2674d71641c56a06",@"os_versions":@"9.2",@"screensize":@"750",@"subject_id":self.extend,@"track_device_info":@"iPhone7%2C2",@"track_deviceid":@"B884FCB9-2C81-448D-82F4-A28AC8CE7034",@"track_user_id":@"1769058",@"v":@"10",@"page":@"0",@"pagesize":@"10"};
    [NetWorkingManager postRequestWithUrl:url_info parameters:dic pageType:nil successBlock:^(id object) {
        NSDictionary *dict = (NSDictionary *)object;
        
        TabelViewModel *model = [[TabelViewModel alloc]initWithDictionary:dict error:nil];
        
        [_dataArray setArray:model.data.list];
        [_tabelView reloadData];
        
    } failBlock:^(NSError *error) {
        
        
    }];

}

- (void)setUIWithNet {
    //_iconImaheView.layer.cornerRadius = 30/2;
    //_contentLabel.textAlignment = NSTextAlignmentJustified;
    
    
    NSString *url_info = @"http://open3.bantangapp.com/community/subject/info?";
    NSDictionary *dic = @{@"app_installtime":@"1452331892.334167",@"app_versions":@"5.3",@"channel_name":@"appStore",@"client_id":@"bt_app_ios",@"client_secret":@"9c1e6634ce1c5098e056628cd66a17a5",@"device_token":@"fcd81a592076bcf8880783024f734f690128cf6722f1f54883a256273364722d",@"oauth_token":@"c63d2a3db13582fd2674d71641c56a06",@"os_versions":@"9.2",@"screensize":@"750",@"subject_id":self.extend,@"track_device_info":@"iPhone7%2C2",@"track_deviceid":@"B884FCB9-2C81-448D-82F4-A28AC8CE7034",@"track_user_id":@"1769058",@"v":@"10"};
    [NetWorkingManager postRequestWithUrl:url_info parameters:dic pageType:nil successBlock:^(id object) {
        
        NSDictionary *dict = (NSDictionary*)object;
       // NSDictionary *subDic = dict[@"data"][@"subject"];
        NowTalkViewModel *model = [[NowTalkViewModel alloc]initWithDictionary:dict error:nil];
        
        
        [_topImageView sd_setImageWithURL:[NSURL URLWithString:model.data.subject.pic2]];
        
        _joinCountLabel.text = [NSString stringWithFormat:@"%@人参加",model.data.subject.dynamic.part_in_num];
       
        [_iconImaheView sd_setImageWithURL:[NSURL URLWithString:model.data.subject.author.avatar]];
        
        _timelabel.text = model.data.subject.datestr;
        _contentLabel.text = model.data.subject.description_read ;
        _rank_ListmodelArray = model.data.subject.dynamic.rank_list;
        [self setRank_listViewWithArray:_rank_ListmodelArray];
    } failBlock:^(NSError *error) {
        
        
    }];
}
- (void)setRank_listViewWithArray:(NSArray *)array {
    
    CGFloat width = 30;
    CGFloat height = 30;
    CGFloat padding = (self.rank_listView.frame.size.width - 5*width)/5;
    NSLog(@"%f",padding);
    for (NSInteger i = 0; i<(array.count<6?array.count:6); i++) {
        Rank_Listmodel *model = array[i];
        
        if (i == 0) {
            
            [_firstIconView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
        }else {
            
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(padding/2+(padding+width)*(i - 1), 5, width, height)];
            imgView.layer.cornerRadius = 15;
            
            imgView.layer.masksToBounds = YES;
            [imgView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
            [_rank_listView addSubview:imgView];
        }
        
    }
}
- (IBAction)rank_listAction:(id)sender {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (void)createTableView{
//    
//    if (_tabelView == nil) {
//        _tabelView = [[UITableView alloc] initWithFrame:self.view.bounds];
//        _tabelView.delegate = self;
//        _tabelView.dataSource = self;
//        [self.view addSubview:_tabelView];
//    }
//    
//    
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"identifier";
    MyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[MyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    List_Model *modle = _dataArray[indexPath.row] ;
    [cell setCellWithModel:modle];
    
    
    
    return cell;
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
