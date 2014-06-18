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
extern SQLForLeXiang * DB;

@synthesize dataSource;
@synthesize keysArray;
@synthesize tableArray;
@synthesize table2View;
@synthesize dataSources;
#define viewWidth   self.view.frame.size.width
#define viewHeight  self.view.frame.size.height

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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
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
    return [self.dataSources count];
    
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
    //NSString * text = [tableArray objectAtIndex:indexPath.row];
    NSString * text = [[self.dataSources objectAtIndex:indexPath.row]objectForKey:@"busiName"];
    cell.textLabel.text = text;
    cell.textLabel.font = [UIFont systemFontOfSize:22];
    cell.detailTextLabel.text = [[self.dataSources objectAtIndex:indexPath.row]objectForKey:@"busiMoney"];;
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    UIImage * image = [UIImage imageNamed:@"folder.png"];
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
        NSString * ids =[[self.dataSources objectAtIndex:indexPath.row]objectForKey:@"id"];
        NSLog(@"ids:%d",[ids intValue]);
        service =[[self.dataSources objectAtIndex:indexPath.row]objectForKey:@"busiName"];
        self.table2View.dataSources = [DB findByParentId:ids];
        NSLog(@"%d",self.table2View.dataSources.count);
    }
    [self.navigationController pushViewController:self.table2View animated:YES];
}

//- (void)showMenu:(id)cell
//{
//    [cell becomeFirstResponder];
//    UIMenuController * menu = [UIMenuController sharedMenuController];
//    [menu setTargetRect: [cell frame] inView: [self view]];
//    [menu setMenuVisible: YES animated: YES];
//    NSLog(@"???");
//}




////允许长按菜单
//- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"string11");
//    return YES;
//}
//
////允许每一个Action
//-(BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{
//    NSLog(@"%@",NSStringFromSelector(action));
//    
//    return YES;
//}
////对一个给定的行告诉代表执行复制或粘贴操作内容,
//-(void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{
//    if (action==@selector(copy:)) {//如果操作为复制
//        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];//黏贴板
//        [pasteBoard setString:cell.textLabel.text];
//        NSLog(@"%@",pasteBoard.string);//获得剪贴板的内容
//        //return YES;
//    }
//    //return NO;
//}


//- (void)longPress:(UILongPressGestureRecognizer *)recognizer {
//    if (recognizer.state == UIGestureRecognizerStateBegan) {
//        TSTableViewCell *cell = (TSTableViewCell *)recognizer.view;
//        [cell becomeFirstResponder];
//
//        UIMenuItem *flag = [[UIMenuItem alloc] initWithTitle:@"Flag"action:@selector(flag:)];
//        UIMenuItem *approve = [[UIMenuItem alloc] initWithTitle:@"Approve"action:@selector(approve:)];
//        UIMenuItem *deny = [[UIMenuItem alloc] initWithTitle:@"Deny"action:@selector(deny:)];
//
//        UIMenuController *menu = [UIMenuController sharedMenuController];
//        [menu setMenuItems:[NSArray arrayWithObjects:flag, approve, deny, nil]];
//        [menu setTargetRect:cell.frame inView:cell.superview];
//        [menu setMenuVisible:YES animated:YES];
//    }
//}
//
//- (void)flag:(id)sender {
//    NSLog(@"Cell was flagged");
//}
//
//- (void)approve:(id)sender {
//    NSLog(@"Cell was approved");
//}
//
//- (void)deny:(id)sender {
//    NSLog(@"Cell was denied");
//}

//- (void)cellLongPress:(UIGestureRecognizer *)recognizer{
//    if (recognizer.state == UIGestureRecognizerStateBegan) {
//        CGPoint location = [recognizer locationInView:self];
//        NSIndexPath * indexPath = [self indexPathForRowAtPoint:location];
//        UIMyTableViewCell *cell = (UIMyTableViewCell *)recognizer.view;
//        　　　　　//这里把cell做为第一响应(cell默认是无法成为responder,需要重写canBecomeFirstResponder方法)
//        [cell becomeFirstResponder];
//        
//        UIMenuItem *itCopy = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(handleCopyCell:)];
//        UIMenuItem *itDelete = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(handleDeleteCell:)];
//        UIMenuController *menu = [UIMenuController sharedMenuController];
//        [menu setMenuItems:[NSArray arrayWithObjects:itCopy, itDelete,  nil]];
//        [menu setTargetRect:cell.frame inView:self];
//        [menu setMenuVisible:YES animated:YES];
//        
//        [itCopy release];
//        [itDelete release];
//    }
//}
//-(void)tableviewCellLongPressed:(UILongPressGestureRecognizer *)gestureRecognizer{
//    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
//        NSLog(@"UIGestureRecognizerStateBegan");
//        CGPoint ponit=[gestureRecognizer locationInView:self.tableView];
//        NSLog(@" CGPoint ponit=%f %f",ponit.x,ponit.y);
//        NSIndexPath* path=[self.tableView indexPathForRowAtPoint:ponit];
//        NSLog(@"row:%d",path.row);
//        currRow=path.row;
//    }else if(gestureRecognizer.state == UIGestureRecognizerStateEnded)
//    {
//        //未用
//    }
//    else if(gestureRecognizer.state == UIGestureRecognizerStateChanged)
//    {
//        //未用
//    }
//    
//    
//}


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
