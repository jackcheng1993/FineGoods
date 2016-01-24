//
//  BannerProductModel.h
//  FineGoods
//
//  Created by qianfeng on 16/1/23.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@protocol BannerDataModel

@end
@interface BannerDataModel : JSONModel

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *good_id;

@property (nonatomic, copy) NSString *category;

@property (nonatomic, copy) NSString *item_id;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *likes;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *platform;

@property (nonatomic, copy) NSString *dateline;

@property (nonatomic, assign) BOOL islike;

@end



@interface BannerProductModel : JSONModel

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger ts;

@property (nonatomic, strong) NSArray<BannerDataModel> *data;

@property (nonatomic, copy) NSString *msg;

@end


