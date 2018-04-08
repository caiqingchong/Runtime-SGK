//
//  ZHTutorialTableViewController.h
//  仿手工课
//
//  Created by 张张凯 on 17/3/2.
//  Copyright © 2017年 zhangkai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHNavTitleView.h"
#import "ZHTutorialPicController.h"

@interface ZHTutorialTableViewController : UIViewController

@property (nonatomic, weak) ZHNavTitleView *titleView;
@property (nonatomic,retain) ZHTutorialPicController *picVc;


@end
