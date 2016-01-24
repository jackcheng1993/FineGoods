//
//  PopMenuView.h
//  FineGoods
//
//  Created by qianfeng on 16/1/11.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ControlBlock)(NSInteger);

@interface PopMenuView : UIView



- (instancetype)initWithFrame:(CGRect)frame controlBlock:(ControlBlock)controlBlock;

+ (void)ShowPopMenuView;

- (void)show;

@end
