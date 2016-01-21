//
//  TopWindow.m
//  FineGoods
//
//  Created by qianfeng on 16/1/14.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "TopWindow.h"
#import <UIKit/UIKit.h>
static UIWindow *window_;

@implementation TopWindow;

//初始化window



+ (void)initialize {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        window_ = [[UIWindow alloc] init];
        window_.windowLevel = UIWindowLevelAlert;
        window_.frame = [UIApplication sharedApplication].statusBarFrame;
        window_.backgroundColor = [UIColor clearColor];
        window_.hidden = NO;
        [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
    });
}
+ (void)show {
    window_.hidden = NO;
}
+ (void)hide {
    window_.hidden = YES;
}
// 监听窗口点击
+ (void)windowClick {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}
+ (void)searchScrollViewInView:(UIView *)superview {
    for (UIScrollView *subview in superview.subviews) {
        // 如果是scrollview, 滚动最顶部
        if ([subview isKindOfClass:[UIScrollView class]] && [self isShowingOnKeyWindow:subview]) {
            CGPoint offset = subview.contentOffset;
            offset.y = - subview.contentInset.top;
            [subview setContentOffset:offset animated:YES];
        }
        // 递归继续查找子控件
        [self searchScrollViewInView:subview];
    }
}
+ (BOOL)isShowingOnKeyWindow:(UIView *)view {
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:view.frame fromView:view.superview];
    CGRect winBounds = keyWindow.bounds;
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    return !view.isHidden && view.alpha > 0.01 && view.window == keyWindow && intersects;
}@end
