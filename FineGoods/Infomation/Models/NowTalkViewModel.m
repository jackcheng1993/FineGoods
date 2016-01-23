//
//  NowTalkViewModel.m
//  FineGoods
//
//  Created by qianfeng on 16/1/18.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "NowTalkViewModel.h"

@implementation NowTalkViewModel



@end


@implementation DataModel

@end


@implementation SubjectModel

+(JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"description":@"description_read"}];
}


@end


@implementation DynamicModel

+ (NSDictionary *)objectClassInArray{
    return @{@"rank_list" : [Rank_Listmodel class]};
}

@end


@implementation Current_UserModel

@end


@implementation Rank_Listmodel

@end


@implementation AuthorModel

@end


