//
//  AppDelegate.m
//  WCTAllFunctionText
//
//  Created by four on 16/3/17.
//  Copyright © 2016年 王春涛. All rights reserved.
//

#import "AppDelegate.h"

#import "Reachability.h"

@interface AppDelegate ()

@property (strong, nonatomic) Reachability *reach;  //创建网络检测类

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    /**
     *  这个工程是我自己测试功能的地方，很多东西都是我从项目中提取的
     *  康美健康云   网络医疗部iOS开发的成员的成果
     */
    
    [self initNav];
    
    [self initReachability];
    
    return YES;
}
#pragma mark - 创建导航栏
-(void)initNav{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ViewController *view = [[ViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:134/255.0 green:201/255.0 blue:250/255.0 alpha:0.7f]];
    [self.window setRootViewController:nav];
    [self.window makeKeyAndVisible];
}

#pragma mark - 检测网络状态第三方（Reachability）
-(void)initReachability
{
    //创建监视网络连接状况的reach,并向通知中心注册
    self.reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    [self.reach startNotifier];
}
#pragma mark - reachabilityChanged
- (void)reachabilityChanged:(NSNotification *)note{
    Reachability *curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);

    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    switch (netStatus) {
        case NotReachable:
        {
//            [WCTTool showAlertMessage:@"当前网络不稳定，请检查网络"];
            NSLog(@"当前网络不稳定，请检查网络");
        }
            break;
        case ReachableViaWWAN:
        {
//            [WCTTool showAlertMessage:@"当前网络使用3G/4G网络连接，请注意流量使用"];
            NSLog(@"当前网络使用2G/3G/4G网络连接，请注意流量使用");
        }
            break;
        case ReachableViaWiFi:
        {
//            [WCTTool showAlertMessage:@"当前网络使用wifi连接"];
            NSLog(@"当前网络使用wifi连接");
        }
            break;
        default:
            break;
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
