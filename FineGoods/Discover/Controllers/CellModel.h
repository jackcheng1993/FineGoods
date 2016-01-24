//
//  CellModel.h
//  FineGoods
//
//  Created by qianfeng on 16/1/23.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface AuthorrModel : JSONModel

@property (nonatomic, copy)NSString *user_id;
@property (nonatomic, copy)NSString *nickname;
@property (nonatomic, copy)NSString *avatar;
@property (nonatomic, copy)NSString *is_official;

@end

@protocol AttentionModel
@end

@interface AttentionModel : JSONModel

@property (nonatomic, copy)NSString *user_id;
@property (nonatomic, copy)NSString *nickname;
@property (nonatomic, copy)NSString *avatar;
@property (nonatomic, copy)NSString *is_official;

@end

@interface DynamiccModel : JSONModel

@property (nonatomic, copy)NSString *views;
@property (nonatomic, copy)NSString *attentions;
@property (nonatomic, copy)NSString *posts;

@end

@interface InfoModel : JSONModel

@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *pic1;
@property (nonatomic, copy)NSString *pic2;
@property (nonatomic, copy)NSString *pic3;
@property (nonatomic, copy)NSString *create_time;
@property (nonatomic, copy)NSString *update_time;
@property (nonatomic, strong)AuthorrModel *author;
@property (nonatomic, strong)NSMutableArray<AttentionModel> *attention_users;
@property (nonatomic, strong)DynamiccModel *dynamic;
@property (nonatomic, copy)NSString *attention_type;
@property (nonatomic, copy)NSString *desc;
@property (nonatomic, copy)NSString *share_url;

@end

@protocol TagsssModel
@end

@interface TagsssModel : JSONModel

@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *name;

@end

@protocol PicsMModel
@end

@interface PicsMModel : JSONModel
@property (nonatomic, copy)NSString *url;
@property (nonatomic, copy)NSString *tags;
@property (nonatomic, copy)NSString *width;
@property (nonatomic, copy)NSString *height;
@end

@protocol likesModel <NSObject>
@end

@interface likesModel : JSONModel
@end

@interface DDynamiccModel : JSONModel

@property (nonatomic, copy)NSString *praises;
@property (nonatomic, copy)NSString *views;
@property (nonatomic, copy)NSString *comments;
@property (nonatomic, copy)NSString *likes;
@property (nonatomic, copy)NSString *is_collect;
@property (nonatomic, copy)NSString *is_comment;
@property (nonatomic, copy)NSMutableArray<likesModel> *likes_users;

@end

@protocol  PProductModel
@end

@interface PProductModel : JSONModel

@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *price;
@property (nonatomic, copy)NSString *url;
@property (nonatomic, copy)NSString *category_id;
@property (nonatomic, copy)NSString *item_id;
@property (nonatomic, copy)NSString *platform;
@property (nonatomic, copy)NSString *desc;
@property (nonatomic, copy)NSString *pic;

@end

@interface AAuthorrModel : JSONModel

@property (nonatomic, copy)NSString *user_id;
@property (nonatomic, copy)NSString *nickname;
@property (nonatomic, copy)NSString *avatar;
@property (nonatomic, copy)NSString *is_official;
@property (nonatomic, copy)NSString *attention_type;

@end

@protocol CCommentsModel
@end

@interface CCommentsModel : JSONModel
@end

@protocol PostModel
@end

@interface PostModel : JSONModel

@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *content;
@property (nonatomic, copy)NSString *author_id;
@property (nonatomic, strong)NSMutableArray<TagsssModel> *tags;
@property (nonatomic, copy)NSString *i_tags;
@property (nonatomic, copy)NSString *relation_id;
@property (nonatomic, copy)NSString *create_time;
@property (nonatomic, copy)NSString *publish_time;
@property (nonatomic, copy)NSString *datestr;
@property (nonatomic, strong)NSMutableArray<PicsMModel> *pics;
@property (nonatomic, strong)DDynamiccModel *dynamic;
@property (nonatomic, strong)NSMutableArray<PProductModel> *product;
@property (nonatomic, strong)AAuthorrModel *author;
@property (nonatomic, copy)NSString *share_url;
@property (nonatomic, copy)NSString *is_recommend;
@property (nonatomic, strong)NSMutableArray<CCommentsModel> *comments;

@end

@protocol SelfPostModel
@end

@interface SelfPostModel : JSONModel

@end

@interface CellDateModel : JSONModel

@property (nonatomic, strong)InfoModel *info;
@property (nonatomic, strong)NSMutableArray<PostModel> *post_list;
@property (nonatomic, strong)NSMutableArray<SelfPostModel> *self_post_list;

@end

@interface CellModel : JSONModel

@property (nonatomic, copy)NSString *status;
@property (nonatomic, copy)NSString *msg;
@property (nonatomic, copy)NSString *ts;
@property (nonatomic, strong)CellDateModel *data;


@end
