//
//  ProductNewsInfoModel.m
//  FineGoods
//
//  Created by qianfeng on 16/1/23.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "ProductNewsInfoModel.h"

@implementation ProductNewsInfoModel

- (instancetype)init {
    if (self = [super init]) {
        if (self.pic == nil) {
            self.pic = [NSMutableArray new];
        }
    }
    return self;
}
@end

@implementation ProductNewsInfoPicModel

@end


