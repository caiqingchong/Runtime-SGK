//
//  ZHTutorialPicController.m
//  仿手工课
//
//  Created by 张张凯 on 17/3/3.
//  Copyright © 2017年 zhangkai. All rights reserved.
//

#import "ZHTutorialPicController.h"
#import "GPTutorialPicCell.h"
#import "GPJianDaoHeader.h"
#import "GPTutoriaPicData.h"

@interface ZHTutorialPicController ()

@end

@implementation ZHTutorialPicController

static NSString * const reuseIdentifier = @"Cell";

//初始化的时候进行流水布局
- (instancetype)init{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat W = SCREEN_WIDTH*.4;
    //长宽比1.5：1
    layout.itemSize = CGSizeMake(W,W*1.5);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    return [self initWithCollectionViewLayout:layout];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置collectionCell页面坐标
    self.collectionView.contentInset = UIEdgeInsetsMake(GPTitlesViewH, 0, GPTabBarH, 0);
}
#pragma mark 初始化方法
- (void)regisCell{
    //指定具体
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GPTutorialPicCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.gacate = @"allcate";
    self.oreder = @"hot";
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self regisCell];
    [self loadData];
   
}

#pragma mark 数据处理，动画处理
- (void)loadData{
    //添加下拉刷新
    GPJianDaoHeader *header = [self addRefreshHead];
    [self addRefreshHead];
}

- (GPJianDaoHeader *)addRefreshHead{
    GPJianDaoHeader *header = [GPJianDaoHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.automaticallyChangeAlpha = YES;
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    //设置文字以及刷新状态
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"小客正在为你刷新" forState:MJRefreshStateRefreshing];
    
    //设置字体大小以及颜色
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.stateLabel.textColor = [UIColor darkGrayColor];
    //进入刷新状态
    [header beginRefreshing];
    return header;
}

- (void)loadNewData{
    //数据转模型
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"c"] = @"Course";
    params[@"a"] = @"newCourseList";
    params[@"gcate"] = self.gacate;
    params[@"order"] = self.oreder;
    params[@"vid"] = @"18";
    params[@"cate_id"] = self.cateId;
    params[@"pub_time"] = self.pubtime;
    
    __weak typeof(self) weakSelf = self;
    //先删除掉之前的数据
    [self.DataS removeAllObjects];
    
    //2、发起网络请求获取数据  我们构建自己的网络请求模块
    [GPHttpTool get:HomeBaseURl params:params success:^(id responseObj) {
        //通过字典数组创建一个模型数组
        NSArray *moreNewArray = [GPTutoriaPicData mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
        NSLog(@"获取数据：%@",moreNewArray);
        GPTutoriaPicData *picData = [moreNewArray lastObject];
        if (!picData.last_id) {
//            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        self.lastId = picData.last_id;
        [weakSelf.DataS addObjectsFromArray:moreNewArray];
        [self.collectionView reloadData];
//        [weakSelf.collectionView.mj_footer endRefreshing];

        
    } failure:^(NSError *error) {
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];


}

//瀑布流的代理和数据
#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.DataS.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GPTutorialPicCell *Piccell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    //把数据先放到数组中，然后传到collviewCell中进行赋值传值
    Piccell.picData = self.DataS[indexPath.row];
    return Piccell;
}
#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GPTutoriaPicData *pData = self.DataS[indexPath.row];
    
    XWCoolAnimator *animator = [XWCoolAnimator xw_animatorWithType:XWCoolTransitionAnimatorTypeFoldFromRight];
//    GPDaRenPicController *picVc = [[GPDaRenPicController alloc]init];
//    picVc.tagCpunt = pData.hand_id;
//    NSLog(@"index:%@",pData.hand_id);
//    //运用动画进行专场
//    [self xw_presentViewController:picVc withAnimator:animator];
}


/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
