//
//  connectionAPI.h
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-3.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DES3Util.h"
@interface connectionAPI : NSObject<NSXMLParserDelegate, NSURLConnectionDelegate>{
    UIAlertView * alerts;
}
- (void)LoginWithUserName:(NSString *)NewUsername Password:(NSString *)NewPassword ;
- (void)LoginWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 UserName:(NSString *)NewUsername Parameter2:(NSString *)parameter2 Password:(NSString *)NewPassword ;
- (void)BusiInfoVersion:(NSString *)version;
- (void)BusiInfoWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Version:(NSString *)version;
- (void)UserInfoWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Name:(NSString *)name Parameter2:(NSString *)parameter2 Token:(NSString *)token;
- (void)BackAccountWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Name:(NSString *)name Parameter2:(NSString *)parameter2 Token:(NSString *)token;
- (void)RecommendedRecordWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Name:(NSString *)name Parameter2:(NSString *)parameter2 StartMonth:(NSString *)startmonth Parameter3:(NSString *)parameter3 EndMonth:(NSString *)endmonth Parameter4:(NSString *)parameter4 Token:(NSString *)token;
+ (void)showAlertWithTitle:(NSString *)titles AndMessages:(NSString *)messages;
@property (strong, nonatomic) NSMutableData *webData;
@property (strong, nonatomic) NSMutableString *soapResults;

@property (strong, nonatomic) NSXMLParser *xmlParser;
@property (nonatomic) BOOL elementFound;
@property (strong, nonatomic) NSString *matchingElement;
@property (strong, nonatomic) NSString *matchingElement1;

@property (strong, nonatomic) NSURLConnection *conn;
@property (strong, nonatomic) NSMutableString *getXMLResults;

@property (strong, nonatomic) NSDictionary *resultDic;
@property (strong, nonatomic) NSMutableString *soapResults1;
@property (nonatomic) BOOL elementFound1;
@property (strong, nonatomic) NSString *matchingElement2;
@property (strong, nonatomic) NSMutableString *soapResults2;
@property (nonatomic) BOOL elementFound2;
@property (strong, nonatomic) NSString *matchingElement3;
@property (nonatomic) BOOL elementFound3;
@property (strong, nonatomic) NSString *matchingElement4;

@end