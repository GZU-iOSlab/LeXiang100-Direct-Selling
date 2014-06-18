//
//  FavoriteViewController.h
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-1.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoriteViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView * tableview;
@property (nonatomic,strong)NSMutableArray * dataSource;
@end
