//
//  UpdateCheckingViewController.m
//  LeXiang100 Direct Selling
//
//  Created by 任魏翔 on 14-6-17.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import "UpdateCheckingViewController.h"

@interface UpdateCheckingViewController ()

@end

@implementation UpdateCheckingViewController
extern connectionAPI * soap;
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
        
        UIScrollView *scrollview=[[UIScrollView alloc] initWithFrame:self.view.frame];
        scrollview.contentSize=CGSizeMake(viewWidth, viewHeight*1.1);
        scrollview.showsHorizontalScrollIndicator=FALSE;
        scrollview.showsVerticalScrollIndicator=TRUE;
        UITextView * background = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
        background.editable=NO;
        [self.view addSubview:background];
        
       
        UIFont *font1 = [UIFont fontWithName:@"Arial" size:viewHeight/47];
        UIFont *font2=[UIFont fontWithName:@"Arial" size:viewHeight/35];
        UIColor *myColorRGB = [ UIColor colorWithRed: 0.75
                                               green: 0.75
                                                blue: 0.75
                                               alpha: 1.0  
                               ]; 

        
        //乐享图标自助办理
        UIImage * Image = [UIImage imageNamed:@"ic_launcher.png"];
        UIImageView * imgView = [[UIImageView alloc]initWithImage:Image];
        imgView.frame = CGRectMake(viewWidth/2-viewWidth/8, viewHeight/10, viewWidth/4, viewWidth/4);
        
        [self.view addSubview:imgView];
        
        //乐享100
        UILabel * Lexiang100 = [[UILabel alloc]initWithFrame:CGRectMake(viewWidth/2-viewWidth/10, viewHeight/8, viewWidth/5, viewHeight/20)];
        Lexiang100.text = @"乐享100";
        Lexiang100.font=font2;
        Lexiang100.center=CGPointMake(viewWidth/2, viewHeight/3.5);
        Lexiang100.backgroundColor = [UIColor clearColor];
        Lexiang100.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:Lexiang100];
        
        //版本号标题
        UILabel * version = [[UILabel alloc]initWithFrame:CGRectMake(viewWidth/2-viewWidth/7+viewWidth/60, viewHeight/6-viewHeight/80+viewHeight/40, viewWidth/4, viewHeight/20)];
        version.text = @"版 本 号：1.48";
        version.font=font1;
        version.center=CGPointMake(viewWidth/2, viewHeight/3);
        version.textAlignment = NSTextAlignmentCenter;
        version.backgroundColor = [UIColor clearColor];
        [self.view addSubview:version];
        
        
        
        //检查更新按钮
        UIButton *updateButton=[[UIButton alloc] initWithFrame:CGRectMake(viewWidth/3+viewWidth/70, viewHeight/3, viewWidth/4, viewHeight/20)];
        updateButton.backgroundColor=myColorRGB;
        updateButton.center=CGPointMake(viewWidth/2, viewHeight/2.5);
        [updateButton setTitle:@"检查更新" forState:UIControlStateNormal];
        [updateButton addTarget:self action:@selector(updateData) forControlEvents:UIControlEventTouchUpInside];//添加点击按钮执行的方法
        [self.view addSubview:updateButton];
        
        //乐享版权标题
        UILabel *  copyright= [[UILabel alloc]initWithFrame:CGRectMake(viewWidth/5, viewHeight/4+viewHeight/10, viewWidth/3, viewHeight/20)];
        copyright.text = @"乐享100 版权所有";
        copyright.font=font1;
        copyright.center=CGPointMake(viewWidth/2, viewHeight/2);
        copyright.textAlignment = NSTextAlignmentCenter;
        copyright.backgroundColor = [UIColor clearColor];
        [self.view addSubview:copyright];
        
        //乐享版权
        UILabel *  copyright_c= [[UILabel alloc]initWithFrame:CGRectMake(viewWidth/5, viewHeight/4+viewHeight/5, viewWidth/1.5, viewHeight/20)];
        copyright_c.center = CGPointMake(viewWidth/2, viewHeight/1.8);
        copyright_c.text = @"Copyright 2010 乐享100.All Right Rreserved.";
        copyright_c.font=font1;
        copyright_c.backgroundColor = [UIColor clearColor];
        copyright_c.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:copyright_c];

        //设备是iPad时
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
            imgView.frame = CGRectMake(viewWidth/2-viewWidth/12, viewHeight/10, viewWidth/6, viewWidth/6);
        }
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)updateData{
    //[soap BusiInfoWithInterface:@"queryBusiInfo" Parameter1:@"versionTag" Version:@"Public"];
    [soap HotServiceWithInterface:@"queryBusiHotInfo" Parameter1:@"versionTag" Version:@"hotservice"];
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
