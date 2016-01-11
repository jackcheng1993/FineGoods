//
//  Define.h
//  FineGoods
//
//  Created by qianfeng on 16/1/10.
//  Copyright © 2016年 Aili. All rights reserved.
//

#ifndef Define_h
#define Define_h

#pragma mark - 宏定义
#define  FNavigationHeight 64
#define  FTabBarHeight 49
#define  FScreenWidth [UIScreen mainScreen].bounds.size.width
#define  FScreenHeight [UIScreen mainScreen].bounds.size.height

#pragma mark - 第三方库
#import <AFNetworking/AFNetworking.h>
#import <MJRefresh/MJRefresh.h>
#import <UIImageView+WebCache.h>
#import "Masonry.h"  //约束
#import "HYBLoopScrollView.h" //滚动视图

#pragma mark - 页面类型
#define FHomePage @"homePage"


#pragma mark - 请求Url
#define FHomeUrl @"http://open3.bantangapp.com/recommend/index?app_installtime=1452331892.334167&app_versions=5.3&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&device_token=fcd81a592076bcf8880783024f734f690128cf6722f1f54883a256273364722d&oauth_token=a685e481eb1d56727a9c8503ae879781&os_versions=9.2&page=%ld&pagesize=20&screensize=750&track_device_info=iPhone7%2C2&track_deviceid=B884FCB9-2C81-448D-82F4-A28AC8CE7034&track_user_id=1769058&v=10"

#endif /* Define_h */
