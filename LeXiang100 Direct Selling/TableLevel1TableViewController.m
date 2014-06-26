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
extern NSMutableString * service;
extern DataBuffer * data ;
extern SQLForLeXiang * DB;
extern connectionAPI * soap;

@synthesize dataSource;
@synthesize keysArray;
@synthesize tableArray;
@synthesize table2View;
@synthesize dataSources;
@synthesize detailView;
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
        alert = [[UIAlertView alloc] initWithTitle:@"请选择操作"message:nil delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"添加到收藏夹",@"查看业务介绍",@"推荐办理业务", nil];
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
    cell.detailTextLabel.text = [[self.dataSources objectAtIndex:indexPath.row]objectForKey:@"busiMoney"];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    UIImage * image;
    //关于页面的特殊处理
    if ([text rangeOfString:@"集团V网"].length>0||[text rangeOfString:@"集团通讯录"].length>0||[text rangeOfString:@"集团彩铃5元"].length>0) {
        image = [UIImage imageNamed:@"paper.png"];
        //设置长按响应
        UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [cell addGestureRecognizer:recognizer];
    }else{
        image = [UIImage imageNamed:@"folders.png"];
    }
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
    //service = [self.tableArray objectAtIndex:indexPath.row];
    //NSLog(@"%@  service",service);
    if (self.table2View != NULL) {
        [self.table2View release];
        self.table2View = [[TableLevle2TableViewController alloc]init];
        self.table2View.dataSource = data.dataSource;
        self.table2View.keysArray = data.keys;
        NSLog(@"table1%@",data);
        NSString * ids =[[self.dataSources objectAtIndex:indexPath.row]objectForKey:@"id"];
        NSLog(@"ids:%d",[ids intValue]);
        [service setString:@""];
        [service appendString: [[self.dataSources objectAtIndex:indexPath.row]objectForKey:@"busiName"]];
        self.table2View.dataSources = [DB findByParentId:ids];
        NSLog(@"%d",self.table2View.dataSources.count);
    }
    NSString * item = [[self.dataSources objectAtIndex:indexPath.row]objectForKey:@"busiName"];
    if ([item rangeOfString:@"集团V网"].length>0||[item rangeOfString:@"集团通讯录"].length>0||[item rangeOfString:@"集团彩铃5元"].length>0) {
        service = [[self.dataSources objectAtIndex:indexPath.row]objectForKey:@"busiName"];
        self.detailView = [[[DetailViewController alloc]init]autorelease];
        NSString * busiName = [[self.dataSources objectAtIndex:indexPath.row]objectForKey:@"busiName"];
        self.detailView.detailService = [DB findByBusiName:busiName];
        self.detailView.haveBtn = @"1";
        //NSLog(@"busy:%@,count:%d",busiName,self.detailView.detailService.count);
        [self.navigationController pushViewController:self.detailView animated:YES];
    }else{
    [self.navigationController pushViewController:self.table2View animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    pressedCell =  indexPath.row;
}

#pragma mark - 长按提示
- (void)longPress:(UILongPressGestureRecognizer *)recognizer {
    if (alert.visible != YES) {
        [alert show];
    }
}

+ (void)showAlertWithTitle:(NSString *)titles AndMessages:(NSString *)messages{
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:titles message:messages delegate:self cancelButtonTitle:@"关闭" otherButtonTitles: nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
            
        case 1:
            NSLog(@"添加到收藏夹");
                [self pushToCollect];
            break;
        case 2:
            NSLog(@"查看业务介绍");
            [self checkTheBusi];
            break;
        case 3:
            NSLog(@"办理推荐业务");
            [self toDetailView];
            break;
        default:
            break;
    }
}

-(void)toDetailView{
    self.detailView = [[[DetailViewController alloc]init]autorelease];
    self.detailView.haveBtn = @"1";
    NSString * busiName = [[self.dataSources objectAtIndex:pressedCell]objectForKey:@"busiName"];
    self.detailView.detailService = [DB findByBusiName:busiName];
    [self.navigationController pushViewController:self.detailView animated:YES];
}

-(void)checkTheBusi{
    NSString * busiDesc =[[self.dataSources objectAtIndex:pressedCell]objectForKey:@"busiDesc"];
    [TableLevle2TableViewController showAlertWithTitle:@"业务描述" AndMessages:busiDesc];
}

- (void)pushToCollect{
    //NSLog(@"被按的cell:%d",pressedCell);
    //先读取路径下的数据
    NSArray * readArray = [self readFileArray];
    //将收藏的业务
    NSLog(@"%d",pressedCell);
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
        //[self readFileArray];
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
