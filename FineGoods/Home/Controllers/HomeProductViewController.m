//
//  HomeProductViewController.m
//  FineGoods
//
//  Created by qianfeng on 16/1/18.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "HomeProductViewController.h"
#import <WebKit/WebKit.h>

@interface HomeProductViewController ()<WKNavigationDelegate>
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation HomeProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (instancetype)initWithUrlString:(NSString *)urlString {
    self = [super init];
    if (self) {
        _urlString = urlString;
    }
    return self;
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
