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

@interface FTabBarController ()

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
        viewContr.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 5, -5, -5);
        viewContr.tabBarItem.image = [UIImage imageNamed:dict[@"iconName"]];
        viewContr.tabBarItem.selectedImage = [UIImage imageNamed:dict[@"selectedImage"]];
        [mutableArray addObject:viewContr];
    }
    self.viewControllers = mutableArray;
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
