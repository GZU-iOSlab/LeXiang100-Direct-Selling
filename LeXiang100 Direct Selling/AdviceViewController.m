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
        UIButton *feedbackButton=[[UIButton alloc] initWithFrame:CGRectMake(viewWidth/40, viewHeight/30, viewWidth*0.95, viewHeight/20)];
        feedbackButton.backgroundColor=myColorRGB;
        [feedbackButton setTitle:@"                           " forState:UIControlStateNormal];
        [self.view addSubview:feedbackButton];
        
        ////反馈内容标题
        UILabel * feedbackbackTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, viewHeight/10+viewHeight/30, viewWidth/4+viewWidth/50, viewHeight/35)];
        feedbackbackTitle.text = @"反馈内容：";
        feedbackbackTitle.font=font2;
        feedbackbackTitle.backgroundColor = [UIColor clearColor];
        [self.view addSubview:feedbackbackTitle];
        
        //输入反馈内容
        UITextView *inputFeedback=[[UITextView alloc]initWithFrame:CGRectMake(viewWidth/40, viewHeight/10+viewHeight/15, viewWidth*0.95, viewHeight/3)];
        inputFeedback.text=@"您的建议是我们不断改进的动力，请留下您在使用软件的过程中遇到的问题或提出宝贵意见。";
        inputFeedback.delegate = self;
        inputFeedback.backgroundColor=myColorRGB;
        inputFeedback.font=font1;
        [self.view addSubview:inputFeedback];
        
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
