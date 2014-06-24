//
//  DetailViewController.h
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-2.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionAPI.h"
#import "UIColorForiOS7Colors.h"
#import "SQLForLeXiang.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "AddresseBookTableViewController.h"
@interface DetailViewController : UIViewController<UITextFieldDelegate>{
    UILabel * descriptionDetailLabel;
    UILabel * servicesDetailLabel;
    AddresseBookTableViewController * addressBook;
    UITextField * phoneText;
    UIButton * linkManBtn;
//    NSString *firstname;
//    NSString *lastname;
//    NSString *phoneNumber;
}
@property (nonatomic,strong)NSDictionary * detailService;
@property (nonatomic,strong)NSString * haveBtn;
@property (nonatomic,strong)NSString * phoneNmubers;

@end
