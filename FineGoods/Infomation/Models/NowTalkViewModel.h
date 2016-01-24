//
//  NowTalkViewModel.h
//  FineGoods
//
//  Created by qianfeng on 16/1/18.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class DataModel,SubjectModel,DynamicModel,Current_UserModel,Rank_Listmodel,AuthorModel;

@interface Current_UserModel : JSONModel

@property (nonatomic, assign) NSInteger part_in_rank_no;

@property (nonatomic, assign) NSInteger part_in_rate;

@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger is_official;

@property (nonatomic, copy) NSString *avatar;

@end

@protocol Rank_Listmodel


@end
@interface Rank_Listmodel : JSONModel

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger is_official;

@property (nonatomic, assign) NSInteger part_in_rank_no;

@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, assign) NSInteger part_in_rate;

@property (nonatomic, assign) NSInteger attention_type;

@end


@interface AuthorModel : JSONModel

@property (nonatomic, assign) NSInteger attention_type;

@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger is_official;

@property (nonatomic, copy) NSString *avatar;

@end

//
@interface DynamicModel : JSONModel

@property (nonatomic, copy) NSString *part_in_num;

@property (nonatomic, strong) NSArray<Rank_Listmodel> *rank_list;

@property (nonatomic, strong) Current_UserModel *current_user;

@end
//
@interface SubjectModel : JSONModel

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *description_read;

@property (nonatomic, copy) NSString *pic1;

@property (nonatomic, strong) AuthorModel *author;

@property (nonatomic, copy) NSString *datestr;

@property (nonatomic, copy) NSString *tags;

@property (nonatomic, copy) NSString *start_time;

@property (nonatomic, strong) DynamicModel *dynamic;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *rank_share_url;

@property (nonatomic, copy) NSString *author_id;

@property (nonatomic, copy) NSString *share_url;

@property (nonatomic, copy) NSString *pic2;

@property (nonatomic, copy) NSString *is_recommend;

@end

@interface DataModel : JSONModel

@property (nonatomic, strong) SubjectModel *subject;

@end
//
@interface NowTalkViewModel : JSONModel

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger ts;

@property (nonatomic, strong) DataModel *data;

@property (nonatomic, copy) NSString *msg;




@end

