//
//  HomeViewController.h
//  FineGoods
//
//  Created by qianfeng on 16/1/10.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^InitLoopDataBlock)(NSArray *loopData);

@interface HomeViewController : UIViewController

//用于保存点击图片 用于转场动画
@property (nonatomic,strong) UIImageView *iconImageView;

@property (nonatomic,copy) InitLoopDataBlock loopData;

- (void)updateLoopData:(NSArray *)loopData;

@end
