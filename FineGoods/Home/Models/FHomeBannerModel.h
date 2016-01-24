//
//  FHomeBannerModel.h
//  FineGoods
//
//  Created by qianfeng on 16/1/22.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import <JSONModel/JSONModel.h>




@protocol FHomeBannerDataModel

@end
@interface FHomeBannerDataModel : JSONModel
@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *pic;
@property (nonatomic, copy)NSString *tags;
@property (nonatomic, copy)NSString *likes;
@property (nonatomic, copy)NSString<Optional> *islike;
@property (nonatomic, copy)NSString *update_time;
@property (nonatomic, copy)NSString *type;
@end


@interface FHomeBannerModel : JSONModel
@property (nonatomic, copy)NSString *status;
@property (nonatomic, copy)NSString *msg;
@property (nonatomic, copy)NSString *ts;
@property (nonatomic, strong)NSArray<FHomeBannerDataModel> *data;
@end
