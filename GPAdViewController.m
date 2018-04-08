//
//  GPAdViewController.m
//  仿手工课
//
//  Created by 张张凯 on 17/2/28.
//  Copyright © 2017年 zhangkai. All rights reserved.
//

#import "GPAdViewController.h"
#import "ZHTabBarController.h"
@interface GPAdViewController ()

@end

@implementation GPAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor orangeColor];
    [self setupAdimage];

}
- (void)setupAdimage
{
    self.adImageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    self.adImageView.image = [UIImage imageNamed:@"ad"];
    [self.view addSubview:self.adImageView];
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(removeAdImageView) userInfo:nil repeats:NO];
}

-(void)removeAdImageView
{
    [UIView animateWithDuration:0.3f animations:^{
        self.adImageView.transform = CGAffineTransformMakeScale(1.5f,1.5f);
        self.adImageView.alpha = 0.f;
    } completion:^(BOOL finished) {
        
        [UIApplication sharedApplication].keyWindow.rootViewController = [[ZHTabBarController alloc]init];
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
