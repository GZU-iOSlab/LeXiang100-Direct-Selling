//
//  MyLeXiangViewController.m
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-5-31.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import "MyLeXiangViewController.h"

@interface MyLeXiangViewController ()

@end

@implementation MyLeXiangViewController
@synthesize backgroundText;
@synthesize loginNameText;
@synthesize loginPasswordText;
@synthesize loginActivityIndicator;
@synthesize UserViewController;
@synthesize BankViewController;
@synthesize RecommendedViewController;
@synthesize UserInfoDic;
extern Boolean login;
extern NSNotificationCenter *nc;

extern connectionAPI * soap;
extern NSMutableDictionary * UserInfo;

#define viewWidth   self.view.frame.size.width
#define viewHeight  self.view.frame.size.height

#define firstX   viewWidth/10
#define secondX (viewWidth/10+viewWidth/3)
#define thirdX  (viewWidth/10+viewWidth/3*2)
#   define firstY (viewHeight/6)
#   define secondY (viewHeight/8+viewHeight/6.5)
#   define thirdY (viewHeight/8+viewHeight/6.5*2)
#   define fouthY (viewHeight/8+viewHeight/6.5*3)

#define iconSize   (viewWidth/5.5)

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //添加soap通知
        [nc addObserver:self selector:@selector(loginFeedback:) name:@"loginResponse" object:nil];
        [nc addObserver:self selector:@selector(tunrToUserInfoView) name:@"queryUserInfoResponse" object:nil];
        [nc addObserver:self selector:@selector(tunrToBankAccountView) name:@"queryBankInfoResponse" object:nil];
        [nc addObserver:self selector:@selector(stopIndicator) name:@"loginFalse" object:nil];

        self.UserInfoDic = [[NSMutableDictionary alloc]init];
        
        self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        UIImage *MyLeXiang = [UIImage imageNamed:@"my.png"];
        self.title = @"我的乐享";
        self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的乐享" image:MyLeXiang tag:1];
        self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        
        UIImage * personalImg = [UIImage imageNamed:@"mylx100_userinfo.png"];
        imgViewPersonal = [[UIImageView alloc] initWithImage:personalImg];
        imgViewPersonal.frame = CGRectMake(firstX, firstY, iconSize, iconSize);
        [self.view addSubview:imgViewPersonal];
        UIImage * accountImg = [UIImage imageNamed:@"mylx100_bank.png"];
        imgViewAccount = [[UIImageView alloc] initWithImage:accountImg];
        imgViewAccount.frame = CGRectMake(secondX, firstY, iconSize, iconSize);
        [self.view addSubview:imgViewAccount];
        UIImage * searchImg = [UIImage imageNamed:@"mylx100_query_recommend.png"];
        imgViewSearch = [[UIImageView alloc] initWithImage:searchImg];
        imgViewSearch.frame = CGRectMake(thirdX, firstY, iconSize, iconSize);
        [self.view addSubview:imgViewSearch];
        
        self.backgroundText = [[UITextField alloc]initWithFrame:CGRectMake(viewWidth/8, -viewHeight, viewWidth - viewWidth/4, viewHeight/2.7)];
        self.backgroundText.borderStyle = UITextBorderStyleRoundedRect;
        self.backgroundText.backgroundColor = [UIColor lightTextColor];
        self.backgroundText.delegate = self;
        [self.view addSubview:backgroundText];
        
        self.loginNameText = [[UITextField alloc]initWithFrame:CGRectMake( viewWidth/3.8 , viewHeight/15, viewWidth/2.3, viewHeight/18)];
        self.loginNameText.borderStyle = UITextBorderStyleRoundedRect;
        self.loginNameText.text=@"123";
        self.loginNameText.font = [UIFont systemFontOfSize:viewHeight/28];
        self.loginNameText.delegate = self;
        self.loginNameText.clearButtonMode =UITextFieldViewModeWhileEditing;
        self.loginNameText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        [self.backgroundText addSubview:self.loginNameText];
        
        UILabel * loginNameLabel = [[UILabel alloc]initWithFrame:CGRectMake( viewWidth/25 , viewHeight/15, viewWidth/5, viewHeight/18)];
        loginNameLabel.text = @"手机号码";
        loginNameLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        loginNameLabel.backgroundColor = [UIColor clearColor];
        [self.backgroundText addSubview:loginNameLabel];
        
        self.loginPasswordText = [[UITextField alloc]initWithFrame:CGRectMake( viewWidth/3.8 , viewHeight/15+viewHeight/12, viewWidth/2.3, viewHeight/18)];
        self.loginPasswordText.borderStyle = UITextBorderStyleRoundedRect;
        self.loginPasswordText.secureTextEntry = YES;
        self.loginPasswordText.text=@"qwe";
        self.loginPasswordText.delegate = self;
        self.loginPasswordText.clearButtonMode =UITextFieldViewModeWhileEditing;
        self.loginPasswordText.font = [UIFont systemFontOfSize:viewHeight/28];
        [self.backgroundText addSubview:self.loginPasswordText];
        
        UILabel * loginPasswordLabel = [[UILabel alloc]initWithFrame:CGRectMake( viewWidth/25 , viewHeight/15+viewHeight/12, viewWidth/5, viewHeight/18)];
        loginPasswordLabel.text = @"密码";
        loginPasswordLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        loginPasswordLabel.backgroundColor = [UIColor clearColor];
        [self.backgroundText addSubview:loginPasswordLabel];
        
        UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        loginBtn.frame = CGRectMake( viewWidth/1.9 , viewHeight/4.5, viewWidth/6, viewHeight/20);
        [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        loginBtn.titleLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        [loginBtn addTarget:self action:@selector(loginWithName:AndPassword:) forControlEvents:UIControlEventTouchUpInside];
        [self.backgroundText addSubview:loginBtn];
        
        UILabel * messageLabel = [[UILabel alloc]initWithFrame:CGRectMake( viewWidth/25 , viewHeight/3.5, viewWidth/1.5, viewHeight/18)];
        messageLabel.text = @"提示：登录密码为您在乐享100网站注册使用的密码。";
        messageLabel.numberOfLines = 0;
        messageLabel.lineBreakMode = NSLineBreakByCharWrapping;
        UIFont *font1 = [UIFont fontWithName:@"Arial" size:viewHeight/40];
        CGSize size1 = CGSizeMake(viewWidth/1.5,MAXFLOAT);
        CGSize labelsize1 = [messageLabel.text sizeWithFont:font1 constrainedToSize:size1 lineBreakMode:NSLineBreakByWordWrapping];
        messageLabel.frame = CGRectMake(viewWidth/25 , viewHeight/3.5, viewWidth/1.5, labelsize1.height);
        messageLabel.font =font1;
        messageLabel.backgroundColor = [UIColor clearColor];
        [self.backgroundText addSubview:messageLabel];
        
//        loginActivityIndicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
//        [loginActivityIndicator setCenter:CGPointMake(self.view.center.x,self.view.center.y)];
//        [loginActivityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
//        [self.view addSubview:loginActivityIndicator];
        
        UIBarButtonItem * logoutBtn = [[UIBarButtonItem alloc]initWithTitle:@"注销" style:UIBarButtonItemStyleBordered target:self action:@selector(logout)];
        self.navigationItem.rightBarButtonItem = logoutBtn;
        [logoutBtn release];
        
        if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7){
            self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
            loginBtn.backgroundColor = [UIColor whiteColor];
            loginBtn.layer.borderColor =  [UIColor iOS7lightGrayColor].CGColor;
            loginBtn.layer.borderWidth = 1;
            UIImage * metal = [UIImage imageNamed:@"metal.jpg"];
            UIImageView *imgViewMetal = [[UIImageView alloc] initWithImage:metal];
            imgViewMetal.frame = CGRectMake(0, 0, viewWidth, viewHeight);
            [self.view addSubview:imgViewMetal];
            [self.view sendSubviewToBack:imgViewMetal];
        }

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)viewDidAppear:(BOOL)animated{
    if (!login) {
        [UIView beginAnimations:@"下降" context:nil];
        [UIView setAnimationDuration:0.3];
        self.backgroundText.center= CGPointMake(self.view.center.x, self.view.center.y-viewHeight/8);
        [UIView commitAnimations];
        [loginNameText becomeFirstResponder];
        
        self.navigationItem.rightBarButtonItem.enabled = NO;
        imgViewAccount.userInteractionEnabled = NO;
        imgViewPersonal.userInteractionEnabled = NO;
        imgViewSearch.userInteractionEnabled = NO;
    }else{
        [UIView beginAnimations:@"上升" context:nil];
        [UIView setAnimationDuration:0.3];
        self.backgroundText.center= CGPointMake(self.view.center.x, -viewHeight);
        [UIView commitAnimations];
        [loginNameText resignFirstResponder];
    }
}

//- (void)viewWillAppear:(BOOL)animated{
//    if (self.RecommendedViewController != nil) {
//        [self.RecommendedViewController release];
//    }
//    self.RecommendedViewController = [[RecommendedRecordViewController  alloc]init];
//}

#pragma mark - Touch

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if ([touch view]== imgViewPersonal) {
//        if (self.UserViewController !=NULL) {
//            [self.UserViewController release];
//            self.UserViewController = [[UserTableViewController  alloc]init];
//        }else self.UserViewController = [[UserTableViewController  alloc]init];
        [self getUserInfo];
    }else if([touch view]== imgViewAccount){
//        if ( self.BankViewController!=NULL) {
//            [self.BankViewController release];
//            self.BankViewController = [[BankAccountTableViewController  alloc]init];
//        }else self.BankViewController = [[BankAccountTableViewController  alloc]init];
        [self getBankAccount];
    }else if ([touch view]== imgViewSearch){
//        if ( self.RecommendedViewController!=NULL) {
//            [self.RecommendedViewController release];
//            self.RecommendedViewController = [[RecommendedRecordViewController  alloc]init];
//        }else self.RecommendedViewController = [[RecommendedRecordViewController  alloc]init];
        [self.navigationController pushViewController:self.RecommendedViewController animated:YES];
    }
}

#pragma mark - BankAccount

-(void)getBankAccount{
//    NSRange range = [loginString rangeOfString:@"}"];
//    NSString * loginName1 = [loginString substringFromIndex:range.location+1];
//    NSArray * resultOfCut = [loginString componentsSeparatedByString:@":"];
//    NSString * token1 =[resultOfCut objectAtIndex:resultOfCut.count-1];
//    token1 = [token1 substringWithRange:NSMakeRange(0, token1.length-13)];
//    NSMutableString * token = [[NSMutableString alloc]initWithString:@"0:"];
//    [token appendString:token1];
//    [soap BackAccountWithInterface:@"queryBankInfo" Parameter1:@"opPhone" Name:loginName Parameter2:@"token" Token:token];
//    if ([loginName isEqual:@""]) {
//        [loginName appendString:loginName1];
//    }else if ([loginName isEqual:loginName1]){
//    }else {
//        [loginName setString: @""];
//        [loginName appendString:loginName1];
//    }1111
    NSString * loginName =  [self.UserInfoDic objectForKey:@"name"];
    NSString * token = [self.UserInfoDic objectForKey:@"token"];
    NSLog(@"name:%@  token:%@",loginName,token);
    [soap BackAccountWithInterface:@"queryBankInfo" Parameter1:@"opPhone" Name:loginName Parameter2:@"token" Token:token];
    self.view.userInteractionEnabled = NO;

}

- (void)tunrToBankAccountView{
    [self.navigationController pushViewController:self.BankViewController animated:YES];
    self.view.userInteractionEnabled = YES;
}

#pragma mark - UserInfo

-(void)getUserInfo{
//    NSLog(@"loginString:%@",loginString);
//    NSRange range = [loginString rangeOfString:@"}"];
//    NSString * loginName1 = [loginString substringFromIndex:range.location+1];
//    NSArray * resultOfCut = [loginString componentsSeparatedByString:@":"];
//    NSString * token1 =[resultOfCut objectAtIndex:resultOfCut.count-1];
//    //NSRange range1 = [token rangeOfString:@"}"];
//    token1 = [token1 substringWithRange:NSMakeRange(0, token1.length-13)];
//    NSMutableString * token = [[NSMutableString alloc]initWithString:@"0:"];
//    [token appendString:token1];
    
    
    NSString * loginName = [self.UserInfoDic objectForKey:@"name"];
    NSString * token = [self.UserInfoDic objectForKey:@"token"];
    NSLog(@"name:%@  token:%@",loginName,token);
    [soap UserInfoWithInterface:@"queryUserInfo" Parameter1:@"opPhone" Name:loginName Parameter2:@"token" Token:token];
    //阻止多次推送同个viewController
    self.view.userInteractionEnabled = NO;
//    if ([loginName isEqual:@""]) {
//        [loginName appendString:loginName1];
//    }else if ([loginName isEqual:loginName1]){
//    }else {
//        [loginName setString: @""];
//        [loginName appendString:loginName1];
//    }
}

- (void)tunrToUserInfoView{
//    NSString * feedbackString = [[NSString alloc]initWithString:[[note userInfo] objectForKey:@"1"]];
//    if ([feedbackString rangeOfString:@"opName"].length>0&&[feedbackString rangeOfString:@"opStatus"].length>0) {
    [self.navigationController pushViewController:self.UserViewController animated:YES];
    self.view.userInteractionEnabled = YES;

    //}else [self showAlertWithTitle:@"获取失败" AndMessages:@"获取信息失败"];
    
}

#pragma mark - login

- (void)loginWithName:(NSString *)name AndPassword:(NSString *)password{
    if ([loginNameText.text  isEqual: @""]) {
        [self showAlertWithTitle:nil AndMessages:@"手机号码不能为空"];
    }else if ([loginPasswordText.text  isEqual: @""]){
        [self showAlertWithTitle:nil AndMessages:@"密码不能为空"];
    }else{
    connectionAPI * soap = [[[connectionAPI alloc]init]autorelease];
    [soap LoginWithInterface:@"modifyLogin" Parameter1:@"loginPwd" UserName:loginPasswordText.text Parameter2:@"opPhone" Password:loginNameText.text ];
//        if ([loginActivityIndicator isAnimating]) {
//            [loginActivityIndicator stopAnimating];
//        }
//        [loginActivityIndicator startAnimating];
        [loginNameText resignFirstResponder];
        [loginPasswordText resignFirstResponder];
    }
    [self showAlerView];
}

- (void)loginFeedback:(NSNotification *)note{
//    if ([loginActivityIndicator isAnimating]) {
//        [loginActivityIndicator stopAnimating];
//    }
    [self dimissAlert:alerts];
    
    [self.UserInfoDic setDictionary:[[note userInfo] objectForKey:@"1"]];
    login = YES;
    self.navigationItem.rightBarButtonItem.enabled = YES;
    imgViewAccount.userInteractionEnabled = YES;
    imgViewPersonal.userInteractionEnabled = YES;
    imgViewSearch.userInteractionEnabled = YES;
    [UIView beginAnimations:@"上升" context:nil];
    [UIView setAnimationDuration:0.3];
    self.backgroundText.center= CGPointMake(self.view.center.x, -viewHeight);
    [UIView commitAnimations];
    [loginNameText resignFirstResponder];
    [loginPasswordText resignFirstResponder];
    [self.UserInfoDic setObject:loginNameText.text forKey:@"name"];
    if ([loginNameText.text isEqualToString:@"123"])  {
        [self.UserInfoDic setObject:@"15285987576" forKey:@"name"];
    }
    UserInfo = self.UserInfoDic;
    NSLog(@"name:%@",[self.UserInfoDic objectForKey:@"name"]);
    
    //初始化查询页面
    if ( self.RecommendedViewController == nil) {
        self.RecommendedViewController = [[RecommendedRecordViewController  alloc]init];
    }else {
        //[self.RecommendedViewController release];
        self.RecommendedViewController = [[RecommendedRecordViewController  alloc]init];
    }
    if (self.UserViewController == nil) {
        self.UserViewController = [[UserTableViewController alloc]init];
    }else{
        //[self.UserViewController release];
        self.UserViewController = [[UserTableViewController alloc]init];
    }
    if (self.BankViewController == nil) {
        self.BankViewController = [[BankAccountTableViewController alloc]init];
    }else{
        //[self.BankViewController release];
        self.BankViewController = [[BankAccountTableViewController alloc]init];
    }
}

- (void)logout{
    [UIView beginAnimations:@"下降" context:nil];
    [UIView setAnimationDuration:0.3];
    self.backgroundText.center= CGPointMake(self.view.center.x, self.view.center.y-viewHeight/8);
    [UIView commitAnimations];
    [loginNameText becomeFirstResponder];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    login = NO;
    [self.UserInfoDic release];
    self.UserInfoDic = [[NSMutableDictionary alloc]init];
    
    //释放查询页面
    if ( self.RecommendedViewController!=nil) {
        [self.RecommendedViewController release];
    }
    if ( self.UserViewController!=nil) {
        [self.UserViewController release];
    }
    if ( self.BankViewController!=nil) {
        [self.BankViewController release];
    }

}

#pragma mark - textField

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == backgroundText) {
        return NO;
    }
    return  YES;//NO进入不了编辑模式
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"进入编辑模式时调用");
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;//NO 退出不了编辑模式
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //官方 取消第一响应者（就是退出编辑模式收键盘）
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - alert

- (void)showAlertWithTitle:(NSString *)titles AndMessages:(NSString *)messages{
    
    
//    if ([loginActivityIndicator isAnimating]) {
//        [loginActivityIndicator stopAnimating];
//    }
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:titles message:messages delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"知道", nil];
    [alert show];
}

- (void)showAlerView{
    alerts = [[UIAlertView alloc]initWithTitle:@"连接中"
                                                  message:nil
                                                 delegate:nil
                                        cancelButtonTitle:nil
                                        otherButtonTitles:nil];
    alerts.frame = CGRectMake(0, 0, viewWidth/1.5, viewHeight/5);
    alerts.center = CGPointMake(0, viewHeight/2);
    [alerts show];
    UIActivityIndicatorView*activeView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activeView.center = CGPointMake(alerts.bounds.size.width/2.0f, alerts.bounds.size.height-40.0f);
    [activeView startAnimating];
    //alerts.delegate = self;
    [alerts addSubview:activeView];
    [activeView release];
    [alerts release];
}

- (void) dimissAlert:(UIAlertView *)alert
{
    if(alerts)
    {
        [alerts dismissWithClickedButtonIndex:[alert cancelButtonIndex]animated:YES];
    }
}

- (void)stopIndicator{
//    if ([loginActivityIndicator isAnimating]) {
//        [loginActivityIndicator stopAnimating];
//    }
    self.view.userInteractionEnabled = YES;
    
    [self dimissAlert:alerts];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [super dealloc];
    [self.UserViewController release];
    [self.RecommendedViewController release];
    [self.BankViewController release];
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
