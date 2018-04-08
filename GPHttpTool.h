//
//  GPHttpTool.h
//  仿手工课
//
//  Created by 张张凯 on 17/3/6.
//  Copyright © 2017年 zhangkai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface GPHttpTool : NSObject
//设置get/post方法
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void(^)(id))success failure:(void(^)(NSError *error))failure;

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void(^)(id))success failure:(void(^)(NSError *error))failure;

@end
