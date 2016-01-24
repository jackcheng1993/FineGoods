//
//  HomeViewController.m
//  FineGoods
//
//  Created by qianfeng on 16/1/10.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "HomeViewController.h"
#import "Define.h"
#import "HomeCell.h"
#import "NetWorkingManager.h"
#import "TitleLabel.h"
#import "HomePageViewController.h"
#import "HomeDetailViewController.h"

#define identifity @"HomeCell"
#define LabelWidth 60
#define TitleMargin 20
#define TitleHeight 44

@interface HomeViewController ()<UIScrollViewDelegate,UITableViewDelegate,HomePageViewControllerDelegate> {
    
    UIScrollView *_mainScrollView;
    HYBLoopScrollView *_loopScrollView;
    UIScrollView *_titleScrollView;
//  UIScrollView *_contentScrollView;
    NSArray *_pageArray;
    NSMutableArray *_titleArray;
    
    BOOL _isClickTitle;//记录标题是否点击
    
    UITableView *_tableView;
    UIScrollView *_sectionHeaderView;
    
    UIView *_headView;
    
    NSMutableArray *_dataArray;
   // NSMutableArray *_headArray;
   // NSArray *_titleArray;
    
   
}

@property (nonatomic,strong) NSMutableArray *headArray;

/** 下标视图 */
@property (nonatomic, weak) UIView *underLine;

/** 记录上一次内容滚动视图偏移量 */
@property (nonatomic, assign) CGFloat lastOffsetX;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    //新手指引
    [self newUserGuide];
    //初始化数据源
    [self initData];
    //布局场景
    [self createSence];
}



#pragma mark - 新手指引
- (void)newUserGuide {
    CGRect frame = [UIScreen mainScreen].bounds;
    UIView *bgView  = [[UIView alloc]initWithFrame:frame];
    bgView.backgroundColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:52/255.0 alpha:0.8];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(guideSureClick:)];
    [bgView addGestureRecognizer:tap];
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    
    //添加第一个路径
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:frame];
    [path appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(FScreenWidth/2,FScreenHeight-20) radius:30 startAngle:0 endAngle:2*M_PI clockwise:NO]];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    [bgView.layer setMask:shapeLayer];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, FScreenHeight-150, 200, 100)];
    imageView.image = [UIImage imageNamed:@"Fplaceholder"];
    [bgView addSubview:imageView];
    
}

//点击屏幕后触发事件
- (void)guideSureClick:(UITapGestureRecognizer *)gesture {
    UIView *view = gesture.view;
    [view removeFromSuperview];
    // [view removeAllSubviews];
    [view removeGestureRecognizer:gesture];
}

#pragma mark - 初始化数据源
- (void)initData {
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"HomePages" ofType:@"plist"];
    _pageArray = [NSArray arrayWithContentsOfFile:plistPath];
    
}

- (NSMutableArray *)headArray {
    if (_headArray == nil) {
        _headArray = [NSMutableArray new];
    }
    return _headArray;
}


#pragma mark - 布局场景
- (void)createSence {
    self.automaticallyAdjustsScrollViewInsets = NO;
    _mainScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    _mainScrollView.contentSize = CGSizeMake(FScreenWidth*_pageArray.count, FScreenHeight);
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.delegate = self;
    _mainScrollView.bounces = NO;
    [self.view addSubview:_mainScrollView];
    //添加子视图控制器
    [self addChildControllers];
     //设置导航栏代理
    
    //__weak typeof(self) weakSelf;
    //添加刷新控件及事件
//    _mainScrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        NSInteger idx = _mainScrollView.mj_offsetX/FScreenWidth;
//        HomePageViewController *pageContr = self.childViewControllers[idx];
//        [pageContr fetchDataFromNet:NO withRefreshHeader:_mainScrollView.mj_header];
//    }];
    
    //banner 滚动视图
    _loopScrollView = [HYBLoopScrollView loopScrollViewWithFrame:CGRectMake(0, 0, FScreenWidth, 200) imageUrls:@[@"Fplaceholder",@"Fplaceholder"] timeInterval:5.0 didSelect:^(NSInteger atIndex, HYBLoadImageView *sender) {
       
    } didScroll:NULL];
    _loopScrollView.alignment = kPageControlAlignCenter;
    UIPanGestureRecognizer *pangesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(LoopPanGesture:)];
    [_loopScrollView addGestureRecognizer:pangesture];
    [self.view addSubview:_loopScrollView];
    //[self initLoopData];
    
    //创建标题滚动视图
    _titleScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _loopScrollView.mj_h, FScreenWidth, TitleHeight)];
    _titleScrollView.backgroundColor = [UIColor whiteColor];
    _titleScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_titleScrollView];
   // [self.view bringSubviewToFront:_titleScrollView];
    [self addTitle];
    
    //创建内容滚动视图
//    _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleScrollView.frame), FScreenWidth, 10000)];
//    _contentScrollView.contentSize = CGSizeMake(FScreenWidth*_pageArray.count, _contentScrollView.mj_h);
//    _contentScrollView.pagingEnabled = YES;
//    _contentScrollView.delegate = self;
//    [_mainScrollView addSubview:_contentScrollView];
    
    //默认添加第一页
    [self addChildControllerViewAtIndex:0];
}

- (void)addChildControllers {
    for (NSInteger i = 0 ; i < _pageArray.count; i++) {
        NSDictionary *dict = _pageArray[i];
        HomePageViewController *homePageContr = [[HomePageViewController alloc]init];
        homePageContr.title = dict[@"title"];
        homePageContr.sence = dict[@"scene"];
        homePageContr.delegate = self;
        [self addChildViewController:homePageContr];
    }
}

- (UIView *)underLine
{
    if (_underLine == nil) {
        
        UIView *underLineView = [[UIView alloc] init];
        
        underLineView.backgroundColor = [UIColor redColor];
        
        [_titleScrollView addSubview:underLineView];
        
        _underLine = underLineView;
        
    }
    return _underLine;
}

#pragma mark - 设置banner的数据
- (void)updateLoopData:(NSArray *)loopData {
//    if (self.loopData) {
//        [self.headArray removeAllObjects];
//        __weak typeof(self) weakSelf;
//        self.loopData = ^(NSArray *loopDate){
//            [weakSelf.headArray addObjectsFromArray:loopData];
//        };
//    }
    
    [self.headArray removeAllObjects];
    [self.headArray addObjectsFromArray:loopData];
    NSMutableArray *imageUrls = [NSMutableArray new];
    for (FAppBannerModel *bannerModel in self.headArray) {
        [imageUrls addObject:bannerModel.photo];
    }
    _loopScrollView.imageUrls = imageUrls;
}
- (void)initLoopData {
    NSInteger page = 0;
    _headArray = [NSMutableArray new];
     NSString *urlString = [NSString stringWithFormat:FHomeUrl,(long)page];
    [NetWorkingManager getRequestWithUrl:urlString parameters:nil pageType:FHomePage successBlock:^(id object) {
        NSDictionary *dict = (NSDictionary *)object;
        FAppModel *appModel = [[FAppModel alloc]initWithDictionary:dict error:nil];
        [_headArray addObjectsFromArray:appModel.data.banner];
        NSMutableArray *imageUrls = [NSMutableArray new];
        for (FAppBannerModel *bannerModel in _headArray) {
            [imageUrls addObject:bannerModel.photo];
        }
        _loopScrollView.imageUrls = imageUrls;
    } failBlock:^(NSError *error)   {
        NSLog(@"%@",error);
    }];
}

#pragma mark - AddTitle
- (void)addTitle {
    _titleScrollView.contentSize = CGSizeMake(LabelWidth*_pageArray.count, _titleScrollView.mj_h);
    _titleArray = [NSMutableArray new];
    for (NSInteger i = 0; i< _pageArray.count; i++ ) {
        NSDictionary *dict = _pageArray[i];
        TitleLabel *label = [[TitleLabel alloc]initWithFrame:CGRectMake(LabelWidth * i, 0,LabelWidth , _titleScrollView.mj_h)];
        label.textColor = [UIColor grayColor];
        label.text = dict[@"title"];
        label.tag = i;
        UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleTapAction:)];
        [label addGestureRecognizer:tapgesture];
        [_titleScrollView addSubview:label];
        [_titleArray addObject:label];
    }
}

#pragma mark - 拖动LoopScrollView
- (void)LoopPanGesture:(UIPanGestureRecognizer *)panGesture {
    NSLog(@"panGesture");
}

#pragma mark - 点击标题
- (void)titleTapAction:(UITapGestureRecognizer *)tapgesture {
    TitleLabel *label = (TitleLabel *)tapgesture.view;
    NSInteger i = label.tag;
    
    CGFloat offsetX = i*FScreenWidth;
     [self addChildControllerViewAtIndex:i];
    _mainScrollView.contentOffset = CGPointMake(offsetX, 0);
}

- (void)addChildControllerViewAtIndex:(NSInteger)idx {
    HomePageViewController *homePageContr = self.childViewControllers[idx];
    UITableView *tableView = (UITableView *)homePageContr.view;
    if (tableView.superview == nil) {
        tableView.frame = CGRectMake(FScreenWidth*idx, 0, FScreenWidth, FScreenHeight-64);
        tableView.delegate = self;
        [_mainScrollView addSubview:tableView];
    }
    
    TitleLabel *label = _titleArray[idx];
    [self selectLabel:label];

}
//设置标题选中
- (void)selectLabel:(TitleLabel *)label {
     // 修改标题选中颜色
    for (TitleLabel *labelView in _titleArray) {
        if ([label isEqual:labelView]) {
            labelView.textColor = [UIColor redColor];
        }
        else {
            labelView.textColor = [UIColor grayColor];
        }
    }
    
    // 设置标题居中
    [self setLabelTitleCenter:label];
    // 设置下标的位置
    [self setUpUnderLine:label];

}

// 让选中的按钮居中显示
- (void)setLabelTitleCenter:(UILabel *)label
{
    // 设置标题滚动区域的偏移量
    CGFloat offsetX = label.center.x - FScreenWidth * 0.5;
    
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    // 计算下最大的标题视图滚动区域
    CGFloat maxOffsetX = _titleScrollView.contentSize.width - FScreenWidth + TitleMargin;
    
    if (maxOffsetX < 0) {
        maxOffsetX = 0;
    }
    
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    
    // 滚动区域
    [_titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
}

// 设置下标的位置
- (void)setUpUnderLine:(UILabel *)label
{
    // 获取文字尺寸
   // CGRect titleBounds = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil];
    
    CGFloat underLineH =2;
    
    self.underLine.mj_y = label.mj_h - underLineH;
    self.underLine.mj_h = underLineH;
    
    // 最开始不需要动画
    if (self.underLine.mj_x == 0) {
        self.underLine.mj_w = 20;
        self.underLine.hyb_centerX = label.hyb_centerX;
        return;
    }
    
    // 点击时候需要动画
    [UIView animateWithDuration:0.25 animations:^{
        self.underLine.mj_w = 20;
        self.underLine.hyb_centerX = label.hyb_centerX;
    }];
    
}

#pragma mark - HomePageViewControllerDelegate
- (void)changeTitleScllorViewY:(CGFloat)offsetY {
    if (_titleScrollView.mj_y > 64) {
        _loopScrollView.mj_y = -offsetY;
        _titleScrollView.mj_y = CGRectGetMaxY(_loopScrollView.frame);
    }else if (_titleScrollView.mj_y <= 64 && offsetY < 136){
        _loopScrollView.mj_y = -offsetY;
        _titleScrollView.mj_y = CGRectGetMaxY(_loopScrollView.frame);
    }
}


- (void)pushDetailController:(UIViewController *)viewController {
    HomeDetailViewController *detailContr = (HomeDetailViewController *)viewController;
    self.navigationController.delegate = detailContr;
    detailContr.image = self.iconImageView.image;
    [self.navigationController pushViewController:detailContr animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
        CGFloat offsetX = _mainScrollView.mj_offsetX;
        NSInteger i = offsetX/FScreenWidth;
        [self addChildControllerViewAtIndex:i];
    
    //设置滚动视图和标题视图的Y坐标
    HomePageViewController *homePageContr = self.childViewControllers[i];
    UITableView *tableView = (UITableView *)homePageContr.view;
     CGFloat offsetY = - tableView.mj_offsetY;
//    if (tableView.mj_offsetY < 136) {
//        _loopScrollView.mj_y = offsetY;
//        _titleScrollView.mj_y = CGRectGetMaxY(_loopScrollView.frame);
//    }
    //_tableView.contentOffset
  //  NSLog(@"_titleScrollView %lf",_titleScrollView.mj_y);
    
//    if (_titleScrollView.mj_y > 64) {
//        _loopScrollView.mj_y = offsetY;
//        _titleScrollView.mj_y = CGRectGetMaxY(_loopScrollView.frame);
//    }else if (_titleScrollView.mj_y <= 64 && tableView.mj_offsetY < 136){
//        _loopScrollView.mj_y = offsetY;
//        _titleScrollView.mj_y = CGRectGetMaxY(_loopScrollView.frame);
//    }
    
    //设置其它子视图的偏移量
    [self setOffTableViewOffsetY:offsetY];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//      HomeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    NSLog(@"zzzzzz %@",cell.titleLabel.text);
    HomeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
   // FAppTopicModel *topicModel = _dataArray[indexPath.row];
    
    self.iconImageView = cell.iconImage;
    HomeDetailViewController *detailContr = [[HomeDetailViewController alloc]init];
    detailContr.image = self.iconImageView.image;
    detailContr.newsInfoId =cell.topicModel.id;
    
    detailContr.naviAlpha = self.navigationController.navigationBar.alpha;
    
    self.navigationController.delegate = detailContr;
    detailContr.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:detailContr animated:YES];
//        if (self.delegate) {
//            HomeViewController *viewContr = (HomeViewController *)self.delegate;
//            viewContr.iconImageView = cell.iconImage;
//            [self.delegate pushDetailController:detailContr];
//        }
}

- (void)setOffTableViewOffsetY:(CGFloat)offsetY {
    for (HomePageViewController *pageContr in self.childViewControllers) {
        UITableView *tableView =(UITableView *) pageContr.view;
        tableView.mj_offsetY = - offsetY;
    }
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
