//
//  DiscoverViewController.m
//  FineGoods
//
//  Created by qianfeng on 16/1/10.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "DiscoverViewController.h"
#import "Define.h"



@interface DiscoverViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate> {
    UITableView *_tableView;
    
    NSArray *_nameArray;
    UIScrollView *_smallScrollView;
    
    CGFloat _screenWidth;
    
    UIButton *_button;
    
    UILabel *_label;
    
    UIScrollView *_bigScrollView;
    
    NSArray *_dataArray;
    
    CGFloat _point;
    
    
    
}

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createBigScrollView];
    [self createSmallScrollView];
    [self addTitleButton];
    [self addButton8];
    
    
}

- (void)createSmallScrollView {
    _smallScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, FScreenWidth, 40)];
    _smallScrollView.backgroundColor = [UIColor whiteColor];
    _smallScrollView.delegate = self;
    [self.view addSubview:_smallScrollView];
}

- (void)createBigScrollView {
    _bigScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64+40, FScreenWidth, FScreenWidth/2)];
    _bigScrollView.delegate = self;
    _bigScrollView.backgroundColor = [UIColor whiteColor];
    _bigScrollView.contentSize = CGSizeMake(4*FScreenWidth, FScreenWidth/2);
    _bigScrollView.pagingEnabled = YES;
    _bigScrollView.showsHorizontalScrollIndicator = NO;
    _bigScrollView.showsVerticalScrollIndicator = NO;
    _bigScrollView.alwaysBounceHorizontal = NO;
    [self.view addSubview:_bigScrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _bigScrollView) {
        NSInteger index = _bigScrollView.contentOffset.x/FScreenWidth;
        UIButton *button = (UIButton *)[self.view viewWithTag:index+100];
        _button.selected = NO;
        _button.transform = CGAffineTransformMakeScale(1, 1);
        button.selected = YES;
        _button = button;
        _button.transform = CGAffineTransformMakeScale(1, 1);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _bigScrollView) {
        [UIView animateWithDuration:0.5 animations:^{
            _label.frame = CGRectMake(scrollView.contentOffset.x/_bigScrollView.frame.size.width*_screenWidth, CGRectGetMaxY(_button.frame)-1, _screenWidth, 2);
        }];
    }
}

- (void)addButton8 {
    for (int i = 0; i < _nameArray.count ; i++) {
        
        for (int k = 0; k <= 7; k++) {
            UIButton *_btn = [[UIButton alloc] init];
            if (k/4 == 0) {
                _btn.frame = CGRectMake(FScreenWidth/8*(2*k+1)+i*(FScreenWidth), 60, FScreenWidth/6, FScreenWidth/6);
                _btn.center = CGPointMake(FScreenWidth/8*(2*k+1)+i*(FScreenWidth), FScreenWidth/8);
                _btn.layer.cornerRadius = FScreenWidth/6/2;
                _btn.layer.masksToBounds = YES;
                [_btn setBackgroundImage:[UIImage imageNamed:@"Fplaceholder"] forState:UIControlStateNormal];
                [_bigScrollView addSubview:_btn];
                
                
            }else if (k/4 > 0){
                _btn.frame = CGRectMake(FScreenWidth/8*(2*(k-4)+1)+i*(FScreenWidth), 60*2, FScreenWidth/6, FScreenWidth/6);
                _btn.center = CGPointMake(FScreenWidth/8*(2*(k-4)+1)+i*(FScreenWidth), 3*FScreenWidth/8);
                _btn.layer.cornerRadius = FScreenWidth/6/2;
                _btn.layer.masksToBounds = YES;
                [_btn setBackgroundImage:[UIImage imageNamed:@"Fplaceholder"] forState:UIControlStateNormal];
                
            }
            
            [_bigScrollView addSubview:_btn];
        }
        
    }
}

- (void)addTitleButton {
    _nameArray = @[@"热门推荐",@"深夜食堂",@"变美神器",@"一种生活"];
    _screenWidth = self.view.frame.size.width/4;
    for (int i = 0; i < _nameArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(_screenWidth*i, 0, _screenWidth, 35);
        [button setTitle:_nameArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100 + i;
        [_smallScrollView addSubview:button];
        if (i == 0) {
            button.selected = YES;
            _button = button;
            _button.transform = CGAffineTransformMakeScale(1.1, 1.1);
            _label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(button.frame)-1, _screenWidth, 2)];
            _label.backgroundColor = [UIColor redColor];
            [_smallScrollView addSubview:_label];
        }
    }
    _smallScrollView.contentSize = CGSizeMake(_screenWidth*_nameArray.count, 40);
    _smallScrollView.showsHorizontalScrollIndicator = NO;
}

- (void)buttonClick:(UIButton *)button {
    if (_button == button) {
        return;
    }
    button.selected = YES;
    _button.selected = NO;
    _button.transform = CGAffineTransformMakeScale(1, 1);
    _button = button;
    _button.transform = CGAffineTransformMakeScale(1.0, 1.0);
    [UIView animateWithDuration:0.5 animations:^{
        _label.frame = CGRectMake(CGRectGetMinX(_button.frame), CGRectGetMaxY(_button.frame)-1, _screenWidth, 2);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        _bigScrollView.contentOffset = CGPointMake(self.view.frame.size.width*(button.tag-100), 0);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
