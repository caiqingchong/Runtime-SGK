//
//  ZHContainerView.m
//  仿手工课
//
//  Created by 张张凯 on 17/3/3.
//  Copyright © 2017年 zhangkai. All rights reserved.
//

#import "ZHContainerView.h"

@interface  ZHContainerView()<UIScrollViewDelegate>

@property (nonatomic, copy) selecBlock selecB;
@property (nonatomic, strong) NSArray *childVcArray;
@property (nonatomic, strong) UIView *lasetView;
@end

@implementation ZHContainerView

- (instancetype)initWithChildControllerS:(NSArray *)vcArray selectBlock:(selecBlock)selecB{
    
    if (self = [super init]) {
        self.selecB = selecB;
        //设置背景色、可滑动、下标、代理
        self.backgroundColor = [UIColor whiteColor];
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        self.delegate = self;
        
        self.childVcArray = vcArray;
        [self layout];

    }
    
    return self;
}

- (void)layout{
    UIView *lastView = nil;
    for (UIViewController *viewVC in self.childVcArray) {
        [self addSubview:viewVC.view];
        //先走else，再走if，lastview来记录最后一个页面，并为其坐标赋值。
        if(lastView){
            viewVC.view.sd_layout.widthIs(SCREEN_WIDTH)
            .heightIs(SCREEN_HEIGHT).leftSpaceToView(lastView,0);
        }else{
            //第一次加载所以是self
            viewVC.view.sd_layout.widthIs(SCREEN_WIDTH)
            .heightIs(SCREEN_HEIGHT).leftSpaceToView(self,0);
        }
        lastView = viewVC.view;
    }
    //设置最后一个界面的边缘
    [self setupAutoWidthWithRightView:lastView rightMargin:0];
}


-(void)updateVCViewFromIndex:(NSInteger )index
{
    [self setContentOffset:CGPointMake(index*SCREEN_WIDTH, 0) animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (scrollView.contentOffset.x + SCREEN_WIDTH / 2) / SCREEN_WIDTH;
    self.selecB(page);
}



@end
