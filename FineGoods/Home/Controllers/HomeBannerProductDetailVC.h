//
//  HomeBannerProductDetailVC.h
//  FineGoods
//
//  Created by qianfeng on 16/1/23.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeBannerProductDetailVC : UIViewController
@property (nonatomic, copy)NSString *urlString;
@property (nonatomic, copy)NSString *newsId;

- (instancetype)initWithNewID:(NSString *)newsId;

@end
