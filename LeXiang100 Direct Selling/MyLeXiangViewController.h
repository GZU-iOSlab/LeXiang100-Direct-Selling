//
//  MyLeXiangViewController.h
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-5-31.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionAPI.h"
#import "UIColorForiOS7Colors.h"
#import "UserTableViewController.h"
#import "BankAccountTableViewController.h"
#import "RecommendedRecordViewController.h"
@interface MyLeXiangViewController : UIViewController<UITextFieldDelegate>{
    UIImageView * imgViewPersonal;
    UIImageView * imgViewAccount;
    UIImageView * imgViewSearch;
}

@property(nonatomic,strong)UITextField * backgroundText;
@property(nonatomic,strong)UITextField * loginNameText;
@property(nonatomic,strong)UITextField * loginPasswordText;
@property(nonatomic,strong)UIActivityIndicatorView * loginActivityIndicator;
@property(nonatomic,assign)UserTableViewController * UserViewController;
@property(nonatomic,assign)BankAccountTableViewController * BankViewController;
@property(nonatomic,assign)RecommendedRecordViewController * RecommendedViewController;
@property(nonatomic,strong)NSMutableDictionary * UserInfoDic;
@end
