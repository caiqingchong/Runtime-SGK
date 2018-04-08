
//
//  ZHTabBarController.m
//  仿手工课
//
//  Created by 张张凯 on 17/3/1.
//  Copyright © 2017年 zhangkai. All rights reserved.
//
#import "ZHTabBarController.h"
#import "ZHHomController.h"
#import "ZHHandTableViewController.h"
#import "ZHFairTableViewController.h"
#import "ZHMyTableViewController.h"
#import "ZHTutorialTableViewController.h"

#define kClassKey   @"rootVCClassString"
#define kTitleKey   @"title"
#define kImgKey     @"imageName"
#define kSelImgKey  @"selectedImageName"

@interface ZHTabBarController ()

@end

@implementation ZHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addChileVC];
    
}
//要创建一个Nav来接收这些页面
- (void)addChileVC{
    //创建最便捷的写法，把他们都集中起来处理
    NSArray *childItemsArray = @[
                                 @{kClassKey  : @"ZHHomController",
                                   kTitleKey  : @"首页",
                                   kImgKey    : @"icon_jiaocheng_",
                                   kSelImgKey : @"icon_jiaocheng_s"},
                                 
                                 @{kClassKey  : @"ZHTutorialTableViewController",
                                   kTitleKey  : @"教程",
                                   kImgKey    : @"icon_ketang_",
                                   kSelImgKey : @"icon_ketang_s"},
                                 
                                 @{kClassKey  : @"ZHHandTableViewController",
                                   kTitleKey  : @"手工圈",
                                   kImgKey    : @"icon_shougongquan_",
                                   kSelImgKey : @"icon_shougongquan_s"},
                                 
                                 @{kClassKey  : @"ZHFairTableViewController",
                                   kTitleKey  : @"市集",
                                   kImgKey    : @"icon_shiji_",
                                   kSelImgKey : @"icon_shiji_s"},
                                 
                                 @{kClassKey  : @"ZHMyTableViewController",
                                   kTitleKey  : @"我的",
                                   kImgKey    : @"icon_wode_",
                                   kSelImgKey : @"icon_wode_s"}];

    [childItemsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        self.vc = [[NSClassFromString(obj[kClassKey]) alloc] init];
        self.vc.title = obj[kTitleKey];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:self.vc];
        //设置标题、图片与被点击图片
        UITabBarItem *item = nav.tabBarItem;
        item.title = obj[kTitleKey];
        item.image = [UIImage imageNamed:obj[kImgKey]];
        item.selectedImage = [[UIImage imageNamed:obj[kSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //设置被点击文字 设置文字属性
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]} forState:UIControlStateSelected];
        
        [self addChildViewController:nav];
       
    }];
    
    
    
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
