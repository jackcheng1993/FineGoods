//
//  UIScrollView+SpringHeadView.h
//  FineGoods
//
//  Created by qianfeng on 16/1/21.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import <UIKit/UIKit.h>

//headView 的高度
#define SpringHeadViewHeight 200

@interface UIScrollView (SpringHeadView)<UIScrollViewDelegate>

//在分类增加了属性，这个是利用runtime实现的
@property (nonatomic, weak) UIView *topView;
- (void)addSpringHeadView:(UIView *)view;

@end
