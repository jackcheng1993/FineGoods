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
    self.view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.webView];
    [self setUpNavigationItem];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.alpha = 1.0;
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
        _webView = [[WKWebView alloc]initWithFrame:self.view.bounds];
        _webView.navigationDelegate = self;
        NSURL *url = [NSURL URLWithString:_urlString];
        NSURLRequest *urlRequest = [[NSURLRequest alloc]initWithURL:url];
        [_webView loadRequest:urlRequest];
    }
    return _webView;
}

- (void)setUpNavigationItem {
    self.navigationItem.hidesBackButton = YES;
    
    NSMutableArray *items = [NSMutableArray new];
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    backButton.imageEdgeInsets = UIEdgeInsetsMake(8, 10, 8, 10);
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backCliked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    [items addObject:backItem];
    
    UIButton *foreButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    foreButton.imageEdgeInsets = UIEdgeInsetsMake(8, 10, 8, 10);
    [foreButton setImage:[UIImage imageNamed:@"goForward"] forState:UIControlStateNormal];
    [foreButton addTarget:self action:@selector(foreCliked) forControlEvents:UIControlEventTouchUpInside];
     UIBarButtonItem * foreItem = [[UIBarButtonItem alloc]initWithCustomView:foreButton];
    [items addObject:foreItem];
    
    self.navigationItem.leftBarButtonItems = items;
}

- (void)backCliked {
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }else {
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
