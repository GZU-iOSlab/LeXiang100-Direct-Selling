//
//  MoreViewController.m
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-5-31.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController
@synthesize dataSource;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
        //DataBuffer * data = [[DataBuffer alloc]init];
        self.title = @"更多";
        UIImage *more = [UIImage imageNamed:@"more.png"];
        self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"更多" image:more tag:1];
        NSMutableArray * data = [[NSMutableArray  alloc]initWithObjects:@"关于乐享",@"使用帮助",@"检查更新",@"用户建议",@"分享给好友", nil];
        self.tableView.scrollEnabled = NO;
        self.dataSource = data;
        leXiang100ViewController = [[AboutLeXiang100ViewController alloc]init];
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.rowHeight = 228;
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleSingleLine;
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataSource count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"basis-cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        [cell autorelease];
    }    // Configure the cell...
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSString * text = [self.dataSource objectAtIndex:indexPath.row];
    //cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    //[tableView setSeparatorColor:[UIColor clearColor]];
    //cell.imageView.sizeToFit = UIViewContentModeCenter;
    //    float sw=10/cell.imageView.image.size.width;
    //    float sh=10/cell.imageView.image.size.height;
    //    cell.imageView.transform=CGAffineTransformMakeScale(sw,sh);
    cell.textLabel.text = text;
    //cell.detailTextLabel.text = @"haha";
//    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
//        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
//    }
    //UIImage * image = [UIImage imageNamed:@"Folder.png"];
    //cell.imageView.image = image;
    return cell;
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell*cell =[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7) return 10;
    else    return 30;}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    //NSLog(@"%d  row",indexPath.row);
    //NSLog(@"%@  service",service);
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:leXiang100ViewController animated:YES];
    }
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
