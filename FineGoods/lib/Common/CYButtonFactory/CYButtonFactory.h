//
//  CYButtonFactory.h
//  ScanWorld
//
//  Created by qianfeng on 15/12/18.
//  Copyright © 2015年 Aili. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYButtonFactory : UIButton

- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)title
                         font:(UIFont *)font
                   titleColor:(UIColor *)titleColor
                  normalImage:(UIImage *)normalImage
                selectedImage:(UIImage *)selectedImage;

- (instancetype)initWithFrame:(CGRect)frame
                  normalImage:(UIImage *)normalImage
                selectedImage:(UIImage *)selectedImage
                       target:(id)target
                       action:(SEL)action;
@end
