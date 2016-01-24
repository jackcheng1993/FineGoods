//
//  ButtonModel.h
//  FineGoods
//
//  Created by qianfeng on 16/1/22.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol ButtonListModel
@end

@protocol TagsModel
@end

@interface TagsModel : JSONModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;

@end

@protocol PicsModel
@end

@interface PicsModel : JSONModel

@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *tags;
@property (nonatomic, copy) NSString *width;
@property (nonatomic, copy) NSString *height;

@end

@protocol likeUserModel
@end

@interface likeUserModel : JSONModel
@end

@interface DynamicModel : JSONModel
@property (nonatomic, copy) NSString *praises;
@property (nonatomic, copy) NSString *views;
@property (nonatomic, copy) NSString *comments;
@property (nonatomic, copy) NSString *likes;
@property (nonatomic, copy) NSString *is_collect;
@property (nonatomic, copy) NSString *is_comment;
@property (nonatomic, strong) NSArray<likeUserModel> *likes_users;
@end

@protocol ProductModel
@end

@interface ProductModel : JSONModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *category_id;
@property (nonatomic, copy) NSString *item_id;
@property (nonatomic, copy) NSString *platform;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *pic;

@end

@interface AuthorModel : JSONModel

@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *is_official;
@property (nonatomic, copy) NSString *attention_type;

@end

@protocol CommentsModel
@end

@interface at_userModel : JSONModel

@property (nonatomic, copy) NSString<Optional> *user_id;
@property (nonatomic, copy) NSString<Optional> *nickname;
@property (nonatomic, copy) NSString<Optional> *avatar;
@property (nonatomic, copy) NSString<Optional> *is_official;

@end

@interface commentsProductModel : JSONModel

@end

@interface CommentsModel : JSONModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *conent;
@property (nonatomic, copy) NSString *dateline;
@property (nonatomic, copy) NSString *datestr;
@property (nonatomic, copy) NSString *praise;
@property (nonatomic, copy) NSString *reply;
@property (nonatomic, copy) NSString *is_praise;
@property (nonatomic, copy) NSString *is_hot;
@property (nonatomic, strong) at_userModel *at_user;
@property (nonatomic, strong) commentsProductModel *product;
@property (nonatomic, copy) NSString *is_official;
@end

@interface ButtonListModel : JSONModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *author_id;
@property (nonatomic, strong) NSMutableArray<TagsModel> *tags;
@property (nonatomic, copy) NSString *i_tags;
@property (nonatomic, copy) NSString *relation_id;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *publish_time;
@property (nonatomic, copy) NSString *datestr;
@property (nonatomic, strong) NSMutableArray<PicsModel> *pics;
@property (nonatomic, strong) DynamicModel *dynamic;
@property (nonatomic, strong) NSMutableArray<ProductModel> *product;
@property (nonatomic, strong) AuthorModel *author;
@property (nonatomic, copy) NSString *share_url;
@property (nonatomic, copy) NSString *is_recommend;
@property (nonatomic, strong) NSMutableArray<CommentsModel> *comments;


@end

@interface ButtonDataModel : JSONModel

@property (nonatomic, strong) NSMutableArray<ButtonListModel> *list;

@end


@interface ButtonModel : JSONModel

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, assign) NSInteger ts;
@property (nonatomic, strong) ButtonDataModel *data;

@end
