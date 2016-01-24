//
//  PushControllerTransition.h
//  FineGoods
//
//  Created by qianfeng on 16/1/14.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,FControllerTransitionType) {
    FControllerTransitionTypePush = 1<<1,
    FControllerTransitionTypePop = 1 << 2
};

@interface PushControllerTransition : NSObject <UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithType:(FControllerTransitionType)transitionType duration:(NSTimeInterval)duration;

@end
