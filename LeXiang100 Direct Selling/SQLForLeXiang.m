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
-(void)openDB {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path1 = [documents stringByAppendingPathComponent:DBNAME];
    
    if (sqlite3_open([database_path1 UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
        
        NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS BUSIINFO (ID INTEGER PRIMARY KEY , busiAlias TEXT, busiCode TEXT, busiDesc TEXT, busiIcon TEXT, busiMoney TEXT, busiName TEXT, isLeaf INTEGER, isTopBusi INTEGER, parentId INTEGER)";
        
        [self execSql:sqlCreateTable];
        
    }
    
}

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

- (void)deleteDB{
    [self openDB];
    NSString *sqlDelete = [NSString stringWithFormat:@"delete from busiInfo"];
    NSLog(@"%@",sqlDelete);
    [self execSql:sqlDelete];
    NSLog(@"==================数据已经清除=======================");
    sqlite3_close(db);
}

-(void)execSql:(NSString *)sql
{
    char *err;
    [self openDB];
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库操作数据失败!???");
    }
    sqlite3_close(db);
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
     sqlite3_close(db);
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

//根据业务名称查找,返回该业务的描述信息和资费信息busiDesc,busiMoney
-(NSDictionary*)findByBusiName:(NSString *)bName {
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM BUSIINFO WHERE BUSINAME = '%@'",bName ];
    NSString *nsBusiDescStr;
    NSDictionary *dic;
    NSLog(@"sqlQuery%@", sqlQuery);
    [self openDB];

    sqlite3_stmt * statement;
    
    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            
            char *busiDesc = (char*)sqlite3_column_text(statement, 3);
            nsBusiDescStr = [[NSString alloc]initWithUTF8String:busiDesc];
            char *busiMoney = (char*)sqlite3_column_text(statement, 5);
            NSString *nsBusiMoneyStr = [[NSString alloc]initWithUTF8String:busiMoney];
            
            dic = [[NSDictionary alloc]initWithObjectsAndKeys:nsBusiDescStr,@"busiDesc",nsBusiMoneyStr,@"busiMoney",bName,@"busiName",nil];
        }
        
    }
    sqlite3_close(db);

    return dic;
    
}


//根据busiCode查找
-(NSDictionary *)findBybusiCode:(NSString *)busiCode{
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM BUSIINFO WHERE BUSICODE = '%@'",busiCode ];
    NSString *nsBusiDescStr;
    NSDictionary *dic;
    NSLog(@"sqlQuery%@", sqlQuery);
    [self openDB];
    
    sqlite3_stmt * statement;
    
    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            
            char *busiDesc = (char*)sqlite3_column_text(statement, 3);
            nsBusiDescStr = [[NSString alloc]initWithUTF8String:busiDesc];
            char *busiMoney = (char*)sqlite3_column_text(statement, 5);
            NSString *nsBusiMoneyStr = [[NSString alloc]initWithUTF8String:busiMoney];
            char *bName = (char*)sqlite3_column_text(statement, 6);
            NSString *nsBusiNameStr = [[NSString alloc]initWithUTF8String:bName];
            
            dic = [[NSDictionary alloc]initWithObjectsAndKeys:nsBusiDescStr,@"busiDesc",nsBusiMoneyStr,@"busiMoney",nsBusiNameStr,@"busiName",busiCode,@"busiCode",nil];
        }
        
    }
    sqlite3_close(db);
    
    return dic;

}
//根据parentid查找
-(NSMutableArray*)findByParentId:(int)parentID {
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM BUSIINFO WHERE PARENTID = %d",parentID ];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [self openDB];
    NSDictionary *dic;
    NSLog(@"sqlQuery%@", sqlQuery);
    sqlite3_stmt * statement;
    int  ids;
    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            ids = sqlite3_column_int(statement, 0);
            
            //NSString * idS = [[NSString alloc]initWithFormat:@"%d",ids];
            dic = [self findById:ids];
            [array addObject:dic];
        }
        
        
    }
    sqlite3_close(db);

    return array;
    
}

//根据id进行查找，返回存有所有字段的字典
-(NSDictionary*)findById:(int)busiID {
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM BUSIINFO WHERE id = %d",busiID ];
    //NSMutableArray *array = [[NSMutableArray alloc]init];
    NSDictionary *dic;
    NSLog(@"sqlQuery%@", sqlQuery);
    [self openDB];
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
            
            int ids = sqlite3_column_int(statement, 0);
            NSString * idS = [[NSString alloc]initWithFormat:@"%d",ids];
            
            int isLeaf = sqlite3_column_int(statement, 7);
            NSString * isLEAF = [[NSString alloc]initWithFormat:@"%d",isLeaf];
            
            int isTopBusi = sqlite3_column_int(statement, 8);
            NSString * isTOPBUSI = [[NSString alloc]initWithFormat:@"%d",isTopBusi];
            
            int parentId = sqlite3_column_int(statement, 9);
            NSString * isPARENTID = [[NSString alloc]initWithFormat:@"%d",parentId];
      
            dic = [[NSDictionary alloc]initWithObjectsAndKeys:idS,@"id",nsBusiAliasStr,@"busiAlias", nsBusiCodeStr,@"busiCode",nsBusiDescStr,@"busiDesc",nsBusiIconStr,@"busiIcon",nsBusiMoneyStr,@"busiMoney",nsBusiNameStr,@"busiName",isLEAF,@"isLeaf",isTOPBUSI,@"isTopBusi",isPARENTID,@"parentId",nil];
        }
        
    }
    sqlite3_close(db);
    return dic;
}


//返回数据库中所有纪录的条数
-(int)numOfRecords {
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM BUSIINFO"];
    int num = 0;;
    NSLog(@"sqlQuery%@", sqlQuery);
    sqlite3_stmt * statement;
    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            num ++;
        }
    }
    sqlite3_close(db);
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
    [self openDB];
    sqlite3_close(db);
    return self;
}

@end
