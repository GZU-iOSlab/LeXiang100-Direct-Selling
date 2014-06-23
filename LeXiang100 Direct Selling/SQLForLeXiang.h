//
//  SQLForLeXiang.h
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-15.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "NSArray+FirstLetterArray.h"
#import "NSString+FirstLetter.h"
@interface SQLForLeXiang : NSObject{
    sqlite3 * database;
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

- (BOOL)insertDBWithBusiAlias:(NSString *)busiAlias BusiCode:(NSString *)busiCode BusiDesc:(NSString *)busiDesc BusiIcon:(NSString *)busiIcon BusiMoney:(NSString *)busiMoney BusiName:(NSString *)busiName IDs:(NSString *)ids IsLeaf:(NSString *)isLeaf IsTopBusi:(NSString *)isTopBusi ParentId:(NSString *)parentId;
//- (void)selectDB;
- (BOOL)deleteDB;
- (BOOL)openDB;
- (BOOL) createTable:(sqlite3*)db;
-(NSDictionary*)findByBusiName:(NSString *)bName;
-(NSMutableArray*)findByFuzzyBusiName:(NSString *)bName;
-(NSMutableArray*)findByIsTopbusi;
 -findByParentId:(NSString*)parentID;
-(NSDictionary*)findById:(NSString *)ids;
-(NSDictionary *)findBybusiCode:(NSString *)bCode;
-(int)numOfRecords;
-(NSMutableArray*)getBusiNameByLetter:(NSString *)inputLetter;
-(NSMutableArray*)findAll;


@end
