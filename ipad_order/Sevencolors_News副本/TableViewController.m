//
//  TableViewController.m
//  RTImageLoader
//
//  Created by Ryan Tang on 13-7-7.
//  Copyright (c) 2013年 Ericsson Labs. All rights reserved.
//

#import "TableViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "AppDelegate.h"
#import "WebEngine.h"
#import "LSTintedButton.h"
#import "HomeViewController.h"

@interface TableViewController ()
{
    LSTintedButton *addButton;
}

@end

@implementation TableViewController


@synthesize Lists;
//@synthesize homeController;
@synthesize tableView;

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

    ApplicationDelegate.itemLists = [NSMutableArray array];
    self.view.backgroundColor = [UIColor grayColor];
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
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

#pragma -UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ApplicationDelegate.itemLists count];
   
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *Identifier = @"UITableViewIdentifier";
    BOOL setCellEnable = 0;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Identifier];
        

    }
    NSInteger row = indexPath.row;
    
    addButton = (LSTintedButton*)[cell viewWithTag:1000];
    if (!addButton)
    {
        addButton = [[LSTintedButton alloc] initWithFrame:CGRectMake(240, 85, 70,30)];
        addButton.tag = 1000;
        
        [addButton setTitle:@"订阅" forState:UIControlStateNormal];
        [addButton setBackgroundImage:[UIImage imageNamed:@"cell_add"]forState:UIControlStateNormal];
        //[addButton setTitle:@"打开" forState:UIControlStateSelected];
        //[addButton setBackgroundImage:[UIImage imageNamed:@"cell_open"]forState:UIControlStateSelected];
        [addButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:13.0]];
        [addButton addTarget:self action:@selector(OnAddAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:addButton];
    }
    addButton.index = indexPath.row;
    //addButton.selected = setCellEnable;
    

    NSMutableDictionary *obj = [ApplicationDelegate.itemLists objectAtIndex:row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
  
    NSString *descPath = [obj objectForKey:@"description"];
    NSString *titlePath = [obj objectForKey:@"title"];
    cell.detailTextLabel.text = descPath;
    cell.textLabel.text = titlePath;
    cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:12];

    NSString *urlPath = [obj objectForKey:@"url"];
    NSURL *url = [[NSURL alloc] initWithString:urlPath];
    [cell.imageView setImageWithURL:url];
    
    CGSize itemSize = CGSizeMake(120, 100);
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
   
    [cell.textLabel setNumberOfLines:2];
    [cell.detailTextLabel setNumberOfLines:3];
    Lists = [[NSArray alloc] initWithObjects:titlePath,url,descPath, nil];
    //NSLog(@"%@",Lists);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setCellEnable:(BOOL)Enable{
    if(Enable)
    {
        
        [addButton setBackgroundImage:[UIImage imageNamed:@"cell_add"]
                                 forState:UIControlStateNormal];
        addButton.enabled = YES;
        [addButton setTitle:@"订阅" forState:UIControlStateNormal];
        [addButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        
    }else
    {
       
        [addButton setBackgroundImage:[UIImage imageNamed:@"1"]  forState:UIControlStateNormal];
        
        [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        addButton.enabled = NO;
        [addButton setTitle:@"" forState:UIControlStateNormal];
    }
}


- (IBAction)OnAddAction:(id)sender
{
    
    addButton = (LSTintedButton*)sender;
    NSArray *list =[ApplicationDelegate.itemLists objectAtIndex:addButton.index];
    //addButton.selected = ;
   [self setCellEnable:0];
    //NSLog(@"%d",addButton.index);
    
    NSFileManager *fm = [NSFileManager defaultManager];
    //找到Documents文件所在的路径
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //取得第一个Documents文件夹的路径
    NSString *filePath = [path objectAtIndex:0];
    NSString *plistPaths = [filePath stringByAppendingPathComponent:@"tests.plist"];
    //开始创建文件
    [fm createFileAtPath:plistPaths contents:nil attributes:nil];

    [list writeToFile:plistPaths atomically:YES];
    
    
    NSDictionary *data1= [[NSDictionary alloc] initWithContentsOfFile:plistPaths];
    
    ApplicationDelegate.data = data1;
    ApplicationDelegate.number+=1;
    NSLog(@"arr1 is %d",ApplicationDelegate.number);
    
    //NSLog(@"arr1 is %@", ApplicationDelegate.data);
    //[tableView reloadData];
    ViewController *homeController = [[ViewController alloc]init];
    [homeController.tableView reloadData];
   
    
}


@end
