//
//  SpecialOfferViewController.h
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-22.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "connectionAPI.h"
#import "UIColorForiOS7Colors.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "AddresseBookTableViewController.h"
#import "DetailViewController.h"
@interface SpecialOfferViewController : UIViewController<UITextFieldDelegate>{
    UITextField * phoneText;
    AddresseBookTableViewController * addressBook;
    UILabel * busiLabel;
    UITextField * busiText;
    NSMutableString * HELLOWORD;
    NSMutableString * offerID;
    NSMutableString * offerType;
    BOOL toDetail;
    //NSArray * offerArray;
}


@property (nonatomic,strong)UIAlertView * alerts;

- (void) dimissAlert:(UIAlertView *)alert;
@end
