//
//  HomeBannerViewController.h
//  FineGoods
//
//  Created by qianfeng on 16/1/22.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeBannerViewController : UIViewController
@property (nonatomic, copy)NSString *extends;
@property (nonatomic, strong) UIImageView *iconImageView;

- (instancetype)initWithType:(NSString *)type;
@end
