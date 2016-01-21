//
//  BaseViewController.m
//  FineGoods
//
//  Created by qianfeng on 16/1/12.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUINavigationBar];
    [self setRightBarButtonItemWithType:_extend];
}
- (void)setRightBarButtonItemWithType:(NSString *)type {
    if ([_extend isEqualToString:@"114"]||[_extend isEqualToString:@"110"]||[_extend isEqualToString:@"68"]) {
        
        UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 10, 22, 22)];
        [rightBtn setImage:[UIImage imageNamed:@"btn_share"] forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    }
}
- (void)setUINavigationBar {
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 10, 10, 20)];
    [backBtn setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    title.text = _nTitle;
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)shareAction {
    
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
