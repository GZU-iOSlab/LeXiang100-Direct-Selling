//
//  TableLevle2TableViewController.m
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-2.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import "TableLevle2TableViewController.h"

@interface TableLevle2TableViewController ()
@end

@implementation TableLevle2TableViewController
@synthesize dataSource;
@synthesize keysArray;
@synthesize tableArray;
@synthesize detailView;
@synthesize dataSources;
extern NSString * service;
extern DataBuffer * data ;
extern SQLForLeXiang * DB;

#define viewWidth   self.view.frame.size.width
#define viewHeight  self.view.frame.size.height

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
        //DataBuffer * data = [[DataBuffer alloc]init];
        self.dataSource = data.dataSource;
        self.keysArray = data.keys;
        //self.detailView = [[DetailViewController alloc]init];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableArray = [dataSource objectForKey:service];
    
    self.title = service;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    id key = [keys objectAtIndex:0];
//    return [[dataSource objectForKey:key]count];
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return [self.dataSources count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"basis-cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        [cell autorelease];
    }    // Configure the cell...
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //NSString * text = [tableArray objectAtIndex:indexPath.row];
    NSString * text = [[self.dataSources objectAtIndex:indexPath.row]objectForKey:@"busiName"];
    cell.textLabel.text = text;
    cell.textLabel.font = [UIFont systemFontOfSize:20];
   // cell.detailTextLabel.text = @"haha";
    cell.detailTextLabel.text = [[self.dataSources objectAtIndex:indexPath.row]objectForKey:@"busiMoney"];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    UIImage * image = [UIImage imageNamed:@"Folder.png"];
    cell.imageView.image = image;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    //NSLog(@"%d  row",indexPath.row);
    service = [self.tableArray objectAtIndex:indexPath.row];
//    NSLog(@"%@  service",service);
    if (self.detailView != NULL) {
        [self.detailView release];
    }
    self.detailView = [[DetailViewController alloc]init];
    NSString * busiName = [[self.dataSources objectAtIndex:indexPath.row]objectForKey:@"busiName"];
    
    self.detailView.detailService = [DB findByBusiName:busiName];
    NSLog(@"busy:%@,count:%d",busiName,self.detailView.detailService.count);

    [self.navigationController pushViewController:self.detailView animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7) return 10;
    else    return 30;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
