//
//  ZHNavTitleView.m
//  仿手工课
//
//  Created by 张张凯 on 17/3/2.
//  Copyright © 2017年 zhangkai. All rights reserved.
//

#import "ZHNavTitleView.h"

#import "UIView+SDAutoLayout.h"
@implementation ZHNavTitleView

- (NSArray *)titleArray{
    if(!_titleArray){
        _titleArray = @[@"图文",@"视频",@"专题"];
    }
    return _titleArray;
}

- (NSArray *)btnArray{
    if (!_btnArray) {
        _btnArray = [[NSMutableArray alloc] init];
    }
    return _btnArray;
}

//设置block的作用是什么呢？  重写init
- (instancetype)initWithFrame:(CGRect)frame block:(NavTitleClickBlock)block{
    self = [super initWithFrame:frame];
    if (self) {
        //添加按钮
        [self addChildView];
        self.backgroundColor = [UIColor redColor];
        //自适应
        [self addlayout];
        //点击的Block块
        self.navtitleClickBlock = block;
        
    }
    return self;
}

- (void)addChildView{
    //设置完按钮的全部属性，除了frame
    for (int i = 0; i < 3; i ++) {
        UIButton *NavBtn = [[UIButton alloc]init];
        NavBtn.tag = i;
        [NavBtn setTitle:self.titleArray[i] forState:UIControlStateNormal];
        //设置文字大小
        NavBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        //设置选中和未选中状态颜色
        [NavBtn setTitleColor:[UIColor colorWithWhite:1 alpha:.5] forState:UIControlStateNormal];
        [NavBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
      
        //为按钮添加事件
        [NavBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.btnArray addObject:NavBtn];
        [self addSubview:NavBtn];
    }
}


//进行自适应
- (void)addlayout{
    //点击按钮被选中之后不能再点击
    UIButton *picBtn = self.btnArray[0];
    UIButton *videoBtn = self.btnArray[1];
    UIButton *subBtn = self.btnArray[2];
//    picBtn.backgroundColor = [UIColor redColor];
//    videoBtn.backgroundColor = [UIColor redColor];
//    subBtn.backgroundColor = [UIColor redColor];
    //竖条
    UIView *leftLine = [[UIView alloc]init];
    leftLine.backgroundColor = [UIColor colorWithWhite:1 alpha:.6];
    [self addSubview:leftLine];
    
    UIView *rightLine = [[UIView alloc]init];
    rightLine.backgroundColor = [UIColor colorWithWhite:1 alpha:.6];
    [self addSubview:rightLine];
    
    //均匀的分割成三份
    CGFloat W = SCREEN_WIDTH * 0.6 * 0.33;

    picBtn.sd_layout
    .leftSpaceToView(self,0)
    .bottomSpaceToView(self,0)
    .topSpaceToView(self,0)
    .widthIs(W);
    
    leftLine.sd_layout
    .leftSpaceToView(picBtn,0)
    .topSpaceToView(self,0)
    .bottomSpaceToView(self,0)
    .widthIs(1);
    
    videoBtn.sd_layout
    .topEqualToView(leftLine)
    .bottomEqualToView(leftLine)
    .leftSpaceToView(leftLine,0)
    .widthIs(W);
    
    rightLine.sd_layout
    .topEqualToView(videoBtn)
    .bottomEqualToView(videoBtn)
    .leftSpaceToView(videoBtn,0)
    .widthIs(1);
    
    subBtn.sd_layout
    .topEqualToView(rightLine)
    .bottomEqualToView(rightLine)
    .leftSpaceToView(rightLine,0)
    .widthIs(W);

    
}

- (void)titleClick:(UIButton *)sender{
    self.navtitleClickBlock(sender);
}

- (void)changeSelectBtn:(UIButton *)btn{

    self.previousBtn = self.currentBtn;
    self.currentBtn = btn;
    self.previousBtn.selected = NO;
    self.currentBtn.selected = YES;
    
}

//更新按钮状态
-(void)updateSelecterToolsIndex:(NSInteger)index{
    UIButton *selectBtn = self.btnArray[index];
    [self changeSelectBtn:selectBtn];
}

@end
