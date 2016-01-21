//
//  DiscoverModel.h
//  FineGoods
//
//  Created by qianfeng on 16/1/12.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol RecGroupsModel
@end

@interface RecGroupsModel : JSONModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pic1;
@property (nonatomic, copy) NSString *pic2;
@property (nonatomic, copy) NSString *pic3;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *update_time;
@end

@protocol buttonModel
@end

@interface buttonModel : JSONModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *sub_title;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *extend;
@property (nonatomic, copy) NSString *index;
@end

@protocol ElementsModel
@end

@interface ElementsModel : JSONModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSMutableArray<buttonModel> *elements;
@end

@protocol AttionGroupModel
@end

@interface AttionGroupModel : JSONModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pic1;
@property (nonatomic, copy) NSString *pic2;
@property (nonatomic, copy) NSString *pic3;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *update_time;

@end

@interface CGYDataModel : JSONModel
@property (nonatomic, strong) NSArray<RecGroupsModel> *rec_groups;
@property (nonatomic, copy) NSString *attention_group_size;
@property (nonatomic, strong) NSArray<ElementsModel> *module_elements;
@property (nonatomic, strong) NSArray<AttionGroupModel> *attention_groups;
@end


@interface DiscoverModel : JSONModel
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString<Optional> *msg;
@property (nonatomic, assign) NSInteger ts;
@property (nonatomic, strong) CGYDataModel *data;
@end



