//
//  TabelViewModel.m
//  FineGoods
//
//  Created by qianfeng on 16/1/19.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "TabelViewModel.h"

@implementation TabelViewModel

@end
@implementation Data_Modle

//+ (NSDictionary *)objectClassInArray{
//    return @{@"list" : [List_Model class]};
//}

@end


@implementation List_Model

//+ (NSDictionary *)objectClassInArray{
//    return @{@"product" : [Product_Model class], @"tags" : [Tags_Model class], @"pics" : [Pics_Model class]};
//}

@end


@implementation Dynamic_Model

@end


@implementation Author_Model

@end


@implementation Product_Model
+(JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"id_tabelView"}];
}
@end


@implementation Tags_Model

@end


@implementation Pics_Model

@end


