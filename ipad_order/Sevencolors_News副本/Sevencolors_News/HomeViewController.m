//
//  ViewController.m
//  Sevencolors_News
//
//  Created by test on 14-7-19.
//  Copyright (c) 2014年 test. All rights reserved.
//

#import "HomeViewController.h"
#import "DetailViewController.h"
#import "TableViewController.h"
#import "AppDelegate.h"
#import "LSTintedButton.h"
#import "UIImageView+WebCache.h"
@interface ViewController ()
{

    NSMutableArray * images;

}

@property (weak, nonatomic) IBOutlet UIButton *add;
- (void)setupPage;
@end

@implementation ViewController
@synthesize tableView;
@synthesize list;
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
    list = [NSMutableArray array];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(add:)];
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:tableView];
    NSLog(@"%@",list);
    [tableView reloadData];
    

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [tableView reloadData];
   
    
   
}
#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (ApplicationDelegate.number%2 == 0) {
        return ApplicationDelegate.number/2;
    }
    else
    return ApplicationDelegate.number/2+1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
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
    LSTintedButton *btn = (LSTintedButton*)[cell viewWithTag:1001];
    LSTintedButton *btn1 = (LSTintedButton*)[cell viewWithTag:1002];
    if (!btn)
    {
        if (ApplicationDelegate.number%2 == 1)
        {
            btn = [[LSTintedButton alloc] initWithFrame:CGRectMake(20, 10, 130,100)];
            btn.tag = 1001;
            NSString *fileURL = [NSString stringWithFormat:[ApplicationDelegate.data objectForKey:@"url"], 1,1];
            NSData *dateImg = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
            [btn setTitle:[ApplicationDelegate.data objectForKey:@"title"] forState:UIControlStateNormal];
            btn.titleLabel.textAlignment = NSTextAlignmentNatural;
            [btn setBackgroundImage:[UIImage imageWithData:dateImg] forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:13.0]];
            [btn addTarget:self action:@selector(pressIn:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn];
        }
    }
    if (!btn1)
        {
          if (ApplicationDelegate.number%2 == 0)
          {
            btn1 = [[LSTintedButton alloc] initWithFrame:CGRectMake(170, 10, 130,100)];
           
            btn1.tag = 1002;
            NSString *fileURL = [NSString stringWithFormat:[ApplicationDelegate.data objectForKey:@"url"], 1,1];
            NSData *dateImg = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
        
            [btn1 setTitle:[ApplicationDelegate.data objectForKey:@"title"] forState:UIControlStateNormal];
            btn1.titleLabel.textAlignment = NSTextAlignmentNatural;
            [btn1 setBackgroundImage:[UIImage imageWithData:dateImg] forState:UIControlStateNormal];
            [btn1.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:13.0]];
            [btn1 addTarget:self action:@selector(pressIn:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn1];

          }
        
        }
    
    NSLog(@"arr is %@",ApplicationDelegate.data);
    
    NSUInteger row = [indexPath row];
    
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

   - (IBAction)add:(id)sender
{
    TableViewController *tableViewCtrl = [[TableViewController alloc] init];
    tableViewCtrl.navigationItem.title = @"UITableView";
    
    [self.navigationController pushViewController:tableViewCtrl animated:YES];
    NSLog(@"arr is %@",ApplicationDelegate.data);
    

}
 - (IBAction)pressIn:(id)sender
{
    DetailViewController *detailViewController = [[DetailViewController alloc]init];
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}
//- (void)addObject : (NSMutableDictionary*)obj
//{
//    obj = ApplicationDelegate.data;
//    [list addObject:obj];
//}
@end
