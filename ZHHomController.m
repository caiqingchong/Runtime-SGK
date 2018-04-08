//
//  ZHHomController.m
//  仿手工课
//
//  Created by 张张凯 on 17/3/2.
//  Copyright © 2017年 zhangkai. All rights reserved.
//

#import "ZHHomController.h"
#import "ZHFeaturedController.h"
#import "ZHFocusController.h"
#import "ZHDaRenController.h"
#import "ZHEventController.h"

@interface ZHHomController ()

@end

@implementation ZHHomController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor orangeColor];
    //初始化
      [self setupView];
    // 添加子控制器
    [self addAllChildVc];

}
#pragma mark - 初始化子控件
- (void)setupView{

    // 设置标题栏样式
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight) {
        *titleScrollViewColor = [UIColor whiteColor];
        *norColor = [UIColor darkGrayColor];
        *selColor = [UIColor redColor];
        *titleHeight = GPTitlesViewH;
    }];
    
    // 设置下标
    [self setUpUnderLineEffect:^(BOOL *isShowUnderLine, BOOL *isDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor) {
        
        *isShowUnderLine = YES;
        *underLineColor = [UIColor redColor];
    }];
}


- (void)addAllChildVc{
//    ZHFeaturedController *feature = [[ZHFeaturedController alloc] init];
//    feature.title = @"精选";
//    [self addChildViewController:feature];
//    
//    ZHFocusController *focus = [[ZHFocusController alloc] init];
//    focus.title = @"关注";
//    [self addChildViewController:focus];
    
    ZHDaRenController *daRenVc = [[ZHDaRenController alloc]init];
    daRenVc.title = @"达人";
    [self addChildViewController:daRenVc];
    
    ZHEventController *eventVc = [[ZHEventController alloc]init];
    eventVc.title = @"活动";
    [self addChildViewController:eventVc];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
