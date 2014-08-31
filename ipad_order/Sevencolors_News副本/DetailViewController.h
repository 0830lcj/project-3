//
//  DetailViewController.h
//  Sevencolors_News
//
//  Created by test on 14-7-21.
//  Copyright (c) 2014年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic)NSArray *list1;
@property (strong,nonatomic)NSArray *list2;
@property (strong,nonatomic)NSArray *list;
@property (strong,nonatomic)NSMutableArray *jsonArray1;


@end
