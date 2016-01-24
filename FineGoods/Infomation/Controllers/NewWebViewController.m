//
//  NewWebViewController.m
//  FineGoods
//
//  Created by qianfeng on 16/1/23.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "NewWebViewController.h"
#import "Define.h"
@interface NewWebViewController ()

@end

@implementation NewWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     [self.view addSubview:self.webView];
}
- (void)viewWillAppear:(BOOL)animated {
//    self.navigationController.navigationBar.hidden = NO;
//    self.navigationController.navigationBar.alpha = 1.0;
    
    
}


- (instancetype)initWithUrlString:(NSString *)urlString {
    self = [super init];
    if (self) {
        _urlString = urlString;
    }
    return self;
}

- (WKWebView *)webView {
    if (_webView == nil) {
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0,0, FScreenWidth, FScreenHeight - FNavigationHeight)];
        _webView.navigationDelegate = self;
        NSURL *url = [NSURL URLWithString:_urlString];
        NSURLRequest *urlRequest = [[NSURLRequest alloc]initWithURL:url];
        
        [_webView loadRequest:urlRequest];
    }
    return _webView;
}
- (void)back {
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }else {
        
        //self.tabBarController.tabBar.hidden = NO;
        
       // self.hidesBottomBarWhenPushed = YES;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)foreCliked {
    if (self.webView.canGoForward) {
        [self.webView goForward];
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
