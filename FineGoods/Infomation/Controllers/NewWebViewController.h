//
//  NewWebViewController.h
//  FineGoods
//
//  Created by qianfeng on 16/1/23.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>
@interface NewWebViewController : BaseViewController
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, strong) WKWebView *webView;
- (instancetype)initWithUrlString:(NSString *)urlString;
@end
