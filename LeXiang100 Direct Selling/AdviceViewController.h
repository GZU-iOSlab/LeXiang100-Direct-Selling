//
//  AdviceViewController.h
//  LeXiang100 Direct Selling
//
//  Created by 任魏翔 on 14-6-18.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "ConnectionAPI.h"
#import "SQLForLeXiang.h"
#import "UIColorForiOS7Colors.h"
@interface AdviceViewController : UIViewController<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *classTableviewtableview;
    NSArray *array;
    UIButton *feedbackButton;
    UITextView *inputFeedback;
    UILabel *tishi;
    NSString *selectedString;
    NSArray *arrayImage;
}
@property (nonatomic,assign) UITableView * classTableview;
@property (nonatomic,assign) NSArray *array;
@property (nonatomic,assign) UIButton *feedbackButton;
@property (nonatomic,assign) UITextView *inputFeedback;
@property (nonatomic,assign) UILabel *tishi;
@property (nonatomic,assign) NSArray *arrayImage;

@end
