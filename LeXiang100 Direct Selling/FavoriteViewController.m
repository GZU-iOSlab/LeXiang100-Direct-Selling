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
@synthesize tableview;
@synthesize dataSource;
#define viewWidth   self.view.frame.size.width
#define viewHeight  self.view.frame.size.height
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tableview = [[UITableView alloc]initWithFrame:self.view.frame];
        self.tableview.delegate = self;
        self.tableview.dataSource = self;
        NSArray * array = [self readFileArray];
        if (array.count != 0) {
            return self;
        }
        if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7) {
            UIImage * metal = [UIImage imageNamed:@"metal.jpg"];
            UIImageView *imgViewMetal = [[UIImageView alloc] initWithImage:metal];
            imgViewMetal.frame = CGRectMake(0, 0, viewWidth, viewHeight);
            [self.view addSubview:imgViewMetal];
            
            UITextView * la = [[UITextView alloc]init];
            la.text = @"收藏夹是空的！\n\n将经常使用的业务添加到收藏夹，便于以后能够快速找到它们。";
            la.font = [UIFont systemFontOfSize:viewHeight/40];
            CGRect bounds = [[UIScreen mainScreen]applicationFrame];
            la.frame = bounds;
            la.backgroundColor = [UIColor clearColor];
            [imgViewMetal addSubview:la];
        }else{
            UITextView * la = [[UITextView alloc]init];
            la.text = @"收藏夹是空的！\n\n将经常使用的业务添加到收藏夹，便于以后能够快速找到它们。";
            la.font = [UIFont systemFontOfSize:viewHeight/40];
            la.frame = CGRectMake(0, 0, viewWidth, viewHeight);
            la.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
            [self.view addSubview:la];
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
        NSLog(@"没数据！");
    }else{
        [self.view addSubview: self.tableview];
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

- (void)longPress:(UILongPressGestureRecognizer *)recognizer {

}

#pragma mark readfile

-(NSArray *)readFileArray
{
    NSLog(@"To read collectBusi........\n");
    //filePath 表示程序目录下指定文件
    NSString *filePath = [self documentsPath:@"collectedBusi.txt"];
    //从filePath 这个指定的文件里读
    NSArray * collectBusiArray = [NSArray arrayWithContentsOfFile:filePath];
    NSLog(@"%@",[collectBusiArray objectAtIndex:0] );
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
