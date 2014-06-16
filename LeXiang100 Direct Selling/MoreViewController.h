//
//  MoreViewController.h
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-5-31.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AboutLeXiang100ViewController.h"
@interface MoreViewController : UITableViewController{
    AboutLeXiang100ViewController * leXiang100ViewController;
}
@property (strong,nonatomic)NSMutableArray * dataSource;

@end
