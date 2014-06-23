//
//  POAPinyin.h
//  LeXiang100 Direct Selling
//
//  Created by flying on 14-6-21.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface POAPinyin : NSObject

//输入中文，返回全拼。
+ (NSString *) Convert:(NSString *) hzString;

@end
