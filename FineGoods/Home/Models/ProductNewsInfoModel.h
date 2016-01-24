//
//  ProductNewsInfoModel.h
//  FineGoods
//
//  Created by qianfeng on 16/1/23.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ProductNewsInfoPicModel : NSObject
@property (nonatomic, copy)NSString *pic;
@end

@interface ProductNewsInfoModel : NSObject
@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *desc;
@property (nonatomic, copy)NSString *price;
@property (nonatomic, copy)NSString *url;
@property (nonatomic, strong)NSMutableArray *pic;
@end

