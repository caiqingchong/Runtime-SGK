//
//  GPHttpTool.m
//  仿手工课
//
//  Created by 张张凯 on 17/3/6.
//  Copyright © 2017年 zhangkai. All rights reserved.
//

#import "GPHttpTool.h"

@implementation GPHttpTool


#pragma mark 怎么获取数据呢
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void(^)(id))success failure:(void(^)(NSError *error))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);

    }];
}

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void(^)(id))success failure:(void(^)(NSError *error))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);

    }];
    
}


@end
