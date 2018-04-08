//
//  ZHTutorialTableViewController.m
//  仿手工课
//
//  Created by 张张凯 on 17/3/2.
//  Copyright © 2017年 zhangkai. All rights reserved.
//

#import "ZHTutorialTableViewController.h"

@interface ZHTutorialTableViewController ()

@end

@implementation ZHTutorialTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundColor:[UIColor redColor]];

    [self addNavTitleView];
    [self addChildVC];
}

#pragma mark - 初始化
- (void)addNavTitleView
{
    __weak typeof(self) weakSelf = self;
    ZHNavTitleView *titleView = [[ZHNavTitleView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.6, 44) block:^(UIButton *button) {
        //这里添加于按钮相关联的界面，scrollerview
//        [weakSelf.containView updateVCViewFromIndex:button.tag];
        NSLog(@"店家按钮的tag:%ld",button.tag);
    }];
    self.titleView = titleView;
#pragma mark 把包含三个按钮的UIView放到navigationItem上面，实现点击方法
    self.navigationItem.titleView = titleView;
}

- (void)addChildVC{
    self.picVc = [[ZHTutorialPicController alloc]init];
    [self addChildViewController:self.picVc];


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
