//
//  UserTableViewController.m
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-10.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import "UserTableViewController.h"

@interface UserTableViewController ()

@end

@implementation UserTableViewController
extern NSNotificationCenter *nc;
extern NSMutableString * loginString;
extern NSMutableString * loginName;
extern NSMutableDictionary * UserInfo;
@synthesize tableArray;
@synthesize tableCellArray;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
        //nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(userInfoFeedback:) name:@"queryUserInfoResponse" object:nil];
        self.tableArray = [[NSArray alloc]initWithObjects:@"手机号码：",@"姓名：",@"状态：",@"类型：",@"归属地区：",@"归属县市：",@"归属营业厅：",@"注册时间：", nil];
        self.tableCellArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)userInfoFeedback:(NSNotification *)note{
//    NSString * userInfo = [[NSString alloc]initWithString:[[note userInfo] objectForKey:@"1"]];
//    //if ([userInfo rangeOfString:@"opName"].length>0&&[userInfo rangeOfString:@"opStatus"].length>0) {
//        NSLog(@"userInfo %@",userInfo);
//        NSArray * resultArray1 = [userInfo componentsSeparatedByString:@","];
//        NSMutableArray * resultArray = [[NSMutableArray alloc]init];
//        NSLog(@"loginName:%@",loginName);
//        [self.tableCellArray addObject:[UserInfo objectForKey:@"name" ]];
//        for (NSString * str in resultArray1) {
//            if ([str rangeOfString:@"regTime"].length==0) {
//                NSArray * resultOfCut = [str componentsSeparatedByString:@":"];
//                NSString * token1 =[resultOfCut objectAtIndex:resultOfCut.count-1];
//                str = [token1 substringWithRange:NSMakeRange(1, token1.length-2)];
//                NSLog(@"%@",str);
//                [resultArray addObject:str];
//            }else{
//                str = [str substringWithRange:NSMakeRange(11, 19)];
//                NSLog(@"%@",str);
//                [resultArray addObject:str];
//            }
//            [self.tableCellArray addObject:str];
//        }
    NSMutableDictionary * CellDic = [[NSMutableDictionary alloc]initWithDictionary:[[note userInfo] objectForKey:@"1"]];
    [CellDic setObject:[UserInfo objectForKey:@"name" ] forKey:@"name"];
    NSArray * array = [NSArray arrayWithObjects:@"name",@"opName",@"opStatus",@"regTime",@"opType",@"cityName",@"countyName",@"channelName", nil];
    for (NSString * str in array) {
        [self.tableCellArray addObject:[CellDic objectForKey:str ]];
    }
    NSLog(@"self.tableCellArray%@ self.tableCellArray%@",self.tableCellArray,self.tableCellArray);
    //}else [UserTableViewController showAlertWithTitle:@"获取失败" AndMessages:@"获取信息失败"];
    //[self.tableCellArray arrayByAddingObjectsFromArray:resultArray];
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
    return self.tableCellArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    static NSString * identifier = @"basis-cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier];
        [cell autorelease];
    }    // Configure the cell...
    NSString * text = [self.tableArray objectAtIndex:indexPath.row];
    NSString * detailtext = [self.tableCellArray objectAtIndex:indexPath.row];
    cell.textLabel.text = text;
    cell.detailTextLabel.text = detailtext;
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    cell.userInteractionEnabled = NO;
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
