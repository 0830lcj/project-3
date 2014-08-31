//
//  tableTableViewController.m
//  Sevencolors_News
//
//  Created by test on 14-7-19.
//  Copyright (c) 2014年 test. All rights reserved.
//

#import "StoreViewController.h"
#import <SDWebimage/UIimageView+WebCache.h>
#import "WebEngine.h"
#import "AppDelegate.h"
@interface tableTableViewController ()


@end

@implementation tableTableViewController

@synthesize array2;
@synthesize array1;
@synthesize list;
@synthesize jsonArray;
@synthesize homeController;
@synthesize filename;
- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self= [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        // Custom initialization
        //[homeController addObject:obj];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"标题";
    ApplicationDelegate.itemLists = [NSMutableArray array];
     NSString *stringUrl =[NSString stringWithFormat:@"%@",@"http://223.4.135.23/7colors/data.json"];
    [ApplicationDelegate.appWebEngine sendHttpRequest:stringUrl data:nil method:@"GET" completionHandler:^(NSString *responseString) {
        //[hud hide];
        [ApplicationDelegate.itemLists removeAllObjects];
        
        if (responseString && responseString.length > 0 && [ApplicationDelegate.appWebEngine checkUserAuth:responseString])
        {
            //itemLists = [NSJSONSerialization JSONObjectWithData:responseString options:NSJSONReadingMutableLeaves error:nil];
            ApplicationDelegate.itemLists = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%d",ApplicationDelegate.itemLists.count);
        }
        
        
    }];
     NSLog(@"%d",[ApplicationDelegate.itemLists count]);
//    jsonArray = [[NSMutableArray alloc] initWithObjects:@{@"image":imageString,@"title":@"这是一幅画这是一幅画这是一幅画这是一幅画",@"description":@"this is image1's description"}, @{@"image":imageString,@"title":@"这是一幅画这是一幅画这是一幅画这是一幅画",@"description":@"this is image2's description"}, @{@"image":imageString,@"title":@"这是一幅画这是一幅画这是一幅画这是一幅画",@"description":@"this is image3's description"},@{@"image":imageString,@"title":@"这是一幅画这是一幅画这是一幅画这是一幅画",@"description":@"this is image4's description"},@{@"image":imageString,@"title":@"这是一幅画这是一幅画这是一幅画这是一幅画",@"description":@"this is image5's description"}, nil];


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
    
    return [ApplicationDelegate.itemLists count];
    NSLog(@"%d",[ApplicationDelegate.itemLists count]);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
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
   
   
   
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(240, 100, 75, 25)];
    //[button1 addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTitle:@"订阅" forState:UIControlStateNormal];
    [button1 setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    button1.titleLabel.font    = [UIFont systemFontOfSize: 12];
    
    [button1 setBackgroundImage:[UIImage imageNamed:@"cell_add"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(OnAddAction:) forControlEvents:UIControlEventTouchUpInside];

    [cell.contentView addSubview:button1];
      
    
    
        
    NSUInteger row = [indexPath row];
        
//    list = [[NSMutableArray alloc]initWithObjects:[[jsonArray objectAtIndex:row ] objectForKey:@"title"],[[jsonArray objectAtIndex:row ] objectForKey:@"description"], nil];
        
    //list = [[jsonArray objectAtIndex:row ] objectForKey:@"title"];
        NSLog(@"%@",list);
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
    cell.textLabel.text = [[ApplicationDelegate.itemLists valueForKey:@"title"]objectAtIndex:row];
    cell.detailTextLabel.text =[[ApplicationDelegate.itemLists valueForKey:@"description"]objectAtIndex:row];
    [cell.imageView setImageWithURL:[[ApplicationDelegate.itemLists valueForKey:@"url"] objectAtIndex:row]];
    //[cell.imageView setimage:[[jsonArray valueForKey:@"image"] objectAtIndex:row]];
    CGSize itemSize = CGSizeMake(120, 100);
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
  
    
    cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:12];
    [cell.textLabel setNumberOfLines:2];
    [cell.detailTextLabel setNumberOfLines:3];
    NSLog(@"%@",cell.detailTextLabel.text);
        
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (IBAction)OnAddAction:(id)sender
{
    NSFileManager *fm = [NSFileManager defaultManager];
    //找到Documents文件所在的路径
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //取得第一个Documents文件夹的路径
    NSString *filePath = [path objectAtIndex:0];
    NSString *plistPaths = [filePath stringByAppendingPathComponent:@"tests.plist"];
    //开始创建文件
    //NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    [fm createFileAtPath:plistPaths contents:nil attributes:nil];
    //创建一个数组
    //NSArray *arr = [[NSArray alloc] initWithObjects:[jsonArray valueForKey:@"title"],[jsonArray valueForKey:@"image"],[jsonArray valueForKey:@"description"], nil];
    //写入
    //NSArray *arr = [NSArray arrayWithArray:list];
    [list writeToFile:plistPaths atomically:YES];
    NSArray *arr1 = [NSArray arrayWithContentsOfFile:plistPaths];
    //打印
    NSLog(@"arr1is %@",arr1);
}
-(void)setCellEnable:(BOOL)Enable
{
    if(Enable)
    {
        [Button1 setBackgroundImage:[UIImage imageNamed:@"cell_add"]
                                 forState:UIControlStateNormal];
        Button1.enabled = YES;
        [Button1 setTitle:@"订阅" forState:UIControlStateNormal];
        [Button1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        
    }else{
        [Button1 setBackgroundImage:[UIImage imageNamed:@"cell_open"]  forState:UIControlStateNormal];
        //        [_tintedButton setBackgroundimage:nil  forState:UIControlStateNormal];
        //        [_tintedButton setTintColor: [UIColor greenColor]];
        [Button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        Button1.enabled = YES;
        [Button1 setTitle:@"打开" forState:UIControlStateNormal];
    }
}


@end
