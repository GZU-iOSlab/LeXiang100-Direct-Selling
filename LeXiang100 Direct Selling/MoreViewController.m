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
@synthesize array;
#define viewWidth   self.view.frame.size.width
#define viewHeight  self.view.frame.size.height
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
        self.title = @"更多";
        UIImage *more = [UIImage imageNamed:@"more.png"];
        self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"更多" image:more tag:1];
        NSMutableArray * data = [[NSMutableArray  alloc]initWithObjects:@"关于乐享",@"使用帮助",@"检查更新",@"用户建议",@"分享给好友", nil];
        self.tableView.scrollEnabled = NO;
        self.dataSource = data;
        
        aboutLeXiang100ViewController = [[AboutLeXiang100ViewController alloc]init];
        helpLeXiang100ViewController=[[Helplexiang100ViewController alloc]init];
        updateCheckingViewController=[[UpdateCheckingViewController alloc]init];
        adviceViewController=[[AdviceViewController alloc]init];
        
        NSMutableArray *arrayImageValue=[[[NSMutableArray alloc] init]autorelease];
        UIImage *aboutUsImg=[UIImage imageNamed:@"ahoutus_moreview.png"];
        
        UIImage *helpImg=[UIImage imageNamed:@"help_moreview.png"];
        UIImage *updateImg=[UIImage imageNamed:@"update_moreview.png"];
        UIImage *adviceImg=[UIImage imageNamed:@"advice_moreview.png"];
        UIImage *shareImg=[UIImage imageNamed:@"share_moreview.png"];
      
        [arrayImageValue addObject:aboutUsImg];
        [arrayImageValue addObject:helpImg];
        [arrayImageValue addObject:updateImg];
        [arrayImageValue addObject:adviceImg];
        [arrayImageValue addObject:shareImg];
        //[arrayImageValue addObject:elseImg];
        array=[[NSArray alloc]initWithArray:arrayImageValue];
        
    }
    return self;
}

-(BOOL) respondsToSelector : (SEL)aSelector {
    //printf("SELECTOR: %s\n", [NSStringFromSelector(aSelector) UTF8String]);
    return [super respondsToSelector:aSelector];
}

- (void)dealloc{
    [super dealloc];
    [array release];
    [aboutLeXiang100ViewController release];
    [helpLeXiang100ViewController release];
    [adviceViewController release];
    [updateCheckingViewController release];
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
    cell.imageView.image=[array objectAtIndex:[indexPath row]];;

    cell.textLabel.text = text;
    cell.textLabel.font = [UIFont systemFontOfSize:22];
    
    tableView.backgroundView = nil;
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7) {
        tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        cell.backgroundColor = [UIColor lightTextColor];
        cell.textLabel.backgroundColor = [UIColor clearColor];
    }else {
        tableView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        cell.backgroundColor = [UIColor lightTextColor];
        cell.textLabel.backgroundColor = [UIColor clearColor];
    }
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
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:aboutLeXiang100ViewController animated:YES];
    }
    else if (indexPath.row==1)
    {
        [self.navigationController pushViewController:helpLeXiang100ViewController animated:YES];
    }
    else if (indexPath.row==2)
    {
        [self.navigationController pushViewController:updateCheckingViewController animated:YES];
    }
    else if (indexPath.row==3)
    {
        [self.navigationController pushViewController:adviceViewController animated:YES];
    }
    else if (indexPath.row==4)
    {
        [self sendSMS:@"你知道吗？乐享100推出了iOS版的手机客户端软件，从此再也不用记忆那繁锁的业务代码了，推荐业务快捷又方便！快去App Store下载吧！" recipientList:nil];
    }
    
}

//内容，收件人列表
- (void)sendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients
{
    
    MFMessageComposeViewController *controller = [[[MFMessageComposeViewController alloc] init] autorelease];
    
    if([MFMessageComposeViewController canSendText])
        
    {
        
        controller.body = bodyOfMessage;
        
        controller.recipients = recipients;
        
        controller.messageComposeDelegate = self;
        
         //[self presentModalViewController:controller animated:YES];
        [self presentViewController:controller animated:YES completion:^(void){ }];
    }   
    
}

// 处理发送完的响应结果
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
     //[self dismissModalViewControllerAnimated:YES];
    
    [self dismissViewControllerAnimated:YES completion:^(void){ }];
    
    if (result == MessageComposeResultCancelled)
        NSLog(@"Message cancelled");
    else if (result == MessageComposeResultSent)
        NSLog(@"Message sent");
    else
        NSLog(@"Message failed")  ;
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
