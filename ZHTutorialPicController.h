//
//  ZHTutorialPicController.h
//  仿手工课
//
//  Created by 张张凯 on 17/3/3.
//  Copyright © 2017年 zhangkai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHTutorialPicController : UICollectionViewController

@property (nonatomic, strong) NSArray *evenythingS;
@property (nonatomic, strong) NSArray *twoSizeS;
@property (nonatomic, strong) NSArray *thrreSizeS;
@property (nonatomic, strong) NSArray *fourSizeS;
@property (nonatomic, strong) NSArray *timeS;
@property (nonatomic, strong) NSArray *hotS;
@property (nonatomic, strong) NSArray *evenythingImageS;
@property (nonatomic, strong) NSArray *timeImageS;
@property (nonatomic, strong) NSArray *hotImageS;

@property (nonatomic, copy) NSString *lastId; // 标记
@property (nonatomic, strong) NSMutableArray *DataS; // 请求数据模型数组
@property (nonatomic, copy) NSString *cateId;
@property (nonatomic, copy) NSString *gacate;
@property (nonatomic, copy) NSString *pubtime;
@property (nonatomic, copy) NSString *oreder;

@end
