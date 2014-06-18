//
//  NewCellTableViewCell.h
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-6.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewCellTableViewCell : UITableViewCell{
    id delegate;
}
@property (nonatomic, assign) id delegate;

@end
