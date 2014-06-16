//
//  AboutLeXiang100ViewController.m
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-11.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import "AboutLeXiang100ViewController.h"

@interface AboutLeXiang100ViewController ()

@end

@implementation AboutLeXiang100ViewController
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
        [self.view addSubview:background];
        UILabel * platform = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight/30)];
        platform.text = @"   平台介绍";
        platform.backgroundColor = [UIColor groupTableViewBackgroundColor];
        platform.layer.borderColor = [UIColor grayColor].CGColor;
        platform.layer.borderWidth = 0.5;
        [self.view addSubview:platform];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"关于乐享100";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [super dealloc];
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
