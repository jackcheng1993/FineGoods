//
//  NetWorkingManager.h
//  FineGoods
//
//  Created by qianfeng on 16/1/10.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Define.h"

typedef void(^FetchDateSuccessBlock)(id object);
typedef void(^FetchDateFailBlock)(NSError *error);

@interface NetWorkingManager : NSObject

//+ (NetWorkingManager *)shareManager;

+ (void)postRequestWithUrl:(NSString *)urlString parameters:(NSDictionary *)parameters pageType:(NSString *)pageType successBlock:(FetchDateSuccessBlock)successBlock failBlock:(FetchDateFailBlock)failBlock;

+ (void)getRequestWithUrl:(NSString *)urlString parameters:(NSDictionary *)parameters pageType:(NSString *)pageType successBlock:(FetchDateSuccessBlock)successBlock failBlock:(FetchDateFailBlock)failBlock;

@end
