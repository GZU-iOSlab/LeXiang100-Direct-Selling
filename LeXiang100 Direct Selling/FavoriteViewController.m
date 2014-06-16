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
#define viewWidth   self.view.frame.size.width
#define viewHeight  self.view.frame.size.height
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
