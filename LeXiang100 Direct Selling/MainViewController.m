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
extern DataBuffer * data ;
extern NSString * currentTabView;
extern connectionAPI * soap;
extern NSMutableDictionary * UserInfo;
extern NSNotificationCenter *nc;
extern SQLForLeXiang * DB;
extern NSString * phoneNumber;

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
        //右划
        UISwipeGestureRecognizer *swipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipeGesture)];
        [self.view addGestureRecognizer:swipeGesture];
        [swipeGesture release];
        //左划
        UISwipeGestureRecognizer *swipeLeftGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipeGesture)];
        swipeGesture.direction=UISwipeGestureRecognizerDirectionLeft;//不设置黑夜是右
        [self.view  addGestureRecognizer:swipeLeftGesture];
        [swipeLeftGesture release];
        
        
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
    
    NSDictionary * versionDic = [self readFileDic];
    NSArray * hotArray = [self readFileArray];
    //检查是否写入了版本信息
    if (versionDic == NULL) {
        NSString * version = @"20140404144444";
        NSDictionary * phoneUpdateCfg = [[NSDictionary alloc]initWithObjectsAndKeys:version ,@"releaseDate", nil];
        NSDictionary * versionDic = [[NSDictionary alloc]initWithObjectsAndKeys:phoneUpdateCfg ,@"phoneUpdateCfg", nil];
        [versionDic writeToFile:[self documentsPath:@"version.txt"] atomically:YES];
         [soap CheckVersionWithInterface:@"queryVersionInfo" Parameter1:@"clientVersion" ClientVersion:@"1.0.0" Parameter2:@"dataVersion" DataVersion:version Parameter3:@"appName" AppName:@"lx100-iPhone"];
    }
    //检测是否写入了热点业务
    if (hotArray == NULL) {
        [soap HotServiceWithInterface:@"queryBusiHotInfo" Parameter1:@"versionTag" Version:@"public"];
    }
    //检测数据库是否有数据
    //phoneNumber = [[NSString alloc]init];
   
}

#pragma mark readfile

-(NSDictionary *)readFileDic
{
    NSLog(@"To read versionDic........\n");
    //filePath 表示程序目录下指定文件
    NSString *filePath = [self documentsPath:@"version.txt"];
    //从filePath 这个指定的文件里读
    NSDictionary * collectBusiArray = [NSDictionary dictionaryWithContentsOfFile:filePath];//[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];//[NSArray arrayWithContentsOfFile:filePath];
    //NSLog(@"%@",[collectBusiArray objectAtIndex:0] );
    return collectBusiArray;
}

-(NSArray *)readFileArray
{
    NSLog(@"To read hotBusi........\n");
    //filePath 表示程序目录下指定文件
    NSString *filePath = [self documentsPath:@"hotBusi.txt"];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}

//- (void)viewWillAppear:(BOOL)animated{
////    NSArray *paths = NSSearchPathForDirectoriesInDomains
////    (NSDocumentDirectory, NSUserDomainMask, YES);
////    NSString *documentsPath = [paths objectAtIndex:0];
//    int i;
//    NSLog(@"writeFileArray\n");
//    //新建userinfomation数组用来存一些信息
//    NSArray *userinfomation = [NSArray arrayWithObjects:@"One",@"Two",@"Three",@"four",@"five",@"six",@"seven",@"name",@"school",@"class",@"age",@"imformation",@"last",nil];
//    for(i = 0; i<12; i++)
//    {
//        NSLog(@"%i %@",i+1,[userinfomation objectAtIndex:i]);
//    }
//    //把userinfomation这个数组存入程序指定的一个文件里
//    [userinfomation writeToFile:[self documentsPath:@"usefile.txt"] atomically:YES];
//}
//
//-(void)readFileArray
//{
//    NSLog(@"readfile........\n");
//    //dataPath 表示当前目录下指定的一个文件 data.plist
//    //NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
//    //filePath 表示程序目录下指定文件
//    NSString *filePath = [self documentsPath:@"usefile.txt"];
//    //从filePath 这个指定的文件里读
//    NSArray *userinfo = [NSArray arrayWithContentsOfFile:filePath];
//    NSLog(@"%@",[userinfo objectAtIndex:1] );
//    
//}
//
//-(NSString *)documentsPath:(NSString *)fileName {
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    return [documentsDirectory stringByAppendingPathComponent:fileName];
//}

+ (void)showAlertWithTitle:(NSString *)titles AndMessages:(NSString *)messages{
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:titles message:messages delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好的", nil];
    [alert show];
}

- (void)rightSwipeGesture{
    NSLog(@"right");
//    NSArray * businessRecommendedArray = [NSArray arrayWithObjects:businessRecommendedNav,myLeXiangNav,moreNav, nil];
//    NSArray * myLeXiangArray = [NSArray arrayWithObjects:myLeXiangNav,moreNav,businessRecommendedNav, nil];
//    NSArray * moreArray = [NSArray arrayWithObjects:moreNav,businessRecommendedNav,myLeXiangNav, nil];
//    if ([currentTabView isEqualToString:@"0"]) {
//         [self.tabBarController setViewControllers:myLeXiangArray animated:YES];
//    }else if ([currentTabView isEqualToString:@"1"]){
//        [self.tabBarController setViewControllers:moreArray animated:YES];
//    }else if ([currentTabView isEqualToString:@"2"]){
//        [self.tabBarController setViewControllers:businessRecommendedArray animated:YES];
//    }
    // Try to find the root view controller programmically
    // Find the top window (that is not an alert view or other window)
//    UIViewController *result;
//    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
//    if (topWindow.windowLevel != UIWindowLevelNormal)
//    {
//        NSArray *windows = [[UIApplication sharedApplication] windows];
//        for(topWindow in windows)
//        {
//            if (topWindow.windowLevel == UIWindowLevelNormal)
//                break;
//        }
//    }
//    UIView *rootView = [[topWindow subviews] objectAtIndex:0];
//    id nextResponder = [rootView nextResponder];
//    if ([nextResponder isKindOfClass:[UIViewController class]])
//        result = nextResponder;
//    else if ([topWindow respondsToSelector:@selector(rootViewController)] && topWindow.rootViewController != nil)
//        result = topWindow.rootViewController;
//    else
//        NSAssert(NO, @"ShareKit: Could not find a root view controller.  You can assign one manually by calling [[SHK currentHelper] setRootViewController:YOURROOTVIEWCONTROLLER].");
}

- (void)leftSwipeGesture{
    NSLog(@"left");
    self.tabBarController.selectedViewController = businessRecommendedNav;
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
