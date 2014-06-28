//
//  MainViewController.m
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-5-30.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize navigationController;
extern NSString * currentTabView;
extern connectionAPI * soap;
extern NSMutableDictionary * UserInfo;
extern NSNotificationCenter *nc;
extern SQLForLeXiang * DB;
extern NSString * phoneNumber;
extern NSMutableString * service;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        BusinessRecommendedViewController * businessTab =[[BusinessRecommendedViewController alloc]init];
        MyLeXiangViewController * myTab = [[MyLeXiangViewController alloc]init];
        MoreViewController * moreTab = [[MoreViewController alloc]init];
        
        businessRecommendedNav = [[UINavigationController alloc]initWithRootViewController:businessTab];
        myLeXiangNav = [[UINavigationController alloc]initWithRootViewController:myTab];
        moreNav = [[UINavigationController alloc]initWithRootViewController:moreTab];
        
        self.viewControllers = [NSArray arrayWithObjects:businessRecommendedNav,myLeXiangNav,moreNav, nil];
        //self.tabBar.delegate = self;
        if (([[[UIDevice currentDevice]systemVersion]floatValue]>=7)) {
            [businessRecommendedNav.navigationBar  setBackgroundColor:[UIColor blackColor]];
            //[businessRecommendedNav.navigationBar setBackgroundImage:[UIImage imageNamed:@"123.png"] forBarMetrics:UIBarMetricsDefault];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    soap = [[connectionAPI  alloc]init];
    UserInfo = [[NSMutableDictionary alloc]init] ;
    nc = [NSNotificationCenter defaultCenter];
    DB = [[SQLForLeXiang alloc]init];
    service = [[NSMutableString alloc]init];
    //取得数据版本
    NSDictionary * versionDic = [self readFileDic];
    //检查数据库是否为空
    int recordNumber = [DB numOfRecords];
    NSArray * hotArray = [self readFileArray];
    if (recordNumber == 0) {
        NSString * version = @"20140404144444";
         [soap CheckVersionWithInterface:@"queryVersionInfo" Parameter1:@"clientVersion" ClientVersion:@"1.0.0" Parameter2:@"dataVersion" DataVersion:version Parameter3:@"appName" AppName:@"lx100-iPhone"];
    }
    //检测是否写入了热点业务
    else if (hotArray == NULL) {
        UIAlertView * alertForHotBusi = [[UIAlertView alloc]initWithTitle:@"热点业务更新" message:@"是否更新热点业务？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
        alertForHotBusi.delegate = self;
        [alertForHotBusi show];
        [alertForHotBusi release];
    }
    else{
        NSDictionary * phoneUpdateCfg = [versionDic objectForKey:@"phoneUpdateCfg"];
        NSString * version = [phoneUpdateCfg objectForKey:@"versionCode"];
        [soap CheckVersionWithInterface:@"queryVersionInfo" Parameter1:@"clientVersion" ClientVersion:@"1.0.0" Parameter2:@"dataVersion" DataVersion:version Parameter3:@"appName" AppName:@"lx100-iPhone"];
    }
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
	return NO;
}

- (NSUInteger)supportedInterfaceOrientations {
	return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
	return UIInterfaceOrientationPortrait;
}


#pragma mark readfile
//读取版本信息
-(NSDictionary *)readFileDic
{
    NSLog(@"To read versionDic........\n");
    //filePath 表示程序目录下指定文件
    NSString *filePath = [self documentsPath:@"version.txt"];
    //从filePath 这个指定的文件里读
    NSDictionary * collectBusiArray = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return collectBusiArray;
}

//读取热点业务
-(NSArray *)readFileArray
{
    NSLog(@"To read hotBusi........\n");
    //filePath 表示程序目录下指定文件
    NSString *filePath = [self documentsPath:@"hotBusi.txt"];
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

#pragma mark - AlertView

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        //[nc postNotificationName:@"VersionInfoUpadate" object:self userInfo:self.resultDic];
    }else if (buttonIndex == 1){
        [soap HotServiceWithInterface:@"queryBusiHotInfo" Parameter1:@"versionTag" Version:@"public"];
    }
}

+ (void)showAlertWithTitle:(NSString *)titles AndMessages:(NSString *)messages{
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:titles message:messages delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好的", nil];
    [alert show];
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
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
