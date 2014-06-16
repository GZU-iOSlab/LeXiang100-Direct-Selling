//
//  UserTableViewController.h
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-10.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionAPI.h"
@class MainViewController;
@interface UserTableViewController : UITableViewController{
}
@property(nonatomic,strong) NSArray * tableArray;
@property(nonatomic,strong) NSMutableArray * tableCellArray;
@end
