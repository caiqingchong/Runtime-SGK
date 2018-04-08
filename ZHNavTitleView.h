//
//  ZHNavTitleView.h
//  仿手工课
//
//  Created by 张张凯 on 17/3/2.
//  Copyright © 2017年 zhangkai. All rights reserved.
//

#import <UIKit/UIKit.h>

//设置block块   名字                   类型
typedef void (^NavTitleClickBlock) (UIButton *button);

@interface ZHNavTitleView : UIView

@property (nonatomic, strong) UIButton * previousBtn;
@property (nonatomic, strong) UIButton * currentBtn;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSMutableArray *btnArray;
@property (nonatomic,copy) NavTitleClickBlock navtitleClickBlock;

//设置block的作用是什么呢？  回调方法
- (instancetype)initWithFrame:(CGRect)frame block:(NavTitleClickBlock)block;

//设置索引
-(void)updateSelecterToolsIndex:(NSInteger )index;



@end
