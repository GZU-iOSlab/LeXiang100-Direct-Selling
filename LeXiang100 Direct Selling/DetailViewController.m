//
//  DetailViewController.m
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-2.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
extern SQLForLeXiang *DB;
extern NSString * phoneNumber;
extern connectionAPI * soap;
extern NSMutableDictionary * UserInfo;

#define viewWidth   self.view.frame.size.width
#define viewHeight  self.view.frame.size.height
@synthesize detailService;
@synthesize phoneNmubers;
@synthesize haveBtn;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // 设置导航栏
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"推荐" style:UIBarButtonItemStyleBordered target:self action:@selector(recommended)];
        //self.navigationItem.rightBarButtonItem.enabled = NO;
        //背景色
        self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        //通讯录tableview初始化
        addressBook = [[AddresseBookTableViewController alloc]init];
        addressBook.uerInfoArray = [[NSMutableArray alloc]init];
        
        UILabel * phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewWidth/32+viewWidth/40, viewHeight/32, viewWidth/3, viewHeight/25)];
        phoneLabel.text = @"客户手机号码:";
        phoneLabel.textColor = [UIColor blueColor];
        phoneLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        phoneLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //[self.view addSubview:phoneLabel];

        //背景框
        UITextField * backgroudText = [[UITextField alloc]initWithFrame:CGRectMake(viewWidth/40, viewHeight/60, viewWidth-viewWidth/20, viewHeight-viewHeight/4.8) ];
        backgroudText.enabled = NO;
        backgroudText.borderStyle = UITextBorderStyleRoundedRect;
        backgroudText.backgroundColor = [UIColor lightTextColor];
        //backgroudText.text = @"客户手机号码:";
        backgroudText.autoresizesSubviews = YES;
        [self.view addSubview:backgroudText];
        
        phoneText = [[UITextField alloc]initWithFrame:CGRectMake( viewWidth/32+viewWidth/40 , viewHeight/12, viewWidth/1.5, viewHeight/18)];
        phoneText.placeholder = @"请输入号码";
        phoneText.font = [UIFont systemFontOfSize:viewHeight/30];
        phoneText.borderStyle = UITextBorderStyleRoundedRect;
        phoneText.backgroundColor = [UIColor whiteColor];
        phoneText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        phoneText.clearButtonMode = UITextFieldViewModeWhileEditing;
        phoneText.delegate = self;
        [self.view addSubview:phoneText];
        
        linkManBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        linkManBtn.frame = CGRectMake(viewWidth/1.3, viewHeight/12, viewWidth/6, viewHeight/18);
        [linkManBtn setTitle:@"联系人" forState:UIControlStateNormal];
        linkManBtn.titleLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        [linkManBtn addTarget:self action:@selector(linkMan) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:linkManBtn];
        
        UILabel * servicesLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewWidth/32+viewWidth/40, viewHeight/6.1, viewWidth/4, viewHeight/28)];
        servicesLabel.text = @"业务名称:";
        servicesLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        servicesLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.view addSubview:servicesLabel];
        
        servicesDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewWidth/32+viewWidth/40, viewHeight/4.7, viewWidth-(viewWidth/16+viewWidth/20), viewHeight/19)];
        //servicesDetailLabel.text = @"全球通88套餐";
        servicesDetailLabel.font = [UIFont systemFontOfSize:viewHeight/35];
        servicesDetailLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.view addSubview:servicesDetailLabel];
        
        UILabel * descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewWidth/32+viewWidth/40, viewHeight/3.7, viewWidth/4, viewHeight/28)];
        descriptionLabel.text = @"描述:";
        descriptionLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        descriptionLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.view addSubview:descriptionLabel];
        
        descriptionDetailLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        descriptionDetailLabel.center = CGPointMake(self.view.center.x, self.view.center.y);
        descriptionDetailLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        descriptionDetailLabel.numberOfLines = 0;
        descriptionDetailLabel.lineBreakMode = NSLineBreakByCharWrapping;
        descriptionDetailLabel.backgroundColor = [UIColor clearColor];
        
        //解决ios7界面上移  配色等问题
        if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars =NO;
            self.modalPresentationCapturesStatusBarAppearance = NO;
            self.navigationController.navigationBar.translucent = NO;
            descriptionDetailLabel.backgroundColor = [UIColor clearColor];
            servicesDetailLabel.backgroundColor = [UIColor clearColor];
            linkManBtn.backgroundColor = [UIColor whiteColor];
            linkManBtn.layer.borderColor =  [UIColor iOS7lightGrayColor].CGColor;
            linkManBtn.layer.borderWidth = 1;
            phoneText.backgroundColor = [UIColor whiteColor];
            backgroudText.backgroundColor = [UIColor lightTextColor];
            backgroudText.frame = CGRectMake(viewWidth/40, viewHeight/60, viewWidth-viewWidth/20, viewHeight-viewHeight/4);
            servicesLabel.backgroundColor = [UIColor clearColor];
            //phoneLabel.backgroundColor = [UIColor clearColor];
            descriptionLabel.backgroundColor = [UIColor clearColor];
            self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }
        
        //针对iPad的界面调整
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            descriptionLabel.frame = CGRectMake(viewWidth/32+viewWidth/40, viewHeight/3.5, viewWidth/4, viewHeight/28);
            backgroudText.frame = CGRectMake(viewWidth/40, viewHeight/60, viewWidth-viewWidth/20, viewHeight-viewHeight/8);
            linkManBtn.frame = CGRectMake(viewWidth/1.3, viewHeight/12, viewWidth/8, viewHeight/18);
            phoneText.frame = CGRectMake( viewWidth/32+viewWidth/40 , viewHeight/12, viewWidth/1.5, viewHeight/18);
            phoneText.keyboardType = UIKeyboardTypeNumberPad;
            if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7) {
                backgroudText.frame = CGRectMake(viewWidth/40, viewHeight/60, viewWidth-viewWidth/20, viewHeight-viewHeight/6);
            }
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"业务推荐";
    // Do any additional setup after loading the view.
    
}

- (void)viewWillAppear:(BOOL)animated{
    servicesDetailLabel.text = [self.detailService objectForKey:@"busiName"];

    descriptionDetailLabel.text = [self.detailService objectForKey:@"busiDesc"];
    UIFont *font1 = [UIFont systemFontOfSize:viewHeight/28];
    CGSize size1 = CGSizeMake(viewWidth - viewWidth/10,MAXFLOAT);
    CGSize labelsize1 = [descriptionDetailLabel.text sizeWithFont:font1 constrainedToSize:size1 lineBreakMode:NSLineBreakByWordWrapping];
    descriptionDetailLabel.frame = CGRectMake(viewWidth/32+viewWidth/40, viewHeight/2.5, viewWidth-(viewWidth/16+viewWidth/20), labelsize1.height);
    descriptionDetailLabel.font =font1;
    [self.view addSubview:descriptionDetailLabel];
    
    if ([phoneNumber rangeOfString:@"1"].length>0||phoneNumber.length>6){
        phoneText.text = phoneNumber;
    }else phoneText.text =@"";
    
    if (![self.haveBtn isEqualToString:@"0"]) {
        linkManBtn.hidden = YES;
        phoneText.text = self.phoneNmubers;
        phoneText.enabled = NO;
    }
    
}

- (void)viewDidDisappear:(BOOL)animated{
    phoneNumber = @"";
}

- (void)recommended{
    if ([self.haveBtn isEqualToString:@"0"]) {
        NSString * number = [[[NSString alloc]init]autorelease];
        if ([phoneText.text isEqualToString:@""]) {
            [connectionAPI showAlertWithTitle:@"请输入手机号" AndMessages:@"手机号码不能为空,请检查后重新输入！"];
        }else{
            number = [phoneText.text substringWithRange:NSMakeRange(0,1)];
            if (phoneText.text.length != 11 && ![number isEqualToString:@"1"]) {
                [connectionAPI showAlertWithTitle:@"号码错误" AndMessages:@"手机号码错误,请检查后重新输入！"];
            }else{
                NSString * opPhone = [UserInfo objectForKey:@"name"];
                //if ([opPhone rangeOfString:@"1"].length>0) {
                    NSString * busiCode = [[DB findByBusiName:[self.detailService objectForKey:@"busiName"]]objectForKey:@"busiCode"];
                    NSString * smsContent = [NSString stringWithFormat:@"OPIOS_%@#%@",phoneText.text,busiCode];
                    [soap MockUpSMSWithInterface:@"mockUpSMS" Parameter1:@"opPhone" OpPhone:opPhone Parameter2:@"smsPort" SmsPort:@"10658260"     Parameter3:@"smsContent" SmsContent:smsContent];
                //}else [connectionAPI showAlertWithTitle:@"请登录" AndMessages:@"请登录后在使用推荐功能！"];
            }
        }
    }else if([self.haveBtn isEqualToString:@"1"]){
        NSString * custPhone = [self.detailService objectForKey:@"name" ];
        NSString * token = [UserInfo objectForKey:@"token"];
        NSString * offerID = [self.detailService objectForKey:@"OFFER_ID"];
        [soap UpdateUserMainOfferWithInterface:@"updateUserMainOffer" Parameter1:@"custPhone" CustPhone:custPhone Parameter2:@"OfferId" ParameterOfferId:offerID Parameter3:@"token" Token:token];
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
       // NSLog(@"phoneNumber:%@",phoneNumber);
        [dic setObject:phoneNumber forKey:@"phoneNumber"];
        //[NSDictionary dictionaryWithObjectsAndKeys:firstname,@"firstname", lastname,@"lastname",phoneNumber,@"phoneNumber",nil ];
        [addressBook.uerInfoArray addObject:dic];

        }
    
    [self.navigationController pushViewController:addressBook animated:YES];
    
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
    return  YES;//NO进入不了编辑模式
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (![phoneText.text isEqualToString:@""]) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
    NSLog(@"进入编辑模式时调用");
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (![phoneText.text isEqualToString:@""]){
        phoneText.placeholder = @"请输入号码";
    }
    [textField resignFirstResponder];
    return YES;//NO 退出不了编辑模式
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
