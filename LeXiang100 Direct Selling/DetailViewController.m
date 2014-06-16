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

#define viewWidth   self.view.frame.size.width
#define viewHeight  self.view.frame.size.height

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"推荐" style:UIBarButtonItemStyleBordered target:self action:@selector(recommended)];
        
        self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        UITextField * backgroudText = [[UITextField alloc]initWithFrame:CGRectMake(viewWidth/40, viewHeight/60, viewWidth-viewWidth/20, viewHeight-viewHeight/4.8) ];
        //backgroudText.autoresizingMask = UIViewAutoresizingFlexibleHeight |UIViewAutoresizingFlexibleWidth;
        backgroudText.enabled = NO;
        backgroudText.borderStyle = UITextBorderStyleRoundedRect;
        backgroudText.backgroundColor = [UIColor lightTextColor];
        backgroudText.autoresizesSubviews = YES;
        [self.view addSubview:backgroudText];
        
        UITextField * phoneText = [[UITextField alloc]initWithFrame:CGRectMake( viewWidth/32+viewWidth/40 , viewHeight/50+viewHeight/60, viewWidth/1.5, viewHeight/18)];
        phoneText.placeholder = @"请输入号码";
        phoneText.font = [UIFont systemFontOfSize:viewHeight/30];
        phoneText.borderStyle = UITextBorderStyleRoundedRect;
        phoneText.backgroundColor = [UIColor whiteColor];
        phoneText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        //phoneText.layer.borderWidth = 1.0;
        phoneText.delegate = self;
        [self.view addSubview:phoneText];
        
        UIButton * linkManBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        linkManBtn.frame = CGRectMake(viewWidth/1.3, viewHeight/50+viewHeight/60, viewWidth/6, viewHeight/18);
        [linkManBtn setTitle:@"联系人" forState:UIControlStateNormal];
        linkManBtn.titleLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        [linkManBtn addTarget:self action:@selector(linkMan) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:linkManBtn];
        
        UILabel * servicesLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewWidth/32+viewWidth/40, viewHeight/9.5, viewWidth/4, viewHeight/28)];
        servicesLabel.text = @"业务名称:";
        servicesLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        servicesLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.view addSubview:servicesLabel];
        
        UILabel * servicesDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewWidth/32+viewWidth/40, viewHeight/6.5, viewWidth-(viewWidth/16+viewWidth/20), viewHeight/19)];
        servicesDetailLabel.text = @"全球通88套餐";
        servicesDetailLabel.font = [UIFont systemFontOfSize:viewWidth/21];
        servicesDetailLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.view addSubview:servicesDetailLabel];
        
        UILabel * descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewWidth/32+viewWidth/40, viewHeight/4.5, viewWidth/4, viewHeight/28)];
        descriptionLabel.text = @"描述:";
        descriptionLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        descriptionLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.view addSubview:descriptionLabel];
        
        UILabel * descriptionDetailLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        descriptionDetailLabel.text = @"全球通本地套餐适用于不出差、本地通话（尤其本地长途通话）需求多的忠告消费的本地客户。全球通本地88套餐报航480分钟的免费通话时长（国内主叫国内），超出套餐后本地主叫国内0.19元/分钟，漫游主叫0.29元/分钟；全国接听免费；赠送30M上网流量，超出套餐后移动数据流量单价只要0.001元/KB；套餐还赠送来电显示、139邮箱5元版业务。";
        descriptionDetailLabel.center = CGPointMake(self.view.center.x, self.view.center.y);
        descriptionDetailLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        descriptionDetailLabel.numberOfLines = 0;
        descriptionDetailLabel.lineBreakMode = NSLineBreakByCharWrapping;
        UIFont *font1 = [UIFont fontWithName:@"Arial" size:viewWidth/21];
        CGSize size1 = CGSizeMake(viewWidth - viewWidth/10,MAXFLOAT);
        CGSize labelsize1 = [descriptionDetailLabel.text sizeWithFont:font1 constrainedToSize:size1 lineBreakMode:NSLineBreakByWordWrapping];
        descriptionDetailLabel.frame = CGRectMake(viewWidth/32+viewWidth/40, viewHeight/3.7, viewWidth-(viewWidth/16+viewWidth/20), labelsize1.height);
        descriptionDetailLabel.font =font1;
        [self.view addSubview:descriptionDetailLabel];
        
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
            descriptionLabel.backgroundColor = [UIColor clearColor];
            self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }
        
        //针对iPad的界面调整
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            backgroudText.frame = CGRectMake(viewWidth/40, viewHeight/60, viewWidth-viewWidth/20, viewHeight-viewHeight/8);//ios6    iPad
            linkManBtn.frame = CGRectMake(viewWidth/1.3, viewHeight/50+viewHeight/60, viewWidth/8, viewHeight/18);
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

- (void)recommended{
    connectionAPI * soap = [[connectionAPI alloc]init];
    //[soap LoginWithInterface:@"modifyLogin" Parameter1:@"loginPwd" UserName:@"123456" Parameter2:@"opPhone" Password:@"15085921612" ];
    //[soap LoginWithUserName:@"15085921612" Password:@"123456"];
    //RNSString * pu = [[NSString alloc]initWithString:@"Public"];
    [soap BusiInfoWithInterface:@"queryBusiInfo" Parameter1:@"versionTag" Version:@"Public"];
    [soap release];
}

- (void)linkMan{

}

#pragma mark textefield delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
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
