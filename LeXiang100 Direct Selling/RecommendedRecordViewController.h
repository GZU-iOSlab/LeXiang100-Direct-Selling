//
//  RecommendedRecordViewController.h
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-12.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColorForiOS7Colors.h"
#import "ConnectionAPI.h"

@interface RecommendedRecordViewController : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>{
    UITextField * backgroudText;
    UIDatePicker * startDatePicker;
    UIDatePicker * endDatePicker;
    UITextField * startMonthText;
    UITextField * endMonthText;
    Boolean startDatePickerShowed;
    Boolean endDatePickerShowed;
    UIButton * dateSureBtn;
    UILabel * startLeftLabel;
    UILabel * endLeftLabel;
    
    NSDateFormatter * formatter;
    //UIAlertView * alerts;
}
@property (nonatomic,strong) NSMutableArray * tableCellArray;
@property (nonatomic,strong) NSMutableArray * tableArray;
@property (nonatomic,assign) UITableView * recordTableview;

@end
