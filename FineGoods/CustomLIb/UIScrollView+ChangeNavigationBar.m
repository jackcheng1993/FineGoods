//
//  UIScrollView+ChangeNavigationBar.m
//  FineGoods
//
//  Created by qianfeng on 16/1/10.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "UIScrollView+ChangeNavigationBar.h"
#import <objc/runtime.h>

static char UIScrollVIewNavigation;

@interface UIScrollView ()<UIScrollViewDelegate>


@end


@implementation UIScrollView (ChangeNavigationBar)

@dynamic NDelegate;


- (void)setNDelegate:(id<ChangeNavigationBarDelegate>)NDelegate {
   
    objc_setAssociatedObject(self, &UIScrollVIewNavigation, NDelegate, OBJC_ASSOCIATION_ASSIGN);
    
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    
    
}

//- (void)dealloc {
//    
//}

- (id<ChangeNavigationBarDelegate>)NDelegate {
    return objc_getAssociatedObject(self, &UIScrollVIewNavigation);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    [self scrollViewDidScroll:self];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGPoint offSet = scrollView.contentOffset;
    if (offSet.y < 200) {
        CGFloat alpha = offSet.y/200*1.0;
        if (self.NDelegate&&[self.NDelegate respondsToSelector:@selector(changeTransparency:)]) {
            [self.NDelegate changeTransparency:alpha];
        }
    }else {
        if (self.NDelegate&&[self.NDelegate respondsToSelector:@selector(changeTransparency:)]) {
            [self.NDelegate changeTransparency:1];
        }
    }

}

@end
