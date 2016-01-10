//
//  NetWorkingManager.m
//  FineGoods
//
//  Created by qianfeng on 16/1/10.
//  Copyright © 2016年 Aili. All rights reserved.
//

#import "NetWorkingManager.h"
//#import "FAppModel.h"
//#import <AFNetworking/AFNetworking.h>

@interface NetWorkingManager ()
@end

@implementation NetWorkingManager


+ (void)getRequestWithUrl:(NSString *)urlString parameters:(NSDictionary *)parameters pageType:(NSString *)pageType successBlock:(FetchDateSuccessBlock)successBlock failBlock:(FetchDateFailBlock)failBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlString parameters:nil progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        successBlock (dict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failBlock) failBlock(error);
    }];

}

+ (void)postRequestWithUrl:(NSString *)urlString parameters:(NSDictionary *)parameters pageType:(NSString *)pageType successBlock:(FetchDateSuccessBlock)successBlock failBlock:(FetchDateFailBlock)failBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        successBlock (dict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failBlock) failBlock(error);
    }];
}
@end
