//
//  AdviceViewController.m
//  LeXiang100 Direct Selling
//
//  Created by 任魏翔 on 14-6-18.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import "AdviceViewController.h"

@interface AdviceViewController ()

@end

@implementation AdviceViewController

#define viewWidth   self.view.frame.size.width
#define viewHeight  self.view.frame.size.height
@synthesize classTableview;
@synthesize array;
@synthesize feedbackButton;
@synthesize inputFeedback;
@synthesize tishi;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //解决ios7界面上移  配色等问题
        if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars =NO;
            self.modalPresentationCapturesStatusBarAppearance = NO;
            self.navigationController.navigationBar.translucent = NO;
        }
        UITextView * background = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
        background.editable=NO;
        UIColor *myColorRGB = [ UIColor colorWithRed: 0.75
                                               green: 0.75
                                                blue: 0.75
                                               alpha: 1.0
                               ];
        UIFont *font1 = [UIFont fontWithName:@"Arial" size:viewHeight/47];
        UIFont *font2=[UIFont fontWithName:@"Arial" size:viewHeight/35];
        [self.view addSubview:background];
        
        //反馈类型标题
        UILabel * feedbackbackClass = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, viewWidth/4+viewWidth/50, viewHeight/35)];
        feedbackbackClass.text = @"反馈类型：";
        feedbackbackClass.font=font2;
        feedbackbackClass.backgroundColor = [UIColor clearColor];
        
        [self.view addSubview:feedbackbackClass];
        
        //反馈类型按钮
        feedbackButton=[[UIButton alloc] initWithFrame:CGRectMake(viewWidth/40, viewHeight/30, viewWidth*0.95, viewHeight/20)];
        feedbackButton.backgroundColor=myColorRGB;
        [feedbackButton setTitle:@"请选择反馈类型" forState:UIControlStateNormal];
        [feedbackButton addTarget:self action:@selector(showTable) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:feedbackButton];
        
        ////反馈内容标题
        UILabel * feedbackbackTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, viewHeight/10+viewHeight/30, viewWidth/4+viewWidth/50, viewHeight/35)];
        feedbackbackTitle.text = @"反馈内容：";
        feedbackbackTitle.font=font2;
        feedbackbackTitle.backgroundColor = [UIColor clearColor];
        [self.view addSubview:feedbackbackTitle];
        
        //输入反馈内容
        inputFeedback=[[UITextView alloc]initWithFrame:CGRectMake(viewWidth/40, viewHeight/10+viewHeight/15, viewWidth*0.95, viewHeight/3)];
        //inputFeedback.text=@"您的建议是我们不断改进的动力，请留下您在使用软件的过程中遇到的问题或提出宝贵意见。";
        inputFeedback.delegate = self;
        inputFeedback.backgroundColor=myColorRGB;
       
        inputFeedback.font=font1;
        [self.view addSubview:inputFeedback];
         inputFeedback.delegate=self;
        
        tishi=[[UILabel alloc]initWithFrame:CGRectMake(viewWidth/40, viewHeight/60, viewWidth*0.95, viewHeight/3)];
        tishi.text=@"您的建议是我们不断改进的动力，请留下您在使用软件的过程中遇到的问题或提出宝贵意见。";
        tishi.enabled=NO;
        tishi.backgroundColor=[UIColor clearColor];
        [self.view addSubview:tishi];
        
        //提交按钮
        //
        UIButton *submitButton=[[UIButton alloc] initWithFrame:CGRectMake(viewWidth/3+viewWidth/70, viewHeight/2+viewHeight/80, viewWidth/4, viewHeight/20)];
        submitButton.backgroundColor=myColorRGB;
        [submitButton setTitle:@"提交" forState:UIControlStateNormal];
        [submitButton addTarget:self action:@selector(submitData) forControlEvents:UIControlEventTouchUpInside];//添加点击按钮执行的方法
        [self.view addSubview:submitButton];
        


    }
    return self;
}
-(void)textViewDidChange:(UITextView *)textView
{
    if(textView.text.length==0)
    {
        tishi.text=@"您的建议是我们不断改进的动力，请留下您在使用软件的过程中遇到的问题或提出宝贵意见。";
        
    }
    else
    {
        tishi.text=@"";
    }
}

- (void)submitData
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [array count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil)
    {
        //cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault:CellIdentifier];
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text=[array objectAtIndex:[indexPath row]];
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
   // NSString *header=
    return @"反馈类型";
}
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @"   ";
}
-(void)showTable
{
    classTableview=[[UITableView alloc]initWithFrame:CGRectMake(viewWidth/2, viewHeight/2, viewWidth/2, viewHeight/2.9)style:UITableViewStylePlain];
    
    classTableview.delegate=self;
    classTableview.dataSource=self;
    [self.view addSubview:classTableview];
    classTableview.center=CGPointMake(viewWidth/2, viewHeight*1.5);
    [UIView animateWithDuration:0.3 animations:^{self.classTableview.center = CGPointMake(viewWidth/2, viewHeight/3);}];
    NSMutableArray *arrayValue=[[NSMutableArray alloc]init];
    [arrayValue addObject:@"功能建议"];
    [arrayValue addObject:@"界面建议"];
    [arrayValue addObject:@"新的需求"];
    [arrayValue addObject:@"流量问题"];
    [arrayValue addObject:@"BUG报错"];
    [arrayValue addObject:@"其他"];
    
    array=arrayValue;
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // classTableview.center=CGPointMake(viewWidth/2, viewHeight*1.5);
    [UIView animateWithDuration:0.3 animations:^{self.classTableview.center = CGPointMake(viewWidth/2, viewHeight*1.5);}];
    NSString *selectedString=[array objectAtIndex:indexPath.row];
    
    [feedbackButton setTitle:selectedString forState:UIControlStateNormal];
    
    
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
