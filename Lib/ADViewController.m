//
//  ADViewController.m
//  TRSTest7.26
//
//  Created by 张张凯 on 16/7/26.
//  Copyright © 2016年 zhangkai. All rights reserved.
//

#import "ADViewController.h"

@interface ADViewController ()<UIWebViewDelegate>{
    
    NSString *titleHtmlInfo;
    NSString *strurl;
}

@end

@implementation ADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    strurl=@"http://www.jianshu.com/p/0c6f3f4b3b34";
    
    UIWebView *web = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    web.delegate = self;
    
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strurl]]];
    
    [self.view addSubview:web];
    
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeSystem];
    but.frame = CGRectMake(0, 0, 50, 50);
    but.backgroundColor = [UIColor redColor];
    [but addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
    UIButton *but1 = [UIButton buttonWithType:UIButtonTypeSystem];
    but1.frame = CGRectMake(0, 100, 50, 50);
    but1.backgroundColor = [UIColor redColor];
    [but1 addTarget:self action:@selector(click1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but1];
    
    
//    [TRSRequest eventKey:@"推送设置" eventType:@"个性化设置" eventValueString:@"open"];
//    [TRSRequest eventItem:@"产品型号" eventItemName:@"广告名称" eventItemType:@"广告位"];
}

//网页代理里面获取网页标题
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //获取网页title
    
    NSString *htmlTitle = @"document.title";
    //获取网页标题
    //    NSString *titleHtmlInfo = [webView stringByEvaluatingJavaScriptFromString:htmlTitle];
    
    //如今日头条APP：推荐--->图文新闻类型--->美航母在南海航行 日媒：或欲在仲裁公布前牵制中国
    
//    [TRSRequest referView:@"推荐" andCurrentView:@"图文新闻" andCurrentDocTitle:[webView stringByEvaluatingJavaScriptFromString:htmlTitle] andDocID:@"857"];

}

//进入统计页面
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}

//离开统计页面
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    
}

- (void)click1{
    NSLog(@"进行点击支付统计");
    //如果没有必填的值，那么非必填的值就没有意义，这是对象和属性的关系，人和影子
   
    
}


//- (void)click{
//    [self dismissViewControllerAnimated:YES completion:^{
//        NSLog(@"--------返回主界面");
//    }];
//    
//    //    [self.navigationController popViewControllerAnimated:YES];
//    
//}


@end
