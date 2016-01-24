//
//  HomeBannerProductDetailVC.m
//  FineGoods
//
//  Created by qianfeng on 16/1/23.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "HomeBannerProductDetailVC.h"
#import "NetWorkingManager.h"
#import "ProductnewsInfoModel.h"
#import "Define.h"
#import "HomeProductViewController.h"
#define NewInfoUrl @"http://open3.bantangapp.com/product/newInfo"
#define PaddingTop 10

@interface HomeBannerProductDetailVC ()
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) ProductNewsInfoModel *newsInfoModel;
@property (strong, nonatomic) HYBLoopScrollView *loopScrollView;
@property (strong, nonatomic) UILabel *titleLabel,*priceLabel,*desLabel;

@end

@implementation HomeBannerProductDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpDataModel];
    [self setUpScrollView];
    [self setUpLabels];
    [self setUpButtons];
}

- (instancetype)initWithNewID:(NSString *)newsId {
    if (self = [super init]) {
        _newsId = newsId;
    }
    return self;
}

- (void)setUpDataModel {
   // NSString *urlString = [NSString stringWithFormat:NewInfoUrl,self.newsId];
    NSDictionary *paramerts = @{@"id":self.newsId,@"client_id":@"bt_app_ios",@"client_secret":@"9c1e6634ce1c5098e056628cd66a17a5"};
    [NetWorkingManager postRequestWithUrl:NewInfoUrl parameters:paramerts pageType:nil successBlock:^(id object) {
        
        NSDictionary *dict = (NSDictionary *)object;
        _newsInfoModel = [[ProductNewsInfoModel alloc]init];
        _newsInfoModel.id = dict[@"data"][@"product"][@"id"];
        _newsInfoModel.title = dict[@"data"][@"product"][@"title"];
        _newsInfoModel.desc = dict[@"data"][@"product"][@"desc"];
        _newsInfoModel.price = dict[@"data"][@"product"][@"price"];
        _newsInfoModel.url = dict[@"data"][@"product"][@"url"];
        NSArray *picArray = dict[@"data"][@"product"][@"pic"];
        for (NSDictionary *picDict in picArray) {
            ProductNewsInfoPicModel *picModel = [[ProductNewsInfoPicModel alloc]init];
            picModel.pic = picDict[@"pic"];
            [_newsInfoModel.pic addObject:picModel];
        }
        //更新数据
        [self updateData];
        
    } failBlock:^(NSError *error) {
        NSLog(@"error :%@",error);
    }];
}

- (void)setUpScrollView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.scrollView  = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.scrollView];
    
    self.loopScrollView = [HYBLoopScrollView loopScrollViewWithFrame:CGRectMake(0, 0, FScreenWidth, FScreenWidth) imageUrls:@[@"Fplaceholder",@"Fplaceholder"] timeInterval:0.5 didSelect:NULL didScroll:NULL];
    [self.scrollView addSubview:self.loopScrollView];
}

- (void)setUpLabels {
    UIImageView *titleBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, FScreenWidth, 64)];
    titleBackView.image = [UIImage imageNamed:@"titleBack"];
    [self.scrollView addSubview:titleBackView];
    
    CGFloat titleLabelY = CGRectGetMaxY(self.loopScrollView.frame)+PaddingTop;
    CGFloat titleLabelH = 21;
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,titleLabelY , FScreenWidth,titleLabelH)];
    self.titleLabel.font  =[UIFont systemFontOfSize:13];
    self.titleLabel.textColor = [UIColor darkGrayColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:self.titleLabel];
    
    CGFloat priceLabelY = CGRectGetMaxY(self.titleLabel.frame)+PaddingTop;
    CGFloat priceLabelH = 18;
    self.priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, priceLabelY, FScreenWidth, priceLabelH)];
    self.priceLabel.textColor = FBaseColor;
    self.priceLabel.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:self.priceLabel];
    
    CGFloat desLabelY = CGRectGetMaxY(self.priceLabel.frame)+PaddingTop*2;
    CGFloat deslabelW = FScreenWidth - PaddingTop*2;
     self.desLabel = [[UILabel alloc]initWithFrame:CGRectMake(PaddingTop, desLabelY, deslabelW,100)];
    self.desLabel.textColor = [UIColor grayColor];
    self.desLabel.font = [UIFont systemFontOfSize:13];
    self.desLabel.numberOfLines = 0;
    [self.scrollView addSubview:self.desLabel];
    
}

- (void)setUpButtons {
    CGFloat btnW = 30;
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, btnW, btnW)];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(8, 10, 8, 10);
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    CGFloat buyBtnW = 70;
    CGFloat buyBtnH = 26;
    CGFloat buyBtnX = FScreenWidth-buyBtnW-PaddingTop;
    CGFloat buyBtnY = FScreenHeight - buyBtnH - PaddingTop;
    UIButton *buyBtn = [[UIButton alloc]initWithFrame:CGRectMake(buyBtnX, buyBtnY, buyBtnW, buyBtnH)];
    [buyBtn setImage:[UIImage imageNamed:@"buy"] forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(buyBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buyBtn];
}

//点击返回按钮
- (void)backClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

//点击购买按钮
- (void)buyBtnClicked {
    NSLog(@"购买点击按钮");
    HomeProductViewController *productVC = [[HomeProductViewController alloc]initWithUrlString:self.newsInfoModel.url];
    [self.navigationController pushViewController:productVC animated:YES];
}

//更行数据
- (void)updateData {
    NSMutableArray *imgUrls = [NSMutableArray new];
    for (ProductNewsInfoPicModel *picModel in self.newsInfoModel.pic) {
        [imgUrls addObject:picModel.pic];
    }
    self.loopScrollView.imageUrls = imgUrls;
    
    self.titleLabel.text = self.newsInfoModel.title;
    
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",self.newsInfoModel.price];
    
    CGFloat desLabelH = [self.newsInfoModel.desc boundingRectWithSize:CGSizeMake(FScreenWidth - PaddingTop*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
    self.desLabel.mj_h = desLabelH;
    self.desLabel.text = self.newsInfoModel.desc;
    
    CGFloat contentH = CGRectGetMaxY(self.desLabel.frame)+PaddingTop*2;
    self.scrollView.contentSize = CGSizeMake(FScreenWidth, contentH);
    
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
