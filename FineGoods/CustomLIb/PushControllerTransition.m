//
//  PushControllerTransition.m
//  FineGoods
//
//  Created by qianfeng on 16/1/14.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "PushControllerTransition.h"
#import "HomeViewController.h"
#import "HomeDetailViewController.h"
#import "Define.h"

@interface PushControllerTransition ()

@property (nonatomic ,assign) FControllerTransitionType transitionType;

@property (nonatomic, assign) NSTimeInterval duration;

@end

@implementation PushControllerTransition

- (instancetype)init {
    if (self = [super init]) {
        //默认push模式
        self.transitionType = FControllerTransitionTypePush;
    }
    return self;
}

+ (instancetype)transitionWithType:(FControllerTransitionType)transitionType duration:(NSTimeInterval)duration {
    PushControllerTransition *transition = [[PushControllerTransition alloc]init];
    transition.transitionType = transitionType;
    transition.duration = duration;
    return transition;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (self.transitionType) {
        case FControllerTransitionTypePush:
            [self push:transitionContext];
            break;
            case FControllerTransitionTypePop:
            [self pop:transitionContext];
            break;
            
        default:
            break;
    }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.duration;
}

- (void)animationEnded:(BOOL)transitionCompleted {
    NSLog(@"%s",__func__);
}

#pragma mark - Private
- (void)push:(id<UIViewControllerContextTransitioning>)transitionContext {
    HomeViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //if([fromVC isKindOfClass:[HomeViewController class]]) {
        HomeDetailViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
     //   HomeViewController *fromVC = (HomeViewController *)fromVC;
        UIView *containerView = [transitionContext containerView];
        UIView *fromImageVIew = fromVC.iconImageView;
        UIView *tempView = [fromImageVIew snapshotViewAfterScreenUpdates:NO];
        // tempView.frame = [fromImageVIew convertRect:fromImageVIew.bounds toView:containerView];
        tempView.frame = [fromImageVIew convertRect:CGRectMake(0,FScreenHeight/2 , fromImageVIew.bounds.size.width,fromImageVIew.bounds.size.height) toView:containerView];
        //    //查看contrainer 上面的视图
        //    for (UIView *view in containerView.subviews) {
        //        NSLog(@"%@",view);
        //        if (fromVC.view == view) {
        //            NSLog(@"YES");
        //        }
        //    }
        UIView *toImageView = toVc.iconView;
        
        fromImageVIew.hidden = YES;
        toVc.view.alpha = 0.0;
        toImageView.hidden = YES;
        //把 toVc.view 置顶
        // [containerView insertSubview:toVc.view atIndex:0];
        [containerView addSubview:toVc.view];
        [containerView addSubview:tempView];
    
        [UIView animateWithDuration:self.duration animations:^{
            toVc.view.alpha = 1.0;
            tempView.frame = [toImageView convertRect:toImageView.bounds toView:containerView];
        } completion:^(BOOL finished) {
            tempView.hidden = YES;
            toImageView.hidden = NO;
            [transitionContext completeTransition:YES];
        }];
    
//        [UIView animateWithDuration:self.duration delay:0.0 usingSpringWithDamping:0.55 initialSpringVelocity:1/0.55 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
//            toVc.view.alpha = 1.0;
//            tempView.frame = [toImageView convertRect:toImageView.bounds toView:containerView];
//        } completion:^(BOOL finished) {
//            //fromVC.view.alpha = 1.0;
//            tempView.hidden = YES;
//            toImageView.hidden = NO;
//            [transitionContext completeTransition:YES];
//        }];
    
    }
//    HomeDetailViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    UIView *containerView = [transitionContext containerView];
//    UIView *fromImageVIew = fromVC.iconImageView;
//    UIView *tempView = [fromImageVIew snapshotViewAfterScreenUpdates:NO];
//   // tempView.frame = [fromImageVIew convertRect:fromImageVIew.bounds toView:containerView];
//    tempView.frame = [fromImageVIew convertRect:CGRectMake(0,FScreenHeight/2 , fromImageVIew.bounds.size.width,fromImageVIew.bounds.size.height) toView:containerView];
////    //查看contrainer 上面的视图
////    for (UIView *view in containerView.subviews) {
////        NSLog(@"%@",view);
////        if (fromVC.view == view) {
////            NSLog(@"YES");
////        }
////    }
//    UIView *toImageView = toVc.iconView;
//    
//    fromImageVIew.hidden = YES;
//    toVc.view.alpha = 0.0;
//    toImageView.hidden = YES;
//    //把 toVc.view 置顶
//   // [containerView insertSubview:toVc.view atIndex:0];
//    [containerView addSubview:toVc.view];
//    [containerView addSubview:tempView];
//    
//    [UIView animateWithDuration:self.duration delay:0.0 usingSpringWithDamping:0.55 initialSpringVelocity:1/0.55 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
//        toVc.view.alpha = 1.0;
//        tempView.frame = [toImageView convertRect:toImageView.bounds toView:containerView];
//    } completion:^(BOOL finished) {
//        //fromVC.view.alpha = 1.0;
//        tempView.hidden = YES;
//        toImageView.hidden = NO;
//        [transitionContext completeTransition:YES];
//    }];
    
    
//}

- (void)pop:(id<UIViewControllerContextTransitioning>)transitionContext {
    HomeDetailViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    HomeViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIView *toImageView = toVc.iconImageView;
    UIView *tempView = containerView.subviews.lastObject;
    //查看contrainer 上面的视图
    for (UIView *view in containerView.subviews) {
        NSLog(@"%@",view);
        if (fromVC.view == view) {
            NSLog(@"YES");
        }
    }
    
    toImageView.hidden = YES;
    tempView.hidden = NO;
    //把 toVc.view 置顶
    [containerView insertSubview:toVc.view atIndex:0];
    
//    [UIView animateWithDuration:self.duration delay:0.0 usingSpringWithDamping:0.55 initialSpringVelocity:1/0.55 options:UIViewAnimationOptionLayoutSubviews animations:^{
//        fromVC.view.alpha = 0;
//        tempView.frame = [toImageView convertRect:toImageView.bounds toView:containerView];
//    } completion:^(BOOL finished) {
//        tempView.hidden = NO;
//        toImageView.hidden = NO;
//        [tempView removeFromSuperview];
//        [transitionContext completeTransition:YES];
//    }];
    
    [UIView animateWithDuration:self.duration animations:^{
        fromVC.view.alpha = 0;
        tempView.frame = [toImageView convertRect:toImageView.bounds toView:containerView];
    } completion:^(BOOL finished) {
        tempView.hidden = NO;
        toImageView.hidden = NO;
        [tempView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
    
}
@end
