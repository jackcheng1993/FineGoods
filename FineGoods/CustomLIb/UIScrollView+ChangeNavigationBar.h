//
//  UIScrollView+ChangeNavigationBar.h
//  FineGoods
//
//  Created by qianfeng on 16/1/10.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChangeNavigationBarDelegate <NSObject>

- (void)changeTransparency:(CGFloat)alpha;

@end

@interface UIScrollView (ChangeNavigationBar)


@property (nonatomic, weak) id<ChangeNavigationBarDelegate> NDelegate;


//- (void)setNDelegate:(id<ChangeNavigationBarDelegate> _Nullable)NDelegate;

//- (void)setSDelegate:(id<ChangeNavigationBarDelegate> _Nullable)SDelegate;

@end
