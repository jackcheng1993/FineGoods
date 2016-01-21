//
//  NewUserGuideController.m
//  FineGoods
//
//  Created by qianfeng on 16/1/13.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "NewUserGuideController.h"
#import <CoreGraphics/CoreGraphics.h>

@interface NewUserGuideController ()

@end

@implementation NewUserGuideController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self newUserGuide];
}

- (void)newUserGuide {
    CGRect frame = [UIScreen mainScreen].bounds;
    UIView *bgView  = [[UIView alloc]initWithFrame:frame];
    bgView.backgroundColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:52/255.0 alpha:0.8];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(guideSureClick:)];
    [bgView addGestureRecognizer:tap];
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    
    //添加第一个路径
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:frame];
    [path appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(frame.size.width-30, 42) radius:30 startAngle:0 endAngle:2*M_PI clockwise:NO]];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    [bgView.layer setMask:shapeLayer];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-300, 72, 270, 137)];
    imageView.image = [UIImage imageNamed:@"Fplaceholder"];
    [bgView addSubview:imageView];
    
}

- (void)guideSureClick:(UITapGestureRecognizer *)gesture {
    UIView *view = gesture.view;
    [view removeFromSuperview];
   // [view removeAllSubviews];
    [view removeGestureRecognizer:gesture];
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
