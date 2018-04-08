//
//  UITabBar+Swizzling.m
//  TabbarDemo
//
//  Created by 张张凯 on 16/12/8.
//  Copyright © 2016年 方. All rights reserved.
//

#import "UITabBar+Swizzling.h"
#import "NSObject+Swizzling.h"
#import <objc/runtime.h>
#import "UIEventAttributes.h"


@implementation UITabBar (Swizzling)

//获取Tabbar点击事件监控。不能再按钮类别中单独的获取事件，这样会导致数据出现问题。
+ (void)load{    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodSwizzlingWithOriginalSelector:@selector(hitTest:withEvent:) bySwizzledSelector:@selector(s_hitTest:withEvent:)];
    });
}

//可以在这里实现监测Tabbar点击监测   事件的获取建立在电机的情况下
- (UIView *)s_hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    for (UIView *childView in self.subviews){
        
#pragma mark 判断每一个控件中的text值
    if (![childView isKindOfClass:NSClassFromString(@"UITabBarButton")]){
        
    if (!self.clipsToBounds && !self.hidden && self.alpha > 0) {
        UIView *result = [super hitTest:point withEvent:event];
        
//        NSLog(@"点击的按钮的按钮：%@",result);
        
        if (result) {
            //在这里可以获知点击的是第几个tabbar  上传数据，以供判断   上传坐标数据
            
            float x = result.frame.origin.x;
            float w = result.frame.size.width;
        
            int tabIndex = x/w;
//            NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~~~~收到的控件result：%@",result);
#pragma mark 进一步判别自定义控件。
            for (id obj in [result subviews]) {
                UIView * litSubview = (UIView *)obj;
                
                if (litSubview.opaque == NO || litSubview.opaque == YES) {
                    
                    //在这里也要遍历一下它的text尽量获取
                    NSString *litSubText = [UIEventAttributes getEventText:litSubview];
                    NSString *litSubID = [UIEventAttributes getControllerName:NSStringFromClass(result.superview.class) eventText:litSubText eventUI:@"UITabBarButton" indexForView:[NSString stringWithFormat:@"%ld",result.tag]];
//                 NSLog(@"点击的按钮的按钮litSubview：%@",litSubText);
                    
                    
                }
              }

#pragma mark 系统控件生成ID规则
//            NSString *tabBarID = [UIEventAttributes getControllerName:NSStringFromClass(result.superview.class) eventText:@"UITabBar" eventUI:@"UITabBarButton" indexForView:[NSString stringWithFormat:@"%d",tabIndex]];
            
            
            
//            NSLog(@"---------~~~~~~~~~~~~~~~~~~~~~~~~~~点击后获取的UITabBarButton:%@-------------%@",result,tabBarID);
            return result;
        }
      }
    }
    
    }
    return nil;
}




@end
