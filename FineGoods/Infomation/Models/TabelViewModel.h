//
//  TabelViewModel.h
//  FineGoods
//
//  Created by qianfeng on 16/1/19.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class Data_Modle,List_Model,Dynamic_Model,Author_Model,Product_Model,Tags_Model,Pics_Model;

@interface Product_Model : JSONModel

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *id_tabelView;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *category_id;

@property (nonatomic, copy) NSString *platform;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, copy) NSString *item_id;

@property (nonatomic, copy) NSString *url;

@end
@protocol Tags_Model



@end

@interface Tags_Model : JSONModel

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *name;

@end

@protocol Pics_Model



@end
@interface Pics_Model : JSONModel

@property (nonatomic, copy) NSString *tags;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, assign) NSInteger height;

@end



@interface Dynamic_Model : JSONModel

@property (nonatomic, copy) NSString *comments;

@property (nonatomic, strong) NSArray *likes_users;

@property (nonatomic, assign) BOOL is_comment;

@property (nonatomic, copy) NSString *praises;

@property (nonatomic, copy) NSString *views;

@property (nonatomic, copy) NSString *likes;

@property (nonatomic, assign) BOOL is_collect;

@end

@interface Author_Model : JSONModel

@property (nonatomic, assign) NSInteger attention_type;

@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger is_official;

@property (nonatomic, copy) NSString *avatar;

@end
@protocol List_Model


@end

@interface List_Model : JSONModel

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *relation_id;

@property (nonatomic, copy) NSString *is_recommend;

@property (nonatomic, strong) NSArray *comments;

@property (nonatomic, strong) Author_Model *author;

@property (nonatomic, copy) NSString *datestr;

@property (nonatomic, strong) NSArray<Product_Model *> *product;

@property (nonatomic, strong) NSArray<Tags_Model > *tags;

@property (nonatomic, strong) Dynamic_Model *dynamic;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *author_id;

@property (nonatomic, copy) NSString *share_url;

@property (nonatomic, copy) NSString *publish_time;

@property (nonatomic, copy) NSString *create_time;

@property (nonatomic, copy) NSString *i_tags;

@property (nonatomic, strong) NSArray<Pics_Model > *pics;

@property (nonatomic, copy) NSString *content;

@end

@interface Data_Modle : JSONModel

@property (nonatomic, strong) NSArray<List_Model> *list;

@end

@interface TabelViewModel : JSONModel

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger ts;

@property (nonatomic, strong) Data_Modle *data;

@property (nonatomic, copy) NSString *msg;

@end



