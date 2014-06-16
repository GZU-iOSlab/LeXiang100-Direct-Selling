//
//  BusinessRecommendedViewController.h
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-5-31.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavoriteViewController.h"
#import "TableLevle2TableViewController.h"
#import "TableLevel1TableViewController.h"
#import "DataBuffer.h"
#import "SQLForLeXiang.h"
@interface BusinessRecommendedViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>{
    UITextField * messageText;
    //UINavigationController * navigationController;
    UITextField * searchText;
    //UIImageView *imgViewCancel;
    //UIImageView * searchView;
    UIImageView *imgViewFavourite;
    UIImageView *imgViewTop ;
    UIImageView *imgViewPackage;
    UIImageView *imgViewValue;
    UIImageView *imgViewSjb ;
    UIImageView *imgViewCamp;
    UIImageView *imgViewFamily;
    UIImageView *imgViewService ;
    UIImageView *imgViewEnt;
    UIImageView *imgViewLdtx;
    UIImageView *imgViewCancel;
    BOOL search ;
    BOOL message;
    FavoriteViewController * favourite;
    TableLevle2TableViewController * tables2;
    TableLevel1TableViewController * tables1;
    SQLForLeXiang * initDB;
}
//@property (nonatomic,retain)  UINavigationController * navigationController;
@property (nonatomic,retain)UITextField * messageText;
@property (retain,strong)TableLevle2TableViewController * tables2;
@property (retain,strong) TableLevel1TableViewController * tables1;

@end
