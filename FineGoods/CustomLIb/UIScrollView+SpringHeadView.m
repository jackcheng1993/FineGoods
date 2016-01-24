//
//  UIScrollView+SpringHeadView.m
//  FineGoods
//
//  Created by qianfeng on 16/1/21.
//  Copyright © 2016年 Aili. All rights reserved.
//

#define ChangeValue @"SpringHeadView"

#import "UIScrollView+SpringHeadView.h"
#import <objc/Object.h>


static char UIScrollViewSpringHeadView;
@implementation UIScrollView (SpringHeadView)

- (void)setTopView:(UIView *)topView {
    [self willChangeValueForKey:ChangeValue];
    objc_setAssociatedObject(self, &UIScrollViewSpringHeadView, topView, OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:ChangeValue];
}

- (UIView *)topView {
    return objc_getAssociatedObject(self, &UIScrollViewSpringHeadView);
}

- (void)addSpringHeadView:(UIView *)view{
    self.contentInset = UIEdgeInsetsMake(view.bounds.size.height, 0, 0, 0);
    // self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self addSubview:view];
    view.frame = CGRectMake(0, -view.bounds.size.height, view.bounds.size.width, view.bounds.size.height);
    self.topView = view;
    //使用kvo监听scrollView的滚动
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self scrollViewDidScroll:self];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offy = scrollView.contentOffset.y;
    
    if (offy < 0) {
        self.topView.frame = CGRectMake(0, offy, self.topView.bounds.size.width, -offy);
    }
}


@end
