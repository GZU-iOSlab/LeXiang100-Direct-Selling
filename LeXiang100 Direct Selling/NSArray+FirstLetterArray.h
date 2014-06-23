//
//  NSArray+FirstLetterArray.h
//  LeXiang100 Direct Selling
//
//  Created by flying on 14-6-21.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (FirstLetterArray)
 /**
  *	通过需要按【首字母分类】的 【姓名数组】 调用此函数
  *
  *	@return	A：以a打头的姓名或者单词
            B：以b打头的姓名或者单词
  */

- (NSDictionary *)sortedArrayUsingFirstLetter;

@end
