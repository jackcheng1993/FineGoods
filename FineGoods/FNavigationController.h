//
//  LNavigationController.h
//  FineGoods
//
//  Created by qianfeng on 16/1/10.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+ChangeNavigationBar.h"
typedef void(^ChangeTransparencyBlock)(CGFloat);

//typedef NS_ENUM(NSInteger, PageType) {
//    PageTypeHome = 0,
//    PageTypeSecond,
//};

@interface FNavigationController : UINavigationController <ChangeNavigationBarDelegate>
@property (nonatomic, copy) ChangeTransparencyBlock changeTansparencyBlock;

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController type:(NSString *)type;// changeTransparencyBlock:(ChangeTransparencyBlock)changeTransparencyBlock;
@end
