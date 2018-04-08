//
//  GPNewFeatureController.m
//  仿手工课
//
//  Created by 张张凯 on 17/2/28.
//  Copyright © 2017年 zhangkai. All rights reserved.
//

#import "GPNewFeatureController.h"
#import "ZLCGuidePageView.h"
@interface GPNewFeatureController ()

@end

@implementation GPNewFeatureController

//导航页面加载到tabban中
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //引导页图片数组
    //我们就在这里进行判断如果是第一次启动就加载启动导航页，如果不是就加载广告页面
    
    NSArray *images =  @[[UIImage imageNamed:@"image1.jpg"],[UIImage imageNamed:@"image2.jpg"],[UIImage imageNamed:@"image3.jpg"],[UIImage imageNamed:@"image4.jpg"],[UIImage imageNamed:@"image5.jpg"]];
    //创建引导页视图
    ZLCGuidePageView *pageView = [[ZLCGuidePageView alloc]initWithFrame:self.view.frame WithImages:images];
    
    [self.view addSubview:pageView];
        
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
