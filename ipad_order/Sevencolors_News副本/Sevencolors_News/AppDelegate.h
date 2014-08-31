//
//  AppDelegate.h
//  Sevencolors_News
//
//  Created by test on 14-7-19.
//  Copyright (c) 2014年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebEngine.h"
#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) NSMutableArray *itemLists;

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) WebEngine *appWebEngine;
@property (strong, nonatomic) NSMutableDictionary *data;
@property (nonatomic) BOOL needReloadHomeData;
@property (nonatomic) int number;
@end
