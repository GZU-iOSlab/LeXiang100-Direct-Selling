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
        UIImage * Image = [UIImage imageNamed:@"busi_package.png"];
        UIImageView * imgView = [[UIImageView alloc]initWithImage:Image];
        imgView.frame = CGRectMake(viewWidth/2-viewWidth/20, viewHeight/10, viewWidth/20, viewHeight/20);
        
        [self.view addSubview:imgView];
        
        //乐享100
        UILabel * Lexiang100 = [[UILabel alloc]initWithFrame:CGRectMake(viewWidth/2-viewWidth/10, viewHeight/8, viewWidth/5, viewHeight/5)];
        Lexiang100.text = @"乐享100";
        Lexiang100.font=font2;
        Lexiang100.backgroundColor = [UIColor clearColor];
        [self.view addSubview:Lexiang100];
        
        //版本号标题
        UILabel * version = [[UILabel alloc]initWithFrame:CGRectMake(viewWidth/2-viewWidth/7+viewWidth/60, viewHeight/6-viewHeight/80+viewHeight/40, viewWidth/5, viewHeight/5)];
        version.text = @"版 本 号：";
        version.font=font1;
        version.backgroundColor = [UIColor clearColor];
        [self.view addSubview:version];
        
        //版本号
        UILabel * versionNum = [[UILabel alloc]initWithFrame:CGRectMake(viewWidth/2, viewHeight/6-viewHeight/80+viewHeight/40, viewWidth/5, viewHeight/5)];
        versionNum.text = @"1.48";
        versionNum.font=font1;
        versionNum.backgroundColor = [UIColor clearColor];
        [self.view addSubview:versionNum];
        
        //检查更新按钮
        UIButton *updateButton=[[UIButton alloc] initWithFrame:CGRectMake(viewWidth/3+viewWidth/70, viewHeight/3, viewWidth/4, viewHeight/20)];
        updateButton.backgroundColor=myColorRGB;
        [updateButton setTitle:@"检查更新" forState:UIControlStateNormal];
        
        [self.view addSubview:updateButton];
        
        //乐享版权标题
        UILabel *  copyright= [[UILabel alloc]initWithFrame:CGRectMake(viewWidth/2-viewWidth/7, viewHeight/4+viewHeight/10, viewWidth/3, viewHeight/5)];
        copyright.text = @"乐享100 版权所有";
        copyright.font=font1;
        copyright.backgroundColor = [UIColor clearColor];
        [self.view addSubview:copyright];
        
        //乐享版权
        UILabel *  copyright_c= [[UILabel alloc]initWithFrame:CGRectMake(viewWidth/5, viewHeight/4+viewHeight/5, viewWidth, viewHeight/5)];
        copyright_c.text = @"Copyright 2010 乐享100.All Right Rreserved.";
        copyright_c.font=font1;
        copyright_c.backgroundColor = [UIColor clearColor];
        [self.view addSubview:copyright_c];

        
        
    }
    
    
    return self;
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
