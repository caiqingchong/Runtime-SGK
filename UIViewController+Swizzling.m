//
//  UIViewController+Swizzling.m
//  SwizzlingTestOC
//
//  Created by Linus on 16/3/25.
//  Copyright © 2016年 Linus. All rights reserved.
//   http://www.aichengxu.com/view/6420972
//在Objective-C中，运行时会自动调用每个类的两个方法。+load会在类初始加载时调用，+initialize会在第一次调用类的类方法或实例方法之前被调用。这两个方法是可选的，且只有在实现了它们时才会被调用。由于methodswizzling会影响到类的全局状态，因此要尽量避免在并发处理中出现竞争的情况。+load能保证在类的初始化过程中被加载，并保证这种改变应用级别的行为的一致性。相比之下，+initialize在其执行时不提供这种保证—事实上，如果在应用中没为给这个类发送消息，则它可能永远不会被调用。

#import "UIViewController+Swizzling.h"
#import "NSObject+Swizzling.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import <AVFoundation/AVFoundation.h>
#import "UIEventAttributes.h"
#import "MyMD5.h"

#import "UIButton+Swizzling.h"
#define KSCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width

//当前设备的屏幕高度

#define KSCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height


@implementation UIViewController (Swizzling)

+ (void)load {
#ifdef DEBUG
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodSwizzlingWithOriginalSelector:@selector(viewDidAppear:) bySwizzledSelector:@selector(swizzledViewDidAppear:)];
        [self methodSwizzlingWithOriginalSelector:@selector(viewWillDisappear:) bySwizzledSelector:@selector(myviewWillDisappear:)];
  
    });
#endif
}



NSInteger TAG;



//我们可以在这里进行埋点，获取开始和离开界面面时间
- (void)swizzledViewDidAppear:(BOOL)animated {
    [self swizzledViewDidAppear:animated];
    
#pragma mark 不能使用类别，由于界面可能是由多个类组成，或者能选出来它本身的类
    [[NSUserDefaults standardUserDefaults] setObject:NSStringFromClass([self class]) forKey:@"className"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    

    //遍历出导航栏和tabbar，再次进行遍历，看一下是否能够遍历出来控件
    for (id object in [self.view subviews]) {
        if ([object isKindOfClass:[UIView class]]) {
            // 对 object 进行了判断，它一定是 UIView 或其子类
            UIView * view = (UIView *)object;

            //遍历UITabBar获取UITabbarItem  可以直接遍历当前页面的所有控件，然后再找出按钮
            if ([NSStringFromClass(view.class) isEqualToString:@"UITabBar"]) {
                for (id object in [view subviews]) {
                    UIView * subview = (UIView *)object;
//                    NSLog(@"获取当前页面所有控件的名称：%@",subview);
                    for (id obj in [subview subviews]) {
                        UIView * litSubview = (UIView *)obj;
                    
#pragma mark 自定义TabBar，自定义的按钮都会有opaque属性，所以。。。。。。
                        
                        if (litSubview.opaque == NO || litSubview.opaque == YES) {
                            
                            //在这里也要遍历一下它的text尽量获取
                            NSString *litSubText = [UIEventAttributes getEventText:litSubview];
                            NSMutableDictionary *dic = [UIEventAttributes getEventAttributes:litSubview andUI:@"UITabBarButton"];
                            [UIEventAttributes getControllerName:NSStringFromClass(litSubview.superview.class) eventText:litSubText eventUI:@"UITabBarButton" indexForView:[NSString stringWithFormat:@"%ld",litSubview.tag]];
//                            NSLog(@"UITabBarButton的坐标值为：%@",dic);
                        
                        }
                        
#pragma mark 系统控件UITabBarButton
                        if([NSStringFromClass(subview.class) isEqualToString:@"UITabBarButton"]){//查看余数，如果不为零则说明还有一个
                            float x = subview.frame.origin.x;
                            float w = subview.frame.size.width;
                            //由此可以得出每一个tabbar的索引值
                            int tabIndex = x/w;
                            //判断当为UITabBar时，不用类别作为生成事件ID的参数。切记切记额
                           NSString *tabBarID = [UIEventAttributes getControllerName:NSStringFromClass(subview.superview.class) eventText:@"UITabBar" eventUI:@"UITabBarButton" indexForView:[NSString stringWithFormat:@"%d",tabIndex]];
                            
                           NSLog(@"UITabBarButton获取ID：%@---------%@",tabBarID,subview);
                        }

                    }

                }
            }
      
 
            //遍历获取导航栏UINavigationBar获取按钮上传数据   UIButtonLabel
            if([NSStringFromClass(view.class) isEqualToString:@"UINavigationBar"]){
#pragma mark 自定义UINavigationBar类型，特别要注意自定义控件的实现方式，要涵盖大多数自定义控件的实现方法
                for (id object in [view subviews]) {
                    UIView * subview = (UIView *)object;
                    //自定义的Nav要进一步遍历控件，找出按钮。
                    for (id obj in [subview subviews]) {
                        UIView * litSubview = (UIView *)obj;
                        NSString *text = [[NSString alloc] init];//剥出来按钮信息，并得出坐标
                        
                        if ([NSStringFromClass(litSubview.class) isEqualToString:@"UIButton"]) {
                            //获取父视图的坐标,获取在window上的坐标
                            NSMutableDictionary *dic = [UIEventAttributes getEventAttributes:litSubview andUI:@"UIButton"];

                            float Super_X = litSubview.superview.frame.origin.x;
                            float Super_Y = litSubview.superview.frame.origin.y;
                            float but_x = [[dic objectForKey:@"b_x"] floatValue]+Super_X;
                            float but_y = [[dic objectForKey:@"b_y"] floatValue]+Super_Y;
                            [dic setObject:[NSString stringWithFormat:@"%f",but_x] forKey:@"b_x"];
                            [dic setObject:[NSString stringWithFormat:@"%f",but_y] forKey:@"b_y"];
                           
                           text = [UIEventAttributes getEventText:litSubview];
                        
                           //开始生成ID
                           NSString *butID =  [UIEventAttributes getControllerName:NSStringFromClass(litSubview.superview.class) eventText:text eventUI:@"UIButton" indexForView:[NSString stringWithFormat:@"1%ld",litSubview.tag]];
//                            NSLog(@"UINavigationBar中[litSubview subviews]所有控件信息：%@-------ButtonText:%@-------butID:%@",litSubview,text,butID);
                        }
   
                    }
                    
               
                    //应该直接遍历上面所有的控件信息，找出所有的可点击控件。并生成ID，获取坐标等属性。
#pragma mark 系统UINavigationBar类型。
                    if ([NSStringFromClass(subview.class) isEqualToString:@"UINavigationButton"]) {
                        NSString *className = [[NSUserDefaults standardUserDefaults] objectForKey:@"className"];
//                        NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~：%@",className);
                        
                        if (subview.frame.origin.x <100) {
                            NSString *eventID = [UIEventAttributes getControllerName:className eventText:@"left" eventUI:NSStringFromClass(subview.class) indexForView:@"1"];
//                            NSLog(@"~~~~~~~~~~~左边的按钮，索引设置为1~~~~~~~ID:%@",eventID);
                        }else{
                            
                            NSString *eventID = [UIEventAttributes getControllerName:className eventText:@"right" eventUI:NSStringFromClass(subview.class) indexForView:@"2"];
//                            NSLog(@"-----------右边的按钮，索引设置为2~~~~~~~ID:%@",eventID);
                        }
                       
                    }
                }
                
            }
    

            
          

         }
    }
    
    
}




// Recursively travel down the view tree, increasing the indentation level for children
- (void)dumpView:(UIView *)aView atIndent:(int)indent into:(NSMutableString *)outstring
{
    for (int i = 0; i < indent; i++) [outstring appendString:@"--"];
    aView.backgroundColor = [UIColor clearColor];
    [outstring appendFormat:@"[%2d] %@==\n", indent, [[aView class] description]];
    
    for (UIView *view in [aView subviews])
        [self dumpView:view atIndent:indent + 1 into:outstring];
}

// Start the tree recursion at level 0 with the root view
- (NSString *) displayViews: (UIView *) aView
{
    NSMutableString *outstring = [[NSMutableString alloc] init];
    [self dumpView: aView atIndent:0 into:outstring];
    return outstring;
}
// Show the tree
- (void)logViewTreeForMainWindow: (UIView *) aView
{
    //  CFShow([self displayViews: self.window]);
    NSLog(@"The view tree:\n%@", [self displayViews:aView]);
}





























- (void)myviewWillDisappear:(BOOL)animated{
    [self myviewWillDisappear:animated];
//    NSLog(@"---------myviewWillDisappear-------%@",NSStringFromSelector(_cmd));
//    NSLog(@"-----------UITabbar:%@",[self appDelegateMethods]);
}








// 保存图片

- (void)saveScreenShotsView

{
    
    UIImage *image = [self getNormalImage:self.view];
    
    //这里存储的图片放到了相册中去了，完全不必
    //    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    
    
    
    [self saveToDisk:image];
    
    NSLog(@"结束");
    
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation

{
    
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    
}



#pragma mark - 获取屏幕截图

- (UIImage *)getNormalImage:(UIView *)view

{
    
    UIGraphicsBeginImageContext(CGSizeMake(KSCREEN_WIDTH, KSCREEN_HEIGHT));
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:context];
    
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}



#pragma mark - 保存到硬盘中
//我们并不需要存储到相册中，可以存储到自己创建的一个文件夹中，可以设定一段时间之后进行删除掉数据，或者直接有不同的界面进行替换掉数据。
//11.23 怎么实现摇一摇
- (void)saveToDisk:(UIImage *)image

{
    
    //    NSString *dirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //
    //    NSFileManager *manager = [NSFileManager defaultManager];
    //
    //    NSLog(@"保存路径： %@", dirPath);
    //
    //
    //  0=NO 1=YES;
    NSLog(@"%i",[[self class] createVideoFolderIfNotExist]);
    NSString *picpath =[NSString stringWithFormat:@"%@/tmp/",NSHomeDirectory()];
    
    NSString *dirPath = [picpath stringByAppendingPathComponent:@"Picture"];
    
    
    //对于图片，我们可以进行替换，这样也就方便了找出数据，之后在进行对比，相同的图片就不变，不同的就替换
    //    NSString *path = [NSString stringWithFormat:@"%@/pic_%f.jpeg",dirPath,[NSDate timeIntervalSinceReferenceDate]];
    NSString *path = [NSString stringWithFormat:@"%@/appPic.jpeg",dirPath];
    //
    //    [manager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    
    
    //转换成JPEG中格式并进行压缩  2E2AEC79-ED20-4CDF-81D2-6A74E6D46BEC/
    self.imageData = [NSData dataWithData:UIImageJPEGRepresentation(image,1)];
    
    
    //图片写入到地址中
    [self.imageData writeToFile:path atomically:YES];
    
    
    
    NSLog(@"保存路径： %@", path);
    
    
    
    NSString *imagePath = [[path componentsSeparatedByString:@"/"] lastObject];
    
    //你所谓的路径并没有创建成功
    
    NSLog(@"保存路径2imagePath： %@", imagePath);
    
    NSLog(@"保存完毕");
    
}

//创建文件夹成功
+ (BOOL)createVideoFolderIfNotExist
{
    // NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path =[NSString stringWithFormat:@"%@/tmp/",NSHomeDirectory()];
    
    //[paths objectAtIndex:0];
    
    NSString *folderPath = [path stringByAppendingPathComponent:@"Picture"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isDirExist = [fileManager fileExistsAtPath:folderPath isDirectory:&isDir];
    
    if(!(isDirExist && isDir))
    {
        BOOL bCreateDir = [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
        if(!bCreateDir){
            NSLog(@"创建图片文件夹失败");
            return NO;
        }
        NSLog(@"folderPath:%@",folderPath);
        return YES;
    }
    return YES;
}




- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"begin motion");
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event

{
    NSLog(@"end motion");
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}




@end
