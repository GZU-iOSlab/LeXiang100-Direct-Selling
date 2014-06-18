//
//  FavoriteViewController.m
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-1.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import "FavoriteViewController.h"

@interface FavoriteViewController ()

@end

@implementation FavoriteViewController
extern SQLForLeXiang * DB;

@synthesize tableview;
@synthesize dataSource;
@synthesize detailView;
#define viewWidth   self.view.frame.size.width
#define viewHeight  self.view.frame.size.height
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"收藏夹";
        // 设置导航栏
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"清空" style:UIBarButtonItemStyleBordered target:self action:@selector(deleteAllCollection)];
        
        self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight) style:UITableViewStyleGrouped];
        //self.tableview.center = self.view.center;
        self.tableview.delegate = self;
        self.tableview.dataSource = self;
        self.dataSource = [[NSMutableArray alloc]init];
        
        alert = [[UIAlertView alloc] initWithTitle:@"请选择操作"message:nil delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"从收藏夹移除",@"查看业务介绍",@"推荐办理业务", nil];
        
        if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7) {
            UIImage * metal = [UIImage imageNamed:@"metal.jpg"];
            imgViewMetal = [[UIImageView alloc] initWithImage:metal];
            imgViewMetal.frame = CGRectMake(0, 0, viewWidth, viewHeight);
            [self.view addSubview:imgViewMetal];
            
            la = [[UITextView alloc]init];
            la.text = @"收藏夹是空的！\n\n将经常使用的业务添加到收藏夹，便于以后能够快速找到它们。";
            la.font = [UIFont systemFontOfSize:viewHeight/40];
            CGRect bounds = [[UIScreen mainScreen]applicationFrame];
            la.frame = bounds;
            la.backgroundColor = [UIColor clearColor];
            [imgViewMetal addSubview:la];
        }else{
            la = [[UITextView alloc]init];
            la.text = @"收藏夹是空的！\n\n将经常使用的业务添加到收藏夹，便于以后能够快速找到它们。";
            la.font = [UIFont systemFontOfSize:viewHeight/40];
            la.frame = CGRectMake(0, 0, viewWidth, viewHeight);
            la.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
            [self.view addSubview:la];
        }
        
        NSArray * array = [self readFileArray];
        if (array.count != 0) {
            imgViewMetal.hidden = YES;
            la.hidden = YES;
        }
        
        if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars =NO;
            self.modalPresentationCapturesStatusBarAppearance = NO;
            self.navigationController.navigationBar.translucent = NO;
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    NSArray * array = [self readFileArray];
    if (array.count == 0) {
        imgViewMetal.hidden = NO;
        la.hidden = NO;
        NSLog(@"没数据！");
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }else{
        [self.view addSubview: self.tableview];
        [self.dataSource setArray: [self readFileArray]];
        [self.tableview reloadData];
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [self.tableview removeFromSuperview];
}

#pragma mark tableview
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
    
    return [self.dataSource count];
    
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
    NSString * text = [[self.dataSource objectAtIndex:indexPath.row]objectForKey:@"busiName"];
    cell.textLabel.text = text;
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    // cell.detailTextLabel.text = @"haha";
    cell.detailTextLabel.text = [[self.dataSource objectAtIndex:indexPath.row]objectForKey:@"busiMoney"];
    if ([self.tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableview setSeparatorInset:UIEdgeInsetsZero];
    }
    UIImage * image = [UIImage imageNamed:@"Folder.png"];
    cell.imageView.image = image;
    
    //设置长按响应
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [cell addGestureRecognizer:recognizer];
    return cell;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    pressedCell =  indexPath.row;
}

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
            NSLog(@"从收藏夹移除");
            [self deleteCollection];
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
    NSString * busiName = [[self.dataSource objectAtIndex:pressedCell]objectForKey:@"busiName"];
    self.detailView.detailService = [DB findByBusiName:busiName];
    [self.navigationController pushViewController:self.detailView animated:YES];
}

-(void)checkTheBusi{
    NSString * busiDesc =[[self.dataSource objectAtIndex:pressedCell]objectForKey:@"busiDesc"];
    [FavoriteViewController showAlertWithTitle:@"业务描述" AndMessages:busiDesc];
}

- (void)deleteCollection{
    //先读取路径下的数据
    NSMutableArray * readArray = [[[NSMutableArray alloc]initWithArray:[self readFileArray]]autorelease];
    //NSString * collectedName =[[self.dataSource objectAtIndex:pressedCell]objectForKey:@"busiName"];
    NSDictionary * collectedBusi = [self.dataSource objectAtIndex:pressedCell];
    NSLog(@"remove before %d",readArray.count);
    [readArray removeObject:collectedBusi];
    NSLog(@"remove after %d",readArray.count);
    [readArray writeToFile:[self documentsPath:@"collectedBusi.txt"] atomically:YES];
    
    [self.dataSource removeObjectAtIndex:pressedCell];
    [self.tableview reloadData];
}

- (void)deleteAllCollection{
    NSMutableArray * readArray = [[[NSMutableArray alloc]initWithArray:[self readFileArray]]autorelease];
    [readArray removeAllObjects];
    [readArray writeToFile:[self documentsPath:@"collectedBusi.txt"] atomically:YES];
    
    [self.dataSource removeAllObjects];
    [self.tableview reloadData];
    
}
#pragma mark readfile

-(NSArray *)readFileArray
{
    NSLog(@"To read collectBusi........\n");
    //filePath 表示程序目录下指定文件
    NSString *filePath = [self documentsPath:@"collectedBusi.txt"];
    //从filePath 这个指定的文件里读
    NSArray * collectBusiArray = [NSArray arrayWithContentsOfFile:filePath];
    //NSLog(@"%@",[collectBusiArray objectAtIndex:0] );
    return collectBusiArray;
}

-(NSString *)documentsPath:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
