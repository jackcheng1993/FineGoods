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
#define  FBaseColor [UIColor colorWithRed:1.0 green:83/255.0 blue:77/255.0 alpha:1.0]


#pragma mark - 第三方库
#import <AFNetworking/AFNetworking.h>
#import <MJRefresh/MJRefresh.h>
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>
#import "Masonry.h"  //约束
#import "HYBLoopScrollView.h" //滚动视图


#pragma mark - 自己封装的类
#import "FNavigationController.h"
#import "UIScrollView+ChangeNavigationBar.h"

#pragma mark - 页面类型
#define FHomePage @"homePage"


#pragma mark - 请求Url
//最新页面数据 GET
#define FHomeUrl @"http://open3.bantangapp.com/recommend/index?app_installtime=1452331892.334167&app_versions=5.3&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&device_token=fcd81a592076bcf8880783024f734f690128cf6722f1f54883a256273364722d&oauth_token=a685e481eb1d56727a9c8503ae879781&os_versions=9.2&page=%ld&pagesize=20&screensize=750&track_deviceid=B884FCB9-2C81-448D-82F4-A28AC8CE7034&track_user_id=1769058&v=10"

//#define FHomeUrl  @"http://open3.bantangapp.com/topic/list?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&page=%ld&pagesize=20&scene=3&track_deviceid=D500D036-1242-41A1-9F50-5D8F0789DD32&track_user_id=1768988"
//除了最新页面 其它页面数据 POST
#define FHomeCommonUrl @"http://open3.bantangapp.com/topic/list?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&scene=%@"
//拼接图片
#define FHomeDetailImageUrl @"http://bt.img.17gwx.com/%@"

#define FHomeDetailUrl @"http://open3.bantangapp.com/topic/newInfo?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&id=%@&track_deviceid=D500D036-1242-41A1-9F50-5D8F0789DD32&track_user_id=1768988"

#define FHomeBannerTopicUrl @"http://open3.bantangapp.com/topic/list?app_installtime=1453098684.851776&app_versions=5.3.1&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&ids=%@&oauth_token=58382b7fee3ae4f3eb65b33abdd7b276&os_versions=9.2&page=0&pagesize=20&screensize=640&track_deviceid=46EC3054-4CEB-4997-8956-173FD8FFD0F3&track_user_id=1807119"

#define FHomeBannerProductUrl @"http://open3.bantangapp.com/product/list?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&oauth_token=58382b7fee3ae4f3eb65b33abdd7b276&page=0&pagesize=20&track_deviceid=46EC3054-4CEB-4997-8956-173FD8FFD0F3&track_user_id=1807119&v=10&ids=%@"

#endif /* Define_h */
