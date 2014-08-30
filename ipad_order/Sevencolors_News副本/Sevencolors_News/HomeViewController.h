//
//  ViewController.h
//  Sevencolors_News
//
//  Created by test on 14-7-19.
//  Copyright (c) 2014年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *list;
@property (strong,nonatomic)IBOutlet UIButton *button1;
@property (strong,nonatomic)IBOutlet UIButton *button2;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (void)addObject : (NSMutableDictionary*)obj;
@end
