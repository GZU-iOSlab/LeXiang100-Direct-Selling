//
//  AddresseBookTableViewController.h
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-17.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddresseBookTableViewController : UITableViewController<UISearchDisplayDelegate, UISearchBarDelegate>{
    
}
@property (nonatomic, retain) NSMutableArray *filteredListContentDic;
@property (nonatomic, retain) NSMutableArray *filteredListContentPhone;
@property (nonatomic, retain) NSMutableArray *nameArray;
@property (nonatomic, retain) NSMutableArray *phoneNumberArray;
@property (nonatomic, retain) UISearchDisplayController	*searchDisplayController;


@property(nonatomic,strong)NSMutableArray * firstname;
@property(nonatomic,strong)NSMutableArray * lastname;
@property(nonatomic,strong)NSMutableArray * phoneNumber;
@property(nonatomic,strong)NSDictionary * uerInfoDIc;
@property(nonatomic,strong)NSMutableArray * uerInfoArray;
@property(nonatomic,strong)NSMutableString * number;
@end
