//
//  HomeDetailViewController.h
//  FineGoods
//
//  Created by qianfeng on 16/1/14.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeDetailViewController : UIViewController<UINavigationControllerDelegate>
@property (nonatomic,strong) UIImageView *iconView;

@property (nonatomic,strong) UIImage *image;

@property (nonatomic,assign) CGFloat naviAlpha;

@property (nonatomic, copy) NSString *newsInfoId;
@end
