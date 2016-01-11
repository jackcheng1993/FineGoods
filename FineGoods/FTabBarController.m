//
//  FTabBarController.m
//  FineGoods
//
//  Created by qianfeng on 16/1/10.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "FTabBarController.h"
#import "HomeViewController.h"
#import "DiscoverViewController.h"
#import "PhotoViewController.h"
#import "MessageViewController.h"
#import "UserViewController.h"
#import "Define.h"

@interface FTabBarController ()<UITabBarDelegate>

@end

@implementation FTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createControllers];
}

- (void)createControllers {
    self.tabBar.translucent = NO;
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"controllers" ofType:@"plist"];
    NSArray *vcArray = [NSArray arrayWithContentsOfFile:plistPath];
    
    NSMutableArray *mutableArray = [NSMutableArray new];
    for (NSInteger i = 0; i<vcArray.count; i++) {
        NSDictionary *dict = vcArray[i];
        Class className = NSClassFromString(dict[@"className"]);
        UIViewController *viewContr = [className new];
        FNavigationController *fNavigation = [[FNavigationController alloc] initWithRootViewController:viewContr type:dict[@"className"]];
        fNavigation.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 5, -5, -5);
        fNavigation.tabBarItem.image = [UIImage imageNamed:dict[@"iconName"]];
        fNavigation.tabBarItem.selectedImage = [UIImage imageNamed:dict[@"selectedImage"]];
        fNavigation.tabBarItem.tag = 100+i;
        [mutableArray addObject:fNavigation];
    }
    self.viewControllers = mutableArray;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSLog(@"%ld",item.tag);
    if (item.tag == 102) {
        NSLog(@"itemtest");
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
