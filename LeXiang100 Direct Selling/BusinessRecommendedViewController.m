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
@synthesize searchTableview;
@synthesize searchTableArray;
@synthesize messageText;
@synthesize tables1;
@synthesize tables2;
@synthesize resultArray;
@synthesize detailView;
extern NSMutableString * service;
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
//#   define firstY (viewHeight/8)
//#   define secondY (viewHeight/8+viewHeight/6.5)
//#   define thirdY (viewHeight/8+viewHeight/6.5*2)
//#   define fouthY (viewHeight/8+viewHeight/6.5*3)
//#else
#   define firstY (viewHeight/7)
#   define secondY (viewHeight/7+viewHeight/5.5)
#   define thirdY (viewHeight/7+viewHeight/5.5*2)
#   define fouthY (viewHeight/7+viewHeight/5.5*3)
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
        
        //NSLog(@"!!!%f   isPad%d    phone%d",firstY,  isPad,isPhone);
        //NSLog(@"%d  %d",xe,(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)?YES:NO);
        UIImage *BusinessRecommended = [UIImage imageNamed:@"iPhone.png"];
        
        int firsty,secondy,thirdy,fouthy;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            firsty = viewHeight/7;
            secondy = viewHeight/7+viewHeight/5.5;
            thirdy = viewHeight/7+viewHeight/5.5*2;
            fouthy = viewHeight/7+viewHeight/5.5*3;
        }else{
            firsty = viewHeight/8;
            secondy = viewHeight/8+viewHeight/6.5;
            thirdy = viewHeight/8+viewHeight/6.5*2;
            fouthy = viewHeight/8+viewHeight/6.5*3;
        }
        
        //设置搜索 通知 登录状态
        search =YES;
        message = YES;
        login = NO;
        
        self.title = @"乐享100";
        self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"业务推荐" image:BusinessRecommended tag:0];
        //UIBarButtonItem * searchBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(beginSearch)];
        //self.navigationItem.rightBarButtonItem = searchBtn;
        
        self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        
        messageText = [[UITextField  alloc] initWithFrame:CGRectMake(0,45,viewWidth,viewHeight/30)];
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
        
        UILabel * favouritLabel = [[[UILabel alloc]initWithFrame:CGRectMake(firstX, firsty+iconSize, iconSize, viewHeight/32)]autorelease];
        favouritLabel.text = @"收藏夹";
        favouritLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        favouritLabel.backgroundColor = [UIColor clearColor];
        favouritLabel.textAlignment =NSTextAlignmentCenter;
        [self.view addSubview:favouritLabel];
        UIImage * favouriteImg = [UIImage imageNamed:@"busi_favorite.png"];
        imgViewFavourite = [[UIImageView alloc] initWithImage:favouriteImg];
        imgViewFavourite.frame = CGRectMake(firstX, firsty, iconSize, iconSize);
        //imgViewFavourite.backgroundColor = [UIColor redColor];
        [self.view addSubview:imgViewFavourite];
        imgViewFavourite.userInteractionEnabled = YES;
        
        UILabel * topLabel = [[[UILabel alloc]initWithFrame:CGRectMake(secondX, firsty+iconSize, iconSize, viewHeight/32)]autorelease];
        topLabel.text = @"热点业务";
        topLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        topLabel.backgroundColor = [UIColor clearColor];
        topLabel.textAlignment =NSTextAlignmentCenter;
        [self.view addSubview:topLabel];
        UIImage * topImg = [UIImage imageNamed:@"busi_top.png"];
        imgViewTop = [[UIImageView alloc] initWithImage:topImg];
        imgViewTop.frame = CGRectMake(secondX, firsty, iconSize, iconSize);
        [self.view addSubview:imgViewTop];
        imgViewTop.userInteractionEnabled = YES;
        
        UILabel * packageLabel = [[[UILabel alloc]initWithFrame:CGRectMake(thirdX, firsty+iconSize, iconSize, viewHeight/32)]autorelease];
        packageLabel.text = @"资费套餐";
        packageLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        packageLabel.backgroundColor = [UIColor clearColor];
        packageLabel.textAlignment =NSTextAlignmentCenter;
        [self.view addSubview:packageLabel];
        UIImage * packageImg = [UIImage imageNamed:@"busi_package.png"];
        imgViewPackage = [[UIImageView alloc] initWithImage:packageImg];
        imgViewPackage.frame = CGRectMake(thirdX, firsty, iconSize, iconSize);
        [self.view addSubview:imgViewPackage];
        imgViewPackage.userInteractionEnabled = YES;
        
        UILabel * valueLabel = [[[UILabel alloc]initWithFrame:CGRectMake(firstX, secondy+iconSize, iconSize, viewHeight/32)]autorelease];
        valueLabel.text = @"增值业务";
        valueLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        valueLabel.backgroundColor = [UIColor clearColor];
        valueLabel.textAlignment =NSTextAlignmentCenter;
        [self.view addSubview:valueLabel];
        UIImage * valueImg = [UIImage imageNamed:@"busi_value.png"];
        imgViewValue = [[UIImageView alloc] initWithImage:valueImg];
        imgViewValue.frame = CGRectMake(firstX, secondy, iconSize, iconSize);
        [self.view addSubview:imgViewValue];
        imgViewValue.userInteractionEnabled = YES;
        
        UILabel * sjbLabel = [[[UILabel alloc]initWithFrame:CGRectMake(secondX, secondy+iconSize, iconSize, viewHeight/32)]autorelease];
        sjbLabel.text = @"手机报";
        sjbLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        sjbLabel.backgroundColor = [UIColor clearColor];
        sjbLabel.textAlignment =NSTextAlignmentCenter;
        [self.view addSubview:sjbLabel];
        UIImage * sjbImg = [UIImage imageNamed:@"busi_sjb.png"];
        imgViewSjb = [[UIImageView alloc] initWithImage:sjbImg];
        imgViewSjb.frame = CGRectMake(secondX, secondy, iconSize, iconSize);
        [self.view addSubview:imgViewSjb];
        imgViewSjb.userInteractionEnabled = YES;
        
        UILabel * campLabel = [[[UILabel alloc]initWithFrame:CGRectMake(thirdX, secondy+iconSize, iconSize, viewHeight/32)]autorelease];
        campLabel.text = @"营销活动";
        campLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        campLabel.backgroundColor = [UIColor clearColor];
        campLabel.textAlignment =NSTextAlignmentCenter;
        [self.view addSubview:campLabel];
        UIImage * campImg = [UIImage imageNamed:@"busi_camp.png"];
        imgViewCamp = [[UIImageView alloc] initWithImage:campImg];
        imgViewCamp.frame = CGRectMake(thirdX, secondy, iconSize, iconSize);
        [self.view addSubview:imgViewCamp];
        imgViewCamp.userInteractionEnabled = YES;
        
        UILabel * familyLabel = [[[UILabel alloc]initWithFrame:CGRectMake(firstX, thirdy+iconSize, iconSize, viewHeight/32)]autorelease];
        familyLabel.text = @"家庭产品";
        familyLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        familyLabel.backgroundColor = [UIColor clearColor];
        familyLabel.textAlignment =NSTextAlignmentCenter;
        [self.view addSubview:familyLabel];
        UIImage * familyImg = [UIImage imageNamed:@"busi_family.png"];
        imgViewFamily = [[UIImageView alloc] initWithImage:familyImg];
        imgViewFamily.frame = CGRectMake(firstX, thirdy, iconSize, iconSize);
        [self.view addSubview:imgViewFamily];
        imgViewFamily.userInteractionEnabled = YES;
        
        UILabel * serviceLabel = [[[UILabel alloc]initWithFrame:CGRectMake(secondX, thirdy+iconSize, iconSize, viewHeight/32)]autorelease];
        serviceLabel.text = @"基础服务";
        serviceLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        serviceLabel.backgroundColor = [UIColor clearColor];
        serviceLabel.textAlignment =NSTextAlignmentCenter;
        [self.view addSubview:serviceLabel];
        UIImage * serviceImg = [UIImage imageNamed:@"busi_service.png"];
        imgViewService = [[UIImageView alloc] initWithImage:serviceImg];
        imgViewService.frame = CGRectMake(secondX, thirdy, iconSize, iconSize);
        [self.view addSubview:imgViewService];
        imgViewService.userInteractionEnabled = YES;
        
        UILabel * entLabel = [[[UILabel alloc]initWithFrame:CGRectMake(thirdX, thirdy+iconSize, iconSize, viewHeight/32)]autorelease];
        entLabel.text = @"集团业务";
        entLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        entLabel.backgroundColor = [UIColor clearColor];
        entLabel.textAlignment =NSTextAlignmentCenter;
        [self.view addSubview:entLabel];
        UIImage * entImg = [UIImage imageNamed:@"busi_ent.png"];
        imgViewEnt = [[UIImageView alloc] initWithImage:entImg];
        imgViewEnt.frame = CGRectMake(thirdX, thirdy, iconSize, iconSize);
        [self.view addSubview:imgViewEnt];
        imgViewEnt.userInteractionEnabled = YES;
        
        UILabel * ldxLabel = [[[UILabel alloc]initWithFrame:CGRectMake(firstX, fouthy+iconSize, iconSize, viewHeight/32)]autorelease];
        ldxLabel.text = @"优惠活动";
        ldxLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        ldxLabel.backgroundColor = [UIColor clearColor];
        ldxLabel.textAlignment =NSTextAlignmentCenter;
        [self.view addSubview:ldxLabel];
        UIImage * ldtxImg = [UIImage imageNamed:@"busi_ldtx.png"];
        imgViewLdtx = [[UIImageView alloc] initWithImage:ldtxImg];
        imgViewLdtx.frame = CGRectMake(firstX, fouthy, iconSize, iconSize);
        [self.view addSubview:imgViewLdtx];
        imgViewLdtx.userInteractionEnabled = YES;
        
        data = [[[DataBuffer alloc]init]retain];
 
        //初始化搜索条
        self.mSearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight/60)];
        //[self.mSearchBar setBackgroundImage:[UIImage imageNamed:@"search1.png"]];
        //[self.mSearchBar setPrompt:@"Prompt"];// 顶部提示文本,相当于控件的Title
        //[self.mSearchBar setBarStyle:UIBarStyleDefault];// 搜索框样式
        //[self.mSearchBar setTintColor:[UIColor blackColor]];// 搜索框的颜色，当设置此属性时，barStyle将失效
        //[self.mSearchBar setTranslucent:YES];// 设置是否透明
        [self.mSearchBar setSearchFieldBackgroundPositionAdjustment:UIOffsetMake(0,0)];// 设置搜索框中文本框的背景的偏移量
        [self.mSearchBar setSearchResultsButtonSelected:NO];// 设置搜索结果按钮是否选中
        [self.mSearchBar setShowsSearchResultsButton:YES];// 是否显示搜索结果按钮
        self.mSearchBar.backgroundColor = [UIColor clearColor];
        [self.mSearchBar setPlaceholder:@"搜索业务名称"];
        self.mSearchBar.delegate = self;
        [self.mSearchBar sizeToFit];
        
        [self.view addSubview: self.mSearchBar];
        
        //初始化UISearchDisplayController
        self.searchController =[[UISearchDisplayController alloc] initWithSearchBar:self.mSearchBar contentsController:self];
        
        self.searchController.searchResultsDelegate= self;
        self.searchController.searchResultsDataSource = self;
        self.searchController.delegate = self;
        
        self.resultArray = [[NSMutableArray alloc]init];
        
        self.tables1.dataSource = data.dataSource;
        self.tables1.keysArray = data.keys;
        self.tables2.dataSource = data.dataSource;
        self.tables2.keysArray = data.keys;
        favourite = [[FavoriteViewController alloc]init];
        
        //解决ios界面上移
        if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars =NO;
            self.modalPresentationCapturesStatusBarAppearance = NO;
            self.navigationController.navigationBar.translucent = NO;
            self.view.backgroundColor = [UIColor lightTextColor];
            UIImage * metal = [UIImage imageNamed:@"metal.jpg"];
            UIImageView *imgViewMetal = [[UIImageView alloc] initWithImage:metal];
            imgViewMetal.frame = CGRectMake(0, 0, viewWidth, viewHeight);
            [self.view addSubview:imgViewMetal];
            [self.view sendSubviewToBack:imgViewMetal];
        }
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            messageText.frame = CGRectMake(0,viewHeight/25,viewWidth,viewHeight/30);
        }
    }
    return self;
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

-(BOOL) respondsToSelector : (SEL)aSelector {
    //printf("SELECTOR: %s\n", [NSStringFromSelector(aSelector) UTF8String]);
    return [super respondsToSelector:aSelector];
}

#pragma mark UesrTouche

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    
    self.tables1 = [[[TableLevel1TableViewController alloc]init]autorelease];
    self.tables2 = [[[TableLevle2TableViewController alloc]init]autorelease];
    
//读取数据库
    if ([DB numOfRecords] == 0) {
        BusiInfoAlerts = [[UIAlertView alloc]initWithTitle:@"数据库无数据"
                                                  message:@"现在更新常规数据吗？"
                                                 delegate:self
                                        cancelButtonTitle:@"不更新"
                                        otherButtonTitles:@"更新",nil];
        [BusiInfoAlerts show];
        [BusiInfoAlerts release];
    }
    else if ([touch view]== imgViewFavourite) {
        [self.navigationController pushViewController:favourite animated:YES];
        NSLog(@"imgViewFavourite");
    }else if([touch view]== imgViewTop){
//读本地热点业务
        NSMutableArray * readArray = (NSMutableArray*)[self readFileArray];
        if (readArray.count != 0){
//数据库匹配取热点业务
            NSMutableArray * dataArray =[[[NSMutableArray alloc]init]autorelease];
                for (NSDictionary * dic in readArray) {
                    NSDictionary * dics =[DB findBybusiCode:[dic objectForKey:@"busiCode"]];
                    [dataArray addObject: dics];
                }
//        NSMutableArray * dataArray =[[[NSMutableArray alloc]init]autorelease];
//        [dataArray setArray:[DB findByIsTopbusi]];
            self.tables2.dataSources =  dataArray;
            NSLog(@"热点业务count:%d",self.tables2.dataSources.count);
            [service setString:@""];
            [service appendString: @"热点业务"];
            [self.navigationController pushViewController:self.tables2 animated:YES];
        }else{
            HotBusiAlerts = [[UIAlertView alloc]initWithTitle:@"热点业务无数据"
                                                      message:@"现在更新热点业务数据吗？"
                                                     delegate:self
                                            cancelButtonTitle:@"不更新"
                                            otherButtonTitles:@"更新",nil];
            [HotBusiAlerts show];
            [HotBusiAlerts release];
        }
        NSLog(@"热点业务 imgViewTop");
    }else if ([touch view]== imgViewPackage){
        self.tables1.dataSources =  [DB findByParentId:@"3"];
        [service setString:@""];
        [service appendString: @"资费套餐"];
        [self.navigationController pushViewController:self.tables1 animated:YES];
        NSLog(@"资费套餐 imgViewPackage");
    }else if ([touch view]== imgViewValue) {
        self.tables1.dataSources =  [DB findByParentId:@"4"];
        [service setString:@""];
        [service appendString: @"增值业务"];
        [self.navigationController pushViewController:self.tables1 animated:YES];
        NSLog(@"增值业务 imgViewValue");
    }else if([touch view]== imgViewSjb){
        self.tables2.dataSources =  [DB findByParentId:@"5"];
        NSLog(@"count:%d",self.tables2.dataSources.count);
        [service setString:@""];
        [service appendString: @"手机报"];
        [self.navigationController pushViewController:self.tables2 animated:YES];
        NSLog(@"手机报 imgViewSjb");
    }else if ([touch view]== imgViewCamp){
        self.tables2.dataSources =  [DB findByParentId:@"6"];
        NSLog(@"count:%d",self.tables2.dataSources.count);
        [service setString:@""];
        [service appendString: @"营销活动"];
        [self.navigationController pushViewController:self.tables2 animated:YES];
        
        NSLog(@"营销活动 imgViewCamp");
    }else if ([touch view]== imgViewFamily) {
        self.tables2.dataSources =  [DB findByParentId:@"7"];
        NSLog(@"count:%d",self.tables2.dataSources.count);
        [service setString:@""];
        [service appendString: @"家庭产品"];
        [self.navigationController pushViewController:self.tables2 animated:YES];
        NSLog(@"家庭产品 imgViewFamily");
    }else if([touch view]== imgViewService){
        self.tables2.dataSources =  [DB findByParentId:@"8"];
        NSLog(@"count:%d",self.tables2.dataSources.count);
        [service setString:@""];
        [service appendString: @"基础服务"];
        [self.navigationController pushViewController:self.tables2 animated:YES];
        NSLog(@"基础服务 imgViewService");
    }else if ([touch view]== imgViewEnt){
        self.tables1.dataSources =  [DB findByParentId:@"9"];
        NSLog(@"count:%d",self.tables1.dataSources.count);
        [service setString:@""];
        [service appendString: @"集团业务"];
        [self.navigationController pushViewController:self.tables1 animated:YES];
        NSLog(@"集团业务 imgViewEnt");
    }else if ([touch view]== imgViewLdtx){
        [service setString:@""];
        [service appendString: @"优惠活动"];
        if (login) {
            SpecialOfferViewController * specialView = [[[SpecialOfferViewController alloc]init]autorelease];
            [self.navigationController pushViewController:specialView animated:YES];
        }else{
            [self showAlerView];
        }
        
    }
    else if ([touch view]== imgViewCancel){
        NSLog(@" imgViewCancel");
        [self UesrClicked];
    }
    
}

#pragma mark - alertview 协议


- (void)showAlerView{
    LoginAlert = [[UIAlertView alloc]initWithTitle:@"请登录"
                                                    message:nil
                                                   delegate:nil
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"登录",nil];
    LoginAlert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    LoginAlert.delegate = self;
    [LoginAlert show];
    [LoginAlert release];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self dimissAlert:alertView]; ;
    }
    else if(buttonIndex == 1){
        if ([alertView isEqual:LoginAlert]) {
            UITextField * loginName = [alertView textFieldAtIndex:0];
            UITextField * loginPsd = [alertView textFieldAtIndex:1];
            if ([loginName.text isEqualToString:@""] || [loginPsd.text isEqualToString:@""]) {
                [connectionAPI showAlertWithTitle:@"输入错误" AndMessages:@"帐号或密码不能为空！"];
            }else{
                [soap LoginWithInterface:@"modifyLogin" Parameter1:@"loginPwd" UserName:loginPsd.text Parameter2:@"opPhone" Password:loginName.text ];
                NSLog(@"%@",loginName.text);
                NSLog(@"%@",loginPsd.text);
            }
        }else if ([alertView isEqual:HotBusiAlerts]) {
            [soap HotServiceWithInterface:@"queryBusiHotInfo" Parameter1:@"versionTag" Version:@"public"];
        }else if ([alertView isEqual:BusiInfoAlerts]){
            [DB deleteDB];
            [soap BusiInfoWithInterface:@"queryBusiInfo" Parameter1:@"versionTag" Version:@"Public"];
        }
    }
}

- (void) dimissAlert:(UIAlertView *)alert
{
        [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex]animated:YES];
}

#pragma mark - UISearchBarDelegate 协议

// UISearchBar得到焦点并开始编辑时，执行该方法
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}

// 取消按钮被按下时，执行的方法
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    
}


// 键盘中，搜索按钮被按下，执行的方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    self.searchTableview2 = [[[TableLevle2TableViewController alloc]init]autorelease];
    [service setString:@""];
    [service appendString: @"热点业务"];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    const char *letterPoint = [self.mSearchBar.text UTF8String];
    
    //如果开头不是大小写字母则读取 首字符
    if (!(*letterPoint > 'a' && *letterPoint < 'z') &&
        !(*letterPoint > 'A' && *letterPoint < 'Z')) {
        
        array = [DB findByFuzzyBusiName:searchBar.text ];
    } else {
       NSString *searchBarText = [[NSString stringWithFormat:@"%@", searchBar.text] lowercaseString];
        array = [DB getBusiNameByLetter:searchBarText];
    }
   
   self.searchTableview2.dataSources = array;

    [self.navigationController pushViewController:self.searchTableview2 animated:YES];
  }

// 当搜索内容变化时，执行该方法。很有用，可以实现时实搜索
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;{
    NSLog(@"string");
    //self.searchTableArray = [DB findByFuzzyBusiName:searchBar.text ];
}


#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope{
	/*
	 Update the filtered array based on the search text and scope.
	 */
	
	[self.self.resultArray removeAllObjects];// First clear the filtered array.
	
	/*
	 Search the main list for products whose type matches the scope (if selected) and whose name matches searchText; add items that match to the filtered array.
	 */
	//self.searchTableArray = [DB findByFuzzyBusiName:self.mSearchBar.text ];
    
    
   
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    const char *letterPoint = [self.mSearchBar.text UTF8String];
    
    //如果开头不是大小写字母则读取 首字符
    if (!(*letterPoint > 'a' && *letterPoint < 'z') &&
        !(*letterPoint > 'A' && *letterPoint < 'Z')) {
        
        array = [DB findByFuzzyBusiName:self.mSearchBar.text ];
    } else {
        NSString *mSearchBarText = [[NSString stringWithFormat:@"%@", self.mSearchBar.text] lowercaseString];
        array = [DB getBusiNameByLetter:mSearchBarText];
    }
    self.searchTableArray = array;
    //self.searchTableArray = [DB getBusiNameByLetter:self.mSearchBar.text];
    
    NSLog(@"count %d",self.searchTableArray.count);
    for (NSDictionary *dic in self.searchTableArray ) {
        [self.resultArray addObject:[dic objectForKey:@"busiName"]];
    }
    
}


#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [self filterContentForSearchText:searchString scope:
	 [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
	 [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller{
	/*
     Bob: Because the searchResultsTableView will be released and allocated automatically, so each time we start to begin search, we set its delegate here.
     */
	[self.searchDisplayController.searchResultsTableView setDelegate:self];
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller{
	/*
	 Hide the search bar
	 */
	//[self.tableView setContentOffset:CGPointMake(0, 44.f) animated:YES];
}

#pragma mark tableview delegate
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath{
    return sourceIndexPath;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"count : %d",[self.resultArray count]);
    return [self.resultArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.resultArray.count >5) {
        tableView.scrollEnabled = YES;
    }else
        tableView.scrollEnabled = NO;
    tableView.tableHeaderView = nil;
    //tableView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    static NSString * identifier = @"basis-cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell autorelease];
    }    // Configure the cell...
    
    NSString * text = [self.resultArray objectAtIndex:indexPath.row];
    NSLog(@"%d:%@",indexPath.row,text);
    cell.textLabel.text = text;
    cell.textLabel.font = [UIFont systemFontOfSize:22];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    //cell.textLabel.font = [UIFont systemFontOfSize:viewHeight/35];
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    // 去掉guop tableview的背景
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7) {
    tableView.backgroundView = nil;
    tableView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor lightTextColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    //NSLog(@"%d  row",indexPath.row);
    service = [self.resultArray objectAtIndex:indexPath.row];
    //    NSLog(@"%@  service",service);
    //    if (self.detailView != NULL) {
    //        //[self.detailView release];
    //    }
    self.detailView = [[[DetailViewController alloc]init]autorelease];
    self.detailView.detailService = [self.searchTableArray objectAtIndex:indexPath.row];
    self.detailView.haveBtn = @"1";
    [self.navigationController pushViewController:self.detailView animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
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
    //[DB deleteDB];
    //[soap BusiInfoWithInterface:@"queryBusiInfo" Parameter1:@"versionTag" Version:@"Public"];
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
//    NSString * custPhone = [UserInfo objectForKey:@"name" ];
//    NSString * token = [UserInfo objectForKey:@"token"];
//    [soap  AwordShellWithInterface:@"awordShellQuery" Parameter1:@"custPhone" CustPhone:custPhone Parameter2:@"token" Token:token];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(void)viewDidAppear:(BOOL)animated{
    //[self restoreOriginalTableView];
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
