//
//  TableLevel1TableViewController.m
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-2.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import "TableLevel1TableViewController.h"

@interface TableLevel1TableViewController ()

@end

@implementation TableLevel1TableViewController
extern NSString * service;
extern DataBuffer * data ;
@synthesize dataSource;
@synthesize keysArray;
@synthesize tableArray;
@synthesize table2View;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
        //DataBuffer * data = [[DataBuffer alloc]init];
        //self.dataSource = data.dataSource;
        //self.keysArray = data.keys;
        self.table2View = [[TableLevle2TableViewController alloc]init];
//        self.table2View.dataSource = data.dataSource;
//        self.table2View.keysArray = data.keys;
        //self.tableArray = [self.dataSource objectForKey:service];
        //self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //self.tableView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableArray = [self.dataSource objectForKey:service];
    self.title = service;
    self.tableView.rowHeight = 228;
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleSingleLine;
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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.tableArray count];
    
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
    NSString * text = [tableArray objectAtIndex:indexPath.row];
    //cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    //[tableView setSeparatorColor:[UIColor clearColor]];
    //cell.imageView.sizeToFit = UIViewContentModeCenter;
//    float sw=10/cell.imageView.image.size.width;
//    float sh=10/cell.imageView.image.size.height;
//    cell.imageView.transform=CGAffineTransformMakeScale(sw,sh);
    cell.textLabel.text = text;
    cell.detailTextLabel.text = @"haha";
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    UIImage * image = [UIImage imageNamed:@"Folder.png"];
    cell.imageView.image = image;
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
    service = [self.tableArray objectAtIndex:indexPath.row];
    //NSLog(@"%@  service",service);
    if (self.table2View != NULL) {
        [self.table2View release];
        self.table2View = [[TableLevle2TableViewController alloc]init];
        self.table2View.dataSource = data.dataSource;
        self.table2View.keysArray = data.keys;
        NSLog(@"table1%@",data);
    }
    [self.navigationController pushViewController:self.table2View animated:YES];
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
