

//
//  UIEventAttributes.m
//  TabbarDemo
//
//  Created by 张张凯 on 17/2/10.
//  Copyright © 2017年 方. All rights reserved.
//

#import "UIEventAttributes.h"
#import "MyMD5.h"
//当前设备的屏幕宽度

#define KSCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width

//当前设备的屏幕高度

#define KSCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height

@implementation UIEventAttributes
//返回事件属性，放到数组中，之后发送到服务器中。  或者用字典更好，和后台约定接收参数，这样更有利于数据提取
+ (NSMutableDictionary *)getEventAttributes:(UIView *)view andUI:(NSString *)eventName{
    NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithCapacity:10];
    float Add_Y;//用来计算相对于window的坐标
    if ([eventName isEqualToString:@"UITabBarButton"]) {
        Add_Y = KSCREEN_HEIGHT-49;
    }else if([eventName isEqualToString:@"UINavigationButton"]){
        Add_Y = 20;//手机状态栏的高度加上，获取的坐标是相对于UINavigationBar的坐标
    }else if([eventName isEqualToString:@"UIButton"]){//如果有按钮的父视图，要加上父视图的坐标保证准确性
        Add_Y = 0;
    }
    
    NSString *B_X = [NSString stringWithFormat:@"%.1f",view.frame.origin.x];
    NSString *B_Y = [NSString stringWithFormat:@"%.1f",view.frame.origin.y+Add_Y];
    
    
    
    NSString *B_W = [NSString stringWithFormat:@"%.1f",view.frame.size.width];
    NSString *B_H = [NSString stringWithFormat:@"%.1f",view.frame.size.height];
    NSString *B_A = [NSString stringWithFormat:@"%.2f",view.alpha];
    NSString *B_O = (view.opaque||!view.hidden)?@"YES":@"NO";
    
    [mdic setObject:B_X forKey:@"b_x"];
    [mdic setObject:B_Y forKey:@"b_y"];
    [mdic setObject:B_W forKey:@"b_w"];
    [mdic setObject:B_H forKey:@"b_h"];
    [mdic setObject:B_A forKey:@"b_a"];
    [mdic setObject:B_O forKey:@"b_o"];
    
    return mdic;
}


//返回事件名称  这个只是针对UIButton
+ (NSString *)getEventText:(UIView *)view{
    NSString *eventText = [[NSString alloc]init];
    
    if ([NSStringFromClass(view.class) isEqualToString:@"UIButtonLabel"]) {
        NSArray *arr = [NSArray arrayWithObject:view];
        
        NSString *UIButtonLabel = [NSString stringWithFormat:@"%@",arr[0]];
        
        NSArray *zomeArr = [UIButtonLabel componentsSeparatedByString:@"'"];
        eventText = zomeArr[1];
    }else{
    
        for (id object in [view subviews]) {
            UIView * subview = (UIView *)object;
            //测试如果没有text的话根本就不会进入下面的判断
            if ([NSStringFromClass(subview.class) isEqualToString:@"UIButtonLabel"]) {
                NSArray *arr = [NSArray arrayWithObject:subview];
                
                NSString *UIButtonLabel = [NSString stringWithFormat:@"%@",arr[0]];
                
                NSArray *zomeArr = [UIButtonLabel componentsSeparatedByString:@"'"];
                eventText = zomeArr[1];
            }
            
        }
        //在没有text的时候设置返回text名称（也可以不设置）
        if (eventText == nil || [eventText isEqualToString:@""]) {
            eventText = @"无名事件";
        }

    }
        return eventText;
}

#pragma mark 生成事件ID  父类名
//你要传值过来事件名称  控件text、控件UI、控件在整个view tree中的路径   也要获取当前的页面
+ (NSString *)getControllerName:(NSString *)controllerName eventText:(NSString *)eventName eventUI:(NSString *)eventUI indexForView:(NSString *)index{
//    NSLog(@"存储的当前页面: %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"className"]);
    NSString *eventID = [NSString stringWithFormat:@"%@%@%@%@",controllerName,eventName,index,eventUI];
    NSString *MD5EventID = [MyMD5 md5:eventID];
    NSLog(@"------存储是否相同：%@----------eventID:%@---------MD5EventID:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"className"],eventID,MD5EventID);
    return MD5EventID;
}





@end
