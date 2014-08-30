//
//  AppDelegate.m
//  Sevencolors_News
//
//  Created by test on 14-7-19.
//  Copyright (c) 2014年 test. All rights reserved.
//

#import "AppDelegate.h"
#import "TableViewController.h"
#import "HomeViewController.h"
@implementation AppDelegate

@synthesize needReloadHomeData;
@synthesize appWebEngine;
@synthesize data;
@synthesize number;

int number = 0;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    needReloadHomeData = TRUE;
    appWebEngine = [[WebEngine alloc] init];
    data = [[NSMutableDictionary alloc]init];
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    ViewController *mainViewCtrl = [[ViewController alloc] init];
    mainViewCtrl.navigationItem.title = @"主页";
    
    
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:mainViewCtrl];
    
    self.window.rootViewController = navigation;
    [self.window makeKeyAndVisible];

//    NSFileManager *fm = [NSFileManager defaultManager];
//    //找到Documents文件所在的路径
//    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    //取得第一个Documents文件夹的路径
//    NSString *filePath = [path objectAtIndex:0];
//    NSString *plistPaths = [filePath stringByAppendingPathComponent:@"tests.plist"];
//    //开始创建文件
//    [fm createFileAtPath:plistPaths contents:nil attributes:nil];
//    NSMutableDictionary *data1= [[NSMutableDictionary alloc] initWithContentsOfFile:plistPaths];
//    NSLog(@"arr1 is %@",data1);
//    ApplicationDelegate.data = data1;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
