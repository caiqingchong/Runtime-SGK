//
//  ZHContainerView.h
//  仿手工课
//
//  Created by 张张凯 on 17/3/3.
//  Copyright © 2017年 zhangkai. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^selecBlock)(int);

@interface ZHContainerView : UIScrollView

//selecB 用来接收数据
- (instancetype)initWithChildControllerS:(NSArray *)vcArray selectBlock:(selecBlock)selecB;

//更新索引值，反馈到顶部的按钮中
-(void)updateVCViewFromIndex:(NSInteger )index;

@end
