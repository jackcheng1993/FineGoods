//
//  FAppModel.h
//  FineGoods
//
//  Created by qianfeng on 16/1/10.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class FAppDataModel,FAppAppendExtendModel,FAppCategoryElementModel,FAppEntryListModel,FAppTopicModel,FAppBannerBottomElementModel,FAppBannerModel;


@interface FAppAppendExtendModel : JSONModel

@property (nonatomic, assign) NSInteger entry_list_index;

@end



@protocol FAppCategoryElementModel 

@end

@interface FAppCategoryElementModel : JSONModel

@property (nonatomic, copy) NSString *extend;

@property (nonatomic, copy) NSString<Optional> *sub_title;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString<Optional> *photo;

@property (nonatomic, assign) NSInteger index;

@end



@protocol FAppEntryListModel

@end

@interface FAppEntryListModel : JSONModel

@property (nonatomic, copy) NSString *extend;

@property (nonatomic, copy) NSString<Optional> *sub_title;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *photo;

@property (nonatomic, assign) NSInteger index;

@end


@protocol FAppTopicModel

@end
@interface FAppTopicModel : JSONModel

@property (nonatomic, assign) BOOL islike;

@property (nonatomic, copy) NSString *update_time;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *likes;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *tags;

@end


@protocol FAppBannerBottomElementModel

@end

@interface FAppBannerBottomElementModel : JSONModel

@property (nonatomic, copy) NSString<Optional> *extend;

@property (nonatomic, copy) NSString<Optional> *sub_title;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *photo;

@property (nonatomic, assign) NSInteger index;

@end


@protocol FAppBannerModel

@end
@interface FAppBannerModel : JSONModel

@property (nonatomic, copy) NSString *extend;

@property (nonatomic, copy) NSString<Optional> *sub_title;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *photo;

@property (nonatomic, assign) NSInteger index;

@end


@interface FAppDataModel : JSONModel

@property (nonatomic, strong) NSArray<FAppBannerModel> *banner;

@property (nonatomic, strong) NSArray<FAppBannerBottomElementModel> *banner_bottom_element;

@property (nonatomic, strong) NSArray<FAppEntryListModel> *entry_list;

@property (nonatomic, strong) NSArray *firstpage_element;

@property (nonatomic, strong) NSArray<FAppTopicModel> *topic;

@property (nonatomic, strong) NSArray<FAppCategoryElementModel> *category_element;

@property (nonatomic, strong) FAppAppendExtendModel *append_extend;

@end


@interface FAppModel : JSONModel

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger ts;

@property (nonatomic, strong) FAppDataModel *data;

@property (nonatomic, copy) NSString *msg;

@end

