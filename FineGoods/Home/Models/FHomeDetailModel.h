//
//  FHomeDetailModel.h
//  FineGoods
//
//  Created by qianfeng on 16/1/18.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class FHomeDetailDataModel,FHomeDetailActivityModel,FHomeDetailProductModel,FHomeDetailPicModel,FHomeDetailLikes_ListModel;

@protocol FHomeDetailPicModel

@end
@interface FHomeDetailPicModel : JSONModel

@property (nonatomic, copy) NSString *p;

@property (nonatomic, assign) NSInteger w;

@property (nonatomic, assign) NSInteger h;

@end


@protocol FHomeDetailLikes_ListModel

@end
@interface FHomeDetailLikes_ListModel : JSONModel

@property (nonatomic, assign) NSInteger u;

@property (nonatomic, copy) NSString *a;

@end


@interface FHomeDetailModel : JSONModel

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger ts;

@property (nonatomic, strong) FHomeDetailDataModel *data;

@property (nonatomic, copy) NSString *msg;

@end

@protocol FHomeDetailProductModel

@end

@interface FHomeDetailProductModel : JSONModel

@property (nonatomic, copy) NSString *id;

@property (nonatomic, assign) NSInteger category;

@property (nonatomic, copy) NSString *comments;

@property (nonatomic, assign) BOOL iscomments;

@property (nonatomic, copy) NSString *topic_id;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *likes;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *item_id;

@property (nonatomic, copy) NSString *platform;

@property (nonatomic, strong) NSArray<FHomeDetailPicModel> *pic;

@property (nonatomic, strong) NSArray<FHomeDetailLikes_ListModel> *likes_list;

@property (nonatomic, assign) BOOL islike;

@end


@interface FHomeDetailDataModel : JSONModel

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger category;

@property (nonatomic, strong) NSArray<FHomeDetailProductModel> *product;

@property (nonatomic, copy) NSString *likes;

@property (nonatomic, copy) NSString *tags;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, copy) NSString *tag_ids;

@property (nonatomic, copy) NSString *share_pic;

@property (nonatomic, copy) NSString *share_url;

@property (nonatomic, copy) NSString *user_avatr_host;

@property (nonatomic, strong) FHomeDetailActivityModel *activity;

@property (nonatomic, assign) BOOL islike;

@property (nonatomic, copy) NSString *product_pic_host;

@end

@interface FHomeDetailActivityModel : JSONModel

@end




