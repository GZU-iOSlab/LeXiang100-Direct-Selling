//
//  TableLevel1TableViewController.h
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-2.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "DataBuffer.h"
#import "TableLevle2TableViewController.h"
#import "NewCellTableViewCell.h"
@interface TableLevel1TableViewController : UITableViewController{
}
@property (strong,nonatomic)NSDictionary * dataSource;
@property (strong,nonatomic)NSMutableArray * keysArray;
@property (strong,nonatomic)NSMutableArray * tableArray;
@property (strong,nonatomic)TableLevle2TableViewController * table2View;
@end