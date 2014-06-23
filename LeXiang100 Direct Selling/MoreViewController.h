//
//  MoreViewController.h
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-5-31.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AboutLeXiang100ViewController.h"
#import "Helplexiang100ViewController.h"
#import "UpdateCheckingViewController.h"
#import "AdviceViewController.h"
#import "ShareViewController.h"
@interface MoreViewController : UITableViewController<UIAccelerometerDelegate,UITableViewDataSource>{
    AboutLeXiang100ViewController * aboutLeXiang100ViewController;
    Helplexiang100ViewController * helpLeXiang100ViewController;
    UpdateCheckingViewController *updateCheckingViewController;
    AdviceViewController *adviceViewController;
    ShareViewController *shareViewController;
    NSArray *array;
}
@property (strong,nonatomic)NSMutableArray * dataSource;
@property (strong,nonatomic)NSArray *array;
@end
