//
//  tableTableViewController.h
//  Sevencolors_News
//
//  Created by test on 14-7-19.
//  Copyright (c) 2014年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"

@interface tableTableViewController : UITableViewController
{
    UIButton * Button1;
}
@property (strong, nonatomic) NSArray *array1;
@property (strong, nonatomic) NSArray *array2;
@property (strong, nonatomic) NSMutableArray *list;
@property (strong, nonatomic) NSMutableArray *jsonArray;
@property (strong, nonatomic) NSString *filename;
@property (strong, nonatomic) ViewController *homeController;

@end
