//
//  AppDelegate.h
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-5-29.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

NSString * service;
DataBuffer * data ;
Boolean login;
NSNotificationCenter *nc;
NSMutableDictionary * UserInfo;
connectionAPI * soap;
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    MainViewController * mainViewController;
    //UINavigationController * navigationController;
    UIWindow * window;
    
}
+ (void)showAlertWithTitle:(NSString *)titles AndMessages:(NSString *)messages;
//@property (nonatomic,retain) IBOutlet UINavigationController * navigationController;
@property (retain, nonatomic) IBOutlet UIWindow *window;
@end
