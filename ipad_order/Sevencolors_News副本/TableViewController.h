//
//  TableViewController.h
//  RTImageLoader
//
//  Created by Ryan Tang on 13-7-7.
//  Copyright (c) 2013年 Ericsson Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "HomeViewController.h"



@interface TableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (strong, nonatomic) IBOutlet UITableView *tableView;
 //@property (strong, nonatomic) NSMutableArray * obj;
@property (strong, nonatomic) NSArray *Lists;
//@property (strong, nonatomic) ViewController *homeController;
@end
