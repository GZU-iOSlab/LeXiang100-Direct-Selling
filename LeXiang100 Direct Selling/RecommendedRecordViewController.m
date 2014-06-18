//
//  RecommendedRecordViewController.m
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-12.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import "RecommendedRecordViewController.h"

@interface RecommendedRecordViewController ()

@end

@implementation RecommendedRecordViewController
#define viewWidth   self.view.frame.size.width
#define viewHeight  self.view.frame.size.height
extern connectionAPI * soap;
extern NSMutableDictionary * UserInfo;
extern NSNotificationCenter *nc;
@synthesize tableCellArray;
@synthesize tableArray;
@synthesize recordTableview;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [nc addObserver:self selector:@selector(showTableview:) name:@"queryRecommendRecordsResponse" object:nil];
        self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        self.tableArray = [[NSMutableArray alloc]init];
        self.tableCellArray  = [[NSMutableArray alloc]init];
        self.recordTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, viewHeight, viewWidth, viewHeight/2) style:UITableViewStyleGrouped];
        self.recordTableview.delegate = self;
        self.recordTableview.dataSource = self;
        
        backgroudText = [[UITextField alloc]initWithFrame:CGRectMake(viewWidth/40, viewHeight/60, viewWidth-viewWidth/20, viewHeight/2-viewHeight/6) ];
        backgroudText.borderStyle = UITextBorderStyleRoundedRect;
        backgroudText.backgroundColor = [UIColor lightTextColor];
        backgroudText.autoresizesSubviews = YES;
        backgroudText.delegate = self;
        [self.view addSubview:backgroudText];
        
        UILabel * startMonthLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewWidth/10, viewHeight/15, viewWidth/4, viewHeight/20)];
        startMonthLabel.text = @"起始月份";
        startMonthLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        startMonthLabel.backgroundColor = [UIColor clearColor];
        [backgroudText addSubview:startMonthLabel];
        
        UILabel * endMonthLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewWidth/10, viewHeight/6.5, viewWidth/4, viewHeight/20)];
        endMonthLabel.text = @"截止月份";
        endMonthLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        endMonthLabel.backgroundColor = [UIColor clearColor];
        [backgroudText addSubview:endMonthLabel];
        
        startLeftLabel =[[UILabel alloc]initWithFrame:CGRectMake(viewWidth/10, viewHeight/20, viewWidth/3, viewHeight/22)];
        startLeftLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        startLeftLabel.text = @"2012/06";
        startLeftLabel.backgroundColor = [UIColor clearColor];
        
        startMonthText = [[UITextField alloc]initWithFrame:CGRectMake(viewWidth/2.8, viewHeight/15, viewWidth/2, viewHeight/20)];
        startMonthText.borderStyle = UITextBorderStyleRoundedRect;
        startMonthText.backgroundColor = [UIColor whiteColor];
        startMonthText.delegate = self;
        startMonthText.leftView = startLeftLabel;
        startMonthText.leftViewMode = UITextFieldViewModeAlways;
        [backgroudText addSubview:startMonthText];
        
        endLeftLabel =[[UILabel alloc]initWithFrame:CGRectMake(viewWidth/10, viewHeight/20, viewWidth/3, viewHeight/22)];
        endLeftLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        endLeftLabel.text = @"2014/06";
        endLeftLabel.backgroundColor = [UIColor clearColor];
        
        endMonthText = [[UITextField alloc]initWithFrame:CGRectMake(viewWidth/2.8, viewHeight/6.5, viewWidth/2, viewHeight/20)];
        endMonthText.borderStyle = UITextBorderStyleRoundedRect;
        endMonthText.backgroundColor = [UIColor whiteColor];
        endMonthText.delegate = self;
        endMonthText.leftView = endLeftLabel;
        endMonthText.leftViewMode = UITextFieldViewModeAlways;
        [backgroudText addSubview:endMonthText];

        
        dateSureBtn =  [UIButton buttonWithType:UIButtonTypeRoundedRect];//[[UIButton alloc]initWithFrame:CGRectMake(viewWidth/2, viewHeight+viewHeight/8, viewWidth/5, viewHeight/18)];
        dateSureBtn.frame = CGRectMake(viewWidth/2, viewHeight+viewHeight/8, viewWidth/5, viewHeight/18);
        dateSureBtn.center = CGPointMake(viewWidth/2, viewHeight+viewHeight/8);
        [dateSureBtn setTitle:@"确定" forState:UIControlStateNormal];
        dateSureBtn.titleLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        [dateSureBtn addTarget:self action:@selector(dateForSure) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:dateSureBtn];
        
        UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        searchBtn.frame = CGRectMake(viewWidth/1.5, viewHeight/4.5, viewWidth/5, viewHeight/18);
        [searchBtn setTitle:@"查询" forState:UIControlStateNormal];
        searchBtn.titleLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        [searchBtn addTarget:self action:@selector(recommendedsoap) forControlEvents:UIControlEventTouchUpInside];
        searchBtn.layer.borderColor =  [UIColor iOS7lightGrayColor].CGColor;
        searchBtn.layer.borderWidth = 1;
        [backgroudText addSubview: searchBtn];
        
        startDatePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, viewHeight, viewWidth, viewHeight/3)];
        startDatePicker.datePickerMode = UIDatePickerModeDate;
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文显示
        startDatePicker.locale = locale;
        [self.view addSubview:startDatePicker];
        startDatePickerShowed = NO;
        
        endDatePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, viewHeight, viewWidth, viewHeight/3)];
        endDatePicker.datePickerMode = UIDatePickerModeDate;
        endDatePicker.locale = locale;
        [self.view addSubview:endDatePicker];
        endDatePickerShowed = NO;
        
        formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy/MM"];

        //解决ios7界面上移  配色等问题
        if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars =NO;
            self.modalPresentationCapturesStatusBarAppearance = NO;
            self.navigationController.navigationBar.translucent = NO;
            backgroudText.backgroundColor = [UIColor lightTextColor];
            backgroudText.frame = CGRectMake(viewWidth/40, viewHeight/60, viewWidth-viewWidth/20, viewHeight/2-viewHeight/6);
            self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }
        //ipad
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            backgroudText.frame = CGRectMake(viewWidth/40, viewHeight/60, viewWidth-viewWidth/20, viewHeight/2-viewHeight/6);//ios6    iPad
            //datePicker.frame =CGRectMake(0, viewHeight/2, viewWidth, viewHeight/2);
            if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7) {
                backgroudText.frame = CGRectMake(viewWidth/40, viewHeight/60, viewWidth-viewWidth/20, viewHeight/2-viewHeight/6);
            }
        }
        [self.view sendSubviewToBack:backgroudText];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark textefield delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == backgroudText) {
        [UIView beginAnimations:@"下降" context:nil];
        [UIView setAnimationDuration:0.3];
        startDatePicker.frame = CGRectMake(0, viewHeight, viewWidth, viewHeight/3);
        endDatePicker.frame = CGRectMake(0, viewHeight, viewWidth, viewHeight/3);
        dateSureBtn.center = CGPointMake(viewWidth/2, viewHeight+viewHeight/8);
        if(self.recordTableview != nil){
            self.recordTableview.center = CGPointMake(viewWidth/2, viewHeight+viewHeight/3);
        }
        [UIView commitAnimations];
        startDatePickerShowed = NO;
        endDatePickerShowed = NO;
    }else if(textField == startMonthText){
        if (endDatePickerShowed == YES) {
            [UIView beginAnimations:@"下降" context:nil];
            [UIView setAnimationDuration:0.3];
            endDatePicker.frame = CGRectMake(0, viewHeight, viewWidth, viewHeight/3);
            dateSureBtn.center = CGPointMake(viewWidth/2, viewHeight+viewHeight/8);
            [UIView commitAnimations];
            endDatePickerShowed = NO;
        }
        [UIView beginAnimations:@"上升" context:nil];
        [UIView setAnimationDuration:0.3];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            startDatePicker.frame = CGRectMake(0, viewHeight/2.2, viewWidth, viewHeight/3);
            dateSureBtn.center = CGPointMake(viewWidth/2, viewHeight/2+viewHeight/2.5);
        }else{
            startDatePicker.frame = CGRectMake(0, viewHeight/2, viewWidth, viewHeight/2);
            dateSureBtn.center = CGPointMake(viewWidth/2, viewHeight/2+viewHeight/3);
        }
        startDatePickerShowed = YES;
        if(self.recordTableview != nil){
            self.recordTableview.center = CGPointMake(viewWidth/2, viewHeight+viewHeight/3);
        }
        [UIView commitAnimations];
    }else if(textField == endMonthText){
        if (startDatePickerShowed == YES) {
            [UIView beginAnimations:@"下降" context:nil];
            [UIView setAnimationDuration:0.3];
            startDatePicker.frame = CGRectMake(0, viewHeight, viewWidth, viewHeight/3);
            dateSureBtn.center = CGPointMake(viewWidth/2, viewHeight+viewHeight/8);
            [UIView commitAnimations];
            startDatePickerShowed = NO;
            startLeftLabel.text = [formatter stringFromDate:startDatePicker.date];
        }
        [UIView beginAnimations:@"上升" context:nil];
        [UIView setAnimationDuration:0.3];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            endDatePicker.frame = CGRectMake(0, viewHeight/2.2, viewWidth, viewHeight/3);
            dateSureBtn.center = CGPointMake(viewWidth/2, viewHeight/2+viewHeight/2.5);
        }else{
            endDatePicker.frame = CGRectMake(0, viewHeight/2, viewWidth, viewHeight/2);
            dateSureBtn.center = CGPointMake(viewWidth/2, viewHeight/2+viewHeight/3);
        }
        endDatePickerShowed = YES;
        
        if(self.recordTableview != nil){
            self.recordTableview.center = CGPointMake(viewWidth/2, viewHeight+viewHeight/3);
        }
        [UIView commitAnimations];
    }
    return  NO;//NO进入不了编辑模式
}

#pragma mark tableview 

- (void)showTableview:(NSNotification *)note{
    [UIView beginAnimations:@"下降" context:nil];
    [UIView setAnimationDuration:0.3];
    startDatePicker.frame = CGRectMake(0, viewHeight, viewWidth, viewHeight/3);
    endDatePicker.frame = CGRectMake(0, viewHeight, viewWidth, viewHeight/3);
    dateSureBtn.center = CGPointMake(viewWidth/2, viewHeight+viewHeight/8);
    [UIView commitAnimations];
    startDatePickerShowed = NO;
    endDatePickerShowed = NO;
    
//    if (self.recordTableview != nil) {
//        self.recordTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, viewHeight, viewWidth, viewHeight/2) style:UITableViewStyleGrouped];
//    }else{
//        self.recordTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, viewHeight, viewWidth, viewHeight/2) style:UITableViewStyleGrouped];
//    }

    [self.tableCellArray removeAllObjects];
    [self.tableArray removeAllObjects];
    NSArray * cellArray = [[NSArray alloc]initWithArray:[[note userInfo] objectForKey:@"1"]];
    for (NSMutableDictionary * dic in cellArray){
        NSString * str = [NSString stringWithFormat:@"总推荐量%@笔,成功%@笔，失败%@笔",[dic objectForKey: @"totalRecommend"],[dic objectForKey: @"succRecommend"],[dic objectForKey: @"failRecommend"]];
        [self.tableCellArray addObject:str];
        NSString * str1=[dic objectForKey: @"months"];
        NSString * str2 = [str1 substringWithRange:NSMakeRange(0, 4)];
        NSString * str3 = [str1 substringWithRange:NSMakeRange(4, 2)];
        str1 = [NSString stringWithFormat:@"%@年%@月",str2,str3];
        [self.tableArray addObject:str1];
        NSLog(@"months:%@",str1);
    }
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [UIView animateWithDuration:0.3 animations:^{self.recordTableview.center = CGPointMake(viewWidth/2, viewHeight/1.3);}];
        NSLog(@"%f",viewHeight/1.3);
    }else{
    [UIView animateWithDuration:0.3 animations:^{self.recordTableview.center = CGPointMake(viewWidth/2, viewHeight/1.4);}];
    }
    [self.view addSubview:self.recordTableview];
    [self.recordTableview reloadData];
     NSLog(@"%f",self.recordTableview.center.y);
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"return:%d",[self.tableArray count]);
    return [self.tableArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableArray.count >5) {
        tableView.scrollEnabled = YES;
    }else
    tableView.scrollEnabled = NO;
    tableView.tableHeaderView = nil;
    //tableView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    static NSString * identifier = @"basis-cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        [cell autorelease];
    }    // Configure the cell...
    NSString * text = [self.tableArray objectAtIndex:indexPath.row];
    NSString * detailtext = [self.tableCellArray objectAtIndex:indexPath.row];
    NSLog(@"text:%@ detailtext:%@",text,detailtext);
    cell.textLabel.text = text;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont systemFontOfSize:viewHeight/35];
    cell.detailTextLabel.text = detailtext;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:viewHeight/35];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.textColor = [UIColor iOS7blueGradientEndColor];
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    // 去掉guop tableview的背景
    tableView.backgroundView = nil;
    tableView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor lightTextColor];
    
    NSLog(@"recordTableview：%f",self.recordTableview.center.y);

    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
       return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
}

- (void)dateForSure{
    if (startDatePickerShowed) {
        //NSString * dateString = [formatter stringFromDate:startDatePicker.date];
        startLeftLabel.text = [formatter stringFromDate:startDatePicker.date];
    }else if (endDatePickerShowed){
        endLeftLabel.text = [formatter stringFromDate:endDatePicker.date];
    }
}

- (void)recommendedsoap{
    [self dateForSure];
    
    [UIView beginAnimations:@"下降" context:nil];
    [UIView setAnimationDuration:0.3];
    startDatePicker.frame = CGRectMake(0, viewHeight, viewWidth, viewHeight/3);
    endDatePicker.frame = CGRectMake(0, viewHeight, viewWidth, viewHeight/3);
    dateSureBtn.center = CGPointMake(viewWidth/2, viewHeight+viewHeight/8);
    if(self.recordTableview != nil){
        self.recordTableview.center = CGPointMake(viewWidth/2, viewHeight+viewHeight/3);
    }
    
    [UIView commitAnimations];
    if (!([startLeftLabel.text isEqual:@""]||[endLeftLabel.text isEqual:@""])) {
        NSString * name = [UserInfo objectForKey:@"name"];
        NSString * token = [UserInfo objectForKey:@"token"];
        NSString * startYear = [startLeftLabel.text substringWithRange:NSMakeRange(0,4)];
        NSString * startMonth = [startLeftLabel.text substringWithRange:NSMakeRange(5,2)];
        NSMutableString * startYearAndMonth = [[NSMutableString alloc]init];
        [startYearAndMonth appendString:startYear];
        [startYearAndMonth appendString:startMonth];
        NSString * endYear = [endLeftLabel.text substringWithRange:NSMakeRange(0,4)];
        NSString * endMonth = [endLeftLabel.text substringWithRange:NSMakeRange(5,2)];
        NSMutableString * endYearAndMonth = [[NSMutableString alloc]init];
        [endYearAndMonth appendString:endYear];
        [endYearAndMonth appendString:endMonth];
        [soap RecommendedRecordWithInterface:@"queryRecommendRecords" Parameter1:@"opPhone" Name:name Parameter2:@"startMonth" StartMonth:startYearAndMonth Parameter3:@"endMonth" EndMonth:endYearAndMonth Parameter4:@"token" Token:token];
        [startYearAndMonth release];
        [endYearAndMonth release];
    }
    if (self.recordTableview != nil) {
        //[self.recordTableview release];
    }
    
}



//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
//    if (textField == backgroudText) {
//        return YES;
//    }else{
//        [UIView beginAnimations:@"下降" context:nil];
//        [UIView setAnimationDuration:0.3];
//        datePicker.frame = CGRectMake(0, viewHeight, viewWidth, viewHeight/3);
//        [UIView commitAnimations];
//    }
//    return YES;//NO 退出不了编辑模式
//}
//
//- (void)textFieldDidEndEditing:(UITextField *)textField{
//    //if (textField == backgroudText) {
//        [UIView beginAnimations:@"下降" context:nil];
//        [UIView setAnimationDuration:0.3];
//        datePicker.frame = CGRectMake(0, viewHeight, viewWidth, viewHeight/3);
//        [UIView commitAnimations];
//    //}
//}


+ (void)showAlertWithTitle:(NSString *)titles AndMessages:(NSString *)messages{
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:titles message:messages delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
    [alert show];
    UIDatePicker * datePicker = [[UIDatePicker alloc]init];
    datePicker.center = alert.center;
    [alert addSubview:datePicker];
    
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
