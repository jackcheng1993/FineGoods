//
//  PopMenuView.m
//  FineGoods
//
//  Created by qianfeng on 16/1/11.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "PopMenuView.h"

@interface PopMenuView ()

@property (nonatomic,copy) ControlBlock controlBlock;

@end

@implementation PopMenuView {
    NSMutableArray *_buttons;
    NSMutableArray *_targetPoints;
    UIView *_menuView;
    BOOL _isShow;
    CGPoint _originPoint;
    BOOL _isChange;
}
////////////////////////////////////////////////////////
- (instancetype)initWithFrame:(CGRect)frame controlBlock:(ControlBlock)controlBlock{
    if (self = [super initWithFrame:frame]) {
        self.tag = 1000;
        _controlBlock = controlBlock;
        [self createView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.tag = 1000;
        [self createView];
    }
    return self;
}

- (void)createView {
    NSArray *titles = @[@"请选择图片发送商品",@"从相册选取",@"拍照选取",@"取消"];
    
    _originPoint= CGPointMake(self.center.x, self.frame.size.height-25);
    //CGFloat buttonH = 30;
    CGFloat buttonW = 200;
    _menuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 210)];
    _menuView.center = _originPoint;
    _menuView.backgroundColor = [UIColor whiteColor];
    UIView *backgorundView = [[UIView alloc] initWithFrame:self.bounds];
    backgorundView.backgroundColor = [UIColor lightGrayColor];
    backgorundView.alpha = 0.5;
    [self addSubview:backgorundView];
    NSInteger index = 0;
    for (NSString *title in titles) {
        CGFloat buttonH = 30;
        if (index !=  0) {
            buttonH = 55;
        }
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, buttonH*index, buttonW, 50)];
        button.tag = 100+index;
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        if (index==0||index==3) {
            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
//        }else {
        button.backgroundColor = [UIColor colorWithRed:251.0/255 green:51.0/255 blue:61.0/255 alpha:1];
//        }
        
        [_menuView addSubview:button];
        index++;
        
    }
    _menuView.clipsToBounds = YES;
    _menuView.layer.cornerRadius = 10;
    [self addSubview:_menuView];
    _menuView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    _menuView.alpha = 0;
    
}

- (void)buttonClicked:(UIButton *)btn {
    if (btn.tag==100) {
        return;
    }
    _controlBlock(btn.tag);
    [self show];
}

- (void)show {
    
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    //UIView *view = [keyWindow viewWithTag:1000];
    if (_isShow) {
        [UIView animateWithDuration:0.5 animations:^{
            _menuView.transform = CGAffineTransformMakeScale(0.1, 0.1);
            _menuView.center = _originPoint;
            _menuView.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }else {
        [keyWindow addSubview:self];
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveLinear animations:^{
            _menuView.transform = CGAffineTransformIdentity;
            _menuView.center = keyWindow.center;
            _menuView.alpha = 1;
        } completion:^(BOOL finished) {
            _isChange = NO;
        }];
    }
    _isShow = !_isShow;
//    if (!_isShow) {
//        
//    }else {
//        
//        _isShow = !_isShow;
////        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveLinear animations:^{
////           
////        } completion:^(BOOL finished) {
////            
////        }];
//    }
//    
}

+ (void)ShowPopMenuView {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
//    if (keyWindow.subviews containsObject:) {
//        statements
//    }
//    UIView *popView = [keyWindow viewWithTag:1000];
//    if (popView) {
//        [popView removeFromSuperview];
//    }
    PopMenuView *popMenuView = [[PopMenuView alloc] initWithFrame:keyWindow.bounds];
    
    [popMenuView show];
    //[keyWindow addSubview:popMenuView];
}

//- (void)show {
//    
//}

//
//- (void)createView {
//    _buttons = [[NSMutableArray alloc] init];
//    _targetPoints = [[NSMutableArray alloc] init];
//    UIView *backgorundView = [[UIView alloc] initWithFrame:self.bounds];
//    backgorundView.backgroundColor = [UIColor lightGrayColor];
//    backgorundView.alpha = 0.5;
//    [self addSubview:backgorundView];
//    [self createButtons];
//    
//}
//
//- (void)createDesPoints:(CGPoint)originPoint {
//    for (NSInteger idx = 0; idx < 4; idx++) {
//        
//    }
//}
//
//- (void)createButtons {
//   // NSArray *imageNames = @[@""];
//


//    [keyWindow addSubview:self];
//    CGRect frame = CGRectMake(0, 0, 50, 50);
//    CGPoint originPoint= CGPointMake(self.center.x, self.frame.size.height-25);
//    for (NSInteger idx = 0; idx < 5; idx++) {
//        
//        UIButton *btn = [[UIButton alloc] initWithFrame:frame];
//        btn.center = originPoint;
//        btn.clipsToBounds = YES;
//        btn.layer.cornerRadius = 25;
//        btn.backgroundColor = [UIColor redColor];
//        [_buttons addObject:btn];
//        [keyWindow addSubview:btn];
//        //[keyWindow bringSubviewToFront:btn];
//        
//    }
//    
//}
//
//- (void)animation {
//    
//    for (UIButton *btn in _buttons) {
//        
//    }
//}
//
//+ (void)ShowPopMenuView {
//    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
//    PopMenuView *popMenuView = [[PopMenuView alloc] initWithFrame:keyWindow.bounds];
//    // [keyWindow addSubview:popMenuView];
//}
//
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self removeFromSuperview];
//    for (UIButton *btn in _buttons) {
//        [btn removeFromSuperview];
//    }
//    if (_isShow) {
//        [self removeFromSuperview];
//    }
    if (!_isChange&&_isShow) {
        [self show];
    }
    
    
}
////////////////////////////////////////////////////////



@end
