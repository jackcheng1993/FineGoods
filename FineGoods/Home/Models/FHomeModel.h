//
//  FHomeModel.h
//  FineGoods
//
//  Created by qianfeng on 16/1/12.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "FAppModel.h"


@interface FHomeModel : JSONModel
@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger ts;

@property (nonatomic, strong) NSArray<FAppTopicModel> *data;

@property (nonatomic, copy) NSString *msg;
@end
