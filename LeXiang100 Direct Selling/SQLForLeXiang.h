//
//  SQLForLeXiang.h
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-15.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
@interface SQLForLeXiang : NSObject{
    sqlite3 * db;
    NSString *database_path;
    NSString * rBusiAlias;
    NSString * rBusiCode;
    NSString * rBusiDesc;
    NSString * rBusiIcon;
    NSString * rBusiMoney;
    NSString * rBusiName;
    NSString * rIsLeaf;
    NSString * rIsTopBusi;
    NSString * rParentId;
    NSString * rID;
}
- (void)openDB;
- (void)createDB;
- (void)insertDBWithBusiAlias:(NSString *)busiAlias BusiCode:(NSString *)busiCode BusiDesc:(NSString *)busiDesc BusiIcon:(NSString *)busiIcon BusiMoney:(NSString *)busiMoney BusiName:(NSString *)busiName IDs:(NSString *)ids IsLeaf:(NSString *)isLeaf IsTopBusi:(NSString *)isTopBusi ParentId:(NSString *)parentId;
- (void)selectDB;
- (void)deleteDB;
@end
