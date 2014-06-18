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
        alert = [[UIAlertView alloc] initWithTitle:@"请选择操作"message:nil delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"添加到收藏夹",@"查看业务介绍",@"推荐办理业务", nil];
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
    
    //设置长按响应
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [cell addGestureRecognizer:recognizer];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    //NSLog(@"%d  row",indexPath.row);
    service = [self.tableArray objectAtIndex:indexPath.row];
//    NSLog(@"%@  service",service);
//    if (self.detailView != NULL) {
//        //[self.detailView release];
//    }
    self.detailView = [[[DetailViewController alloc]init]autorelease];
    NSString * busiName = [[self.dataSources objectAtIndex:indexPath.row]objectForKey:@"busiName"];
    
    self.detailView.detailService = [DB findByBusiName:busiName];
    NSLog(@"busy:%@,count:%d",busiName,self.detailView.detailService.count);

    [self.navigationController pushViewController:self.detailView animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7) return 10;
    else    return 30;
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    pressedCell =  indexPath.row;
}

- (void)longPress:(UILongPressGestureRecognizer *)recognizer {
    if (alert.visible != YES) {
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 1:
            NSLog(@"添加到收藏夹");
            [self pushToCollect];
            break;
        case 2:
            NSLog(@"查看业务介绍");
            break;
        case 3:
            NSLog(@"办理推荐业务");
            break;
        default:
            break;
    }
}



- (void)pushToCollect{
    NSLog(@"被按的cell:%d",pressedCell);
    //先读取路径下的数据
    NSArray * readArray = [self readFileArray];
    //将收藏的业务
    NSString * collectedName =[[self.dataSources objectAtIndex:pressedCell]objectForKey:@"busiName"];
    NSDictionary * collectedBusi = [self.dataSources objectAtIndex:pressedCell];
    BOOL isCollected = NO;
    //查找是否有重复
    for (NSDictionary * dic in readArray) {
        if ([collectedName isEqualToString:[dic objectForKey:@"busiName"]]) {
            NSString * str =[NSString stringWithFormat: @"%@已收藏，无需重复添加！",collectedName ];
            UIAlertView * alerts = [[UIAlertView alloc] initWithTitle:@"业务已收藏"message:str delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles: nil];
            [alerts show];
            [alerts release];
            isCollected = YES;
            NSLog(@"业务重复，无需写入!\n");
            break;
        }
    }
    //如果没重复
    if (!isCollected) {
        //把resultArray这个数组存入程序指定的一个文件里
        NSMutableArray * writeArray = [[NSMutableArray alloc]initWithArray:readArray];
        [writeArray addObject:collectedBusi];
        [writeArray writeToFile:[self documentsPath:@"collectedBusi.txt"] atomically:YES];
        NSString * str =[NSString stringWithFormat: @"%@收藏成功",collectedName ];
        UIAlertView * alerts = [[UIAlertView alloc] initWithTitle:@"收藏业务成功"message:str delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles: nil];
        [alerts show];
        [alerts release];
        NSLog(@"业务%@已写入!\n",collectedName);
        [self readFileArray];
        
    }
}

#pragma mark readfile

-(NSArray *)readFileArray
{
    NSLog(@"read collectBusi........\n");
    //filePath 表示程序目录下指定文件
    NSString *filePath = [self documentsPath:@"collectedBusi.txt"];
    //从filePath 这个指定的文件里读
    NSArray * collectBusiArray = [NSArray arrayWithContentsOfFile:filePath];
    NSLog(@"%@",collectBusiArray  );
    return collectBusiArray;
}

-(NSString *)documentsPath:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
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
