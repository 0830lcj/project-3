//
//  DetailViewController.m
//  Sevencolors_News
//
//  Created by test on 14-7-21.
//  Copyright (c) 2014年 test. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize list1;
@synthesize list2;
@synthesize list;
@synthesize jsonArray1;

- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self= [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        // Custom initialization
       
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"标题";
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    ApplicationDelegate.itemLists = [NSMutableArray array];
    
    NSString *stringUrl =[NSString stringWithFormat:@"%@",@"http://223.4.135.23/7colors/data.json"];
    
    [ApplicationDelegate.appWebEngine sendHttpRequest:stringUrl data:nil method:@"GET" completionHandler:^(NSString *responseString) {
        //[hud hide];
        [ApplicationDelegate.itemLists removeAllObjects];
        
        if (responseString && responseString.length > 0 && [ApplicationDelegate.appWebEngine checkUserAuth:responseString])
        {
            
            ApplicationDelegate.itemLists = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%d",ApplicationDelegate.itemLists.count);
        }
        
        [tableView reloadData];
    }];




}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return ApplicationDelegate.itemLists.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:TableSampleIdentifier];
    }

    NSLog(@"%@",cell.textLabel.text);

    NSUInteger row = [indexPath row];
    
    NSMutableDictionary *obj = [ApplicationDelegate.itemLists objectAtIndex:row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    cell.textLabel.text = [[ApplicationDelegate.itemLists valueForKey:@"title"]objectAtIndex:row];
    NSString *descPath = [obj valueForKey:@"description"];
    
    cell.detailTextLabel.text = descPath;
    NSLog(@"%@",cell.detailTextLabel.text);
    
    NSString *urlPath = [obj objectForKey:@"url"];
    NSURL *url = [[NSURL alloc] initWithString:urlPath];
    [cell.imageView setImageWithURL:url];
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:12];
    
    CGSize itemSize = CGSizeMake(100, 70);
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [cell.textLabel setNumberOfLines:2];
    [cell.detailTextLabel setNumberOfLines:2];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



@end
