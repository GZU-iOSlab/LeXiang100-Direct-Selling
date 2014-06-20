//
//  BusinessRecommendedViewController.m
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-5-31.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import "BusinessRecommendedViewController.h"

@interface BusinessRecommendedViewController ()

@end

@implementation BusinessRecommendedViewController
@synthesize messageText;
@synthesize tables1;
@synthesize tables2;
extern NSString * service;
extern DataBuffer * data;
extern Boolean login;
extern SQLForLeXiang * DB;
extern connectionAPI * soap;
extern NSMutableDictionary * UserInfo;


#define iOS7  ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0)?YES:NO
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)?YES:NO
#define isPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)?YES:NO
#define viewWidth   self.view.frame.size.width
#define viewHeight  self.view.frame.size.height


#define firstX   viewWidth/10
#define secondX (viewWidth/10+viewWidth/3)
#define thirdX  (viewWidth/10+viewWidth/3*2)


//#if isPhone
#   define firstY (viewHeight/8)
#   define secondY (viewHeight/8+viewHeight/6.5)
#   define thirdY (viewHeight/8+viewHeight/6.5*2)
#   define fouthY (viewHeight/8+viewHeight/6.5*3)
//#else
//#   define firstY (viewHeight/7)
//#   define secondY (viewHeight/7+viewHeight/5)
//#   define thirdY (viewHeight/7+viewHeight/5*2)
//#   define fouthY (viewHeight/7+viewHeight/5*3)
//#endif

#define iconSize   (viewWidth/5.5)

#define boo NO
#if boo
#define xe 33
#else
#define xe 44
#endif


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //解决ios界面上移
        if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars =NO;
            self.modalPresentationCapturesStatusBarAppearance = NO;
            self.navigationController.navigationBar.translucent = NO;
            //self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
            UIImage * metal = [UIImage imageNamed:@"metal.jpg"];
            UIImageView *imgViewMetal = [[UIImageView alloc] initWithImage:metal];
            imgViewMetal.frame = CGRectMake(0, 0, viewWidth, viewHeight);
            [self.view addSubview:imgViewMetal];
        }
        //NSLog(@"!!!%f   isPad%d    phone%d",firstY,  isPad,isPhone);
        //NSLog(@"%d  %d",xe,(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)?YES:NO);
        UIImage *BusinessRecommended = [UIImage imageNamed:@"iPhone.png"];
        
        
        //设置搜索 通知 登录状态
        search =YES;
        message = YES;
        login = NO;
        
//        NSDictionary *dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[UIColor colorWithRed:200 green:200 blue:200 alpha:1],[UIFont boldSystemFontOfSize:40.0f],[UIColor colorWithWhite:0.0 alpha:1], nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor, nil]];
//        
//        self.navigationController.navigationBar.titleTextAttributes = dict;
        self.title = @"乐享100";
        self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"业务推荐" image:BusinessRecommended tag:0];
        UIBarButtonItem * searchBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(beginSearch)];
        self.navigationItem.rightBarButtonItem = searchBtn;
        self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        
        messageText = [[UITextField  alloc] initWithFrame:CGRectMake(0,0,viewWidth,viewHeight/30)];
        messageText.text = @"贵州移动用户有福啦！微信关注gzlx100即可...";
        NSInteger font = viewHeight/35;
        messageText.font= [UIFont systemFontOfSize:font];
        messageText.backgroundColor = [UIColor lightTextColor];
        messageText.textAlignment=NSTextAlignmentLeft;
        //messageText.enabled = NO;
        UIImage * soundImg = [UIImage imageNamed:@"sound.png"];
        UIImageView *imgViewSound = [[UIImageView alloc] initWithImage:soundImg];
        //imgViewSound.frame = CGRectMake(0, 0, viewWidth/20, viewWidth/20);
        messageText.leftView =imgViewSound;
        messageText.leftViewMode =UITextFieldViewModeAlways;
        //messageText.enabled = NO;
        UIImage * cancelImg = [UIImage imageNamed:@"cancel.png"];
        imgViewCancel = [[UIImageView alloc] initWithImage:cancelImg];
        //imgViewCancel.frame = CGRectMake(viewWidth-viewWidth/20, viewHeight/60, viewWidth/20, viewWidth/20);
        imgViewCancel.userInteractionEnabled = YES;
        messageText.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(UesrClicked)];
        [imgViewCancel addGestureRecognizer:singleTap];
        [singleTap release];
        messageText.rightView = imgViewCancel;
        messageText.rightViewMode =UITextFieldViewModeAlways;
        messageText.delegate = self;
        [self.view addSubview:messageText];
        
        searchText = [[UITextField alloc]initWithFrame:CGRectMake(0, -viewHeight/15, viewWidth, viewHeight/15)];
        searchText.delegate =self;
        searchText.placeholder =@"业务搜索（中文或拼音首字母）";
        NSInteger fonts = viewHeight/28;
        searchText.font= [UIFont systemFontOfSize:fonts];
        searchText.clearButtonMode =UITextFieldViewModeWhileEditing;
        searchText.borderStyle =UITextBorderStyleRoundedRect;
        searchText.clearsOnBeginEditing = YES;
        //searchText.backgroundColor = [UIColor groupTableViewBackgroundColor];
        UIImage * searchImage = [UIImage imageNamed:@"search1.png"];
        UIImageView * imgViewSearch = [[UIImageView alloc]initWithImage:searchImage];
        imgViewSearch.frame = CGRectMake(0, 0, viewHeight/23, viewHeight/23);
        searchText.rightView = imgViewSearch;
        searchText.rightViewMode = UITextFieldViewModeUnlessEditing;
        [self.view addSubview:searchText];
        //searchText.userInteractionEnabled = YES;
        imgViewSearch.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *singleSearchTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(UesrSearch)];
        [imgViewSearch addGestureRecognizer:singleSearchTap];
        [singleSearchTap release];
        
        UIImage * favouriteImg = [UIImage imageNamed:@"busi_favorite.png"];
        imgViewFavourite = [[UIImageView alloc] initWithImage:favouriteImg];
        imgViewFavourite.frame = CGRectMake(firstX, firstY, iconSize, iconSize);
        [self.view addSubview:imgViewFavourite];
        imgViewFavourite.userInteractionEnabled = YES;
        
        UIImage * topImg = [UIImage imageNamed:@"busi_top.png"];
        imgViewTop = [[UIImageView alloc] initWithImage:topImg];
        imgViewTop.frame = CGRectMake(secondX, firstY, iconSize, iconSize);
        [self.view addSubview:imgViewTop];
        imgViewTop.userInteractionEnabled = YES;
        
        UIImage * packageImg = [UIImage imageNamed:@"busi_package.png"];
        imgViewPackage = [[UIImageView alloc] initWithImage:packageImg];
        imgViewPackage.frame = CGRectMake(thirdX, firstY, iconSize, iconSize);
        [self.view addSubview:imgViewPackage];
        imgViewPackage.userInteractionEnabled = YES;
        
        UIImage * valueImg = [UIImage imageNamed:@"busi_value.png"];
        imgViewValue = [[UIImageView alloc] initWithImage:valueImg];
        imgViewValue.frame = CGRectMake(firstX, secondY, iconSize, iconSize);
        [self.view addSubview:imgViewValue];
        imgViewValue.userInteractionEnabled = YES;
        
        UIImage * sjbImg = [UIImage imageNamed:@"busi_sjb.png"];
        imgViewSjb = [[UIImageView alloc] initWithImage:sjbImg];
        imgViewSjb.frame = CGRectMake(secondX, secondY, iconSize, iconSize);
        [self.view addSubview:imgViewSjb];
        imgViewSjb.userInteractionEnabled = YES;
        
        UIImage * campImg = [UIImage imageNamed:@"busi_camp.png"];
        imgViewCamp = [[UIImageView alloc] initWithImage:campImg];
        imgViewCamp.frame = CGRectMake(thirdX, secondY, iconSize, iconSize);
        [self.view addSubview:imgViewCamp];
        imgViewCamp.userInteractionEnabled = YES;
        
        UIImage * familyImg = [UIImage imageNamed:@"busi_family.png"];
        imgViewFamily = [[UIImageView alloc] initWithImage:familyImg];
        imgViewFamily.frame = CGRectMake(firstX, thirdY, iconSize, iconSize);
        [self.view addSubview:imgViewFamily];
        imgViewFamily.userInteractionEnabled = YES;
        
        UIImage * serviceImg = [UIImage imageNamed:@"busi_service.png"];
        imgViewService = [[UIImageView alloc] initWithImage:serviceImg];
        imgViewService.frame = CGRectMake(secondX, thirdY, iconSize, iconSize);
        [self.view addSubview:imgViewService];
        imgViewService.userInteractionEnabled = YES;
        
        UIImage * entImg = [UIImage imageNamed:@"busi_ent.png"];
        imgViewEnt = [[UIImageView alloc] initWithImage:entImg];
        imgViewEnt.frame = CGRectMake(thirdX, thirdY, iconSize, iconSize);
        [self.view addSubview:imgViewEnt];
        imgViewEnt.userInteractionEnabled = YES;
        
        UIImage * ldtxImg = [UIImage imageNamed:@"busi_ldtx.png"];
        imgViewLdtx = [[UIImageView alloc] initWithImage:ldtxImg];
        imgViewLdtx.frame = CGRectMake(firstX, fouthY, iconSize, iconSize);
        [self.view addSubview:imgViewLdtx];
        imgViewLdtx.userInteractionEnabled = YES;
        
        data = [[[DataBuffer alloc]init]retain];
        
        self.tables2 = [[TableLevle2TableViewController alloc]init];
        self.tables1 = [[TableLevel1TableViewController alloc]init];
        self.tables1.dataSource = data.dataSource;
        self.tables1.keysArray = data.keys;
        self.tables2.dataSource = data.dataSource;
        self.tables2.keysArray = data.keys;
        favourite = [[FavoriteViewController alloc]init];
        }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

-(void)viewDidAppear:(BOOL)animated{
}

#pragma mark UesrTouche

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    
    if (self.tables1 != NULL) {
        //[self.tables1 release];
        self.tables1 = [[[TableLevel1TableViewController alloc]init]autorelease];
        self.tables1.dataSource = data.dataSource;
        self.tables1.keysArray = data.keys;
    }
    if (self.tables2 != NULL) {
        self.tables2 = [[[TableLevle2TableViewController alloc]init]autorelease];
        //[self.tables2 release];
    }
    
     if ([touch view]== imgViewFavourite) {
         [self.navigationController pushViewController:favourite animated:YES];
        NSLog(@"imgViewFavourite");
    }else if([touch view]== imgViewTop){
//        NSArray * readArray = [self readFileArray];
//        NSMutableArray * dataArray =[[[NSMutableArray alloc]init]autorelease];
//        for (NSDictionary * dic in readArray) {
//            NSDictionary * dics =[DB findBybusiCode:[dic objectForKey:@"busiCode"]];
//            [dataArray addObject: dics];
//        }
        NSMutableArray * dataArray =[[[NSMutableArray alloc]init]autorelease];
        [dataArray setArray:[DB findByIsTopbusi]];
        self.tables2.dataSources =  dataArray;
        NSLog(@"热点业务count:%d",self.tables2.dataSources.count);
        service = @"热点业务";
        [self.navigationController pushViewController:self.tables2 animated:YES];
        NSLog(@"热点业务 imgViewTop");
    }else if ([touch view]== imgViewPackage){
        self.tables1.dataSources =  [DB findByParentId:@"3"];
        service = @"资费套餐";
        [self.navigationController pushViewController:self.tables1 animated:YES];
        NSLog(@"资费套餐 imgViewPackage");
    }else if ([touch view]== imgViewValue) {
        self.tables1.dataSources =  [DB findByParentId:@"4"];
        service = @"增值业务";
        [self.navigationController pushViewController:self.tables1 animated:YES];
        NSLog(@"增值业务 imgViewValue");
    }else if([touch view]== imgViewSjb){
        self.tables2.dataSources =  [DB findByParentId:@"5"];
        NSLog(@"count:%d",self.tables2.dataSources.count);
        service = @"手机报";
        [self.navigationController pushViewController:self.tables2 animated:YES];
        NSLog(@"手机报 imgViewSjb");
    }else if ([touch view]== imgViewCamp){


        self.tables2.dataSources =  [DB findByParentId:@"6"];
        NSLog(@"count:%d",self.tables2.dataSources.count);
        service = @"营销活动";
        [self.navigationController pushViewController:self.tables2 animated:YES];

        NSLog(@"营销活动 imgViewCamp");
    }else if ([touch view]== imgViewFamily) {
        self.tables2.dataSources =  [DB findByParentId:@"7"];
        NSLog(@"count:%d",self.tables2.dataSources.count);
        service = @"家庭产品";
        [self.navigationController pushViewController:self.tables2 animated:YES];
        NSLog(@"家庭产品 imgViewFamily");
    }else if([touch view]== imgViewService){
        self.tables2.dataSources =  [DB findByParentId:@"8"];
        NSLog(@"count:%d",self.tables2.dataSources.count);
        service = @"基础服务";
        [self.navigationController pushViewController:self.tables2 animated:YES];
        NSLog(@"基础服务 imgViewService");
    }else if ([touch view]== imgViewEnt){
        self.tables2.dataSources =  [DB findByParentId:@"9"];
        NSLog(@"count:%d",self.tables2.dataSources.count);
        service = @"集团业务";
        [self.navigationController pushViewController:self.tables2 animated:YES];
        NSLog(@"集团业务 imgViewEnt");
    }else if ([touch view]== imgViewCancel){
        NSLog(@" imgViewCancel");
        [self UesrClicked];
    }
    
}

#pragma mark readfile

-(NSArray *)readFileArray
{
    NSLog(@"read hotBusi........\n");
    //dataPath 表示当前目录下指定的一个文件 data.plist
    //NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
    //filePath 表示程序目录下指定文件
    NSString *filePath = [self documentsPath:@"hotBusi.txt"];
    //从filePath 这个指定的文件里读
    NSArray * hotBusiArray = [NSArray arrayWithContentsOfFile:filePath];
    NSLog(@"%@",[hotBusiArray objectAtIndex:1] );
    NSLog(@"%@",[hotBusiArray objectAtIndex:2] );
    NSLog(@"%@",[hotBusiArray objectAtIndex:3] );
    return hotBusiArray;
}

-(NSString *)documentsPath:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}

#pragma mark UesrClicked

- (void)UesrClicked{
    NSLog(@"string");
    messageText.hidden = YES;
    message = NO;
    //searchText.center = CGPointMake(searchText.frame.size.width/2, searchText.frame.size.height/2);
    //textView.center = CGPointMake(textView.center.x, textView.center.y-20);
}
#pragma mark UesrSearch
- (void)UesrSearch{
    NSLog(@"Search");
    [DB deleteDB];
    [soap BusiInfoWithInterface:@"queryBusiInfo" Parameter1:@"versionTag" Version:@"Public"];
}

- (void)beginSearch{
    if (search == YES) {
        search = NO;
        [UIView beginAnimations:@"下降" context:nil];
        [UIView setAnimationDuration:0.3];
        if (message) {
            searchText.center= CGPointMake(searchText.center.x, viewHeight/30+searchText.frame.size.height/2+viewHeight/300);
        }else
            searchText.center= CGPointMake(searchText.center.x, searchText.frame.size.height/2);

        [UIView commitAnimations];
        [searchText becomeFirstResponder];
    }else {
        search = YES;
        [UIView beginAnimations:@"上升" context:nil];
        [UIView setAnimationDuration:0.3];
        searchText.center= CGPointMake(searchText.center.x, -viewHeight/15);
        [UIView commitAnimations];
        [searchText resignFirstResponder];
    }
    NSString * CustPhone = [UserInfo objectForKey:@"name" ];
    NSString * token = [UserInfo objectForKey:@"token"];
    [soap  AwordShellWithInterface:@"awordShellQuery" Parameter1:@"custPhone" CustPhone:CustPhone Parameter2:@"token" Token:token];
}

#pragma mark textefield delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == messageText) {
        return NO;
    }
    return  YES;//NO进入不了编辑模式
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == messageText) {
        [messageText resignFirstResponder];
    }
    NSLog(@"进入编辑模式时调用");
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;//NO 退出不了编辑模式
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField.text isEqualToString: @""]) {
        textField.placeholder = @"业务搜索（中文或拼音首字母）";
    }
    NSLog(@"退出编辑模式");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //官方 取消第一响应者（就是退出编辑模式收键盘）
    [textField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [super dealloc];
    [self.tables2 release];
    [self.tables1 release];
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
