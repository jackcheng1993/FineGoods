//
//  ButtonTableViewCell.m
//  FineGoods
//
//  Created by qianfeng on 16/1/12.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "ButtonTableViewCell.h"
#import "Define.h"
#import "DiscoverModel.h"




@interface ButtonTableViewCell ()< UIScrollViewDelegate> {
    UIImageView *_buttonImageView;
    UILabel *_buttonTitle;
    UILabel *_buttonNumber;
}

@end


@implementation ButtonTableViewCell {
    UITableView *_tableView;
    
    NSArray *_nameArray;
    UIScrollView *_smallScrollView;
    
    CGFloat _screenWidth;
    
    UIButton *_button;
    
    UILabel *_label;
    
    UIScrollView *_bigScrollView;
    
    NSArray *_dataArray;
    
    CGFloat _point;
    
    NSMutableArray *_buttons;
    NSMutableArray *_texts;
    NSMutableArray *_hotNums;
    
    
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createCustomViews];
    }
    return self;
}





- (void)createCustomViews {
    _buttonImageView =[UIImageView new];
    _buttonTitle = [UILabel new];
    _buttonNumber = [UILabel new];
    
    [self.contentView addSubview:_buttonImageView];
    [self.contentView addSubview:_buttonTitle];
    [self.contentView addSubview:_buttonNumber];
    
        [self createBigScrollView];
        [self createSmallScrollView];
        [self addTitleButton];
        [self addButton8];
}


- (void)updateWithModel:(NSArray *)buttonSource {
    int a = 999;
    int b = 1039;
    int c = 1099;
    for (NSInteger i = 0; i < buttonSource.count; i++) {
            ElementsModel *elementModel = buttonSource[i];
            for (NSInteger j = 0; j<elementModel.elements.count; j++) {
                buttonModel *buttonModel = elementModel.elements[j];
                
                a++;
                b++;
                c++;
                
                UIButton *button = (UIButton *)[self.contentView viewWithTag:a];
                UILabel *titleLabel = (UILabel *)[self.contentView viewWithTag:b];
                UILabel *Numlabel = (UILabel *)[self.contentView viewWithTag:c];
                
                [button sd_setBackgroundImageWithURL:[NSURL URLWithString:buttonModel.photo] forState:UIControlStateNormal];
                
                titleLabel.text = buttonModel.title;
                titleLabel.font = [UIFont systemFontOfSize:15];
                titleLabel.adjustsFontSizeToFitWidth = YES;
                titleLabel.textAlignment = NSTextAlignmentCenter;
                titleLabel.textColor = [UIColor grayColor];
                
                Numlabel.text = buttonModel.sub_title;
                Numlabel.font = [UIFont systemFontOfSize:13];
                Numlabel.adjustsFontSizeToFitWidth = YES;
                Numlabel.textAlignment = NSTextAlignmentCenter;
                Numlabel.textColor = [UIColor lightGrayColor];
            }
        }
}


- (void)createSmallScrollView {
    _smallScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, FScreenWidth, 40)];
    _smallScrollView.backgroundColor = [UIColor whiteColor];
    _smallScrollView.delegate = self;
    [self.contentView addSubview:_smallScrollView];
}

- (void)createBigScrollView {
    _bigScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, FScreenWidth, FScreenWidth/2)];
    _bigScrollView.delegate = self;
    _bigScrollView.backgroundColor = [UIColor whiteColor];
    _bigScrollView.contentSize = CGSizeMake(4*FScreenWidth, FScreenWidth/2);
    _bigScrollView.pagingEnabled = YES;
    _bigScrollView.showsHorizontalScrollIndicator = NO;
    _bigScrollView.showsVerticalScrollIndicator = NO;
    _bigScrollView.alwaysBounceHorizontal = NO;
    [self.contentView addSubview:_bigScrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _bigScrollView) {
        NSInteger index = _bigScrollView.contentOffset.x/FScreenWidth;
        UIButton *button = (UIButton *)[self.contentView viewWithTag:index+100];
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
    _buttons = [NSMutableArray new];
    _texts = [NSMutableArray new];
    _hotNums = [NSMutableArray new];
    
    int n = 999;
    int t = 1039;
    int h = 1099;
    
    for (int i = 0; i < _nameArray.count ; i++) {
        
        for (int k = 0 ; k <= 7; k++) {
            
            UIButton *_btn = [[UIButton alloc] init];
            
            UILabel *_text = [[UILabel alloc] init];
            
            UILabel *_hotNum = [[UILabel alloc] init];
            
            if (k/4 == 0) {
                
                n++;
                t++;
                h++;
                
                _btn.tag = n;
                _text.tag = t;
                _hotNum.tag = h;
                
                _btn.frame = CGRectMake(FScreenWidth/8*(2*k+1)+i*(FScreenWidth), 60, FScreenWidth/7, FScreenWidth/7);
                _text.frame = CGRectMake(FScreenWidth/8*(2*k+1)+i*(FScreenWidth), 60, FScreenWidth/6, 20);
                _hotNum.frame = CGRectMake(FScreenWidth/8*(2*k+1)+i*(FScreenWidth), 60, FScreenWidth/6, 20);
                
                
                _btn.center = CGPointMake(FScreenWidth/8*(2*k+1)+i*(FScreenWidth), FScreenWidth/8);
                _text.center =  CGPointMake(FScreenWidth/8*(2*k+1)+i*(FScreenWidth), FScreenWidth/8-FScreenWidth/10);
                _hotNum.center = CGPointMake(FScreenWidth/8*(2*k+1)+i*(FScreenWidth), FScreenWidth/8+FScreenWidth/10);
                
                _btn.layer.cornerRadius = FScreenWidth/7/2;
                _btn.layer.masksToBounds = YES;
                
                [_bigScrollView addSubview:_btn];
                [_bigScrollView addSubview:_text];
                [_bigScrollView addSubview:_hotNum];
                
                 [_btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
                [_btn setBackgroundImage:[UIImage imageNamed:@"Fplaceholder"] forState:UIControlStateNormal];
                [_buttons addObject:_btn];
                
            }else if (k/4 > 0){
                
                n++;
                t++;
                h++;
                
                _text.tag = t;
                _btn.tag = n;
                _hotNum.tag = h;
                
                _btn.frame = CGRectMake(FScreenWidth/8*(2*(k-4)+1)+i*(FScreenWidth), 60*2, FScreenWidth/7, FScreenWidth/7);
                _text.frame = CGRectMake(FScreenWidth/8*(2*k+1)+i*(FScreenWidth), 60, FScreenWidth/6, 20);
                _hotNum.frame = CGRectMake(FScreenWidth/8*(2*k+1)+i*(FScreenWidth), 60, FScreenWidth/6, 20);
                
                _btn.center = CGPointMake(FScreenWidth/8*(2*(k-4)+1)+i*(FScreenWidth), 3*FScreenWidth/8);
                _text.center =  CGPointMake(FScreenWidth/8*(2*(k-4)+1)+i*(FScreenWidth), 3*FScreenWidth/8-FScreenWidth/10);
                _hotNum.center = CGPointMake(FScreenWidth/8*(2*(k-4)+1)+i*(FScreenWidth), 3*FScreenWidth/8+FScreenWidth/10);
                
                _btn.layer.cornerRadius = FScreenWidth/7/2;
                _btn.layer.masksToBounds = YES;
                
                [_bigScrollView addSubview:_text];
                [_bigScrollView addSubview:_hotNum];
                [_bigScrollView addSubview:_btn];
                
                [_btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
                [_btn setBackgroundImage:[UIImage imageNamed:@"Fplaceholder"] forState:UIControlStateNormal];
                [_buttons addObject:_btn];
            }

        }
        
    }
    
}

- (void)buttonAction:(UIButton *)button{
    NSLog(@"%ld",(long)button.tag);

}

- (void)addTitleButton {
    _nameArray = @[@"热门推荐",@"深夜食堂",@"变美神器",@"一种生活"];
    _screenWidth = FScreenWidth/4;
    for (int i = 0; i < _nameArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(_screenWidth*i, 0, _screenWidth, 35);
        [button setTitle:_nameArray[i] forState:UIControlStateNormal];
        button.tintAdjustmentMode = NSTextAlignmentCenter;
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
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
        _bigScrollView.contentOffset = CGPointMake(self.contentView.frame.size.width*(button.tag-100), 0);
    }];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
