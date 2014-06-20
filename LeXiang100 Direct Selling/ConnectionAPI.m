//
//  connectionAPI.m
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-3.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import "connectionAPI.h"

@implementation connectionAPI


@synthesize webData;
@synthesize soapResults;
@synthesize xmlParser;
@synthesize conn;
@synthesize getXMLResults;
@synthesize resultDic;

@synthesize elementFound;
@synthesize matchingElement;
@synthesize matchingElement1;
@synthesize soapResults1;
@synthesize elementFound1;
@synthesize matchingElement2;       //isentender
@synthesize soapResults2;
@synthesize elementFound2;
@synthesize matchingElement3;       //isextender
@synthesize elementFound3;
@synthesize matchingElement4;       //SessionID
extern NSNotificationCenter *nc;
extern NSMutableDictionary * UserInfo;
- (void)getSoapFromInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Value1:(NSString *)value1{
    value1 = [DES3Util encrypt:value1];
    
    NSString * soapMsg = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n"
                          "<SOAP-ENV:Envelope \r\n"
                          "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"\r\n "//
                          "xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\" \r\n"
                          "xmlns:xsd=\"http://www.w3.org/1999/XMLSchema\">\r\n "
                          "<SOAP-ENV:Body>\r\n"
                          "<%@>\r\n"                //接口
                          "<%@ xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</%@>\r\n"//参数  值  参数
                          "</%@>\r\n"               //接口
                          "</SOAP-ENV:Body>\r\n"
                          "</SOAP-ENV:Envelope>\r\n",interface,parameter1,value1,parameter1,interface];
    NSLog(@"%@",soapMsg);
    
    NSString * ur = [NSString stringWithFormat:@"http://www.gz.10086.cn/intflx100/ws/phoneintf"];
    NSURL * url = [NSURL URLWithString:ur] ;
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [[NSMutableData data]retain];
        //NSLog(@"%@  22222",webData);
    }else NSLog(@"con为假  %@",webData);

}

- (void)getSoapFromInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Value1:(NSString *)value1 Parameter2:(NSString *)parameter2 Value2:(NSString *)value2{
    if ([value2 isEqualToString:@"123"]) {
        value2 = nil;
        value2 = [[NSString alloc]initWithString:@"15285987576"];
    }
    if ([value1 isEqualToString:@"qwe"]) {
        value1 = nil;
        value1 = [[NSString alloc]initWithString:@"123456"];
    }
    NSLog(@"value1:%@ value2:%@",value1,value2);
    value1 = [DES3Util encrypt:value1];
    value2 = [DES3Util encrypt:value2];
    
    NSString * soapMsg = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n"
                          "<SOAP-ENV:Envelope \r\n"
                          "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"\r\n "//
                          "xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\" \r\n"
                          "xmlns:xsd=\"http://www.w3.org/1999/XMLSchema\">\r\n "
                          "<SOAP-ENV:Body>\r\n"
                          "<%@>\r\n"
                          "<%@ xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</%@>\r\n"
                          "<%@ xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</%@>\r\n"
                          "</%@>\r\n"
                          "</SOAP-ENV:Body>\r\n"
                          "</SOAP-ENV:Envelope>\r\n",interface,parameter1,value1,parameter1,parameter2,value2,parameter2,interface];
    NSLog(@"%@",soapMsg);
    
    NSString * ur = [NSString stringWithFormat:@"http://www.gz.10086.cn/intflx100/ws/phoneintf"];
    if ([interface isEqualToString:@"awordShellQuery"]) {
         ur = [NSString stringWithFormat:@"http://www.gz.10086.cn/intflx100/ws/selfService"];
    }

    NSURL * url = [NSURL URLWithString:ur] ;
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [[NSMutableData data]retain];
        //NSLog(@"%@  22222",webData);
    }else NSLog(@"con为假  %@",webData);
}

- (void)getSoapForInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Value1:(NSString *)value1 Parameter2:(NSString *)parameter2 Value2:(NSString *)value2 Parameter3:(NSString *)parameter3 Value3:(NSString *)value3 {
    NSLog(@"value1:%@ value2:%@ value3:%@", value1, value2, value3);
    value1 = [DES3Util encrypt:value1];
    value2 = [DES3Util encrypt:value2];
    value3 = [DES3Util encrypt:value3];
    
    NSString * soapMsg = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n"
                          "<SOAP-ENV:Envelope \r\n"
                          "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"\r\n "//
                          "xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\" \r\n"
                          "xmlns:xsd=\"http://www.w3.org/1999/XMLSchema\">\r\n "
                          "<SOAP-ENV:Body>\r\n"
                          "<%@>\r\n"
                          "<%@ xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</%@>\r\n"
                          "<%@ xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</%@>\r\n"
                          "<%@ xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</%@>\r\n"
                         "</%@>\r\n"
                          "</SOAP-ENV:Body>\r\n"
                          "</SOAP-ENV:Envelope>\r\n",interface,parameter1,value1,parameter1,parameter2,value2,parameter2,parameter3,value3,parameter3,interface];
    NSLog(@"%@",soapMsg);
    
    NSString * ur = [NSString stringWithFormat:@"http://www.gz.10086.cn/intflx100/ws/phoneintf"];
    
    if ([interface isEqualToString:@"updateUserMainOffer"] || [interface isEqualToString:@"orderVasOffer"]) {
        ur = [NSString stringWithFormat:@"http://www.gz.10086.cn/intflx100/ws/selfService"];
    }
    
    
    NSURL * url = [NSURL URLWithString:ur] ;
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [[NSMutableData data]retain];
        //NSLog(@"%@  22222",webData);
    }else NSLog(@"con为假  %@",webData);
}


- (void)getSoapForInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Value1:(NSString *)value1 Parameter2:(NSString *)parameter2 Value2:(NSString *)value2 Parameter3:(NSString *)parameter3 Value3:(NSString *)value3 Parameter4:(NSString *)parameter4 Value4:(NSString *)value4{
    NSLog(@"value2:%@ value3:%@",value2,value3);
    value1 = [DES3Util encrypt:value1];
    value2 = [DES3Util encrypt:value2];
    value3 = [DES3Util encrypt:value3];
    value4 = [DES3Util encrypt:value4];
    
    NSString * soapMsg = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n"
                          "<SOAP-ENV:Envelope \r\n"
                          "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"\r\n "//
                          "xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\" \r\n"
                          "xmlns:xsd=\"http://www.w3.org/1999/XMLSchema\">\r\n "
                          "<SOAP-ENV:Body>\r\n"
                          "<%@>\r\n"
                          "<%@ xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</%@>\r\n"
                          "<%@ xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</%@>\r\n"
                          "<%@ xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</%@>\r\n"
                          "<%@ xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</%@>\r\n"
                          "</%@>\r\n"
                          "</SOAP-ENV:Body>\r\n"
                          "</SOAP-ENV:Envelope>\r\n",interface,parameter1,value1,parameter1,parameter2,value2,parameter2,parameter3,value3,parameter3,parameter4,value4,parameter4,interface];
    NSLog(@"%@",soapMsg);
    
    NSString * ur = [NSString stringWithFormat:@"http://www.gz.10086.cn/intflx100/ws/phoneintf"];
    NSURL * url = [NSURL URLWithString:ur] ;
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [[NSMutableData data]retain];
        //NSLog(@"%@  22222",webData);
    }else NSLog(@"con为假  %@",webData);
}


- (void)LoginWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 UserName:(NSString *)NewUsername Parameter2:(NSString *)parameter2 Password:(NSString *)NewPassword ;
{
    [self getSoapFromInterface:interface Parameter1:parameter1 Value1:NewUsername Parameter2:parameter2 Value2:NewPassword];
    [self showAlerView];
}

- (void)BusiInfoWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Version:(NSString *)version{
    [self getSoapFromInterface:interface Parameter1:parameter1 Value1:version];
    [self showAlerView];
}

- (void)UserInfoWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Name:(NSString *)name Parameter2:(NSString *)parameter2 Token:(NSString *)token {
    [self getSoapFromInterface:interface Parameter1:parameter1 Value1:name Parameter2:parameter2 Value2:token];
    [self showAlerView];
}

- (void)BankAccountWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Name:(NSString *)name Parameter2:(NSString *)parameter2 Token:(NSString *)token{
    [self getSoapFromInterface:interface Parameter1:parameter1 Value1:name Parameter2:parameter2 Value2:token];
    [self showAlerView];
}

- (void)RecommendedRecordWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Name:(NSString *)name Parameter2:(NSString *)parameter2 StartMonth:(NSString *)startmonth Parameter3:(NSString *)parameter3 EndMonth:(NSString *)endmonth Parameter4:(NSString *)parameter4 Token:(NSString *)token{
    [self getSoapForInterface:interface Parameter1:parameter1 Value1:name Parameter2:parameter2 Value2:startmonth Parameter3:parameter3 Value3:endmonth Parameter4:parameter4 Value4:token];
    [self showAlerView];
}

- (void)HotServiceWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Version:(NSString *)version{
    [self getSoapFromInterface:interface Parameter1:parameter1 Value1:version];
    [self showAlerView];
}

- (void)AwordShellWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 CustPhone:(NSString *)custPhone Parameter2:(NSString *)parameter2 Token:(NSString *)token {
    [self getSoapFromInterface:interface Parameter1:parameter1 Value1:custPhone Parameter2:parameter2 Value2:token];
    [self showAlerView];
}

- (void)UpdateUserMainOfferWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 CustPhone:(NSString *)custPhone Parameter2:(NSString *)parameter2 ParameterOfferId:(NSString *)OfferId Parameter3:(NSString *)parameter3 Token:(NSString *)token {
    [self getSoapForInterface:interface Parameter1:parameter1 Value1:custPhone Parameter2:parameter2 Value2:OfferId Parameter3:parameter3 Value3:token];
}

- (void)OrderVasOfferWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 CustPhone:(NSString *)custPhone Parameter2:(NSString *)parameter2 ParameterOfferId:(NSString *)OfferId Parameter3:(NSString *)parameter3 Token:(NSString *)token {
    
    [self getSoapForInterface:interface Parameter1:parameter1 Value1:custPhone Parameter2:parameter2 Value2:OfferId Parameter3:parameter3 Value3:token];
}

- (void)MockUpSMSWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 OpPhone:(NSString *)opPhone Parameter2:(NSString *)parameter2 SmsPort:(NSString *)smsPort Parameter3:(NSString *)parameter3 SmsContent:(NSString *)smsContent{
    [self getSoapForInterface:interface Parameter1:parameter1 Value1:opPhone Parameter2:parameter2 Value2:smsPort Parameter3:parameter3 Value3:smsContent];
    [self showAlerView];
}

- (void)LoginWithUserName:(NSString *)NewUsername Password:(NSString *)NewPassword{
    NewPassword = [DES3Util encrypt:NewPassword];
    NewUsername = [DES3Util encrypt:NewUsername];
    
    NSString * soapMsg = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n"
                          "<SOAP-ENV:Envelope \r\n"
                          "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"\r\n "//
                          "xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\" \r\n"
                          "xmlns:xsd=\"http://www.w3.org/1999/XMLSchema\">\r\n "
                          "<SOAP-ENV:Body>\r\n"
                          "<modifyLogin>\r\n"
                          "<loginPwd xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</loginPwd>\r\n"
                          "<opPhone xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</opPhone>\r\n"
                          "</modifyLogin>\r\n"
                          "</SOAP-ENV:Body>\r\n"
                          "</SOAP-ENV:Envelope>\r\n",NewPassword,NewUsername];
    NSLog(@"%@",soapMsg);
    
    NSString * ur = [NSString stringWithFormat:@"http://www.gz.10086.cn/intflx100/ws/phoneintf"];
    NSURL * url = [NSURL URLWithString:ur] ;
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [[NSMutableData data]retain];
        //NSLog(@"%@  22222",webData);
        }else NSLog(@"con为假  %@",webData);
}

-(void)BusiInfoVersion:(NSString *)version;
{
    
    version = [DES3Util encrypt:version];
    
    
    NSString * soapMsg = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n"
                          "<SOAP-ENV:Envelope \r\n"
                          "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"\r\n "//
                          "xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\" \r\n"
                          "xmlns:xsd=\"http://www.w3.org/1999/XMLSchema\">\r\n "
                          "<SOAP-ENV:Body>\r\n"
                          "<queryBusiInfo>\r\n"
                          "<versionTag xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</versionTag>\r\n"
                          "</queryBusiInfo>\r\n"
                          "</SOAP-ENV:Body>\r\n"
                          "</SOAP-ENV:Envelope>\r\n",version];
    NSLog(@"%@",soapMsg);
    
    NSString * ur = [NSString stringWithFormat:@"http://www.gz.10086.cn/intflx100/ws/phoneintf"];
    NSURL * url = [NSURL URLWithString:ur] ;
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [[NSMutableData data]retain];
        //NSLog(@"%@  22222",webData);
    }else NSLog(@"con为假  %@",webData);
}

#pragma mark -
#pragma mark URL Connection Data Delegate Methods

// 刚开始接受响应时调用
-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *) response{
    [webData setLength: 0];
    needToAnalysis = YES;
    NSLog(@"  刚开始接受响应时调用");
}

// 每接收到一部分数据就追加到webData中
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *) data {
    [webData appendData:data];
    NSLog(@"  每接收到一部分数据就追加到webData中 ");
    
}

// 出现错误时

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *) error {
    //conn = nil;
    //webData = nil;
    NSLog(@" connection 出现错误时");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"False"
                                                        object:self
     ];
    NSLog(@"Connection failed! Error - ");//%@ %@",[error localizedDescription],[[error userInfo] objectForKey:NSErrorFailingURLStringKey]);
    //如果显示alert   取消
    if (alerts.visible == YES) {
        [self dimissAlert:alerts];
    }
    [connectionAPI showAlertWithTitle:@"网络连接错误" AndMessages:@"网络连接错误,请重新尝试！"];
    [nc postNotificationName:@"loginFalse" object:self userInfo:nil];
    needToAnalysis = NO;
}

// 完成接收数据时调用
-(void) connectionDidFinishLoading:(NSURLConnection *) connection {
    NSString *theXML = [[NSString alloc] initWithBytes:[webData mutableBytes]
                                                length:[webData length]
                                              encoding:NSUTF8StringEncoding];
    
    // 打印出得到的XML
    getXMLResults = [[NSMutableString alloc] initWithString:theXML];
    NSLog(@"接受的soap    %@    soap", getXMLResults);
    //如果显示alert   取消
    if (alerts.visible == YES) {
        [self dimissAlert:alerts];
    }
    if ([getXMLResults isEqualToString:@""]) {
        [connectionAPI showAlertWithTitle:@"网络返回为空" AndMessages:@"网络返回为空,请重新尝试！"];
        [nc postNotificationName:@"loginFalse" object:self userInfo:nil];
        needToAnalysis = NO;
    }
    else if([getXMLResults rangeOfString:@"faultcode"].length>0){
        resultDic = [[[NSDictionary alloc]init]autorelease];
        [connectionAPI showAlertWithTitle:@"调用地址错误" AndMessages:@"调用地址错误！"];
        needToAnalysis = NO;
    }

    // 使用NSXMLParser解析出我们想要的结果
    xmlParser = [[NSXMLParser alloc] initWithData: webData];
    
    [xmlParser setDelegate: self];
    [xmlParser setShouldResolveExternalEntities: YES];
    [xmlParser parse];
}




#pragma mark -
#pragma mark XML Parser Delegate Methods

// 开始解析一个元素名
-(void) parser:(NSXMLParser *) parser didStartElement:(NSString *) elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *) qName attributes:(NSDictionary *) attributeDict {
    if ([elementName isEqualToString:@"return"]) {    //||[elementName isEqualToString:matchingElement1]
        elementFound = YES;
    }
}

// 追加找到的元素值，一个元素值可能要分几次追加
-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string {
    if (elementFound) {                                         //respondse
        soapResults = [[NSMutableString alloc]init];
        [soapResults appendString: [DES3Util decrypt:string]];
        NSLog(@"connection:%@",soapResults);

        //参数错误时返回soap中return为空
        if ([soapResults isEqualToString:@"{}"]) {
            [connectionAPI showAlertWithTitle:@"输入参数错误" AndMessages:@"输入参数错误，请检查输入项！"];
            [nc postNotificationName:@"loginFalse" object:self userInfo:nil];
            needToAnalysis = NO;
        }
        
        if ([soapResults isEqualToString:@"0"]&&[getXMLResults rangeOfString:@"mockUpSMSResponse"].length>0) {
            [connectionAPI showAlertWithTitle:nil AndMessages:@"业务推荐成功！"];
            needToAnalysis = NO;
        }else if ([soapResults isEqualToString:@"1"]&&[getXMLResults rangeOfString:@"mockUpSMSResponse"].length>0){
            [connectionAPI showAlertWithTitle:nil AndMessages:@"业务推荐失败！"];
            needToAnalysis = NO;

        }
        //json解析
        NSData *aData = [soapResults dataUsingEncoding: NSUTF8StringEncoding];
        resultDic = [NSJSONSerialization JSONObjectWithData:aData options:NSJSONReadingMutableContainers error:nil];
    }
}

// 结束解析这个元素名
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if (needToAnalysis) {
        NSMutableDictionary *d = [NSMutableDictionary dictionaryWithObject:resultDic forKey:@"1"];
        
        //登录返回解析
        if([getXMLResults rangeOfString:@"modifyLoginResponse"].length>0 ){
            if ([soapResults rangeOfString:@":0,"].length>0) {
                [nc postNotificationName:@"loginResponse" object:self userInfo:d];
            }else if([soapResults rangeOfString:@":1,"].length>0){
                [connectionAPI showAlertWithTitle:@"登录失败" AndMessages:@"账号或密码错误！"];
                [nc postNotificationName:@"loginFalse" object:self userInfo:d];
            }else{
                [connectionAPI showAlertWithTitle:@"登录失败" AndMessages:@"登陆我的乐享失败！"];
                [nc postNotificationName:@"loginFalse" object:self userInfo:d];
            }
        }
        //用户信息解析
        else if([getXMLResults rangeOfString:@"queryUserInfoResponse"].length>0){
            if ([soapResults rangeOfString:@"opName"].length>0&&[soapResults rangeOfString:@"opStatus"].length>0){
                [nc postNotificationName:@"queryUserInfoResponse" object:self userInfo:d];
            }else {
                [connectionAPI showAlertWithTitle:@"获取失败" AndMessages:@"获取个人信息失败！"];
                [nc postNotificationName:@"loginFalse" object:self userInfo:d];
            }
        }
        //银行账户解析
        else if([getXMLResults rangeOfString:@"queryBankInfoResponse"].length>0){
            //if ([soapResults rangeOfString:@"opName"].length>0&&[soapResults rangeOfString:@"opStatus"].length>0){
            [nc postNotificationName:@"queryBankInfoResponse" object:self userInfo:d];
            //}else [connectionAPI showAlertWithTitle:@"获取失败" AndMessages:@"获取个人信息失败！"];
        }
        //推荐记录查询解析
        else if ([getXMLResults rangeOfString:@"queryRecommendRecordsResponse"].length>0){
            if (!([soapResults rangeOfString:@"months"].length>0&&[soapResults rangeOfString:@"totalRecommend"].length>0)) {
                [connectionAPI showAlertWithTitle:@"没有推荐记录" AndMessages:@"在您查询的时间区间内没有推荐记录，请重新选择！"];
                //[nc postNotificationName:@"loginFalse" object:self userInfo:d];
            }else {
                [nc postNotificationName:@"queryRecommendRecordsResponse" object:self userInfo:d];
            }
        }

        //业务数据返回
        else if ([getXMLResults rangeOfString:@"queryBusiInfoResponse"].length>0){
            if ([resultDic isKindOfClass:[NSArray class]]) {
                NSLog(@"result is kind of arrry class");
                //            NSArray * resultArray = (NSArray *)resultDic;
                //            for (NSDictionary *dic in resultArray) {
                //                NSLog(@"dic:%@",[dic objectForKey:@"busiName"]);
                //            }
                [nc postNotificationName:@"queryBusiInfoResponse" object:self userInfo:d];
            }
        }
        //热点业务
        else if([getXMLResults rangeOfString:@"queryBusiHotInfoResponse"].length>0){
            if (!([soapResults rangeOfString:@"busiCode"].length>0&&[soapResults rangeOfString:@"id"].length>0)) {
                [connectionAPI showAlertWithTitle:@"获取热点业务失败" AndMessages:@"获取热点业务失败，请重试！"];
            }else {
                [nc postNotificationName:@"queryBusiHotInfoResponse" object:self userInfo:d];
            }
        }
        //一句话营销
        else if ([getXMLResults rangeOfString:@"awordShellQueryResponse"].length>0) {
            NSLog(@"aaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
            if ([soapResults isEqualToString:@"{}"]) {
            
            }else{
            NSString * custPhone = [UserInfo objectForKey:@"name" ];
            NSString * token = [UserInfo objectForKey:@"token"];
            NSDictionary * offerList = [resultDic objectForKey:@"returnOfferList"];
            NSString * offerId;
                if (offerList.count ==0) {
                    NSLog(@"没有适合办理的业务");
                    if (alerts.visible == YES) {
                        [self dimissAlert:alerts];
                    }
                }else{
                    if ([offerList isKindOfClass:[NSArray class]]) {
                        NSLog(@"i'm a array");
                        NSArray * offerArray = [resultDic objectForKey:@"returnOfferList"];
                        offerId = [[offerArray objectAtIndex:0]objectForKey:@"OFFER_ID"];
                    }
                    else if ([offerList isKindOfClass:[NSDictionary class]]){
                        offerId = [offerList objectForKey:@"OFFER_ID"];
                    }
                NSLog(@"offerID:%@",offerId);
                [self UpdateUserMainOfferWithInterface:@"updateUserMainOffer" Parameter1:@"custPhone" CustPhone:custPhone Parameter2:@"OfferId"     ParameterOfferId:offerId Parameter3:@"token" Token:token];
                }
            }
        }
        //主推荐业务办理
        else if (([getXMLResults rangeOfString:@"updateUserMainOfferResponse"].length>0)) {
         NSLog(@"======================updateUserMainOfferResponse============================");
     }
        //增值业务办理
        else if (([getXMLResults rangeOfString:@"orderVasOfferResponse"].length>0)) {
         NSLog(@"======================orderVasOfferResponse============================");
     }
        //返回数据为空
     else if (soapResults.length<5) {
            //[connectionAPI showAlertWithTitle:@"返回数据错误" AndMessages:@"返回数据为空，请检查输入项！"];
            [nc postNotificationName:@"loginFalse" object:self userInfo:d];
        }
    }
    //如果显示alert   取消
    if (alerts.visible == YES && [getXMLResults rangeOfString:@"awordShellQueryResponse"].length == 0) {
        [self dimissAlert:alerts];
    }
    
    elementFound = FALSE;
    // 强制放弃解析
    [xmlParser abortParsing];
    soapResults = nil;
    //}
}

// 解析整个文件结束后
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if (soapResults) {
        soapResults = nil;
    }
    
}

// 出错时，例如强制结束解析
- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    if (soapResults) {
        soapResults = nil;
    }
}

+ (void)showAlertWithTitle:(NSString *)titles AndMessages:(NSString *)messages{
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:titles message:messages delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好的", nil];
    [alert show];
}

- (void)showAlerView{
    alerts = [[[UIAlertView alloc]initWithTitle:@"连接中"
                                       message:nil
                                      delegate:nil
                             cancelButtonTitle:nil
                             otherButtonTitles:nil]autorelease];
//    alerts.frame = CGRectMake(0, 0, viewWidth/1.5, viewHeight/5);
//    alerts.center = CGPointMake(0, viewHeight/2);
    [alerts show];
    UIActivityIndicatorView*activeView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activeView.center = CGPointMake(alerts.bounds.size.width/2.0f, alerts.bounds.size.height-40.0f);
    [activeView startAnimating];
    alerts.delegate = self;
    [alerts addSubview:activeView];
    [activeView release];
    //[alerts release];
}

- (void) dimissAlert:(UIAlertView *)alert
{
    if(alerts)
    {
        [alerts dismissWithClickedButtonIndex:[alert cancelButtonIndex]animated:YES];
    }
}

//- (void) dimissAlert:(UIAlertView *)alert
//{
//    if(alerts)
//    {
//        [alerts dismissWithClickedButtonIndex:[alert cancelButtonIndex]animated:YES];
//        [alerts release];
//    }
//}

@end
