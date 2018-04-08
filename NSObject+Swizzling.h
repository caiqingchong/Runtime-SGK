//
//  NSObject+Swizzling.h
//  SwizzlingTestOC
//
//  Created by 张张凯 on 16/11/25.
//  Copyright © 2016年 Linus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
@interface NSObject (Swizzling)

+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector bySwizzledSelector:(SEL)swizzledSelector; 
+(NSArray *)getAllProperties;
+(NSArray *)getAllMethods;
+ (NSDictionary *)getAllPropertiesAndVaules;
@end
