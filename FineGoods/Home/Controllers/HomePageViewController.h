//
//  HomePageViewController.h
//  FineGoods
//
//  Created by qianfeng on 16/1/12.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define.h"

@protocol HomePageViewControllerDelegate <NSObject>

- (void)changeTitleScllorViewY:(CGFloat)offsetY;

- (void)pushDetailController:(UIViewController *)viewController;

@end


@interface HomePageViewController : UITableViewController

//用于保存点击图片 用于转场动画
@property (nonatomic,strong) UIImageView *iconImageView;

@property (nonatomic,copy) NSString *sence;

@property (nonatomic,copy) NSString *requestUrl;

@property (nonatomic,weak) id<HomePageViewControllerDelegate> delegate;

- (void)fetchDataFromNet:(BOOL)isMore withRefreshHeader:(MJRefreshHeader *)refreshHeader;

@end
