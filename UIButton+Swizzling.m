//
//  UIButton+Swizzling.m
//  SwizzlingTestOC
//
//  Created by 张张凯 on 16/11/25.
//  Copyright © 2016年 Linus. All rights reserved.
//

#import "UIButton+Swizzling.h"
#import "NSObject+Swizzling.h"
#import "UIEventAttributes.h"
@implementation UIButton (Swizzling)
static char overlayKey;
#pragma mark 让当前类传值到事件监控的
+ (void)load{
 
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        [self methodSwizzlingWithOriginalSelector:@selector(sendAction:to:forEvent:) bySwizzledSelector:@selector(sure_SendAction:to:forEvent:)];
        
         [self methodSwizzlingWithOriginalSelector:@selector(hitTest:withEvent:) bySwizzledSelector:@selector(s_hitTest:withEvent:)];
    });

}


//分别给类别设置属性和属性调用

+ (id)garlay{
    return objc_getAssociatedObject(self, &overlayKey);
}
//重写的方法第二个必须是大写否则无用
+ (void)setGarlay:(UIView *)garlay{
    objc_setAssociatedObject(self, &overlayKey, garlay, OBJC_ASSOCIATION_ASSIGN);
    
}



//可以在这里实现监测UIButton和UINavigationButton点击监测，UITabBarButton在按钮的类别中不能实现监控
- (UIView *)s_hitTest:(CGPoint)point withEvent:(UIEvent *)event {
 
    if (!self.clipsToBounds && !self.hidden && self.alpha > 0) {
        UIView *result = [super hitTest:point withEvent:event];
        if (result) {

            //在这里要判断各种UI事件的类型,同时生成各自的事件ID。
            if([NSStringFromClass([result class]) isEqualToString:@"UIButton"]){
                //获取Text
                
                
                NSString *text = [UIEventAttributes getEventText:result];
                NSString *className = NSStringFromClass([result.superview class]);
                NSString *butID = [UIEventAttributes getControllerName:className eventText:text eventUI:@"UIButton" indexForView:[NSString stringWithFormat:@"1%ld",(long)result.tag]];
//                NSLog(@"-----------------%@",result);



            }
            else if ([NSStringFromClass([result class]) isEqualToString:@"UINavigationButton"]){
                if (result.frame.origin.x <100) {
                    
                    NSString *eventID = [UIEventAttributes getControllerName:@"" eventText:@"left" eventUI:NSStringFromClass(result.class) indexForView:@"1"];
//                    NSLog(@"~~~~~~~~~~~左边的按钮，索引设置为1~~~~~~~ID:%@",eventID);
                }else{
                    NSString *eventID = [UIEventAttributes getControllerName:@"" eventText:@"right" eventUI:NSStringFromClass(result.class) indexForView:@"2"];
//                    NSLog(@"~~~~~~~~~~~右边的按钮，索引设置为1~~~~~~~ID:%@",eventID);
                }

            }
       
            return result;
        }
        
 }
    return nil;
}

















- (NSTimeInterval)timeInterval{
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}
- (void)setTimeInterval:(NSTimeInterval)timeInterval{
    objc_setAssociatedObject(self, @selector(timeInterval), @(timeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
//当按钮点击事件sendAction 时将会执行sure_SendAction
- (void)sure_SendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    if (self.isIgnore) {
        //不需要被hook
        [self sure_SendAction:action to:target forEvent:event];
        return;
    }

    
    if ([NSStringFromClass(self.class) isEqualToString:@"UIButton"]) {
        self.timeInterval =self.timeInterval == 0 ?1:self.timeInterval;
        if (self.isIgnoreEvent){
            return;
        }else if (self.timeInterval > 0){
            [self performSelector:@selector(resetState) withObject:nil afterDelay:self.timeInterval];
        }

    }
    //此处 methodA和methodB方法IMP互换了，实际上执行 sendAction；所以不会死循环
    self.isIgnoreEvent = YES;
    [self sure_SendAction:action to:target forEvent:event];
//    unsigned int outCount = 0;
  //点击的时候也可以获取事件名称
//    NSLog(@"------------------UIButtonLabel:%@",self.subviews);
    NSArray *arr = [NSArray arrayWithObject:self.subviews];
    
    NSString *UIButtonLabel = [NSString stringWithFormat:@"%@",arr[0]];
//    NSLog(@"--------遍历UIButtonLabel:%@",UIButtonLabel);
    
    NSArray *zomeArr = [UIButtonLabel componentsSeparatedByString:@"'"];
    if(zomeArr.count == 1){
//        NSLog(@"------此按钮没有名称,无法获取数据");
    }else{
//      NSLog(@"--------点击按钮获取按钮名称:%@",zomeArr[1]);
    }

//    NSLog(@"检测到按钮方法------按钮的位置：%@----alpha:%.2lf----",self,self.alpha);
}
//runtime 动态绑定 属性
- (void)setIsIgnoreEvent:(BOOL)isIgnoreEvent{
    // 注意BOOL类型 需要用OBJC_ASSOCIATION_RETAIN_NONATOMIC 不要用错，否则set方法会赋值出错
    objc_setAssociatedObject(self, @selector(isIgnoreEvent), @(isIgnoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)isIgnoreEvent{
    //_cmd == @select(isIgnore); 和set方法里一致
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setIsIgnore:(BOOL)isIgnore{
    // 注意BOOL类型 需要用OBJC_ASSOCIATION_RETAIN_NONATOMIC 不要用错，否则set方法会赋值出错
    objc_setAssociatedObject(self, @selector(isIgnore), @(isIgnore), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)isIgnore{
    //_cmd == @select(isIgnore); 和set方法里一致
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)resetState{
    [self setIsIgnoreEvent:NO];
}



@end
