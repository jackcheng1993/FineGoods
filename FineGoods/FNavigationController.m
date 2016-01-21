//
//  LNavigationController.m
//  FineGoods
//
//  Created by qianfeng on 16/1/10.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "FNavigationController.h"


@interface FNavigationController () {
    CGFloat _prevAlpha;
}

@end

@implementation FNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController type:(NSString *)type  {
   // self.view.userInteractionEnabled = YES;
    _prevAlpha = 1;
    //if (self = [super initWithRootViewController:rootViewController]) {
        if (self = [super initWithRootViewController:rootViewController]) {
            //self.navigationBar.backgroundColor =
            
            self.navigationBar.barTintColor = [UIColor colorWithRed:255.0/255 green:83.0/255 blue:77.0/255 alpha:1];
            [self customNavigationBar:type];
            self.navigationBar.translucent = NO;
        }
    //}
    return self;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = touches.anyObject;
    CGPoint touchPoint = [touch locationInView:self.view];
    if (touchPoint.y <= 20) {
        [self scrollToTop:self.scrollView];
    }
}

- (void)scrollToTop:(UIScrollView *)scrollView {
    //self.scrollView  = scrollView;
    CGFloat offsetY = scrollView.contentOffset.y;
    offsetY = 0;
    scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
}


//- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
//    if (self = [super initWithRootViewController:rootViewController]) {
//        self.navigationController.view.alpha = 0;
//        self.navigationBar.alpha = 0;
//        self.navigationBar.backgroundColor = [UIColor colorWithRed:251.0/255 green:51.0/255 blue:61.0/255 alpha:1];
//        
//    }
//    return self;
//}

- (void)customNavigationBar:(NSString *)type {
    
    UIViewController *controlller = self.childViewControllers[0];
    
    if ([type isEqualToString:@"HomeViewController"]) {
        _prevAlpha = 0;
        self.navigationController.view.alpha = 0;
        self.navigationBar.alpha = 0;
        //controlller.navigationController.view.alpha = 0;
        controlller.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchAction)];
        controlller.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"searchUser"] style:UIBarButtonItemStylePlain target:self action:@selector(searchUserAction)];
        
    }
    if ([type isEqualToString:@"DiscoverViewController"]) {
        
    }
    if ([type isEqualToString:@"MessageViewController"]) {
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 44, 100)];
        title.text = @"消息";
        title.textColor = [UIColor whiteColor];
        controlller.navigationItem.titleView = title;
        
    }
    if ([type isEqualToString:@"UserViewController"]) {
        
    }
}

- (void)changeTransparency:(CGFloat)alpha {
   // self.navigationBar.alpha = alpha;
    self.navigationBar.alpha = alpha;
    _prevAlpha = alpha;
    UIViewController *controlller = self.childViewControllers[0];
    controlller.navigationController.navigationBar.translucent = YES;
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    self.navigationBar.alpha = _prevAlpha;
//    UIViewController *controlller = self.childViewControllers[0];
//    //controlller.navigationController.navigationBar.translucent = YES;
//    controlller.navigationController.navigationBar.alpha = _prevAlpha;
    
    NSLog(@"%lf",_prevAlpha);
}

- (void)searchAction {
    NSLog(@"testLeft");
    //self pushViewController:<#(nonnull UIViewController *)#> animated:<#(BOOL)#>
}

- (void)searchUserAction {
    NSLog(@"testRight");
//    self pushViewController:<#(nonnull UIViewController *)#> animated:<#(BOOL)#>
}

//- (void)

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
