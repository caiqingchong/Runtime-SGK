//
//  UIEventAttributes.h
//  TabbarDemo
//
//  Created by 张张凯 on 17/2/10.
//  Copyright © 2017年 方. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UIEventAttributes : NSObject

+ (NSMutableDictionary *)getEventAttributes:(UIView *)view andUI:(NSString *)eventName;

+ (NSString *)getEventText:(UIView *)view;

+ (NSString *)getControllerName:(NSString *)controllerName eventText:(NSString *)eventName eventUI:(NSString *)eventUI indexForView:(NSString *)index;


@end
