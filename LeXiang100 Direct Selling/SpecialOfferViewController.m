//
//  SpecialOfferViewController.m
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-22.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import "SpecialOfferViewController.h"

@interface SpecialOfferViewController ()

@end

@implementation SpecialOfferViewController
#define viewWidth   self.view.frame.size.width
#define viewHeight  self.view.frame.size.height
extern NSMutableDictionary * UserInfo;
extern Boolean login;
extern connectionAPI * soap;
extern NSNotificationCenter *nc;
extern NSString * phoneNumber;
@synthesize alerts;
extern NSString * service;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [nc addObserver:self selector:@selector(awordShellFeedback) name:@"awordResponseNo" object:nil];
        [nc addObserver:self selector:@selector(awordShellFeedback:) name:@"awordShellQueryResponse" object:nil];
        self.title = service;
        self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"查询" style:UIBarButtonItemStyleBordered target:self action:@selector(searchFor)];
        UITextView * background = [[[UITextView alloc]init]autorelease];
        background.frame = self.view.frame;
        //[self.view addSubview: background];
        
        //通讯录tableview初始化
        addressBook = [[AddresseBookTableViewController alloc]init];
        addressBook.uerInfoArray = [[NSMutableArray alloc]init];
        
        //背景框
        UITextField * backgroundText = [[[UITextField alloc]initWithFrame:CGRectMake(viewWidth/40, viewHeight/60, viewWidth-viewWidth/20, viewHeight/5) ]autorelease];
        backgroundText.enabled = NO;
        backgroundText.borderStyle = UITextBorderStyleRoundedRect;
        backgroundText.backgroundColor = [UIColor lightTextColor];
        backgroundText.autoresizesSubviews = YES;
        [self.view addSubview:backgroundText];
        
        phoneText = [[UITextField alloc]initWithFrame:CGRectMake( viewWidth/32+viewWidth/40 , viewHeight/11, viewWidth/1.5, viewHeight/15)];
        phoneText.placeholder = @"请输入号码";
        phoneText.font = [UIFont systemFontOfSize:viewHeight/25];
        phoneText.borderStyle = UITextBorderStyleRoundedRect;
        phoneText.backgroundColor = [UIColor whiteColor];
        phoneText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        phoneText.clearButtonMode = UITextFieldViewModeWhileEditing;
        phoneText.text = @"15285987576";
        phoneText.delegate = self;
        [self.view addSubview:phoneText];
        
        UIButton * linkManBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        linkManBtn.frame = CGRectMake(viewWidth/1.3, viewHeight/11, viewWidth/6, viewHeight/15);
        [linkManBtn setTitle:@"联系人" forState:UIControlStateNormal];
        linkManBtn.titleLabel.font = [UIFont systemFontOfSize:viewHeight/35];
        [linkManBtn addTarget:self action:@selector(linkMan) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:linkManBtn];
        
        UILabel * servicesLabel = [[[UILabel alloc]initWithFrame:CGRectMake(viewWidth/32+viewWidth/40, viewHeight/30, viewWidth/2, viewHeight/20)]autorelease];
        servicesLabel.text = @"客户手机号码:";
        servicesLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        servicesLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.view addSubview:servicesLabel];
        
        busiLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewWidth/40, viewHeight, viewWidth-viewWidth/20, viewHeight/20)];
        busiLabel.text = @"适合参加的业务：";
        busiLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        busiLabel.backgroundColor = [UIColor clearColor];
        [self.view addSubview:busiLabel];
        
        busiText = [[UITextField alloc]initWithFrame:CGRectMake(viewWidth/40, viewHeight+viewHeight/20, viewWidth-viewWidth/20, viewHeight/5)];
        busiText.borderStyle = UITextBorderStyleRoundedRect;
        UIImage * rightImage = [UIImage imageNamed:@"right.png"];
        UIImageView * imgViewRight = [[[UIImageView alloc]initWithImage:rightImage]autorelease];
        imgViewRight.frame = CGRectMake(0, 0, viewWidth/30, viewWidth/20);
        busiText.font = [UIFont systemFontOfSize:viewHeight/30];
        busiText.delegate = self;
        busiText.rightView = imgViewRight;
        busiText.rightViewMode = UITextFieldViewModeAlways;
        busiText.textAlignment = NSTextAlignmentCenter;
        busiText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        busiText.backgroundColor = [UIColor lightTextColor];
        [self.view addSubview:busiText];
        toDetail = NO;
        
        HELLOWORD = [[NSMutableString alloc]init];
        offerID = [[NSMutableString alloc]init];
        offerType = [[NSMutableString alloc]init];
        
        //解决ios7界面上移  配色等问题
        if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars =NO;
            self.modalPresentationCapturesStatusBarAppearance = NO;
            self.navigationController.navigationBar.translucent = NO;

            linkManBtn.backgroundColor = [UIColor whiteColor];
            linkManBtn.layer.borderColor =  [UIColor iOS7lightGrayColor].CGColor;
            linkManBtn.layer.borderWidth = 1;
            phoneText.backgroundColor = [UIColor whiteColor];
            backgroundText.backgroundColor = [UIColor lightTextColor];
            backgroundText.frame = CGRectMake(viewWidth/40, viewHeight/60, viewWidth-viewWidth/20, viewHeight/6);
            servicesLabel.backgroundColor = [UIColor clearColor];
            self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }
        //针对iPad的界面调整
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            backgroundText.frame = CGRectMake(viewWidth/40, viewHeight/60, viewWidth-viewWidth/20, viewHeight/5);
            linkManBtn.frame = CGRectMake(viewWidth/1.3, viewHeight/10, viewWidth/8, viewHeight/15);
            phoneText.frame = CGRectMake( viewWidth/32+viewWidth/40 , viewHeight/10, viewWidth/1.5, viewHeight/15);
            phoneText.keyboardType = UIKeyboardTypeNumberPad;
            
        }
    }
    return self;
}

- (void)dealloc{
    [super dealloc];
    [busiLabel release];
    [busiText release];
    [HELLOWORD release];
    [offerID release];
    [offerType release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    phoneText.text = phoneNumber;
}

- (void)viewDidDisappear:(BOOL)animated{
    phoneNumber = @"";
}

#pragma mark - AlertView

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self dimissAlert:alerts]; ;
    }
    else{
        //在这里如何获取UIAlertView里的LoginAndPasswordInput值？
    }
}

- (void) dimissAlert:(UIAlertView *)alert
{
    if(self.alerts)
    {
        [self.alerts dismissWithClickedButtonIndex:[alert cancelButtonIndex]animated:YES];
    }
}

#pragma mark UesrTouche

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if ([touch view] != phoneText) {
        [phoneText resignFirstResponder];
    }
    
    
}

#pragma mark textefield delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == busiText && toDetail) {
        DetailViewController * detailView = [[[DetailViewController alloc]init]autorelease];
        detailView.haveBtn = @"0";
        detailView.phoneNmubers = phoneText.text;
        
        NSMutableDictionary * dic = [[[NSMutableDictionary alloc]init]autorelease];//WithObjectsAndKeys:busiText.text,@"busiName",HELLO_WORD,@"busiDesc" ,nil];
        [dic setObject:busiText.text forKey:@"busiName"];
        [dic setObject:HELLOWORD forKey:@"busiDesc"];
        [dic setObject:phoneText.text forKey:@"name"];
        [dic setObject:offerID forKey:@"OFFER_ID"];
        [dic setObject:offerType forKey:@"OFFER_TYPE"];
        detailView.detailService = dic;
        
        [self.navigationController pushViewController:detailView animated:YES];
    }
    if (textField == busiText) {
        return NO;
    }
    return  YES;//NO进入不了编辑模式
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)searchFor{
    if (busiText.frame.origin.y<viewHeight && busiLabel.frame.origin.y<viewHeight) {
        [UIView animateWithDuration:0.3 animations:^{busiLabel.center = CGPointMake(viewWidth/2, viewHeight*5/4);busiText.center = CGPointMake(viewWidth/2, viewHeight*5/4);}];
    }
    
    NSString * number;
    if ([phoneText.text isEqualToString:@""]) {
        [connectionAPI showAlertWithTitle:@"请输入手机号" AndMessages:@"手机号码不能为空,请检查后重新输入！"];
    }else{
        number = [phoneText.text substringWithRange:NSMakeRange(0,1)];
        if (phoneText.text.length != 11 && ![number isEqualToString:@"1"]) {
            [connectionAPI showAlertWithTitle:@"号码错误" AndMessages:@"手机号码错误,请检查后重新输入！"];
        }else{
            NSString * token = [UserInfo objectForKey:@"token"];
            [soap AwordShellWithInterface:@"awordShellQuery" Parameter1:@"custPhone" CustPhone:phoneText.text Parameter2:@"token" Token:token];
        }
    }
}

- (void)linkMan{
    //获取通讯录权限
    ABAddressBookRef addressBooks = ABAddressBookCreateWithOptions(NULL, NULL);
    __block BOOL accessGranted = NO;
    if (ABAddressBookRequestAccessWithCompletion != NULL) {
        
        // we're on iOS 6
        NSLog(@"on iOS 6 or later, trying to grant access permission");
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBooks, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_release(sema);
    }
    CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(addressBooks);
    for(int i = 0; i < CFArrayGetCount(results); i++){
        ABRecordRef person = CFArrayGetValueAtIndex(results, i);
        NSMutableDictionary * dic = [[[NSMutableDictionary alloc]init]autorelease];
        NSMutableString * str = [[[NSMutableString alloc]init]autorelease];
        //读取firstname
        NSString *firstname = (NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
        if(firstname != nil){
            [str appendString:firstname];
            //NSLog(@"firstname:%@",firstname);
        }
        //读取lastname
        NSString *lastname = (NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
        if(lastname != nil){
            [str appendString:lastname];
            //NSLog(@"lastname:%@",lastname);
        }
        [dic setObject:str forKey:@"name"];
        
        //获取的联系人单一属性:Generic phone number
        ABMultiValueRef tmpPhones = ABRecordCopyValue(person, kABPersonPhoneProperty);
        NSString * phoneNumber = (NSString *)ABMultiValueCopyValueAtIndex(tmpPhones, 0);
        if(phoneNumber == NULL) {
            NSLog(@"continue");
            continue;
        }
        [dic setObject:phoneNumber forKey:@"phoneNumber"];
        [addressBook.uerInfoArray addObject:dic];
    }
    [self.navigationController pushViewController:addressBook animated:YES];
}

- (void)awordShellFeedback{
    busiText.text = @"没有适合参加的业务";
    toDetail = NO;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [UIView animateWithDuration:0.3 animations:^{busiLabel.center = CGPointMake(viewWidth/2, viewHeight/2.2-120);busiText.center = CGPointMake(viewWidth/2, viewHeight/2.2);}];
    }else{
    [UIView animateWithDuration:0.3 animations:^{busiLabel.center = CGPointMake(viewWidth/2, viewHeight/2.2-70);busiText.center = CGPointMake(viewWidth/2, viewHeight/2.2);}];
    }
}

-(BOOL) respondsToSelector : (SEL)aSelector {
    //printf("SELECTOR: %s\n", [NSStringFromSelector(aSelector) UTF8String]);
    return [super respondsToSelector:aSelector];
}

- (void)awordShellFeedback:(NSNotification *)note{
    toDetail = YES;
    NSDictionary * dic =[[note userInfo] objectForKey:@"1"];
    NSDictionary * offerList = [dic objectForKey:@"returnOfferList"];
    NSArray * offerArray = [dic objectForKey:@"returnOfferList"];
    [offerID setString:@""];
    
    if ([offerArray isKindOfClass:[NSArray class]]) {
        NSLog(@"i'm a array");
        [offerID setString:@""];
        [offerID appendString:[[offerArray objectAtIndex:0]objectForKey:@"OFFER_ID"]];
        [HELLOWORD setString:@""];
        [HELLOWORD appendString:[[offerArray objectAtIndex:0]objectForKey:@"HELLO_WORD"]];
        [offerType setString:@""];
        [offerType appendString:[[offerArray objectAtIndex:0]objectForKey:@"OFFER_TYPE"]];
    }
    else if ([offerList isKindOfClass:[NSDictionary class]]){
        //HELLOWORD = [offerList objectForKey:@"HELLO_WORD"];
        NSLog(@"i'm a dic");
    }
    NSString * text1;
    if ([offerType isEqualToString:@"1"]) {
        NSArray * list = [HELLOWORD componentsSeparatedByString:@"，"];
        for (NSString * str in list) {
            if ([str rangeOfString:@"消费的"].length>0) {
                NSRange range = [str rangeOfString:@"消费的"];
                NSUInteger location = range.location;
                
                text1 = [str substringWithRange:NSMakeRange(location+3, str.length-location-3)];
            }
        }
    }
    else if ([offerType isEqualToString:@"2"]){
        NSArray * list = [HELLOWORD componentsSeparatedByString:@"，"];
        for (NSString * str in list) {
            if ([str rangeOfString:@"推荐"].length>0) {
                NSRange range = [str rangeOfString:@"推荐"];
                NSUInteger location = range.location;
                
                text1 = [str substringWithRange:NSMakeRange(location+2, str.length-location-2)];
            }
        }
    }
    busiText.text = text1;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [UIView animateWithDuration:0.3 animations:^{busiLabel.center = CGPointMake(viewWidth/2, viewHeight/2.2-120);busiText.center = CGPointMake(viewWidth/2, viewHeight/2.2);}];
    }else{
        [UIView animateWithDuration:0.3 animations:^{busiLabel.center = CGPointMake(viewWidth/2, viewHeight/2.2-70);busiText.center = CGPointMake(viewWidth/2, viewHeight/2.2);}];
    }
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
