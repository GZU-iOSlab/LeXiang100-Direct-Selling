//
//  SQLForLeXiang.m
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-15.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import "SQLForLeXiang.h"
#define DBNAME    @"lexiang1.sqlite"


#define BUSIALIAS   @"busiAlias"
#define BUSICODE    @"busiCode"
#define BUSIDESC    @"busiDesc"
#define BUSIICON    @"busiIcon"
#define BUSIMONEY   @"busiMoney"
#define BUSINAME    @"busiName"
#define ID          @"id"
#define ISLEAF      @"isLeaf"
#define ISTOPBUSI   @"isTopBusi"
#define PARENTID    @"parentId"
#define TABLENAME   @"BUSIINFO"
@implementation SQLForLeXiang
- (id)init{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DBNAME];
    
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
    }
    NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS BUSIINFO (ID INTEGER  , busiAlias TEXT, busiCode TEXT, busiDesc TEXT, busiIcon TEXT, busiMoney TEXT, busiName TEXT, isLeaf INTEGER, isTopBusi INTEGER, parentId INTEGER)";
    
    [self execSql:sqlCreateTable];
    NSLog(@"数据库创建成功!");
    
    
    
    NSString *sql1 = [NSString stringWithFormat:
                      
                      @"INSERT INTO '%@' ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@') VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')",
                      TABLENAME, BUSIALIAS, BUSICODE, BUSIDESC, BUSIICON, BUSIMONEY, BUSINAME, ID, ISLEAF, ISTOPBUSI, PARENTID,
                      @"", @"", @"", @"busi_favorite", @"0", @"收藏夹", @"1", @"0", @"0", @"0" ];
    
    NSLog(@"%@",sql1);
    [self execSql:sql1];
    
    
    
    NSString *sqlQuery = @"SELECT * FROM BUSIINFO";
    sqlite3_stmt * statement;
    
    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *busiAlias = (char*)sqlite3_column_text(statement, 1);
            NSString *nsBusiAliasStr = [[NSString alloc]initWithUTF8String:busiAlias];
            
            char *busiCode = (char*)sqlite3_column_text(statement, 2);
            NSString *nsBusiCodeStr = [[NSString alloc]initWithUTF8String:busiCode];
            
            char *busiDesc = (char*)sqlite3_column_text(statement, 3);
            NSString *nsBusiDescStr = [[NSString alloc]initWithUTF8String:busiDesc];
            
            char *busiIcon = (char*)sqlite3_column_text(statement, 4);
            NSString *nsBusiIconStr = [[NSString alloc]initWithUTF8String:busiIcon];
            
            char *busiMoney = (char*)sqlite3_column_text(statement, 5);
            NSString *nsBusiMoneyStr = [[NSString alloc]initWithUTF8String:busiMoney];
            
            char *busiName = (char*)sqlite3_column_text(statement, 6);
            NSString *nsBusiNameStr = [[NSString alloc]initWithUTF8String:busiName];
            
            int id = sqlite3_column_int(statement, 0);
            
            int isLeaf = sqlite3_column_int(statement, 7);
            
            int isTopBusi = sqlite3_column_int(statement, 8);
            
            int parentId = sqlite3_column_int(statement, 9);
            
            NSLog(@"busiAlias:%@  busiCode:%@  busiDesc:%@ busiIcon:%@ busiMoney:%@ busiName:%@ id:%d isLeaf:%d isTopBusi:%d parentId:%d",
                  nsBusiAliasStr, nsBusiCodeStr, nsBusiDescStr, nsBusiIconStr, nsBusiMoneyStr, nsBusiNameStr, id, isLeaf, isTopBusi, parentId);
        }
    }
    
    
    NSString *sql2 = [NSString stringWithFormat:@"delete from busiInfo"];
    NSLog(@"%@",sql2);
    [self execSql:sql2];
    NSLog(@"==================数据已经清除=======================");
    sqlite3_close(db);
    
    
    return self;
}

-(void)execSql:(NSString *)sql
{
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库操作数据失败!???");
    }
}
@end
