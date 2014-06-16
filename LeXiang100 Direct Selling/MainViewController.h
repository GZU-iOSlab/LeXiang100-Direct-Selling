//
//  MainViewController.h
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-5-30.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusinessRecommendedViewController.h"
#import "MyLeXiangViewController.h"
#import "MoreViewController.h"
@interface MainViewController : UITabBarController{
    UINavigationController * navigationController;
    UINavigationController * businessRecommendedNav;
    UINavigationController * myLeXiangNav;
    UINavigationController * moreNav;
    UIActivityIndicatorView * ActivityIndicator;
}
@property (nonatomic,retain)  UINavigationController * navigationController;
+ (void)showAlertWithTitle:(NSString *)titles AndMessages:(NSString *)messages;
@end
