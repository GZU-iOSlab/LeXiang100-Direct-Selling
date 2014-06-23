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

extern NSNotificationCenter *nc;
@implementation SQLForLeXiang

//获取document目录并返回数据库目录
- (NSString *)dataFilePath{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"=======%@",documentsDirectory);
    return [documentsDirectory stringByAppendingPathComponent:@"lexiang1.sqlite"];//这里很神奇，可以定义成任何类型的文件，也可以不定义成.db文件，任何格式都行，定义成.sb文件都行，达到了很好的数据隐秘性
    
}

//创建，打开数据库
- (BOOL)openDB {
    
    //获取数据库路径
    NSString *path = [self dataFilePath];
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //判断数据库是否存在
    BOOL find = [fileManager fileExistsAtPath:path];
    
    //如果数据库存在，则用sqlite3_open直接打开（不要担心，如果数据库不存在sqlite3_open会自动创建）
    if (find) {
        
        NSLog(@"打开数据库成功");
        
        //打开数据库，这里的[path UTF8String]是将NSString转换为C字符串，因为SQLite3是采用可移植的C(而不是
        //Objective-C)编写的，它不知道什么是NSString.
        if(sqlite3_open([path UTF8String], &database) != SQLITE_OK) {
            
            //如果打开数据库失败则关闭数据库
            sqlite3_close(self->database);
            NSLog(@"Error: open database file.");
            return NO;
        }
        
        //创建一个新表
        [self createTable:self->database];
        
        return YES;
    }
    //如果发现数据库不存在则利用sqlite3_open创建数据库（上面已经提到过），与上面相同，路径要转换为C字符串
    if(sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        
        //创建一个新表
        [self createTable:self->database];
        return YES;
    } else {
        //如果创建并打开数据库失败则关闭数据库
        sqlite3_close(self->database);
        NSLog(@"Error: open database file.");
        return NO;
    }
    return NO;
}

//创建表
- (BOOL) createTable:(sqlite3*)db {
    
    //这句是大家熟悉的SQL语句
    char *sql = "CREATE TABLE IF NOT EXISTS BUSIINFO (id INTEGER PRIMARY KEY , busiAlias TEXT, busiCode TEXT, busiDesc TEXT, busiIcon TEXT, busiMoney TEXT, busiName TEXT, isLeaf INTEGER, isTopBusi INTEGER, parentId INTEGERf)";
    sqlite3_stmt *statement;
    //sqlite3_prepare_v2 接口把一条SQL语句解析到statement结构里去. 使用该接口访问数据库是当前比较好的的一种方法
    NSInteger sqlReturn = sqlite3_prepare_v2(db, sql, -1, &statement, nil);
    
    //如果SQL语句解析出错的话程序返回
    if(sqlReturn != SQLITE_OK) {
        NSLog(@"Error: failed to prepare statement:create  table");
        return NO;
    }
    
    //执行SQL语句
    int success = sqlite3_step(statement);
    //释放sqlite3_stmt
    sqlite3_finalize(statement);
    
    //执行SQL语句失败
    if ( success != SQLITE_DONE) {
        NSLog(@"Error: failed to dehydrate:create table busiInfo");
        return NO;
    }
    //NSLog(@"Create table 'busiInfo' successed.");
    return YES;
}


/**
- (void)insertDBWithBusiAlias:(NSString *)busiAlias BusiCode:(NSString *)busiCode BusiDesc:(NSString *)busiDesc BusiIcon:(NSString *)busiIcon BusiMoney:(NSString *)busiMoney BusiName:(NSString *)busiName IDs:(NSString *)ids IsLeaf:(NSString *)isLeaf IsTopBusi:(NSString *)isTopBusi ParentId:(NSString *)parentId{
    [self openDB];
    
    NSString *sql1 = [NSString stringWithFormat:
                      
                      @"INSERT INTO '%@' ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@') VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')",
                      TABLENAME, BUSIALIAS, BUSICODE, BUSIDESC, BUSIICON, BUSIMONEY, BUSINAME, ID, ISLEAF, ISTOPBUSI, PARENTID,
                      busiAlias, busiCode, busiDesc, busiIcon, busiMoney, busiName, ids, isLeaf, isTopBusi, parentId ];
    
    NSLog(@"插入数据：%@",sql1);
    [self execSql:sql1];
    sqlite3_close(db);
}

- (void)selectDB{
    [self openDB];
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
    sqlite3_close(db);
}
**/

//插入数据
- (BOOL)insertDBWithBusiAlias:(NSString *)busiAlias BusiCode:(NSString *)busiCode BusiDesc:(NSString *)busiDesc BusiIcon:(NSString *)busiIcon BusiMoney:(NSString *)busiMoney BusiName:(NSString *)busiName IDs:(NSString *)ids IsLeaf:(NSString *)isLeaf IsTopBusi:(NSString *)isTopBusi ParentId:(NSString *)parentId
{
    
    //先判断数据库是否打开
    if ([self openDB]) {
        
        NSString *sql = [NSString stringWithFormat:
                         @"INSERT INTO '%@' ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@') VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')",
                         TABLENAME, BUSIALIAS, BUSICODE, BUSIDESC, BUSIICON, BUSIMONEY, BUSINAME, ID, ISLEAF, ISTOPBUSI, PARENTID,
                         busiAlias, busiCode, busiDesc, busiIcon, busiMoney, busiName, ids, isLeaf, isTopBusi, parentId ];
        char *err;
        if (sqlite3_exec(database, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
            NSLog(@"Error: failed to insert:testTable");
            sqlite3_close(database);
            return NO;
        }
        //关闭数据库
        sqlite3_close(database);
        return YES;
    }
    return NO;
}

//删除数据
- (BOOL) deleteDB{
    if ([self openDB]) {
        
        sqlite3_stmt *statement;
        //组织SQL语句
        static char *sql = "delete  from busiInfo";
        //将SQL语句放入sqlite3_stmt中
        int success = sqlite3_prepare_v2(database, sql, -1, &statement, NULL);
        if (success != SQLITE_OK) {
            NSLog(@"Error: failed to delete:busiInfo");
            sqlite3_close(database);
            return NO;
        }
        
        
        //执行SQL语句。这里是更新数据库
        success = sqlite3_step(statement);
        //释放statement
        sqlite3_finalize(statement);
        
        //如果执行失败
        if (success == SQLITE_ERROR) {
            NSLog(@"Error: failed to delete the database with message.");
            //关闭数据库
            sqlite3_close(database);
            return NO;
        }
        //执行成功后依然要关闭数据库
        sqlite3_close(database);
        return YES;
    }
    return NO;
    
}


- (void)busiInfoFeedback:(NSNotification *)note{
    
     [self openDB];
    //判断返回的数据类型
    if ([[[note userInfo] objectForKey:@"1"] isKindOfClass:[NSArray class]]) {
        NSArray * resultArray = (NSArray *)[[note userInfo] objectForKey:@"1"];
        for (NSDictionary *dic in resultArray) {
            NSLog(@"dic:%@",[dic objectForKey:@"busiName"]);
            rBusiAlias  = [dic objectForKey:BUSIALIAS];
            rBusiCode   = [dic objectForKey:BUSICODE];
            rBusiDesc   = [dic objectForKey:BUSIDESC];
            rBusiIcon   = [dic objectForKey:BUSIICON];
            rBusiMoney  = [dic objectForKey:BUSIMONEY];
            rBusiName   = [dic objectForKey:BUSINAME];
            rID         = [dic objectForKey:ID];
            rIsLeaf     = [dic objectForKey:ISLEAF];
            rIsTopBusi  = [dic objectForKey:ISTOPBUSI];
            rParentId   = [dic objectForKey:PARENTID];
            [self insertDBWithBusiAlias:rBusiAlias BusiCode:rBusiCode BusiDesc:rBusiDesc BusiIcon:rBusiIcon BusiMoney:rBusiMoney BusiName:rBusiName IDs:rID IsLeaf:rIsLeaf IsTopBusi:rIsTopBusi ParentId:rParentId];
        }
    }
     sqlite3_close(database);
}

//热点业务内容写入一个数组
- (void)hotbusiInfoFeedback:(NSNotification *)note{
    if ([[[note userInfo] objectForKey:@"1"] isKindOfClass:[NSArray class]]){
        NSArray * resultArray = (NSArray *)[[note userInfo] objectForKey:@"1"];
        //把resultArray这个数组存入程序指定的一个文件里
        [resultArray writeToFile:[self documentsPath:@"hotBusi.txt"] atomically:YES];
    }
    NSLog(@"hotBusi had writed!\n");
}

-(NSString *)documentsPath:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}


//根据业务名称查找
-(NSDictionary*)findByBusiName:(NSString *)bName {
    
    NSDictionary *dic;
    //判断数据库是否打开
    if ([self openDB]) {
        
        sqlite3_stmt *statement = nil;
        //sql语句
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM BUSIINFO WHERE BUSINAME = '%@'",bName];
        const char *sql = [querySQL UTF8String];
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) != SQLITE_OK) {
            NSLog(@"Error: failed to prepare statement with message:find.");
            return NO;
        } else {
            
            sqlite3_bind_text(statement, 3, [bName UTF8String], -1, SQLITE_TRANSIENT);
            //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
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
                
                int ids = sqlite3_column_int(statement, 0);
                NSString * idS = [[NSString alloc]initWithFormat:@"%d",ids];
                
                int isLeaf = sqlite3_column_int(statement, 7);
                NSString * isLEAF = [[NSString alloc]initWithFormat:@"%d",isLeaf];
                
                int isTopBusi = sqlite3_column_int(statement, 8);
                NSString * isTOPBUSI = [[NSString alloc]initWithFormat:@"%d",isTopBusi];
                
                int parentId = sqlite3_column_int(statement, 9);
                NSString * isPARENTID = [[NSString alloc]initWithFormat:@"%d",parentId];
                
                dic = [[NSDictionary alloc]initWithObjectsAndKeys:idS,@"id",nsBusiAliasStr,@"busiAlias", nsBusiDescStr,@"busiDesc",nsBusiCodeStr,@"busiCode",nsBusiIconStr,@"busiIcon",nsBusiMoneyStr,@"busiMoney",nsBusiNameStr,@"busiName",isLEAF,@"isLeaf",isTOPBUSI,@"isTopBusi",isPARENTID,@"parentId",nil];
            }
            
        }
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return dic;
}

//根据业务名称模糊查找，返回字典数组
-(NSMutableArray*)findByFuzzyBusiName:(NSString *)bName {
    
    NSDictionary *dic;
    NSMutableArray *array = [[NSMutableArray alloc]init];
    //判断数据库是否打开
    if ([self openDB]) {
        
        sqlite3_stmt *statement = nil;
        //sql语句
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM BUSIINFO WHERE BUSINAME LIKE '%%%@%%' and isLeaf = 1", bName];
        const char *sql = [querySQL UTF8String];
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) != SQLITE_OK) {
            NSLog(@"Error: failed to prepare statement with message:find.");
            return NO;
        } else {
            
            sqlite3_bind_text(statement, 3, [bName UTF8String], -1, SQLITE_TRANSIENT);
            //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
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
                
                int ids = sqlite3_column_int(statement, 0);
                NSString * idS = [[NSString alloc]initWithFormat:@"%d",ids];
                
                int isLeaf = sqlite3_column_int(statement, 7);
                NSString * isLEAF = [[NSString alloc]initWithFormat:@"%d",isLeaf];
                
                int isTopBusi = sqlite3_column_int(statement, 8);
                NSString * isTOPBUSI = [[NSString alloc]initWithFormat:@"%d",isTopBusi];
                
                int parentId = sqlite3_column_int(statement, 9);
                NSString * isPARENTID = [[NSString alloc]initWithFormat:@"%d",parentId];
                
                dic = [[NSDictionary alloc]initWithObjectsAndKeys:idS,@"id",nsBusiAliasStr,@"busiAlias", nsBusiDescStr,@"busiDesc",nsBusiCodeStr,@"busiCode",nsBusiIconStr,@"busiIcon",nsBusiMoneyStr,@"busiMoney",nsBusiNameStr,@"busiName",isLEAF,@"isLeaf",isTOPBUSI,@"isTopBusi",isPARENTID,@"parentId",nil];
                
                [array addObject:dic];
            }
            
        }
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return array;
}

//根据业务编码查找
-(NSDictionary*)findBybusiCode:(NSString *)bCode {
    
    NSDictionary *dic;
    //判断数据库是否打开
    if ([self openDB]) {
        
        sqlite3_stmt *statement = nil;
        //sql语句
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM BUSIINFO WHERE BUSICODE = '%@'",bCode];
        const char *sql = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) != SQLITE_OK) {
            NSLog(@"Error: failed to prepare statement with message:find.");
            return NO;
        } else {
            
            sqlite3_bind_text(statement, 3, [bCode UTF8String], -1, SQLITE_TRANSIENT);
            //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
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
                
                int ids = sqlite3_column_int(statement, 0);
                NSString * idS = [[NSString alloc]initWithFormat:@"%d",ids];
                
                int isLeaf = sqlite3_column_int(statement, 7);
                NSString * isLEAF = [[NSString alloc]initWithFormat:@"%d",isLeaf];
                
                int isTopBusi = sqlite3_column_int(statement, 8);
                NSString * isTOPBUSI = [[NSString alloc]initWithFormat:@"%d",isTopBusi];
                
                int parentId = sqlite3_column_int(statement, 9);
                NSString * isPARENTID = [[NSString alloc]initWithFormat:@"%d",parentId];
                
                dic = [[NSDictionary alloc]initWithObjectsAndKeys:idS,@"id",nsBusiAliasStr,@"busiAlias", nsBusiDescStr,@"busiDesc",nsBusiCodeStr,@"busiIcon",nsBusiIconStr,@"busiIcon",nsBusiMoneyStr,@"busiMoney",nsBusiNameStr,@"busiName",isLEAF,@"isLeaf",isTOPBUSI,@"isTopBusi",isPARENTID,@"parentId",nil];
            }
            
        }
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return dic;
}
//根据parentid查找
-(NSMutableArray*)findByParentId:(NSString*)parentID {
    NSMutableArray *array = [[NSMutableArray alloc]init];
    NSDictionary *dic;

    if ([self openDB]) {
        
        sqlite3_stmt *statement = nil;
        //sql语句
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM BUSIINFO WHERE PARENTID = %@",parentID];
        NSLog(@"%@",querySQL);
        const char *sql = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) != SQLITE_OK) {
            NSLog(@"Error: failed to prepare statement with message:search testValue.");
            return NO;
        } else {
            
            sqlite3_bind_text(statement, 3, [parentID UTF8String], -1, SQLITE_TRANSIENT);
            //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
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
                
                int ids = sqlite3_column_int(statement, 0);
                NSString * idS = [[NSString alloc]initWithFormat:@"%d",ids];
                
                int isLeaf = sqlite3_column_int(statement, 7);
                NSString * isLEAF = [[NSString alloc]initWithFormat:@"%d",isLeaf];
                
                int isTopBusi = sqlite3_column_int(statement, 8);
                NSString * isTOPBUSI = [[NSString alloc]initWithFormat:@"%d",isTopBusi];
                
                int parentId = sqlite3_column_int(statement, 9);
                NSString * isPARENTID = [[NSString alloc]initWithFormat:@"%d",parentId];
                
                dic = [[NSDictionary alloc]initWithObjectsAndKeys:idS,@"id",nsBusiAliasStr,@"busiAlias", nsBusiDescStr,@"busiDesc",nsBusiCodeStr,@"busiIcon",nsBusiIconStr,@"busiIcon",nsBusiMoneyStr,@"busiMoney",nsBusiNameStr,@"busiName",isLEAF,@"isLeaf",isTOPBUSI,@"isTopBusi",isPARENTID,@"parentId",nil];
                
                [array addObject:dic];
            }
            
        }
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    return array;
}

//根据isTopBusi查找
-(NSMutableArray*)findByIsTopbusi {
    NSMutableArray *array = [[NSMutableArray alloc]init];
    NSDictionary *dic;
    
    
    
    if ([self openDB]) {
        
        sqlite3_stmt *statement = nil;
        //sql语句
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM BUSIINFO WHERE ISTOPBUSI <> 0 order by isTopBusi"];
        NSLog(@"%@",querySQL);
        const char *sql = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) != SQLITE_OK) {
            NSLog(@"Error: failed to prepare statement with message:search testValue.");
            return NO;
        } else {
            
            //sqlite3_bind_text(statement, 3, [parentID UTF8String], -1, SQLITE_TRANSIENT);
            //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
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
                
                int ids = sqlite3_column_int(statement, 0);
                NSString * idS = [[NSString alloc]initWithFormat:@"%d",ids];
                
                int isLeaf = sqlite3_column_int(statement, 7);
                NSString * isLEAF = [[NSString alloc]initWithFormat:@"%d",isLeaf];
                
                int isTopBusi = sqlite3_column_int(statement, 8);
                NSString * isTOPBUSI = [[NSString alloc]initWithFormat:@"%d",isTopBusi];
                
                int parentId = sqlite3_column_int(statement, 9);
                NSString * isPARENTID = [[NSString alloc]initWithFormat:@"%d",parentId];
                
                dic = [[NSDictionary alloc]initWithObjectsAndKeys:idS,@"id",nsBusiAliasStr,@"busiAlias", nsBusiDescStr,@"busiDesc",nsBusiCodeStr,@"busiIcon",nsBusiIconStr,@"busiIcon",nsBusiMoneyStr,@"busiMoney",nsBusiNameStr,@"busiName",isLEAF,@"isLeaf",isTOPBUSI,@"isTopBusi",isPARENTID,@"parentId",nil];
                
                [array addObject:dic];
            }
            
        }
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    return array;
}

//根据id进行查找
-(NSDictionary*)findById:(NSString *)ids {
    
    NSDictionary *dic;
    //判断数据库是否打开
    if ([self openDB]) {
        
        sqlite3_stmt *statement = nil;
        //sql语句
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM BUSIINFO WHERE id = '%@'",ids];
        const char *sql = [querySQL UTF8String];
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) != SQLITE_OK) {
            NSLog(@"Error: failed to prepare statement with message:find.");
            return NO;
        } else {
            
            sqlite3_bind_text(statement, 3, [ids UTF8String], -1, SQLITE_TRANSIENT);
            //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
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
                
                int ids = sqlite3_column_int(statement, 0);
                NSString * idS = [[NSString alloc]initWithFormat:@"%d",ids];
                
                int isLeaf = sqlite3_column_int(statement, 7);
                NSString * isLEAF = [[NSString alloc]initWithFormat:@"%d",isLeaf];
                
                int isTopBusi = sqlite3_column_int(statement, 8);
                NSString * isTOPBUSI = [[NSString alloc]initWithFormat:@"%d",isTopBusi];
                
                int parentId = sqlite3_column_int(statement, 9);
                NSString * isPARENTID = [[NSString alloc]initWithFormat:@"%d",parentId];
                
                dic = [[NSDictionary alloc]initWithObjectsAndKeys:idS,@"id",nsBusiAliasStr,@"busiAlias", nsBusiDescStr,@"busiDesc",nsBusiCodeStr,@"busiIcon",nsBusiIconStr,@"busiIcon",nsBusiMoneyStr,@"busiMoney",nsBusiNameStr,@"busiName",isLEAF,@"isLeaf",isTOPBUSI,@"isTopBusi",isPARENTID,@"parentId",nil];
            }
            
        }
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return dic;
}

//显示所有业务，返回字典数组
-(NSMutableArray*)findAll{
    
    NSDictionary *dic;
    NSMutableArray *array = [[NSMutableArray alloc]init];
    NSString *  nameLetterStr = [[[NSMutableString alloc]init]autorelease];
    
    //判断数据库是否打开
    if ([self openDB]) {
        
        sqlite3_stmt *statement = nil;
        //sql语句
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM BUSIINFO WHERE  isLeaf = 1"];
        const char *sql = [querySQL UTF8String];
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) != SQLITE_OK) {
            NSLog(@"Error: failed to prepare statement with message:find.");
            return NO;
        } else {
            
            //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
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
                
                nameLetterStr =  [nsBusiNameStr firstLetters];
                
                
                //                printf("获取所有汉字的首字符:%s", [[nsBusiNameStr firstLetters] UTF8String]);
                //                srt appendString:aa;
                //                srt set
                
                
                int ids = sqlite3_column_int(statement, 0);
                NSString * idS = [[NSString alloc]initWithFormat:@"%d",ids];
                
                int isLeaf = sqlite3_column_int(statement, 7);
                NSString * isLEAF = [[NSString alloc]initWithFormat:@"%d",isLeaf];
                
                int isTopBusi = sqlite3_column_int(statement, 8);
                NSString * isTOPBUSI = [[NSString alloc]initWithFormat:@"%d",isTopBusi];
                
                int parentId = sqlite3_column_int(statement, 9);
                NSString * isPARENTID = [[NSString alloc]initWithFormat:@"%d",parentId];
                
                dic = [[NSDictionary alloc]initWithObjectsAndKeys:idS,@"id",nsBusiAliasStr,@"busiAlias", nsBusiDescStr,@"busiDesc",nsBusiCodeStr,@"busiIcon",nsBusiIconStr,@"busiIcon",nsBusiMoneyStr,@"busiMoney",nsBusiNameStr,@"busiName",isLEAF,@"isLeaf",isTOPBUSI,@"isTopBusi",isPARENTID,@"parentId",nameLetterStr,@"nameLetter",nil];
                
                [array addObject:dic];
            }
            
        }
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return array;
}

-(NSMutableArray*)getBusiNameByLetter:(NSString *)inputLetter{
    
    NSMutableArray *allBusi = [self findAll];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    NSString *letter = [[[NSMutableString alloc]init]autorelease];
    for (int i = 0; i < allBusi.count; i++){
        letter = [allBusi[i] objectForKey:@"nameLetter"];
        //NSLog(@"第%d个元素---%@", i, [allBusi[i] objectForKey:@"busiName"]);
        if([letter rangeOfString:inputLetter].length > 0) {
            [array addObject:allBusi[i]];
        }
    }
    return array;
}


//返回数据库中所有纪录的条数
-(int)numOfRecords {
    
    int num = 0;;
    
    if ([self openDB]) {
        
        sqlite3_stmt *statement = nil;
        //sql语句
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM BUSIINFO"];
        const char *sql = [querySQL UTF8String];
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) != SQLITE_OK) {
            NSLog(@"Error: failed to prepare statement with message:find.");
            return NO;
        } else {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                num ++;
            }
        }
    }
    return num;
    
}



- (id)init{
    //数据业务通知注册
    [nc addObserver:self selector:@selector(busiInfoFeedback:) name:@"queryBusiInfoResponse" object:nil];
    [nc addObserver:self selector:@selector(hotbusiInfoFeedback:) name:@"queryBusiHotInfoResponse" object:nil];

    
 /**   //打开数据库
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    database_path = [documents stringByAppendingPathComponent:DBNAME];
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
    }
    //创建表
    NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS BUSIINFO (ID INTEGER primary key, busiAlias TEXT, busiCode TEXT, busiDesc TEXT, busiIcon TEXT, busiMoney TEXT, busiName TEXT, isLeaf INTEGER, isTopBusi INTEGER, parentId INTEGER)";
    [self execSql:sqlCreateTable];
    NSLog(@"数据库创建成功!");**/

    return self;
}

@end
