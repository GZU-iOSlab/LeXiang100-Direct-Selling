//
//  TableLevle2TableViewController.h
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-2.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataBuffer.h"
#import "DetailViewController.h"
@interface TableLevle2TableViewController : UITableViewController{
    
}
@property (strong,nonatomic)NSDictionary * dataSource;
@property (strong,nonatomic)NSMutableArray * keysArray;
@property (strong,nonatomic)NSMutableArray * tableArray;
@property (strong,nonatomic)DetailViewController * detailView;
@end