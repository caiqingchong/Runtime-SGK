//
//  UIButton+Swizzling.h
//  SwizzlingTestOC
//
//  Created by 张张凯 on 16/11/25.
//  Copyright © 2016年 Linus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#define defaultInterval 1
@interface UIButton (Swizzling)
//点击间隔
@property (nonatomic, assign) NSTimeInterval timeInterval;
//用于设置单个按钮不需要被hook
@property (nonatomic, assign) BOOL isIgnore;

@property (nonatomic,assign) id garlay;

@end
